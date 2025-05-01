package com.photobooking.model.gallery;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Represents a private gallery in the Event Photography System
 */
public class PrivateGallery extends Gallery {
    private static final long serialVersionUID = 1L;

    // Additional attributes for private galleries
    private List<String> authorizedUserIds; // List of users who can access the gallery
    private boolean requiresPassword;
    private boolean notifyOnAccess;
    private LocalDateTime lastAccessDate;
    private String lastAccessUser;
    private int accessCount;
    private boolean watermarkImages;
    private String accessCode; // Short code for easy sharing
    private LocalDateTime passwordExpiryDate;
    private int maxViewsPerPhoto; // Limit the number of views per photo (0 = unlimited)

    /**
     * Default constructor
     */
    public PrivateGallery() {
        super();
        this.setVisibility(GalleryVisibility.PRIVATE);
        this.authorizedUserIds = new ArrayList<>();
        this.requiresPassword = false;
        this.notifyOnAccess = true;
        this.accessCount = 0;
        this.watermarkImages = true;
        this.maxViewsPerPhoto = 0; // unlimited by default
    }

    /**
     * Constructor with parameters
     * @param title Gallery title
     * @param description Gallery description
     * @param photographerId Photographer ID
     * @param category Gallery category
     * @param clientId Client ID
     */
    public PrivateGallery(String title, String description, String photographerId,
                          String category, String clientId) {
        super(title, description, photographerId, category);
        this.setVisibility(GalleryVisibility.PRIVATE);
        this.setClientId(clientId);
        this.authorizedUserIds = new ArrayList<>();
        if (clientId != null) {
            this.authorizedUserIds.add(clientId);
        }
        this.requiresPassword = false;
        this.notifyOnAccess = true;
        this.accessCount = 0;
        this.watermarkImages = true;
        this.maxViewsPerPhoto = 0;
    }

    // Getters and setters
    public List<String> getAuthorizedUserIds() {
        return authorizedUserIds;
    }

    public void setAuthorizedUserIds(List<String> authorizedUserIds) {
        this.authorizedUserIds = authorizedUserIds;
    }

    public boolean isRequiresPassword() {
        return requiresPassword;
    }

    public void setRequiresPassword(boolean requiresPassword) {
        this.requiresPassword = requiresPassword;

        // Update visibility if password is required
        if (requiresPassword) {
            this.setVisibility(GalleryVisibility.PASSWORD_PROTECTED);
        } else {
            this.setVisibility(GalleryVisibility.PRIVATE);
        }
    }

    public boolean isNotifyOnAccess() {
        return notifyOnAccess;
    }

    public void setNotifyOnAccess(boolean notifyOnAccess) {
        this.notifyOnAccess = notifyOnAccess;
    }

    public LocalDateTime getLastAccessDate() {
        return lastAccessDate;
    }

    public void setLastAccessDate(LocalDateTime lastAccessDate) {
        this.lastAccessDate = lastAccessDate;
    }

    public String getLastAccessUser() {
        return lastAccessUser;
    }

    public void setLastAccessUser(String lastAccessUser) {
        this.lastAccessUser = lastAccessUser;
    }

    public int getAccessCount() {
        return accessCount;
    }

    public void setAccessCount(int accessCount) {
        this.accessCount = accessCount;
    }

    public boolean isWatermarkImages() {
        return watermarkImages;
    }

    public void setWatermarkImages(boolean watermarkImages) {
        this.watermarkImages = watermarkImages;
    }

    public String getAccessCode() {
        return accessCode;
    }

    public void setAccessCode(String accessCode) {
        this.accessCode = accessCode;
    }

    public LocalDateTime getPasswordExpiryDate() {
        return passwordExpiryDate;
    }

    public void setPasswordExpiryDate(LocalDateTime passwordExpiryDate) {
        this.passwordExpiryDate = passwordExpiryDate;
    }

    public int getMaxViewsPerPhoto() {
        return maxViewsPerPhoto;
    }

    public void setMaxViewsPerPhoto(int maxViewsPerPhoto) {
        this.maxViewsPerPhoto = maxViewsPerPhoto;
    }

    // Business methods
    /**
     * Add authorized user
     * @param userId User ID to authorize
     * @return true if added, false if already authorized
     */
    public boolean addAuthorizedUser(String userId) {
        if (userId == null || authorizedUserIds.contains(userId)) {
            return false;
        }

        return authorizedUserIds.add(userId);
    }

    /**
     * Remove authorized user
     * @param userId User ID to remove
     * @return true if removed, false if not found
     */
    public boolean removeAuthorizedUser(String userId) {
        if (userId == null) {
            return false;
        }

        return authorizedUserIds.remove(userId);
    }

    /**
     * Check if user is authorized
     * @param userId User ID to check
     * @return true if authorized, false otherwise
     */
    public boolean isUserAuthorized(String userId) {
        if (userId == null) {
            return false;
        }

        // Photographer is always authorized
        if (userId.equals(getPhotographerId())) {
            return true;
        }

        return authorizedUserIds.contains(userId);
    }

    /**
     * Record an access
     * @param userId User ID accessing the gallery
     */
    public void recordAccess(String userId) {
        this.lastAccessDate = LocalDateTime.now();
        this.lastAccessUser = userId;
        this.accessCount++;
    }

