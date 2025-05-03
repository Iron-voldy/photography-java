package com.photobooking.servlet.photographer;

import java.io.IOException;
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

/**
 * Servlet for displaying photographer service management dashboard
 */
@WebServlet("/photographer/service-management")
public class ServiceManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in and is a photographer
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
            session.setAttribute("errorMessage", "Access denied");
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }

        // Get current photographer's ID
        String photographerId = (String) session.getAttribute("photographerId");
        if (photographerId == null) {
            session.setAttribute("errorMessage", "Photographer profile not found");
            response.sendRedirect(request.getContextPath() + "/photographer/dashboard.jsp");
            return;
        }

        // Get photographer services
        PhotographerServiceManager serviceManager = new PhotographerServiceManager();
        List<PhotographerService> services = serviceManager.getServicesByPhotographer(photographerId);

        // Set attributes for JSP
        request.setAttribute("services", services);

        request.getRequestDispatcher("/photographer/service_management.jsp").forward(request, response);
    }
}