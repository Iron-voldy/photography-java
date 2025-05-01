package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.util.ArrayList;
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
 * Servlet for handling photographer listings
 */
@WebServlet("/photographer/list")
public class PhotographerListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests - display list of photographers
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get filter parameters
        String searchKeyword = request.getParameter("search");
        String specialty = request.getParameter("specialty");
        String location = request.getParameter("location");
        String sortBy = request.getParameter("sortBy");
        String page = request.getParameter("page");

        // Default values
        int currentPage = 1;
        int photographersPerPage = 12; // Number of photographers to display per page

        // Parse page parameter
        if (!ValidationUtil.isNullOrEmpty(page)) {
            try {
                currentPage = Integer.parseInt(page);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                // If page is not a valid number, default to 1
                currentPage = 1;
            }
        }

        // Get photographer manager
        PhotographerManager photographerManager = new PhotographerManager();

        // Get filtered photographers
        List<Photographer> photographers = filterPhotographers(
                photographerManager,
                searchKeyword,
                specialty,
                location
        );

        // Sort photographers
        sortPhotographers(photographers, sortBy);

        // Get total number of photographers
        int totalPhotographers = photographers.size();

        // Calculate total pages
        int totalPages = (int) Math.ceil((double) totalPhotographers / photographersPerPage);

        // Ensure current page is within valid range
        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }

        // Get photographers for current page
        List<Photographer> pagePhotographers = getPhotographersForPage(
                photographers,
                currentPage,
                photographersPerPage
        );

        // Set attributes for the view
        request.setAttribute("photographers", pagePhotographers);
        request.setAttribute("totalPhotographers", totalPhotographers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", searchKeyword);
        request.setAttribute("specialty", specialty);
        request.setAttribute("location", location);
        request.setAttribute("sortBy", sortBy);

        // Set available specialties (for filter dropdown)
        request.setAttribute("specialties", getAvailableSpecialties());

        // Forward to the photographer list JSP
        request.getRequestDispatcher("/photographer/photographer_list.jsp").forward(request, response);
    }

    /**
     * Filter photographers based on search criteria
     */
    private List<Photographer> filterPhotographers(
            PhotographerManager photographerManager,
            String searchKeyword,
            String specialty,
            String location
    ) {
        List<Photographer> result = new ArrayList<>();

        // Apply filters in sequence

        // Start with all photographers
        List<Photographer> photographers = photographerManager.getAllPhotographers();

        // Filter by search keyword if provided
        if (!ValidationUtil.isNullOrEmpty(searchKeyword)) {
            photographers = photographerManager.searchPhotographers(searchKeyword);
        }

        // Filter by specialty if provided
        if (!ValidationUtil.isNullOrEmpty(specialty)) {
            for (Photographer photographer : photographers) {
                if (photographer.getSpecialties().contains(specialty)) {
                    result.add(photographer);
                }
            }
        } else {
            // If no specialty filter, add all
            result.addAll(photographers);
        }

        // Filter by location if provided
        if (!ValidationUtil.isNullOrEmpty(location)) {
            List<Photographer> locationFiltered = new ArrayList<>();
            for (Photographer photographer : result) {
                if (photographer.getLocation() != null &&
                        photographer.getLocation().toLowerCase().contains(location.toLowerCase())) {
                    locationFiltered.add(photographer);
                }
            }
            return locationFiltered;
        }

        return result;
    }

    /**
     * Sort photographers based on sort criteria
     */
    private void sortPhotographers(List<Photographer> photographers, String sortBy) {
        if (ValidationUtil.isNullOrEmpty(sortBy)) {
            // Default sort by rating (highest first)
            sortBy = "rating-desc";
        }

        switch (sortBy) {
            case "rating-desc":
                photographers.sort((p1, p2) -> Double.compare(p2.getRating(), p1.getRating()));
                break;
            case "rating-asc":
                photographers.sort((p1, p2) -> Double.compare(p1.getRating(), p2.getRating()));
                break;
            case "price-asc":
                photographers.sort((p1, p2) -> Double.compare(p1.getBasePrice(), p2.getBasePrice()));
                break;
            case "price-desc":
                photographers.sort((p1, p2) -> Double.compare(p2.getBasePrice(), p1.getBasePrice()));
                break;
            case "experience-desc":
                photographers.sort((p1, p2) -> Integer.compare(p2.getYearsOfExperience(), p1.getYearsOfExperience()));
                break;
            case "name-asc":
                photographers.sort((p1, p2) -> {
                    String name1 = p1.getBusinessName() != null ? p1.getBusinessName() : "";
                    String name2 = p2.getBusinessName() != null ? p2.getBusinessName() : "";
                    return name1.compareToIgnoreCase(name2);
                });
                break;
            case "name-desc":
                photographers.sort((p1, p2) -> {
                    String name1 = p1.getBusinessName() != null ? p1.getBusinessName() : "";
                    String name2 = p2.getBusinessName() != null ? p2.getBusinessName() : "";
                    return name2.compareToIgnoreCase(name1);
                });
                break;
            default:
                // Default sort by rating (highest first)
                photographers.sort((p1, p2) -> Double.compare(p2.getRating(), p1.getRating()));
                break;
        }
    }

    /**
     * Get photographers for current page
     */
    private List<Photographer> getPhotographersForPage(
            List<Photographer> photographers,
            int currentPage,
            int photographersPerPage
    ) {
        List<Photographer> pagePhotographers = new ArrayList<>();

        int start = (currentPage - 1) * photographersPerPage;
        int end = Math.min(start + photographersPerPage, photographers.size());

        if (start < photographers.size()) {
            for (int i = start; i < end; i++) {
                pagePhotographers.add(photographers.get(i));
            }
        }

        return pagePhotographers;
    }

    /**
     * Get list of available specialties
     */
    private List<String> getAvailableSpecialties() {
        List<String> specialties = new ArrayList<>();
        specialties.add("WEDDING");
        specialties.add("PORTRAIT");
        specialties.add("EVENT");
        specialties.add("FAMILY");
        specialties.add("CORPORATE");
        specialties.add("PRODUCT");
        specialties.add("LANDSCAPE");
        return specialties;
    }
}