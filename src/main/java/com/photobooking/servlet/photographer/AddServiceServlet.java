package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.photographer.PhotographerService;
import com.photobooking.model.photographer.PhotographerServiceManager;
import com.photobooking.model.user.User;
import com.photobooking.util.ValidationUtil;

/**
 * Servlet for adding new service packages
 */
@WebServlet("/photographer/add-service")
public class AddServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in and is a photographer
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
            session.setAttribute("errorMessage", "Only photographers can add services");
            response.sendRedirect(request.getContextPath() + "/photographer/dashboard.jsp");
            return;
        }

        // Get current photographer's ID
        String photographerId = (String) session.getAttribute("photographerId");
        if (photographerId == null) {
            session.setAttribute("errorMessage", "Photographer profile not found");
            response.sendRedirect(request.getContextPath() + "/photographer/dashboard.jsp");
            return;
        }

        try {
            // Get form parameters
            String packageName = ValidationUtil.cleanInput(request.getParameter("packageName"));
            String packageCategory = request.getParameter("packageCategory");
            String packageDescription = ValidationUtil.cleanInput(request.getParameter("packageDescription"));
            double packagePrice = Double.parseDouble(request.getParameter("packagePrice"));
            int packageDuration = Integer.parseInt(request.getParameter("packageDuration"));
            int packagePhotographers = Integer.parseInt(request.getParameter("packagePhotographers"));
            String packageFeatures = request.getParameter("packageFeatures");
            String packageDeliverables = ValidationUtil.cleanInput(request.getParameter("packageDeliverables"));
            boolean packageActive = request.getParameter("packageActive") != null;

            // Validate required fields
            if (ValidationUtil.isNullOrEmpty(packageName) || ValidationUtil.isNullOrEmpty(packageCategory) ||
                    ValidationUtil.isNullOrEmpty(packageDescription) || packagePrice <= 0 || packageDuration <= 0) {
                session.setAttribute("errorMessage", "All required fields must be filled correctly");
                response.sendRedirect(request.getContextPath() + "/photographer/service_management.jsp");
                return;
            }

            // Create new service
            PhotographerService newService = new PhotographerService(
                    photographerId,
                    packageName,
                    packageDescription,
                    packagePrice,
                    packageCategory,
                    packageDuration
            );

            newService.setPhotographersCount(packagePhotographers);
            newService.setDeliverables(packageDeliverables);
            newService.setActive(packageActive);

            // Parse features
            if (!ValidationUtil.isNullOrEmpty(packageFeatures)) {
                String[] features = packageFeatures.trim().split("\n");
                for (String feature : features) {
                    if (!feature.trim().isEmpty()) {
                        newService.addFeature(feature.trim());
                    }
                }
            }

            // Save service
            PhotographerServiceManager serviceManager = new PhotographerServiceManager();
            if (serviceManager.addService(newService)) {
                session.setAttribute("successMessage", "Service package added successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to add service package");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid price or duration format");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/photographer/service_management.jsp");
    }
}