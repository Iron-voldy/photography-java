// UploadPhotoServlet.java
package com.photobooking.servlet.gallery;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.photobooking.model.gallery.Gallery;
import com.photobooking.model.gallery.GalleryManager;
import com.photobooking.model.gallery.Photo;
import com.photobooking.model.gallery.PhotoManager;
import com.photobooking.model.user.User;
import com.photobooking.util.ValidationUtil;

/**
 * Servlet for handling photo uploads
 */
@WebServlet("/gallery/upload")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 20,       // 20MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UploadPhotoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UploadPhotoServlet.class.getName());

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
            session.setAttribute("errorMessage", "Only photographers can upload photos");
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }

        // Get parameters
        String galleryId = request.getParameter("galleryId");
        String galleryType = request.getParameter("galleryType");

        // Validate gallery ID for existing gallery
        if ("existing".equals(galleryType) && (galleryId == null || galleryId.trim().isEmpty())) {
            session.setAttribute("errorMessage", "Gallery ID is required");
            response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
            return;
        }

        try {
            GalleryManager galleryManager = new GalleryManager(getServletContext());
            PhotoManager photoManager = new PhotoManager(getServletContext());

            // Create a new gallery if requested
            if ("new".equals(galleryType)) {
                String galleryTitle = ValidationUtil.cleanInput(request.getParameter("galleryTitle"));
                String galleryDescription = ValidationUtil.cleanInput(request.getParameter("galleryDescription"));
                String galleryCategory = request.getParameter("galleryCategory");
                String galleryBooking = request.getParameter("galleryBooking");
                boolean galleryPublic = "on".equals(request.getParameter("galleryPublic"));

                if (ValidationUtil.isNullOrEmpty(galleryTitle)) {
                    session.setAttribute("errorMessage", "Gallery title is required");
                    response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
                    return;
                }

                Gallery newGallery = new Gallery();
                newGallery.setTitle(galleryTitle);
                newGallery.setDescription(galleryDescription);
                newGallery.setCategory(galleryCategory);
                newGallery.setPhotographerId(currentUser.getUserId());

                if (!ValidationUtil.isNullOrEmpty(galleryBooking)) {
                    newGallery.setBookingId(galleryBooking);
                }

                newGallery.setStatus(galleryPublic ?
                        Gallery.GalleryStatus.PUBLISHED : Gallery.GalleryStatus.DRAFT);

                boolean created = galleryManager.createGallery(newGallery);
                if (!created) {
                    session.setAttribute("errorMessage", "Failed to create gallery");
                    response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
                    return;
                }

                galleryId = newGallery.getGalleryId();
            } else {
                // Verify gallery exists and belongs to the photographer
                Gallery gallery = galleryManager.getGalleryById(galleryId);

                if (gallery == null) {
                    session.setAttribute("errorMessage", "Gallery not found");
                    response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
                    return;
                }

                if (!gallery.getPhotographerId().equals(currentUser.getUserId())) {
                    session.setAttribute("errorMessage", "You don't have permission to upload photos to this gallery");
                    response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
                    return;
                }
            }

            // Process photo uploads
            List<Part> fileParts = new ArrayList<>();
            for (Part part : request.getParts()) {
                if (part.getName().equals("photos") && part.getSize() > 0) {
                    fileParts.add(part);
                }
            }

            if (fileParts.isEmpty()) {
                session.setAttribute("errorMessage", "No files uploaded");
                response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
                return;
            }

            // Auto-optimize images if requested
            boolean autoProcess = "on".equals(request.getParameter("autoProcess"));

            // Upload each photo
            int successCount = 0;
            for (Part filePart : fileParts) {
                String originalFileName = getFileName(filePart);
                if (originalFileName == null || originalFileName.trim().isEmpty()) {
                    continue;
                }

                // Create photo object
                Photo photo = new Photo();
                photo.setGalleryId(galleryId);
                photo.setPhotographerId(currentUser.getUserId());
                photo.setOriginalFileName(originalFileName);
                photo.setContentType(filePart.getContentType());

                // Read file data
                byte[] fileData;
                try (InputStream inputStream = filePart.getInputStream()) {
                    fileData = new byte[(int) filePart.getSize()];
                    inputStream.read(fileData);
                }

                // Upload photo
                boolean uploaded = photoManager.createPhoto(photo, fileData);

                if (uploaded) {
                    // Add to gallery
                    galleryManager.addPhotoToGallery(galleryId, photo.getPhotoId());
                    successCount++;
                }
            }

            // Set success message and redirect
            if (successCount > 0) {
                session.setAttribute("successMessage", successCount + " photo(s) uploaded successfully");
                response.sendRedirect(request.getContextPath() + "/gallery/details?id=" + galleryId);
            } else {
                session.setAttribute("errorMessage", "Failed to upload photos");
                response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error uploading photos: " + e.getMessage(), e);
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/gallery/upload_photos.jsp");
        }
    }

    /**
     * Extracts file name from HTTP header content-disposition
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
}