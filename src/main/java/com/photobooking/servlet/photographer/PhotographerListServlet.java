package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;
import com.photobooking.util.ValidationUtil;

/**
 * Servlet for handling photographer listings
 */
@WebServlet("/photographer/list")
public class PhotographerListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        PhotographerManager photographerManager = new PhotographerManager();

        try {
            // Get filter parameters
            String searchKeyword = request.getParameter("search");
            String specialty = request.getParameter("specialty");
            String location = request.getParameter("location");
            String sortBy = request.getParameter("sortBy");
            String pageStr = request.getParameter("page");

            // Default values
            int currentPage = 1;
            int photographersPerPage = 12; // Number of photographers to display per page

            // Parse page parameter
            if (!ValidationUtil.isNullOrEmpty(pageStr)) {
                try {
                    currentPage = Integer.parseInt(pageStr);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    // If page is not a valid number, default to 1
                    currentPage = 1;
                }
            }

            // Start with all photographers
            List<Photographer> allPhotographers = photographerManager.getAllPhotographers();

            // Apply filters
            List<Photographer> filteredPhotographers = allPhotographers;

            // Filter by search keyword if provided
            if (!ValidationUtil.isNullOrEmpty(searchKeyword)) {
                filteredPhotographers = photographerManager.searchPhotographers(searchKeyword);
            }

            // Filter by specialty if provided
            if (!ValidationUtil.isNullOrEmpty(specialty)) {
                filteredPhotographers = filteredPhotographers.stream()
                        .filter(p -> p.getSpecialties().contains(specialty))
                        .toList();
            }

            // Filter by location if provided
            if (!ValidationUtil.isNullOrEmpty(location)) {
                final String locationLower = location.toLowerCase();
                filteredPhotographers = filteredPhotographers.stream()
                        .filter(p -> p.getLocation() != null &&
                                p.getLocation().toLowerCase().contains(locationLower))
                        .toList();
            }

            // Sort photographers
            if (!ValidationUtil.isNullOrEmpty(sortBy)) {
                switch (sortBy) {
                    case "rating-desc":
                        filteredPhotographers = photographerManager.sortPhotographersByRating(filteredPhotographers, false);
                        break;
                    case "rating-asc":
                        filteredPhotographers = photographerManager.sortPhotographersByRating(filteredPhotographers, true);
                        break;
                    case "price-asc":
                        filteredPhotographers = photographerManager.sortPhotographersByPrice(true);
                        break;
                    case "price-desc":
                        filteredPhotographers = photographerManager.sortPhotographersByPrice(false);
                        break;
                    case "experience-desc":
                        filteredPhotographers = photographerManager.sortPhotographersByExperience(false);
                        break;
                    case "name-asc":
                        filteredPhotographers = photographerManager.sortPhotographersByName(true);
                        break;
                    case "name-desc":
                        filteredPhotographers = photographerManager.sortPhotographersByName(false);
                        break;
                    default:
                        // Default sort by rating (highest first)
                        filteredPhotographers = photographerManager.sortPhotographersByRating(filteredPhotographers, false);
                        break;
                }
            } else {
                // Default sort by rating if no sortBy parameter
                filteredPhotographers = photographerManager.sortPhotographersByRating(filteredPhotographers, false);
            }

            // Calculate pagination
            int totalPhotographers = filteredPhotographers.size();
            int totalPages = (int) Math.ceil((double) totalPhotographers / photographersPerPage);

            // Ensure current page is within valid range
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }

            // Get photographers for current page
            int fromIndex = (currentPage - 1) * photographersPerPage;
            int toIndex = Math.min(fromIndex + photographersPerPage, totalPhotographers);

            List<Photographer> pagePhotographers;
            if (fromIndex < totalPhotographers) {
                pagePhotographers = filteredPhotographers.subList(fromIndex, toIndex);
            } else {
                pagePhotographers = List.of();
            }

            // Get available specialties for filter dropdown
            List<String> specialties = Arrays.asList(
                    "WEDDING", "PORTRAIT", "EVENT", "FAMILY", "CORPORATE", "PRODUCT", "LANDSCAPE"
            );

            // Set attributes for the view
            request.setAttribute("photographers", pagePhotographers);
            request.setAttribute("totalPhotographers", totalPhotographers);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("specialties", specialties);

            // Forward to the photographer list JSP
            request.getRequestDispatcher("/photographer/photographer_list.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error in PhotographerListServlet.doGet: " + e.getMessage());
            e.printStackTrace();

            if (session != null) {
                session.setAttribute("errorMessage", "An error occurred while loading the photographers list.");
            }

            // Forward to the photographer list JSP with an empty list
            request.setAttribute("photographers", List.of());
            request.setAttribute("totalPhotographers", 0);
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 0);
            request.setAttribute("specialties", List.of());

            request.getRequestDispatcher("/photographer/photographer_list.jsp").forward(request, response);
        }
    }
}