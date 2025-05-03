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

import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;
import com.photobooking.util.ValidationUtil;

/**
 * Servlet for handling the photographer list display and search functionality
 */
@WebServlet("/photographer/list")
public class PhotographerListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get search parameters
        String search = ValidationUtil.cleanInput(request.getParameter("search"));
        String specialty = request.getParameter("specialty");
        String location = ValidationUtil.cleanInput(request.getParameter("location"));
        String sortBy = request.getParameter("sortBy");

        // Get page number
        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        // Initialize PhotographerManager
        PhotographerManager photographerManager = new PhotographerManager();
        List<Photographer> photographers;

        // Get photographers based on search criteria
        if (ValidationUtil.isNullOrEmpty(search) &&
                ValidationUtil.isNullOrEmpty(specialty) &&
                ValidationUtil.isNullOrEmpty(location) &&
                ValidationUtil.isNullOrEmpty(sortBy)) {
            // No filters - get all photographers
            photographers = photographerManager.getAllPhotographers();
        } else {
            // Apply search filters
            photographers = searchPhotographers(photographerManager, search, specialty, location);
        }

        // Apply sorting
        photographers = applySorting(photographerManager, photographers, sortBy);

        // Apply pagination
        int itemsPerPage = 9;
        int totalPhotographers = photographers.size();
        int totalPages = (int) Math.ceil((double) totalPhotographers / itemsPerPage);

        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, totalPhotographers);

        List<Photographer> pagedPhotographers = new ArrayList<>();
        if (totalPhotographers > 0 && startIndex < totalPhotographers) {
            pagedPhotographers = photographers.subList(startIndex, endIndex);
        }

        // Get all specialties for filter dropdown
        List<String> specialties = getAllSpecialties(photographerManager);

        // Set attributes for JSP
        request.setAttribute("photographers", pagedPhotographers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("specialties", specialties);

        request.getRequestDispatcher("/photographer/photographer_list.jsp").forward(request, response);
    }

    /**
     * Search photographers based on criteria
     */
    private List<Photographer> searchPhotographers(PhotographerManager manager,
                                                   String search, String specialty, String location) {
        List<Photographer> result = manager.getAllPhotographers();

        if (!ValidationUtil.isNullOrEmpty(search)) {
            result = manager.searchPhotographers(search);
        }

        if (!ValidationUtil.isNullOrEmpty(specialty)) {
            result = manager.getPhotographersBySpecialty(specialty);
        }

        if (!ValidationUtil.isNullOrEmpty(location)) {
            result = manager.getPhotographersByLocation(location);
        }

        return result;
    }

    /**
     * Apply sorting to photographer list
     */
    private List<Photographer> applySorting(PhotographerManager manager,
                                            List<Photographer> photographers, String sortBy) {
        if (ValidationUtil.isNullOrEmpty(sortBy) || "rating-desc".equals(sortBy)) {
            return manager.sortPhotographersByRating(photographers, false);
        }

        switch (sortBy) {
            case "price-asc":
                return manager.sortPhotographersByPrice(true);
            case "price-desc":
                return manager.sortPhotographersByPrice(false);
            case "experience-desc":
                return manager.sortPhotographersByExperience(false);
            case "name-asc":
                return manager.sortPhotographersByName(true);
            default:
                return photographers;
        }
    }

    /**
     * Get all unique specialties from photographers
     */
    private List<String> getAllSpecialties(PhotographerManager manager) {
        List<String> specialties = new ArrayList<>();
        List<Photographer> allPhotographers = manager.getAllPhotographers();

        for (Photographer photographer : allPhotographers) {
            for (String specialty : photographer.getSpecialties()) {
                if (!specialties.contains(specialty)) {
                    specialties.add(specialty);
                }
            }
        }

        return specialties;
    }
}