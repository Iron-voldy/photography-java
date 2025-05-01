package com.photobooking.model.gallery;

/**
 * Represents a public gallery in the Event Photography System
 */
public class PublicGallery extends Gallery {
    private static final long serialVersionUID = 1L;

    // Additional attributes for public galleries
    private boolean allowComments;
    private int commentCount;
    private boolean enableSocialSharing;
    private boolean enableDownloads;
    private String customShareMessage;

    /**
     * Default constructor
     */
    public PublicGallery() {
        super();
        this.setVisibility(GalleryVisibility.PUBLIC);
        this.allowComments = true;
        this.commentCount = 0;
        this.enableSocialSharing = true;
        this.enableDownloads = true;
        this.customShareMessage = "Check out this amazing photo gallery!";
    }

    /**
     * Constructor with parameters
     * @param title Gallery title
     * @param description Gallery description
     * @param photographerId Photographer ID
     * @param category Gallery category
     */
    public PublicGallery(String title, String description, String photographerId, String category) {
        super(title, description, photographerId, category);
        this.setVisibility(GalleryVisibility.PUBLIC);
        this.allowComments = true;
        this.commentCount = 0;
        this.enableSocialSharing = true;
        this.enableDownloads = true;
        this.customShareMessage = "Check out this amazing photo gallery!";
    }

    // Getters and setters
    public boolean isAllowComments() {
        return allowComments;
    }

    public void setAllowComments(boolean allowComments) {
        this.allowComments = allowComments;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public boolean isEnableSocialSharing() {
        return enableSocialSharing;
    }

    public void setEnableSocialSharing(boolean enableSocialSharing) {
        this.enableSocialSharing = enableSocialSharing;
    }

    public boolean isEnableDownloads() {
        return enableDownloads;
    }

    public void setEnableDownloads(boolean enableDownloads) {
        this.enableDownloads = enableDownloads;
        // Sync with parent class property
        this.setAllowDownloads(enableDownloads);
    }

    public String getCustomShareMessage() {
        return customShareMessage;
    }

    public void setCustomShareMessage(String customShareMessage) {
        this.customShareMessage = customShareMessage;
    }

    // Business methods
    /**
     * Increment comment count
     */
    public void incrementCommentCount() {
        this.commentCount++;
    }

    /**
     * Get sharing URL for the gallery
     * @param baseUrl Base application URL
     * @return Full sharing URL
     */
    public String getSharingUrl(String baseUrl) {
        if (baseUrl == null || baseUrl.isEmpty()) {
            baseUrl = "http://example.com"; // Default fallback
        }

        return baseUrl + "/gallery/" + getGalleryId();
    }

    /**
     * Get social media sharing link
     * @param platform Platform name (facebook, twitter, instagram, etc.)
     * @param baseUrl Base application URL
     * @return Social media sharing URL
     */
    public String getSocialSharingLink(String platform, String baseUrl) {
        String sharingUrl = getSharingUrl(baseUrl);
        String encodedUrl = sharingUrl.replace(":", "%3A").replace("/", "%2F");
        String encodedMessage = customShareMessage.replace(" ", "%20");

        switch (platform.toLowerCase()) {
            case "facebook":
                return "https://www.facebook.com/sharer/sharer.php?u=" + encodedUrl;
            case "twitter":
                return "https://twitter.com/intent/tweet?url=" + encodedUrl + "&text=" + encodedMessage;
            case "linkedin":
                return "https://www.linkedin.com/sharing/share-offsite/?url=" + encodedUrl;
            case "pinterest":
                // Pinterest needs an image URL
                return "https://pinterest.com/pin/create/button/?url=" + encodedUrl + "&description=" + encodedMessage;
            case "email":
                return "mailto:?subject=" + encodedMessage + "&body=" + encodedUrl;
            default:
                return sharingUrl;
        }
    }

    // Override methods
    @Override
    public String toFileString() {
        // Start with the parent class's implementation
        String baseString = super.toFileString();

        // Append public gallery-specific attributes
        return baseString + ",PUBLIC," +
                allowComments + "," +
                commentCount + "," +
                enableSocialSharing + "," +
                enableDownloads + "," +
                (customShareMessage != null ? customShareMessage.replace(",", ";;") : "");
    }

    /**
     * Create PublicGallery from file string
     * @param fileString String representation from file
     * @return PublicGallery object
     */
    public static PublicGallery fromFileString(String fileString) {
        // Split the string into base part and public part
        String[] parts = fileString.split(",PUBLIC,");
        if (parts.length < 2) {
            return null; // Not a valid public gallery string
        }

        // Parse the base gallery first
        Gallery baseGallery = Gallery.fromFileString(parts[0]);
        if (baseGallery == null) {
            return null;
        }

        // Create a new PublicGallery and copy properties from base
        PublicGallery publicGallery = new PublicGallery();
        publicGallery.setGalleryId(baseGallery.getGalleryId());
        publicGallery.setTitle(baseGallery.getTitle());
        publicGallery.setDescription(baseGallery.getDescription());
        publicGallery.setCoverId(baseGallery.getCoverId());
        publicGallery.setPhotographerId(baseGallery.getPhotographerId());
        publicGallery.setClientId(baseGallery.getClientId());
        publicGallery.setBookingId(baseGallery.getBookingId());
        publicGallery.setCreationDate(baseGallery.getCreationDate());
        publicGallery.setLastUpdatedDate(baseGallery.getLastUpdatedDate());
        publicGallery.setVisibility(baseGallery.getVisibility());
        publicGallery.setStatus(baseGallery.getStatus());
        publicGallery.setAccessPassword(baseGallery.getAccessPassword());
        publicGallery.setCategory(baseGallery.getCategory());
        publicGallery.setImages(baseGallery.getImages());
        publicGallery.setViewCount(baseGallery.getViewCount());
        publicGallery.setDownloadCount(baseGallery.getDownloadCount());
        publicGallery.setAllowDownloads(baseGallery.isAllowDownloads());
        publicGallery.setAllowSharing(baseGallery.isAllowSharing());
        publicGallery.setExpiryDate(baseGallery.getExpiryDate());

        // Parse public gallery-specific properties
        String[] publicParts = parts[1].split(",");
        if (publicParts.length >= 5) {
            publicGallery.setAllowComments(Boolean.parseBoolean(publicParts[0]));
            publicGallery.setCommentCount(Integer.parseInt(publicParts[1]));
            publicGallery.setEnableSocialSharing(Boolean.parseBoolean(publicParts[2]));
            publicGallery.setEnableDownloads(Boolean.parseBoolean(publicParts[3]));

            if (publicParts.length > 4) {
                publicGallery.setCustomShareMessage(publicParts[4].replace(";;", ","));
            }
        }

        return publicGallery;
    }
}