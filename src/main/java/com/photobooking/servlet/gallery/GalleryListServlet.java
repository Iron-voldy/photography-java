// GalleryListServlet.java
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

import com.photobooking.model.gallery.Gallery;
import com.photobooking.model.gallery.GalleryManager;
import com.photobooking.model.gallery.PhotoManager;
import com.photobooking.model.gallery.Photo;
import com.photobooking.model.user.User;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Servlet for displaying gallery list
 */
@WebServlet("/gallery/list")
public class GalleryListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(GalleryListServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Check if user only galleries are requested
        boolean userOnly = "true".equals(request.getParameter("userOnly"));

        if (userOnly && (currentUser == null)) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        try {
            GalleryManager galleryManager = new GalleryManager(getServletContext());
            PhotoManager photoManager = new PhotoManager(getServletContext());
            List<Gallery> galleries = new ArrayList<>();

            // Debug log to see what's happening
            LOGGER.info("GalleryListServlet: Fetching galleries. userOnly=" + userOnly);

            // Filter galleries based on request and user type
            if (userOnly && currentUser != null) {
                if (currentUser.getUserType() == User.UserType.PHOTOGRAPHER) {
                    // Photographer's own galleries
                    galleries = galleryManager.getGalleriesByPhotographer(currentUser.getUserId());
                    LOGGER.info("Fetching photographer galleries for user: " + currentUser.getUserId() + ", found: " + galleries.size());
                } else if (currentUser.getUserType() == User.UserType.CLIENT) {
                    // Galleries shared with this client
                    galleries = galleryManager.getGalleriesByClient(currentUser.getUserId());
                    LOGGER.info("Fetching client galleries for user: " + currentUser.getUserId() + ", found: " + galleries.size());
                }
            } else {
                // Public galleries - for everyone
                String category = request.getParameter("category");
                String search = request.getParameter("search");

                if (category != null && !category.trim().isEmpty()) {
                    galleries = galleryManager.getGalleriesByCategory(category);
                    LOGGER.info("Fetching galleries by category: " + category + ", found: " + galleries.size());
                } else if (search != null && !search.trim().isEmpty()) {
                    galleries = galleryManager.searchGalleries(search);
                    // Filter only published galleries for public view
                    List<Gallery> filteredGalleries = new ArrayList<>();
                    for (Gallery gallery : galleries) {
                        if (gallery.getStatus() == Gallery.GalleryStatus.PUBLISHED) {
                            filteredGalleries.add(gallery);
                        }
                    }
                    galleries = filteredGalleries;
                    LOGGER.info("Fetching galleries by search: " + search + ", found: " + galleries.size());
                } else {
                    // All public galleries
                    galleries = galleryManager.searchGalleries("");
                    // Filter only published galleries
                    List<Gallery> filteredGalleries = new ArrayList<>();
                    for (Gallery gallery : galleries) {
                        if (gallery.getStatus() == Gallery.GalleryStatus.PUBLISHED) {
                            filteredGalleries.add(gallery);
                        }
                    }
                    galleries = filteredGalleries;
                    LOGGER.info("Fetching all public galleries, found: " + galleries.size());
                }
            }

            // Log gallery IDs for debugging
            for (Gallery gallery : galleries) {
                LOGGER.info("Gallery found: ID=" + gallery.getGalleryId() + ", Title=" + gallery.getTitle());
            }

            // Get cover photos for each gallery
            for (Gallery gallery : galleries) {
                if (gallery.getCoverPhotoId() != null) {
                    Photo coverPhoto = photoManager.getPhotoById(gallery.getCoverPhotoId());
                    if (coverPhoto != null) {
                        request.setAttribute("coverPhoto_" + gallery.getGalleryId(), coverPhoto);
                    }
                }
            }

            // Set attributes for JSP
            request.setAttribute("galleries", galleries);
            request.setAttribute("userOnly", userOnly);

            // Forward to JSP
            request.getRequestDispatcher("/gallery/gallery_list.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error displaying gallery list: " + e.getMessage(), e);
            if (session != null) {
                session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}