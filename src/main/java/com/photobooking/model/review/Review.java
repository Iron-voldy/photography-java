package com.photobooking.model.review;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Base Review class for the Event Photography System
 */
public class Review implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * Review status types
     */
    public enum ReviewStatus {
        PENDING("Pending", "Review is awaiting moderation"),
        APPROVED("Approved", "Review has been approved and is visible"),
        REJECTED("Rejected", "Review has been rejected and is not visible");

        private final String displayName;
        private final String description;

        ReviewStatus(String displayName, String description) {
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

    // Review attributes
    private String reviewId;
    private String photographerId;
    private String reviewerId; // User ID of reviewer
    private String reviewerName;
    private int rating; // 1-5 stars
    private String comment;
    private LocalDateTime reviewDate;
    private ReviewStatus status;
    private String rejectionReason;
    private boolean isAnonymous;
    private String bookingId; // Optional, if review is for a specific booking
    private boolean hasResponse;
    private String responseText;
    private LocalDateTime responseDate;
    private boolean isFeatured;
    private int helpfulCount;
    private int reportCount;

    // Constructors
    public Review() {
        this.reviewId = UUID.randomUUID().toString();
        this.reviewDate = LocalDateTime.now();
        this.status = ReviewStatus.PENDING;
        this.isAnonymous = false;
        this.hasResponse = false;
        this.isFeatured = false;
        this.helpfulCount = 0;
        this.reportCount = 0;
    }

    public Review(String photographerId, String reviewerId, String reviewerName,
                  int rating, String comment) {
        this();
        this.photographerId = photographerId;
        this.reviewerId = reviewerId;
        this.reviewerName = reviewerName;
        this.rating = rating;
        this.comment = comment;
    }

    // Getters and Setters
    public String getReviewId() {
        return reviewId;
    }

    public void setReviewId(String reviewId) {
        this.reviewId = reviewId;
    }

    public String getPhotographerId() {
        return photographerId;
    }

    public void setPhotographerId(String photographerId) {
        this.photographerId = photographerId;
    }

    public String getReviewerId() {
        return reviewerId;
    }

    public void setReviewerId(String reviewerId) {
        this.reviewerId = reviewerId;
    }

    public String getReviewerName() {
        return reviewerName;
    }

    public void setReviewerName(String reviewerName) {
        this.reviewerName = reviewerName;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        if (rating < 1 || rating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(LocalDateTime reviewDate) {
        this.reviewDate = reviewDate;
    }

    public ReviewStatus getStatus() {
        return status;
    }

    public void setStatus(ReviewStatus status) {
        this.status = status;
    }

    public String getRejectionReason() {
        return rejectionReason;
    }

    public void setRejectionReason(String rejectionReason) {
        this.rejectionReason = rejectionReason;
    }

    public boolean isAnonymous() {
        return isAnonymous;
    }

    public void setAnonymous(boolean anonymous) {
        isAnonymous = anonymous;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public boolean isHasResponse() {
        return hasResponse;
    }

    public void setHasResponse(boolean hasResponse) {
        this.hasResponse = hasResponse;
    }

    public String getResponseText() {
        return responseText;
    }

    public void setResponseText(String responseText) {
        this.responseText = responseText;
        if (responseText != null && !responseText.isEmpty()) {
            this.hasResponse = true;
            this.responseDate = LocalDateTime.now();
        }
    }

    public LocalDateTime getResponseDate() {
        return responseDate;
    }

    public void setResponseDate(LocalDateTime responseDate) {
        this.responseDate = responseDate;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public int getHelpfulCount() {
        return helpfulCount;
    }

    public void setHelpfulCount(int helpfulCount) {
        this.helpfulCount = helpfulCount;
    }

    public int getReportCount() {
        return reportCount;
    }

    public void setReportCount(int reportCount) {
        this.reportCount = reportCount;
    }

    // Business methods
    /**
     * Approve the review
     * @return true if status was changed, false if already approved
     */
    public boolean approve() {
        if (status == ReviewStatus.APPROVED) {
            return false;
        }

        status = ReviewStatus.APPROVED;
        return true;
    }

    /**
     * Reject the review
     * @param reason Reason for rejection
     * @return true if status was changed, false if already rejected
     */
    public boolean reject(String reason) {
        if (status == ReviewStatus.REJECTED) {
            return false;
        }

        status = ReviewStatus.REJECTED;
        rejectionReason = reason;
        return true;
    }

    /**
     * Add a response to the review
     * @param response Response text
     * @return true if response was added, false if already has response
     */
    public boolean addResponse(String response) {
        if (hasResponse || response == null || response.isEmpty()) {
            return false;
        }

        responseText = response;
        hasResponse = true;
        responseDate = LocalDateTime.now();
        return true;
    }

    /**
     * Increment helpful count
     */
    public void incrementHelpfulCount() {
        helpfulCount++;
    }

    /**
     * Increment report count
     */
    public void incrementReportCount() {
        reportCount++;
    }

    /**
     * Get display name based on anonymity setting
     * @return Name to display
     */
    public String getDisplayName() {
        if (isAnonymous) {
            return "Anonymous";
        }

        return reviewerName != null ? reviewerName : "User";
    }

    /**
     * Get formatted rating (e.g., "4.5 out of 5")
     * @return Formatted rating string
     */
    public String getFormattedRating() {
        return rating + " out of 5";
    }

    /**
     * Is the review visible to public?
     * @return true if visible, false otherwise
     */
    public boolean isVisible() {
        return status == ReviewStatus.APPROVED;
    }

    /**
     * Convert review to file string representation
     * @return String representation for file storage
     */
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(reviewId).append(",");
        sb.append(photographerId != null ? photographerId : "").append(",");
        sb.append(reviewerId != null ? reviewerId : "").append(",");
        sb.append(reviewerName != null ? reviewerName.replace(",", ";;") : "").append(",");
        sb.append(rating).append(",");
        sb.append(comment != null ? comment.replace(",", ";;").replace("\n", "\\n") : "").append(",");
        sb.append(reviewDate != null ? reviewDate.toString() : "").append(",");
        sb.append(status.name()).append(",");
        sb.append(rejectionReason != null ? rejectionReason.replace(",", ";;") : "").append(",");
        sb.append(isAnonymous).append(",");
        sb.append(bookingId != null ? bookingId : "").append(",");
        sb.append(hasResponse).append(",");
        sb.append(responseText != null ? responseText.replace(",", ";;").replace("\n", "\\n") : "").append(",");
        sb.append(responseDate != null ? responseDate.toString() : "").append(",");
        sb.append(isFeatured).append(",");
        sb.append(helpfulCount).append(",");
        sb.append(reportCount);

        return sb.toString();
    }

    /**
     * Create review from file string
     * @param fileString String representation from file
     * @return Review object
     */
    public static Review fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length < 16) {
            return null; // Not enough parts for a valid review
        }

        Review review = new Review();
        int index = 0;

        review.setReviewId(parts[index++]);

        String photographerId = parts[index++];
        if (!photographerId.isEmpty()) {
            review.setPhotographerId(photographerId);
        }

        String reviewerId = parts[index++];
        if (!reviewerId.isEmpty()) {
            review.setReviewerId(reviewerId);
        }

        review.setReviewerName(parts[index++].replace(";;", ","));
        review.setRating(Integer.parseInt(parts[index++]));
        review.setComment(parts[index++].replace(";;", ",").replace("\\n", "\n"));

        String reviewDateStr = parts[index++];
        if (!reviewDateStr.isEmpty()) {
            review.setReviewDate(LocalDateTime.parse(reviewDateStr));
        }

        review.setStatus(ReviewStatus.valueOf(parts[index++]));
        review.setRejectionReason(parts[index++].replace(";;", ","));
        review.setAnonymous(Boolean.parseBoolean(parts[index++]));

        String bookingId = parts[index++];
        if (!bookingId.isEmpty()) {
            review.setBookingId(bookingId);
        }

        review.setHasResponse(Boolean.parseBoolean(parts[index++]));
        review.setResponseText(parts[index++].replace(";;", ",").replace("\\n", "\n"));

        String responseDateStr = parts[index++];
        if (!responseDateStr.isEmpty()) {
            review.setResponseDate(LocalDateTime.parse(responseDateStr));
        }

        review.setFeatured(Boolean.parseBoolean(parts[index++]));
        review.setHelpfulCount(Integer.parseInt(parts[index++]));
        review.setReportCount(Integer.parseInt(parts[index]));

        return review;
    }

    @Override
    public String toString() {
        return "Review{" +
                "reviewId='" + reviewId + '\'' +
                ", reviewerName='" + getDisplayName() + '\'' +
                ", rating=" + rating +
                ", status=" + status +
                ", featured=" + isFeatured +
                '}';
    }
}