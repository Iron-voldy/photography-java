package com.photobooking.model.gallery;

import com.photobooking.util.FileHandler;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Manages gallery-related operations for the Event Photography System
 */
public class GalleryManager {
    private static final String GALLERY_FILE = "galleries.txt";
    private static final String IMAGE_FILE = "images.txt";
    private List<Gallery> galleries;
    private Map<String, List<Image>> imagesByGallery;

    /**
     * Constructor initializes the manager and loads galleries and images
     */
    public GalleryManager() {
        this.galleries = loadGalleries();
        this.imagesByGallery = loadImages();
    }

    /**
     * Load galleries from file
     * @return List of galleries
     */
    private List<Gallery> loadGalleries() {
        List<String> lines = FileHandler.readLines(GALLERY_FILE);
        List<Gallery> loadedGalleries = new ArrayList<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Gallery gallery = Gallery.fromFileString(line);
                if (gallery != null) {
                    loadedGalleries.add(gallery);
                }
            }
        }

        return loadedGalleries;
    }

    /**
     * Load images from file and organize by gallery
     * @return Map of gallery ID to list of images
     */
    private Map<String, List<Image>> loadImages() {
        List<String> lines = FileHandler.readLines(IMAGE_FILE);
        Map<String, List<Image>> imageMap = new HashMap<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Image image = Image.fromFileString(line);
                if (image != null && image.getGalleryId() != null) {
                    // Add image to its gallery's list
                    imageMap.computeIfAbsent(image.getGalleryId(), k -> new ArrayList<>())
                            .add(image);
                }
            }
        }

        return imageMap;
    }

    /**
     * Save all galleries to file
     * @return true if successful, false otherwise
     */
    private boolean saveGalleries() {
        try {
            // Delete existing file content
            FileHandler.deleteFile(GALLERY_FILE);

            // Write each gallery to file
            for (Gallery gallery : galleries) {
                FileHandler.appendLine(GALLERY_FILE, gallery.toFileString());
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error saving galleries: " + e.getMessage());
            return false;
        }
    }

    /**
     * Save all images to file
     * @return true if successful, false otherwise
     */
    private boolean saveImages() {
        try {
            // Delete existing file content
            FileHandler.deleteFile(IMAGE_FILE);

            // Write each image to file
            for (List<Image> images : imagesByGallery.values()) {
                for (Image image : images) {
                    FileHandler.appendLine(IMAGE_FILE, image.toFileString());
                }
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error saving images: " + e.getMessage());
            return false;
        }
    }

    /**
     * Create a new gallery
     * @param gallery The gallery to create
     * @return true if successful, false otherwise
     */
    public boolean createGallery(Gallery gallery) {
        if (gallery == null || gallery.getGalleryId() == null || gallery.getPhotographerId() == null) {
            return false;
        }

        // Initialize images list for this gallery
        imagesByGallery.put(gallery.getGalleryId(), new ArrayList<>());

        // Add gallery and save
        galleries.add(gallery);
        return saveGalleries();
    }

    /**
     * Get gallery by ID
     * @param galleryId The gallery ID
     * @return The gallery or null if not found
     */
    public Gallery getGalleryById(String galleryId) {
        if (galleryId == null) return null;

        return galleries.stream()
                .filter(g -> g.getGalleryId().equals(galleryId))
                .findFirst()
                .orElse(null);
    }

    /**
     * Update an existing gallery
     * @param updatedGallery The updated gallery
     * @return true if successful, false otherwise
     */
    public boolean updateGallery(Gallery updatedGallery) {
        if (updatedGallery == null || updatedGallery.getGalleryId() == null) {
            return false;
        }

        for (int i = 0; i < galleries.size(); i++) {
            if (galleries.get(i).getGalleryId().equals(updatedGallery.getGalleryId())) {
                galleries.set(i, updatedGallery);
                return saveGalleries();
            }
        }

        return false; // Gallery not found
    }

    /**
     * Delete a gallery and all its images
     * @param galleryId The gallery ID
     * @return true if successful, false otherwise
     */
    public boolean deleteGallery(String galleryId) {
        if (galleryId == null) {
            return false;
        }

        boolean removed = galleries.removeIf(g -> g.getGalleryId().equals(galleryId));
        if (removed) {
            // Remove images for this gallery
            imagesByGallery.remove(galleryId);

            // Save changes
            return saveGalleries() && saveImages();
        }

        return false; // Gallery not found
    }

    /**
     * Get all galleries
     * @return List of all galleries
     */
    public List<Gallery> getAllGalleries() {
        return new ArrayList<>(galleries);
    }

    /**
     * Get galleries by photographer
     * @param photographerId The photographer ID
     * @return List of galleries for the photographer
     */
    public List<Gallery> getGalleriesByPhotographer(String photographerId) {
        if (photographerId == null) return new ArrayList<>();

        return galleries.stream()
                .filter(g -> g.getPhotographerId().equals(photographerId))
                .collect(Collectors.toList());
    }

    /**
     * Get galleries by client
     * @param clientId The client ID
     * @return List of galleries for the client
     */
    public List<Gallery> getGalleriesByClient(String clientId) {
        if (clientId == null) return new ArrayList<>();

        return galleries.stream()
                .filter(g -> g.getClientId() != null && g.getClientId().equals(clientId))
                .collect(Collectors.toList());
    }

    /**
     * Get galleries by booking
     * @param bookingId The booking ID
     * @return List of galleries for the booking
     */
    public List<Gallery> getGalleriesByBooking(String bookingId) {
        if (bookingId == null) return new ArrayList<>();

        return galleries.stream()
                .filter(g -> g.getBookingId() != null && g.getBookingId().equals(bookingId))
                .collect(Collectors.toList());
    }

    /**
     * Get galleries by category
     * @param category The category
     * @return List of galleries for the category
     */
    public List<Gallery> getGalleriesByCategory(String category) {
        if (category == null) return new ArrayList<>();

        return galleries.stream()
                .filter(g -> g.getCategory() != null && g.getCategory().equals(category))
                .collect(Collectors.toList());
    }

    /**
     * Get public galleries
     * @return List of public galleries
     */
    public List<Gallery> getPublicGalleries() {
        return galleries.stream()
                .filter(g -> g.getVisibility() == Gallery.GalleryVisibility.PUBLIC)
                .filter(g -> g.getStatus() == Gallery.GalleryStatus.PUBLISHED)
                .filter(g -> !g.isExpired())
                .collect(Collectors.toList());
    }

    /**
     * Get images for a gallery
     * @param galleryId The gallery ID
     * @return List of images for the gallery
     */
    public List<Image> getImagesForGallery(String galleryId) {
        if (galleryId == null) return new ArrayList<>();

        List<Image> images = imagesByGallery.get(galleryId);
        return images != null ? new ArrayList<>(images) : new ArrayList<>();
    }

    /**
     * Add an image to a gallery
     * @param image The image to add
     * @return true if successful, false otherwise
     */
    public boolean addImageToGallery(Image image) {
        if (image == null || image.getGalleryId() == null) {
            return false;
        }

        // Check if gallery exists
        Gallery gallery = getGalleryById(image.getGalleryId());
        if (gallery == null) {
            return false;
        }

        // Add image to gallery's list
        List<Image> images = imagesByGallery.computeIfAbsent(image.getGalleryId(), k -> new ArrayList<>());
        images.add(image);

        // Update gallery's lastUpdatedDate
        gallery.setLastUpdatedDate(LocalDateTime.now());
        updateGallery(gallery);

        return saveImages();
    }

    /**
     * Remove an image from a gallery
     * @param galleryId The gallery ID
     * @param imageId The image ID
     * @return true if successful, false otherwise
     */
    public boolean removeImageFromGallery(String galleryId, String imageId) {
        if (galleryId == null || imageId == null) {
            return false;
        }

        // Check if gallery exists
        List<Image> images = imagesByGallery.get(galleryId);
        if (images == null) {
            return false;
        }

        // Remove image
        boolean removed = images.removeIf(img -> img.getImageId().equals(imageId));

        if (removed) {
            // Update gallery's lastUpdatedDate
            Gallery gallery = getGalleryById(galleryId);
            if (gallery != null) {
                gallery.setLastUpdatedDate(LocalDateTime.now());

                // If removed image was the cover image, set a new one
                if (gallery.getCoverId() != null && gallery.getCoverId().equals(imageId)) {
                    if (!images.isEmpty()) {
                        gallery.setCoverId(images.get(0).getImageId());
                    } else {
                        gallery.setCoverId(null);
                    }
                }

                updateGallery(gallery);
            }

            return saveImages();
        }

        return false;
    }

    /**
     * Get image by ID
     * @param imageId The image ID
     * @return The image or null if not found
     */
    public Image getImageById(String imageId) {
        if (imageId == null) return null;

        for (List<Image> images : imagesByGallery.values()) {
            for (Image image : images) {
                if (image.getImageId().equals(imageId)) {
                    return image;
                }
            }
        }

        return null;
    }

    /**
     * Update an image
     * @param updatedImage The updated image
     * @return true if successful, false otherwise
     */
    public boolean updateImage(Image updatedImage) {
        if (updatedImage == null || updatedImage.getImageId() == null || updatedImage.getGalleryId() == null) {
            return false;
        }

        List<Image> images = imagesByGallery.get(updatedImage.getGalleryId());
        if (images == null) {
            return false;
        }

        for (int i = 0; i < images.size(); i++) {
            if (images.get(i).getImageId().equals(updatedImage.getImageId())) {
                images.set(i, updatedImage);
                return saveImages();
            }
        }

        return false; // Image not found
    }

    /**
     * Publish a gallery
     * @param galleryId The gallery ID
     * @return true if successful, false otherwise
     */
    public boolean publishGallery(String galleryId) {
        Gallery gallery = getGalleryById(galleryId);
        if (gallery == null) {
            return false;
        }

        if (gallery.publish()) {
            return updateGallery(gallery);
        }

        return false;
    }

    /**
     * Archive a gallery
     * @param galleryId The gallery ID
     * @return true if successful, false otherwise
     */
    public boolean archiveGallery(String galleryId) {
        Gallery gallery = getGalleryById(galleryId);
        if (gallery == null) {
            return false;
        }

        if (gallery.archive()) {
            return updateGallery(gallery);
        }

        return false;
    }

    /**
     * Set gallery visibility
     * @param galleryId The gallery ID
     * @param visibility The new visibility
     * @return true if successful, false otherwise
     */
    public boolean setGalleryVisibility(String galleryId, Gallery.GalleryVisibility visibility) {
        if (visibility == null) {
            return false;
        }

        Gallery gallery = getGalleryById(galleryId);
        if (gallery == null) {
            return false;
        }

        gallery.setVisibility(visibility);
        gallery.setLastUpdatedDate(LocalDateTime.now());

        return updateGallery(gallery);
    }

    /**
     * Set gallery password
     * @param galleryId The gallery ID
     * @param password The new password
     * @return true if successful, false otherwise
     */
    public boolean setGalleryPassword(String galleryId, String password) {
        Gallery gallery = getGalleryById(galleryId);
        if (gallery == null) {
            return false;
        }

        gallery.setAccessPassword(password);
        gallery.setVisibility(Gallery.GalleryVisibility.PASSWORD_PROTECTED);
        gallery.setLastUpdatedDate(LocalDateTime.now());

        return updateGallery(gallery);
    }

    /**
     * Increment gallery view count
     * @param galleryId The gallery ID
     * @return true if successful, false otherwise
     */
    public boolean incrementGalleryViewCount(String galleryId) {
        Gallery gallery = getGalleryById(galleryId);
        if (gallery == null) {
            return false;
        }

        gallery.incrementViewCount();
        return updateGallery(gallery);
    }

    /**
     * Increment image view count
     * @param imageId The image ID
     * @return true if successful, false otherwise
     */
    public boolean incrementImageViewCount(String imageId) {
        Image image = getImageById(imageId);
        if (image == null) {
            return false;
        }

        image.incrementViewCount();
        return updateImage(image);
    }

    /**
     * Increment gallery download count
     * @param galleryId The gallery ID
     * @return true if successful, false otherwise
     */
    public boolean incrementGalleryDownloadCount(String galleryId) {
        Gallery gallery = getGalleryById(galleryId);
        if (gallery == null) {
            return false;
        }

        gallery.incrementDownloadCount();
        return updateGallery(gallery);
    }

    /**
     * Increment image download count
     * @param imageId The image ID
     * @return true if successful, false otherwise
     */
    public boolean incrementImageDownloadCount(String imageId) {
        Image image = getImageById(imageId);
        if (image == null) {
            return false;
        }

        image.incrementDownloadCount();
        return updateImage(image);
    }

    /**
     * Toggle image favorite status
     * @param imageId The image ID
     * @return true if successful, false otherwise
     */
    public boolean toggleImageFavorite(String imageId) {
        Image image = getImageById(imageId);
        if (image == null) {
            return false;
        }

        image.toggleFavorite();
        return updateImage(image);
    }

    /**
     * Get favorite images from a gallery
     * @param galleryId The gallery ID
     * @return List of favorite images
     */
    public List<Image> getFavoriteImages(String galleryId) {
        List<Image> images = getImagesForGallery(galleryId);

        return images.stream()
                .filter(Image::isFavorite)
                .collect(Collectors.toList());
    }

    /**
     * Check if gallery is accessible by a user
     * @param galleryId The gallery ID
     * @param userId The user ID
     * @param isAdmin Whether the user is an admin
     * @return true if accessible, false otherwise
     */
    public boolean isGalleryAccessibleByUser(String galleryId, String userId, boolean isAdmin) {
        Gallery gallery = getGalleryById(galleryId);
        if (gallery == null) {
            return false;
        }

        // Admins can access all galleries
        if (isAdmin) {
            return true;
        }

        // Photographer who owns the gallery can access it
        if (userId.equals(gallery.getPhotographerId())) {
            return true;
        }

        // Client who the gallery is for can access it
        if (gallery.getClientId() != null && userId.equals(gallery.getClientId())) {
            return true;
        }

        // Public galleries are accessible by all users
        if (gallery.getVisibility() == Gallery.GalleryVisibility.PUBLIC &&
                gallery.getStatus() == Gallery.GalleryStatus.PUBLISHED &&
                !gallery.isExpired()) {
            return true;
        }

        // Password-protected galleries need password verification (handled elsewhere)

        return false;
    }

    /**
     * Search galleries by keyword
     * @param keyword The keyword to search for
     * @return List of matching galleries
     */
    public List<Gallery> searchGalleries(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return new ArrayList<>(galleries);
        }

        String searchTerm = keyword.toLowerCase().trim();

        return galleries.stream()
                .filter(g -> {
                    // Search in title
                    if (g.getTitle() != null &&
                            g.getTitle().toLowerCase().contains(searchTerm)) {
                        return true;
                    }

                    // Search in description
                    if (g.getDescription() != null &&
                            g.getDescription().toLowerCase().contains(searchTerm)) {
                        return true;
                    }

                    // Search in category
                    if (g.getCategory() != null &&
                            g.getCategory().toLowerCase().contains(searchTerm)) {
                        return true;
                    }

                    return false;
                })
                .collect(Collectors.toList());
    }
}