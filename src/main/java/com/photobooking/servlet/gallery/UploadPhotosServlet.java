package com.photobooking.servlet.gallery;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.booking.Booking;
import com.photobooking.model.booking.BookingManager;
import com.photobooking.model.gallery.Gallery;
import com.photobooking.model.gallery.GalleryManager;
import com.photobooking.model.user.User;
import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Servlet for preparing data for photo upload page
 */
@WebServlet("/gallery/upload-form")
public class UploadPhotosServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UploadPhotosServlet.class.getName());

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
            session.setAttribute("errorMessage", "Only photographers can upload photos");
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }

        try {
            LOGGER.info("UploadPhotosServlet: Starting to prepare upload form for user: " + currentUser.getUserId());

            // First, check if the photographer has galleries with their userId
            GalleryManager galleryManager = new GalleryManager(getServletContext());
            List<Gallery> galleriesByUserId = galleryManager.getGalleriesByPhotographer(currentUser.getUserId());

            if (galleriesByUserId != null && !galleriesByUserId.isEmpty()) {
                // User has galleries with their userId, so use that
                LOGGER.info("Found " + galleriesByUserId.size() + " galleries using userId: " + currentUser.getUserId());

                // Update the photographerId in session to be the userId
                session.setAttribute("photographerId", currentUser.getUserId());
                LOGGER.info("Updated photographerId in session to userId: " + currentUser.getUserId());

                // Get bookings for the photographer
                BookingManager bookingManager = new BookingManager(getServletContext());
                List<Booking> bookings = bookingManager.getBookingsByPhotographer(currentUser.getUserId());
                LOGGER.info("Found " + bookings.size() + " bookings for photographer using userId: " + currentUser.getUserId());

                // Set attributes for the JSP
                request.setAttribute("galleries", galleriesByUserId);
                request.setAttribute("bookings", bookings);
            } else {
                // If not, try with photographerId from session or PhotographerManager
                String photographerId = (String) session.getAttribute("photographerId");

                if (photographerId == null) {
                    // If not in session, try to get from PhotographerManager
                    PhotographerManager photographerManager = new PhotographerManager(getServletContext());
                    Photographer photographer = photographerManager.getPhotographerByUserId(currentUser.getUserId());

                    if (photographer != null) {
                        photographerId = photographer.getPhotographerId();
                        // Save in session for future use
                        session.setAttribute("photographerId", photographerId);
                        LOGGER.info("Found photographer ID from manager: " + photographerId);
                    } else {
                        // Last resort, use userId directly since that's what seems to be used for galleries
                        photographerId = currentUser.getUserId();
                        session.setAttribute("photographerId", photographerId);
                        LOGGER.info("Using user ID as photographer ID: " + photographerId);
                    }
                } else {
                    LOGGER.info("Using photographerId from session: " + photographerId);

                    // Check if there are galleries with this photographerId
                    List<Gallery> galleriesWithSessionId = galleryManager.getGalleriesByPhotographer(photographerId);
                    if (galleriesWithSessionId == null || galleriesWithSessionId.isEmpty()) {
                        // If no galleries found with the session photographerId, try with userId instead
                        LOGGER.info("No galleries found with session photographerId. Trying with userId instead.");
                        photographerId = currentUser.getUserId();
                        session.setAttribute("photographerId", photographerId);
                        LOGGER.info("Updated photographerId in session to userId: " + photographerId);
                    }
                }

                // Get galleries for the photographer
                List<Gallery> galleries = galleryManager.getGalleriesByPhotographer(photographerId);
                LOGGER.info("Found " + galleries.size() + " galleries for photographer: " + photographerId);

                // Get bookings for the photographer
                BookingManager bookingManager = new BookingManager(getServletContext());
                List<Booking> bookings = bookingManager.getBookingsByPhotographer(photographerId);
                LOGGER.info("Found " + bookings.size() + " bookings for photographer: " + photographerId);

                // Set attributes for the JSP
                request.setAttribute("galleries", galleries);
                request.setAttribute("bookings", bookings);
            }

            // Handle a pre-selected gallery ID if provided
            String selectedGalleryId = request.getParameter("galleryId");
            if (selectedGalleryId != null && !selectedGalleryId.isEmpty()) {
                LOGGER.info("Pre-selected gallery ID: " + selectedGalleryId);
                request.setAttribute("selectedGalleryId", selectedGalleryId);
            }

            // Forward to the upload form
            LOGGER.info("Forwarding to upload_photos.jsp");
            request.getRequestDispatcher("/gallery/upload_photos.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error preparing upload form: " + e.getMessage(), e);
            session.setAttribute("errorMessage", "Error loading upload form: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/gallery/list?userOnly=true");
        }
    }
}