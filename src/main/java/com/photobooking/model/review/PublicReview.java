package com.photobooking.model.review;

/**
 * Represents a public review (from any user) in the Event Photography System
 */
public class PublicReview extends Review {
    private static final long serialVersionUID = 1L;

    // Additional attributes for public reviews
    private String customerType; // Potential customer, past customer, etc.
    private String contactEmail;
    private String profileImageUrl;
    private String socialMediaHandle;
    private boolean hasEmailVerification;
    private boolean autoApproved;
    private int votesUp;
    private int votesDown;

    /**
     * Default constructor
     */
    public PublicReview() {
        super();
        this.hasEmailVerification = false;
        this.autoApproved = false;
        this.votesUp = 0;
        this.votesDown = 0;
    }

    /**
     * Constructor with parameters
     * @param photographerId Photographer ID
     * @param reviewerId Reviewer ID
     * @param reviewerName Reviewer name
     * @param rating Overall rating
     * @param comment Review comment
     */
    public PublicReview(String photographerId, String reviewerId, String reviewerName,
                        int rating, String comment) {
        super(photographerId, reviewerId, reviewerName, rating, comment);
        this.hasEmailVerification = false;
        this.autoApproved = false;
        this.votesUp = 0;
        this.votesDown = 0;
    }

    // Getters and Setters
    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public String getProfileImageUrl() {
        return profileImageUrl;
    }

    public void setProfileImageUrl(String profileImageUrl) {
        this.profileImageUrl = profileImageUrl;
    }

    public String getSocialMediaHandle() {
        return socialMediaHandle;
    }

    public void setSocialMediaHandle(String socialMediaHandle) {
        this.socialMediaHandle = socialMediaHandle;
    }

    public boolean isHasEmailVerification() {
        return hasEmailVerification;
    }

    public void setHasEmailVerification(boolean hasEmailVerification) {
        this.hasEmailVerification = hasEmailVerification;
    }

    public boolean isAutoApproved() {
        return autoApproved;
    }

    public void setAutoApproved(boolean autoApproved) {
        this.autoApproved = autoApproved;
    }

    public int getVotesUp() {
        return votesUp;
    }

    public void setVotesUp(int votesUp) {
        this.votesUp = votesUp;
    }

    public int getVotesDown() {
        return votesDown;
    }

    public void setVotesDown(int votesDown) {
        this.votesDown = votesDown;
    }

    // Business methods
    /**
     * Increment up votes
     */
    public void incrementVotesUp() {
        this.votesUp++;
    }

    /**
     * Increment down votes
     */
    public void incrementVotesDown() {
        this.votesDown++;
    }

    /**
     * Get vote score (up votes minus down votes)
     * @return Vote score
     */
    public int getVoteScore() {
        return votesUp - votesDown;
    }

    /**
     * Verify email
     * @return true if verification status changed, false otherwise
     */
    public boolean verifyEmail() {
        if (hasEmailVerification) {
            return false;
        }

        hasEmailVerification = true;
        return true;
    }

    /**
     * Auto-approve review if it meets criteria
     * @return true if auto-approved, false otherwise
     */
    public boolean tryAutoApprove() {
        // Only auto-approve if:
        // 1. Has email verification
        // 2. Review has at least 20 characters
        // 3. No existing flags or reports
        if (hasEmailVerification &&
                getComment() != null && getComment().length() >= 20 &&
                getReportCount() == 0) {

            autoApproved = true;
            setStatus(ReviewStatus.APPROVED);
            return true;
        }

        return false;
    }

    // Override methods
    @Override
    public String toFileString() {
        // Start with the parent class's implementation
        String baseString = super.toFileString();

        // Append public review-specific attributes
        return baseString + ",PUBLIC," +
                (customerType != null ? customerType : "") + "," +
                (contactEmail != null ? contactEmail : "") + "," +
                (profileImageUrl != null ? profileImageUrl : "") + "," +
                (socialMediaHandle != null ? socialMediaHandle : "") + "," +
                hasEmailVerification + "," +
                autoApproved + "," +
                votesUp + "," +
                votesDown;
    }

    /**
     * Create PublicReview from file string
     * @param fileString String representation from file
     * @return PublicReview object
     */
    public static PublicReview fromFileString(String fileString) {
        // Split the string into base part and public part
        String[] parts = fileString.split(",PUBLIC,");
        if (parts.length < 2) {
            return null; // Not a valid public review string
        }

        // Parse the base review first
        Review baseReview = Review.fromFileString(parts[0]);
        if (baseReview == null) {
            return null;
        }

        // Create a new PublicReview and copy properties from base
        PublicReview publicReview = new PublicReview();
        publicReview.setReviewId(baseReview.getReviewId());
        publicReview.setPhotographerId(baseReview.getPhotographerId());
        publicReview.setReviewerId(baseReview.getReviewerId());
        publicReview.setReviewerName(baseReview.getReviewerName());
        publicReview.setRating(baseReview.getRating());
        publicReview.setComment(baseReview.getComment());
        publicReview.setReviewDate(baseReview.getReviewDate());
        publicReview.setStatus(baseReview.getStatus());
        publicReview.setRejectionReason(baseReview.getRejectionReason());
        publicReview.setAnonymous(baseReview.isAnonymous());
        publicReview.setBookingId(baseReview.getBookingId());
        publicReview.setHasResponse(baseReview.isHasResponse());
        publicReview.setResponseText(baseReview.getResponseText());
        publicReview.setResponseDate(baseReview.getResponseDate());
        publicReview.setFeatured(baseReview.isFeatured());
        publicReview.setHelpfulCount(baseReview.getHelpfulCount());
        publicReview.setReportCount(baseReview.getReportCount());

        // Parse public review-specific properties
        String[] publicParts = parts[1].split(",");
        if (publicParts.length >= 8) {
            publicReview.setCustomerType(publicParts[0]);
            publicReview.setContactEmail(publicParts[1]);
            publicReview.setProfileImageUrl(publicParts[2]);
            publicReview.setSocialMediaHandle(publicParts[3]);
            publicReview.setHasEmailVerification(Boolean.parseBoolean(publicParts[4]));
            publicReview.setAutoApproved(Boolean.parseBoolean(publicParts[5]));
            publicReview.setVotesUp(Integer.parseInt(publicParts[6]));
            publicReview.setVotesDown(Integer.parseInt(publicParts[7]));
        }

        return publicReview;
    }
}