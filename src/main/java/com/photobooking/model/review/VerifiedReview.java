package com.photobooking.model.review;

import java.time.LocalDateTime;

/**
 * Represents a verified review (from a confirmed client) in the Event Photography System
 */
public class VerifiedReview extends Review {
    private static final long serialVersionUID = 1L;

    // Additional attributes for verified reviews
    private String bookingDate; // Date of the booking
    private String eventType; // Type of event (wedding, portrait, etc.)
    private int serviceRating; // Additional rating for service (1-5)
    private int communicationRating; // Rating for communication (1-5)
    private int valueRating; // Rating for value for money (1-5)
    private int professionalismRating; // Rating for professionalism (1-5)
    private boolean wouldRecommend; // Would the client recommend this photographer
    private String photographerNote; // Private note from photographer about this review

    /**
     * Default constructor
     */
    public VerifiedReview() {
        super();
        this.serviceRating = 0;
        this.communicationRating = 0;
        this.valueRating = 0;
        this.professionalismRating = 0;
        this.wouldRecommend = true;
    }

    /**
     * Constructor with parameters
     * @param photographerId Photographer ID
     * @param reviewerId Reviewer ID
     * @param reviewerName Reviewer name
     * @param rating Overall rating
     * @param comment Review comment
     * @param bookingId Booking ID
     */
    public VerifiedReview(String photographerId, String reviewerId, String reviewerName,
                          int rating, String comment, String bookingId) {
        super(photographerId, reviewerId, reviewerName, rating, comment);
        this.setBookingId(bookingId);
        this.serviceRating = 0;
        this.communicationRating = 0;
        this.valueRating = 0;
        this.professionalismRating = 0;
        this.wouldRecommend = true;
    }

    // Getters and Setters
    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public int getServiceRating() {
        return serviceRating;
    }

    public void setServiceRating(int serviceRating) {
        if (serviceRating < 0 || serviceRating > 5) {
            throw new IllegalArgumentException("Rating must be between 0 and 5");
        }
        this.serviceRating = serviceRating;
    }

    public int getCommunicationRating() {
        return communicationRating;
    }

    public void setCommunicationRating(int communicationRating) {
        if (communicationRating < 0 || communicationRating > 5) {
            throw new IllegalArgumentException("Rating must be between 0 and 5");
        }
        this.communicationRating = communicationRating;
    }

    public int getValueRating() {
        return valueRating;
    }

    public void setValueRating(int valueRating) {
        if (valueRating < 0 || valueRating > 5) {
            throw new IllegalArgumentException("Rating must be between 0 and 5");
        }
        this.valueRating = valueRating;
    }

    public int getProfessionalismRating() {
        return professionalismRating;
    }

    public void setProfessionalismRating(int professionalismRating) {
        if (professionalismRating < 0 || professionalismRating > 5) {
            throw new IllegalArgumentException("Rating must be between 0 and 5");
        }
        this.professionalismRating = professionalismRating;
    }

    public boolean isWouldRecommend() {
        return wouldRecommend;
    }

    public void setWouldRecommend(boolean wouldRecommend) {
        this.wouldRecommend = wouldRecommend;
    }

    public String getPhotographerNote() {
        return photographerNote;
    }

    public void setPhotographerNote(String photographerNote) {
        this.photographerNote = photographerNote;
    }

    // Business methods
    /**
     * Calculate average detailed rating
     * @return Average of all detailed ratings
     */
    public double getAverageDetailedRating() {
        // Count how many non-zero ratings we have
        int count = 0;
        int sum = 0;

        if (serviceRating > 0) {
            sum += serviceRating;
            count++;
        }

        if (communicationRating > 0) {
            sum += communicationRating;
            count++;
        }

        if (valueRating > 0) {
            sum += valueRating;
            count++;
        }

        if (professionalismRating > 0) {
            sum += professionalismRating;
            count++;
        }

        if (count == 0) {
            return 0.0;
        }

        return (double) sum / count;
    }

    // Override methods
    @Override
    public String toFileString() {
        // Start with the parent class's implementation
        String baseString = super.toFileString();

        // Append verified review-specific attributes
        return baseString + ",VERIFIED," +
                (bookingDate != null ? bookingDate : "") + "," +
                (eventType != null ? eventType : "") + "," +
                serviceRating + "," +
                communicationRating + "," +
                valueRating + "," +
                professionalismRating + "," +
                wouldRecommend + "," +
                (photographerNote != null ? photographerNote.replace(",", ";;").replace("\n", "\\n") : "");
    }

    /**
     * Create VerifiedReview from file string
     * @param fileString String representation from file
     * @return VerifiedReview object
     */
    public static VerifiedReview fromFileString(String fileString) {
        // Split the string into base part and verified part
        String[] parts = fileString.split(",VERIFIED,");
        if (parts.length < 2) {
            return null; // Not a valid verified review string
        }

        // Parse the base review first
        Review baseReview = Review.fromFileString(parts[0]);
        if (baseReview == null) {
            return null;
        }

        // Create a new VerifiedReview and copy properties from base
        VerifiedReview verifiedReview = new VerifiedReview();
        verifiedReview.setReviewId(baseReview.getReviewId());
        verifiedReview.setPhotographerId(baseReview.getPhotographerId());
        verifiedReview.setReviewerId(baseReview.getReviewerId());
        verifiedReview.setReviewerName(baseReview.getReviewerName());
        verifiedReview.setRating(baseReview.getRating());
        verifiedReview.setComment(baseReview.getComment());
        verifiedReview.setReviewDate(baseReview.getReviewDate());
        verifiedReview.setStatus(baseReview.getStatus());
        verifiedReview.setRejectionReason(baseReview.getRejectionReason());
        verifiedReview.setAnonymous(baseReview.isAnonymous());
        verifiedReview.setBookingId(baseReview.getBookingId());
        verifiedReview.setHasResponse(baseReview.isHasResponse());
        verifiedReview.setResponseText(baseReview.getResponseText());
        verifiedReview.setResponseDate(baseReview.getResponseDate());
        verifiedReview.setFeatured(baseReview.isFeatured());
        verifiedReview.setHelpfulCount(baseReview.getHelpfulCount());
        verifiedReview.setReportCount(baseReview.getReportCount());

        // Parse verified review-specific properties
        String[] verifiedParts = parts[1].split(",");
        if (verifiedParts.length >= 8) {
            verifiedReview.setBookingDate(verifiedParts[0]);
            verifiedReview.setEventType(verifiedParts[1]);
            verifiedReview.setServiceRating(Integer.parseInt(verifiedParts[2]));
            verifiedReview.setCommunicationRating(Integer.parseInt(verifiedParts[3]));
            verifiedReview.setValueRating(Integer.parseInt(verifiedParts[4]));
            verifiedReview.setProfessionalismRating(Integer.parseInt(verifiedParts[5]));
            verifiedReview.setWouldRecommend(Boolean.parseBoolean(verifiedParts[6]));

            if (verifiedParts.length > 7) {
                verifiedReview.setPhotographerNote(verifiedParts[7].replace(";;", ",").replace("\\n", "\n"));
            }
        }

        return verifiedReview;
    }
}