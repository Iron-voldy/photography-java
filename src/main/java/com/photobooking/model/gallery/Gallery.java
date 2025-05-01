package com.photobooking.model.gallery;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Base Gallery class for the Event Photography System
 */
public class Gallery implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * Gallery visibility types
     */
    public enum GalleryVisibility {
        PUBLIC("Public", "Visible to anyone with the link"),
        PRIVATE("Private", "Visible only to you and those you share with"),
        PASSWORD_PROTECTED("Password Protected", "Protected with a password");

        private final String displayName;
        private final String description;

        GalleryVisibility(String displayName, String description) {
            this.displayName = displayName;
            this.description = description;
        }

        public String getDisplayName() {
            return displayName;
        }

        public String getDescription() {
            return description;
        }
    }

    /**
     * Gallery status types
     */
    public enum GalleryStatus {
        DRAFT("Draft", "Gallery is being prepared, not visible to clients"),
        PUBLISHED("Published", "Gallery is live and accessible"),
        ARCHIVED("Archived", "Gallery is no longer actively maintained");

        private final String displayName;
        private final String description;

        GalleryStatus(String displayName, String description) {
            this.displayName = displayName;
            this.description = description;
        }

        public String getDisplayName() {
            return displayName;
        }

        public String getDescription() {
            return description;
        }
    }

    // Gallery attributes
    private String galleryId;
    private String title;
    private String description;
    private String coverId; // ID of cover image
    private String photographerId;
    private String clientId; // Optional, for client-specific galleries
    private String bookingId; // Optional, if gallery is associated with a booking
    private LocalDateTime creationDate;
    private LocalDateTime lastUpdatedDate;
    private GalleryVisibility visibility;
    private GalleryStatus status;
    private String accessPassword; // For password-protected galleries
    private String category; // e.g., WEDDING, PORTRAIT, etc.
    private List<Image> images;
    private int viewCount;
    private int downloadCount;
    private boolean allowDownloads;
    private boolean allowSharing;
    private LocalDateTime expiryDate; // Optional, for time-limited galleries

    // Constructors
    public Gallery() {
        this.galleryId = UUID.randomUUID().toString();
        this.creationDate = LocalDateTime.now();
        this.lastUpdatedDate = LocalDateTime.now();
        this.visibility = GalleryVisibility.PRIVATE;
        this.status = GalleryStatus.DRAFT;
        this.images = new ArrayList<>();
        this.viewCount = 0;
        this.downloadCount = 0;
        this.allowDownloads = true;
        this.allowSharing = true;
    }

    public Gallery(String title, String description, String photographerId, String category) {
        this();
        this.title = title;
        this.description = description;
        this.photographerId = photographerId;
        this.category = category;
    }

    // Getters and Setters
    public String getGalleryId() {
        return galleryId;
    }

    public void setGalleryId(String galleryId) {
        this.galleryId = galleryId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverId() {
        return coverId;
    }

    public void setCoverId(String coverId) {
        this.coverId = coverId;
    }

    public String getPhotographerId() {
        return photographerId;
    }

    public void setPhotographerId(String photographerId) {
        this.photographerId = photographerId;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public LocalDateTime getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDateTime creationDate) {
        this.creationDate = creationDate;
    }

    public LocalDateTime getLastUpdatedDate() {
        return lastUpdatedDate;
    }

    public void setLastUpdatedDate(LocalDateTime lastUpdatedDate) {
        this.lastUpdatedDate = lastUpdatedDate;
    }

    public GalleryVisibility getVisibility() {
        return visibility;
    }

    public void setVisibility(GalleryVisibility visibility) {
        this.visibility = visibility;
    }

    public GalleryStatus getStatus() {
        return status;
    }

    public void setStatus(GalleryStatus status) {
        this.status = status;
    }

    public String getAccessPassword() {
        return accessPassword;
    }

    public void setAccessPassword(String accessPassword) {
        this.accessPassword = accessPassword;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(int downloadCount) {
        this.downloadCount = downloadCount;
    }

    public boolean isAllowDownloads() {
        return allowDownloads;
    }

    public void setAllowDownloads(boolean allowDownloads) {
        this.allowDownloads = allowDownloads;
    }

    public boolean isAllowSharing() {
        return allowSharing;
    }

    public void setAllowSharing(boolean allowSharing) {
        this.allowSharing = allowSharing;
    }

    public LocalDateTime getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDateTime expiryDate) {
        this.expiryDate = expiryDate;
    }

    // Business methods
    /**
     * Add an image to the gallery
     * @param image Image to add
     * @return true if successful, false otherwise
     */
    public boolean addImage(Image image) {
        if (image == null) {
            return false;
        }

        images.add(image);
        lastUpdatedDate = LocalDateTime.now();

        // If this is the first image, make it the cover image
        if (coverId == null && images.size() == 1) {
            coverId = image.getImageId();
        }

        return true;
    }

    /**
     * Remove an image from the gallery
     * @param imageId ID of image to remove
     * @return true if image was found and removed, false otherwise
     */
    public boolean removeImage(String imageId) {
        if (imageId == null) {
            return false;
        }

        boolean removed = images.removeIf(img -> img.getImageId().equals(imageId));

        if (removed) {
            lastUpdatedDate = LocalDateTime.now();

            // If the removed image was the cover, set a new cover image
            if (imageId.equals(coverId) && !images.isEmpty()) {
                coverId = images.get(0).getImageId();
            }
        }

        return removed;
    }

    /**
     * Get image by ID
     * @param imageId ID of image to get
     * @return Image if found, null otherwise
     */
    public Image getImageById(String imageId) {
        if (imageId == null) {
            return null;
        }

        return images.stream()
                .filter(img -> img.getImageId().equals(imageId))
                .findFirst()
                .orElse(null);
    }

    /**
     * Get the cover image
     * @return Cover image if found, null otherwise
     */
    public Image getCoverImage() {
        if (coverId == null) {
            return images.isEmpty() ? null : images.get(0);
        }

        return getImageById(coverId);
    }

    /**
     * Set a new cover image
     * @param imageId ID of image to set as cover
     * @return true if image was found and set as cover, false otherwise
     */
    public boolean setCoverImage(String imageId) {
        Image image = getImageById(imageId);

        if (image != null) {
            this.coverId = imageId;
            lastUpdatedDate = LocalDateTime.now();
            return true;
        }

        return false;
    }

    /**
     * Increment the view count
     */
    public void incrementViewCount() {
        this.viewCount++;
    }

    /**
     * Increment the download count
     */
    public void incrementDownloadCount() {
        this.downloadCount++;
    }

    /**
     * Check if gallery is expired
     * @return true if gallery has an expiry date and is expired, false otherwise
     */
    public boolean isExpired() {
        return expiryDate != null && LocalDateTime.now().isAfter(expiryDate);
    }

    /**
     * Publish the gallery
     * @return true if successfully published, false if already published
     */
    public boolean publish() {
        if (status == GalleryStatus.PUBLISHED) {
            return false;
        }

        status = GalleryStatus.PUBLISHED;
        lastUpdatedDate = LocalDateTime.now();
        return true;
    }

    /**
     * Archive the gallery
     * @return true if successfully archived, false if already archived
     */
    public boolean archive() {
        if (status == GalleryStatus.ARCHIVED) {
            return false;
        }

        status = GalleryStatus.ARCHIVED;
        lastUpdatedDate = LocalDateTime.now();
        return true;
    }

    /**
     * Check if a password is correct for this gallery
     * @param password Password to check
     * @return true if correct or no password needed, false otherwise
     */
    public boolean checkPassword(String password) {
        // No password needed for non-password-protected galleries
        if (visibility != GalleryVisibility.PASSWORD_PROTECTED) {
            return true;
        }

        // No password set despite being password-protected
        if (accessPassword == null || accessPassword.isEmpty()) {
            return true;
        }

        return accessPassword.equals(password);
    }

    /**
     * Get the number of images in the gallery
     * @return Number of images
     */
    public int getImageCount() {
        return images.size();
    }

    /**
     * Convert gallery to file string representation
     * @return String representation for file storage
     */
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(galleryId).append(",");
        sb.append(title != null ? title.replace(",", ";;") : "").append(",");
        sb.append(description != null ? description.replace(",", ";;") : "").append(",");
        sb.append(coverId != null ? coverId : "").append(",");
        sb.append(photographerId != null ? photographerId : "").append(",");
        sb.append(clientId != null ? clientId : "").append(",");
        sb.append(bookingId != null ? bookingId : "").append(",");
        sb.append(creationDate != null ? creationDate.toString() : "").append(",");
        sb.append(lastUpdatedDate != null ? lastUpdatedDate.toString() : "").append(",");
        sb.append(visibility.name()).append(",");
        sb.append(status.name()).append(",");
        sb.append(accessPassword != null ? accessPassword : "").append(",");
        sb.append(category != null ? category : "").append(",");
        sb.append(viewCount).append(",");
        sb.append(downloadCount).append(",");
        sb.append(allowDownloads).append(",");
        sb.append(allowSharing).append(",");
        sb.append(expiryDate != null ? expiryDate.toString() : "");

        // Note: images are stored separately from the gallery metadata

        return sb.toString();
    }

    /**
     * Create gallery from file string
     * @param fileString String representation from file
     * @return Gallery object
     */
    public static Gallery fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length < 17) {
            return null; // Not enough parts for a valid gallery
        }

        Gallery gallery = new Gallery();
        int index = 0;

        gallery.setGalleryId(parts[index++]);
        gallery.setTitle(parts[index++].replace(";;", ","));
        gallery.setDescription(parts[index++].replace(";;", ","));

        String coverIdStr = parts[index++];
        if (!coverIdStr.isEmpty()) {
            gallery.setCoverId(coverIdStr);
        }

        String photographerIdStr = parts[index++];
        if (!photographerIdStr.isEmpty()) {
            gallery.setPhotographerId(photographerIdStr);
        }

        String clientIdStr = parts[index++];
        if (!clientIdStr.isEmpty()) {
            gallery.setClientId(clientIdStr);
        }

        String bookingIdStr = parts[index++];
        if (!bookingIdStr.isEmpty()) {
            gallery.setBookingId(bookingIdStr);
        }

        String creationDateStr = parts[index++];
        if (!creationDateStr.isEmpty()) {
            gallery.setCreationDate(LocalDateTime.parse(creationDateStr));
        }

        String lastUpdatedDateStr = parts[index++];
        if (!lastUpdatedDateStr.isEmpty()) {
            gallery.setLastUpdatedDate(LocalDateTime.parse(lastUpdatedDateStr));
        }

        gallery.setVisibility(GalleryVisibility.valueOf(parts[index++]));
        gallery.setStatus(GalleryStatus.valueOf(parts[index++]));

        String passwordStr = parts[index++];
        if (!passwordStr.isEmpty()) {
            gallery.setAccessPassword(passwordStr);
        }

        String categoryStr = parts[index++];
        if (!categoryStr.isEmpty()) {
            gallery.setCategory(categoryStr);
        }

        gallery.setViewCount(Integer.parseInt(parts[index++]));
        gallery.setDownloadCount(Integer.parseInt(parts[index++]));
        gallery.setAllowDownloads(Boolean.parseBoolean(parts[index++]));
        gallery.setAllowSharing(Boolean.parseBoolean(parts[index++]));

        String expiryDateStr = parts[index];
        if (!expiryDateStr.isEmpty()) {
            gallery.setExpiryDate(LocalDateTime.parse(expiryDateStr));
        }

        return gallery;
    }

    @Override
    public String toString() {
        return "Gallery{" +
                "galleryId='" + galleryId + '\'' +
                ", title='" + title + '\'' +
                ", photographerId='" + photographerId + '\'' +
                ", visibility=" + visibility +
                ", status=" + status +
                ", imageCount=" + images.size() +
                '}';
    }
}