    /**
     * Generate a new access code
     * @return The generated access code
     */
    public String generateAccessCode() {
        // Generate a random 6-character alphanumeric code
        String characters = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        StringBuilder codeBuilder = new StringBuilder();

        for (int i = 0; i < 6; i++) {
            int index = (int) (Math.random() * characters.length());
            codeBuilder.append(characters.charAt(index));
        }

        this.accessCode = codeBuilder.toString();
        return this.accessCode;
    }

    /**
     * Check if password is expired
     * @return true if expired, false otherwise
     */
    public boolean isPasswordExpired() {
        if (passwordExpiryDate == null) {
            return false;
        }

        return LocalDateTime.now().isAfter(passwordExpiryDate);
    }

    /**
     * Set password with expiry
     * @param password The password
     * @param expiryDays Number of days until expiry
     */
    public void setPasswordWithExpiry(String password, int expiryDays) {
        this.setAccessPassword(password);
        this.requiresPassword = true;
        this.setVisibility(GalleryVisibility.PASSWORD_PROTECTED);

        if (expiryDays > 0) {
            this.passwordExpiryDate = LocalDateTime.now().plusDays(expiryDays);
        } else {
            this.passwordExpiryDate = null;
        }
    }

    /**
     * Check if a photo has reached its view limit
     * @param imageViews Number of views for the image
     * @return true if limit reached, false otherwise
     */
    public boolean isPhotoViewLimitReached(int imageViews) {
        if (maxViewsPerPhoto <= 0) {
            return false; // No limit
        }

        return imageViews >= maxViewsPerPhoto;
    }

    // Override methods
    @Override
    public String toFileString() {
        // Start with the parent class's implementation
        String baseString = super.toFileString();

        // Build the authorized users string
        String authorizedUsers = String.join("|", authorizedUserIds);

        // Append private gallery-specific attributes
        return baseString + ",PRIVATE," +
                authorizedUsers + "," +
                requiresPassword + "," +
                notifyOnAccess + "," +
                (lastAccessDate != null ? lastAccessDate.toString() : "") + "," +
                (lastAccessUser != null ? lastAccessUser : "") + "," +
                accessCount + "," +
                watermarkImages + "," +
                (accessCode != null ? accessCode : "") + "," +
                (passwordExpiryDate != null ? passwordExpiryDate.toString() : "") + "," +
                maxViewsPerPhoto;
    }

    /**
     * Create PrivateGallery from file string
     * @param fileString String representation from file
     * @return PrivateGallery object
     */
    public static PrivateGallery fromFileString(String fileString) {
        // Split the string into base part and private part
        String[] parts = fileString.split(",PRIVATE,");
        if (parts.length < 2) {
            return null; // Not a valid private gallery string
        }

        // Parse the base gallery first
        Gallery baseGallery = Gallery.fromFileString(parts[0]);
        if (baseGallery == null) {
            return null;
        }

        // Create a new PrivateGallery and copy properties from base
        PrivateGallery privateGallery = new PrivateGallery();
        privateGallery.setGalleryId(baseGallery.getGalleryId());
        privateGallery.setTitle(baseGallery.getTitle());
        privateGallery.setDescription(baseGallery.getDescription());
        privateGallery.setCoverId(baseGallery.getCoverId());
        privateGallery.setPhotographerId(baseGallery.getPhotographerId());
        privateGallery.setClientId(baseGallery.getClientId());
        privateGallery.setBookingId(baseGallery.getBookingId());
        privateGallery.setCreationDate(baseGallery.getCreationDate());
        privateGallery.setLastUpdatedDate(baseGallery.getLastUpdatedDate());
        privateGallery.setVisibility(baseGallery.getVisibility());
        privateGallery.setStatus(baseGallery.getStatus());
        privateGallery.setAccessPassword(baseGallery.getAccessPassword());
        privateGallery.setCategory(baseGallery.getCategory());
        privateGallery.setImages(baseGallery.getImages());
        privateGallery.setViewCount(baseGallery.getViewCount());
        privateGallery.setDownloadCount(baseGallery.getDownloadCount());
        privateGallery.setAllowDownloads(baseGallery.isAllowDownloads());
        privateGallery.setAllowSharing(baseGallery.isAllowSharing());
        privateGallery.setExpiryDate(baseGallery.getExpiryDate());

        // Parse private gallery-specific properties
        String[] privateParts = parts[1].split(",");
        if (privateParts.length >= 10) {
            // Parse authorized users
            String authUsers = privateParts[0];
            if (!authUsers.isEmpty()) {
                String[] users = authUsers.split("\\|");
                for (String user : users) {
                    privateGallery.addAuthorizedUser(user);
                }
            }

            privateGallery.setRequiresPassword(Boolean.parseBoolean(privateParts[1]));
            privateGallery.setNotifyOnAccess(Boolean.parseBoolean(privateParts[2]));

            String lastAccessDateStr = privateParts[3];
            if (!lastAccessDateStr.isEmpty()) {
                privateGallery.setLastAccessDate(LocalDateTime.parse(lastAccessDateStr));
            }

            privateGallery.setLastAccessUser(privateParts[4]);
            privateGallery.setAccessCount(Integer.parseInt(privateParts[5]));
            privateGallery.setWatermarkImages(Boolean.parseBoolean(privateParts[6]));
            privateGallery.setAccessCode(privateParts[7]);

            String passwordExpiryDateStr = privateParts[8];
            if (!passwordExpiryDateStr.isEmpty()) {
                privateGallery.setPasswordExpiryDate(LocalDateTime.parse(passwordExpiryDateStr));
            }

            privateGallery.setMaxViewsPerPhoto(Integer.parseInt(privateParts[9]));
        }

        return privateGallery;
    }
}