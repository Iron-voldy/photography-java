package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;
import com.photobooking.model.gallery.Gallery;
import com.photobooking.model.gallery.GalleryManager;
import com.photobooking.model.review.Review;
import com.photobooking.model.review.ReviewManager;
import com.photobooking.model.user.User;
import com.photobooking.util.ValidationUtil;

/**
 * Servlet to handle photographer profile related operations
 */
@WebServlet("/photographer/profile")
public class PhotographerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests - display photographer profile page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        PhotographerManager photographerManager = new PhotographerManager();

        try {
            // Get photographer ID from request
            String photographerId = request.getParameter("id");

            // If photographer ID not provided, try to get from user ID
            if (ValidationUtil.isNullOrEmpty(photographerId)) {
                String userId = request.getParameter("userId");

                if (!ValidationUtil.isNullOrEmpty(userId)) {
                    // Look up photographer by user ID
                    Photographer photographer = photographerManager.getPhotographerByUserId(userId);

                    if (photographer != null) {
                        photographerId = photographer.getPhotographerId();
                    }
                }
            }

            // If still no photographer ID, check if current user is a photographer
            if (ValidationUtil.isNullOrEmpty(photographerId) && session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");

                if (currentUser.getUserType() == User.UserType.PHOTOGRAPHER) {
                    // Look up photographer by user ID
                    Photographer photographer = photographerManager.getPhotographerByUserId(currentUser.getUserId());

                    if (photographer != null) {
                        photographerId = photographer.getPhotographerId();
                    }
                }
            }

            // If still no photographer ID, redirect to list
            if (ValidationUtil.isNullOrEmpty(photographerId)) {
                response.sendRedirect(request.getContextPath() + "/photographer/list");
                return;
            }

            // Get photographer details
            Photographer photographer = photographerManager.getPhotographerById(photographerId);

            if (photographer == null) {
                // Photographer not found
                if (session != null) {
                    session.setAttribute("errorMessage", "Photographer not found");
                }
                response.sendRedirect(request.getContextPath() + "/photographer/list");
                return;
            }

            // Get photographer's public galleries
            GalleryManager galleryManager = new GalleryManager();
            List<Gallery> galleries = galleryManager.getGalleriesByPhotographer(photographerId);

            // Filter to public galleries only
            galleries = galleries.stream()
                    .filter(g -> g.getVisibility() == Gallery.GalleryVisibility.PUBLIC)
                    .filter(g -> g.getStatus() == Gallery.GalleryStatus.PUBLISHED)
                    .filter(g -> !g.isExpired())
                    .toList();

            // Get photographer's reviews
            ReviewManager reviewManager = new ReviewManager();
            List<Review> reviews = reviewManager.getApprovedReviewsByPhotographer(photographerId);

            // Get rating distribution
            int[] ratingDistribution = reviewManager.getRatingDistribution(photographerId);

            // Check if the current user can review this photographer
            boolean canReview = false;

            if (session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");

                // Only clients can leave reviews, and not for themselves
                if (currentUser.getUserType() == User.UserType.CLIENT &&
                        !currentUser.getUserId().equals(photographer.getUserId())) {

                    canReview = reviewManager.canUserReviewPhotographer(
                            currentUser.getUserId(),
                            photographerId
                    );
                }
            }

            // Check if photographer is in user's favorites
            boolean isFavorite = false;
            if (session != null && session.getAttribute("user") != null) {
                User currentUser = (User) session.getAttribute("user");

                // Check favorites (implementation would depend on your favorites system)
                // This is just a placeholder
                // isFavorite = userManager.isPhotographerInFavorites(currentUser.getUserId(), photographerId);
            }

            // Set attributes for the view
            request.setAttribute("photographer", photographer);
            request.setAttribute("galleries", galleries);
            request.setAttribute("reviews", reviews);
            request.setAttribute("ratingDistribution", ratingDistribution);
            request.setAttribute("canReview", canReview);
            request.setAttribute("isFavorite", isFavorite);

            // Forward to photographer profile JSP
            request.getRequestDispatcher("/photographer/photographer_profile.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error in PhotographerServlet.doGet: " + e.getMessage());
            e.printStackTrace();

            if (session != null) {
                session.setAttribute("errorMessage", "An error occurred while loading the photographer profile.");
            }
            response.sendRedirect(request.getContextPath() + "/photographer/list");
        }
    }
}