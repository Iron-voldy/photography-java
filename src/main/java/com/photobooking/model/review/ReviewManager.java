package com.photobooking.model.review;

import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;
import com.photobooking.util.FileHandler;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Manages review-related operations for the Event Photography System
 */
public class ReviewManager {
    private static final String REVIEW_FILE = "reviews.txt";
    private List<Review> reviews;

    /**
     * Constructor initializes the manager and loads reviews
     */
    public ReviewManager() {
        this.reviews = loadReviews();
    }

    /**
     * Load reviews from file
     * @return List of reviews
     */
    private List<Review> loadReviews() {
        List<String> lines = FileHandler.readLines(REVIEW_FILE);
        List<Review> loadedReviews = new ArrayList<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Review review = null;

                // Try to parse as a VerifiedReview first
                if (line.contains(",VERIFIED,")) {
                    review = VerifiedReview.fromFileString(line);
                }
                // Then try as a PublicReview
                else if (line.contains(",PUBLIC,")) {
                    review = PublicReview.fromFileString(line);
                }
                // Otherwise parse as a base Review
                else {
                    review = Review.fromFileString(line);
                }

                if (review != null) {
                    loadedReviews.add(review);
                }
            }
        }

        return loadedReviews;
    }

    /**
     * Save all reviews to file
     * @return true if successful, false otherwise
     */
    private boolean saveReviews() {
        try {
            // Delete existing file content
            FileHandler.deleteFile(REVIEW_FILE);

            // Write each review to file
            for (Review review : reviews) {
                FileHandler.appendLine(REVIEW_FILE, review.toFileString());
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error saving reviews: " + e.getMessage());
            return false;
        }
    }

    /**
     * Add a new review
     * @param review The review to add
     * @return true if successful, false otherwise
     */
    public boolean addReview(Review review) {
        if (review == null || review.getPhotographerId() == null || review.getReviewerId() == null) {
            return false;
        }

        // Add review to list
        reviews.add(review);

        // If review is approved, update photographer's rating
        if (review.getStatus() == Review.ReviewStatus.APPROVED) {
            updatePhotographerRating(review.getPhotographerId());
        }

        return saveReviews();
    }

    /**
     * Get review by ID
     * @param reviewId The review ID
     * @return The review or null if not found
     */
    public Review getReviewById(String reviewId) {
        if (reviewId == null) return null;

        return reviews.stream()
                .filter(r -> r.getReviewId().equals(reviewId))
                .findFirst()
                .orElse(null);
    }

    /**
     * Update an existing review
     * @param updatedReview The updated review
     * @return true if successful, false otherwise
     */
    public boolean updateReview(Review updatedReview) {
        if (updatedReview == null || updatedReview.getReviewId() == null) {
            return false;
        }

        boolean wasApproved = false;
        boolean isNowApproved = updatedReview.getStatus() == Review.ReviewStatus.APPROVED;

        for (int i = 0; i < reviews.size(); i++) {
            if (reviews.get(i).getReviewId().equals(updatedReview.getReviewId())) {
                wasApproved = reviews.get(i).getStatus() == Review.ReviewStatus.APPROVED;
                reviews.set(i, updatedReview);

                // If approval status changed, update photographer's rating
                if (wasApproved != isNowApproved) {
                    updatePhotographerRating(updatedReview.getPhotographerId());
                }

                return saveReviews();
            }
        }

        return false; // Review not found
    }

    /**
     * Delete a review
     * @param reviewId The review ID
     * @return true if successful, false otherwise
     */
    public boolean deleteReview(String reviewId) {
        if (reviewId == null) {
            return false;
        }

        Review reviewToDelete = getReviewById(reviewId);
        if (reviewToDelete == null) {
            return false;
        }

        boolean wasApproved = reviewToDelete.getStatus() == Review.ReviewStatus.APPROVED;
        String photographerId = reviewToDelete.getPhotographerId();

        boolean removed = reviews.removeIf(r -> r.getReviewId().equals(reviewId));
        if (removed) {
            // If deleted review was approved, update photographer's rating
            if (wasApproved) {
                updatePhotographerRating(photographerId);
            }

            return saveReviews();
        }

        return false;
    }

    /**
     * Get all reviews
     * @return List of all reviews
     */
    public List<Review> getAllReviews() {
        return new ArrayList<>(reviews);
    }

    /**
     * Get reviews by photographer
     * @param photographerId The photographer ID
     * @return List of reviews for the photographer
     */
    public List<Review> getReviewsByPhotographer(String photographerId) {
        if (photographerId == null) return new ArrayList<>();

        return reviews.stream()
                .filter(r -> r.getPhotographerId().equals(photographerId))
                .collect(Collectors.toList());
    }

    /**
     * Get approved reviews by photographer
     * @param photographerId The photographer ID
     * @return List of approved reviews for the photographer
     */
    public List<Review> getApprovedReviewsByPhotographer(String photographerId) {
        if (photographerId == null) return new ArrayList<>();

        return reviews.stream()
                .filter(r -> r.getPhotographerId().equals(photographerId))
                .filter(r -> r.getStatus() == Review.ReviewStatus.APPROVED)
                .collect(Collectors.toList());
    }

    /**
     * Get reviews by reviewer
     * @param reviewerId The reviewer ID
     * @return List of reviews by the reviewer
     */
    public List<Review> getReviewsByReviewer(String reviewerId) {
        if (reviewerId == null) return new ArrayList<>();

        return reviews.stream()
                .filter(r -> r.getReviewerId().equals(reviewerId))
                .collect(Collectors.toList());
    }

    /**
     * Get verified reviews by photographer
     * @param photographerId The photographer ID
     * @return List of verified reviews for the photographer
     */
    public List<VerifiedReview> getVerifiedReviewsByPhotographer(String photographerId) {
        if (photographerId == null) return new ArrayList<>();

        return reviews.stream()
                .filter(r -> r.getPhotographerId().equals(photographerId))
                .filter(r -> r instanceof VerifiedReview)
                .map(r -> (VerifiedReview) r)
                .collect(Collectors.toList());
    }

    /**
     * Get reviews by booking
     * @param bookingId The booking ID
     * @return List of reviews for the booking
     */
    public List<Review> getReviewsByBooking(String bookingId) {
        if (bookingId == null) return new ArrayList<>();

        return reviews.stream()
                .filter(r -> bookingId.equals(r.getBookingId()))
                .collect(Collectors.toList());
    }

    /**
     * Get reviews by status
     * @param status The review status
     * @return List of reviews with the specified status
     */
    public List<Review> getReviewsByStatus(Review.ReviewStatus status) {
        if (status == null) return new ArrayList<>();

        return reviews.stream()
                .filter(r -> r.getStatus() == status)
                .collect(Collectors.toList());
    }

    /**
     * Get featured reviews
     * @return List of featured reviews
     */
    public List<Review> getFeaturedReviews() {
        return reviews.stream()
                .filter(Review::isFeatured)
                .filter(r -> r.getStatus() == Review.ReviewStatus.APPROVED)
                .collect(Collectors.toList());
    }

    /**
     * Get reported reviews
     * @return List of reviews with report count > 0
     */
    public List<Review> getReportedReviews() {
        return reviews.stream()
                .filter(r -> r.getReportCount() > 0)
                .collect(Collectors.toList());
    }

    /**
     * Approve a review
     * @param reviewId The review ID
     * @return true if successful, false otherwise
     */
    public boolean approveReview(String reviewId) {
        Review review = getReviewById(reviewId);
        if (review == null) {
            return false;
        }

        boolean wasApproved = review.getStatus() == Review.ReviewStatus.APPROVED;

        if (review.approve()) {
            // If approval status changed, update photographer's rating
            if (!wasApproved) {
                updatePhotographerRating(review.getPhotographerId());
            }

            return updateReview(review);
        }

        return false;
    }

    /**
     * Reject a review
     * @param reviewId The review ID
     * @param reason Reason for rejection
     * @return true if successful, false otherwise
     */
    public boolean rejectReview(String reviewId, String reason) {
        Review review = getReviewById(reviewId);
        if (review == null) {
            return false;
        }

        boolean wasApproved = review.getStatus() == Review.ReviewStatus.APPROVED;

        if (review.reject(reason)) {
            // If previously approved, update photographer's rating
            if (wasApproved) {
                updatePhotographerRating(review.getPhotographerId());
            }

            return updateReview(review);
        }

        return false;
    }

    /**
     * Add response to a review
     * @param reviewId The review ID
     * @param response Response text
     * @return true if successful, false otherwise
     */
    public boolean addResponseToReview(String reviewId, String response) {
        Review review = getReviewById(reviewId);
        if (review == null) {
            return false;
        }

        if (review.addResponse(response)) {
            return updateReview(review);
        }

        return false;
    }

    /**
     * Mark a review as featured
     * @param reviewId The review ID
     * @param featured Whether the review should be featured
     * @return true if successful, false otherwise
     */
    public boolean setReviewFeatured(String reviewId, boolean featured) {
        Review review = getReviewById(reviewId);
        if (review == null) {
            return false;
        }

        review.setFeatured(featured);
        return updateReview(review);
    }

    /**
     * Increment helpful count for a review
     * @param reviewId The review ID
     * @return true if successful, false otherwise
     */
    public boolean incrementHelpfulCount(String reviewId) {
        Review review = getReviewById(reviewId);
        if (review == null) {
            return false;
        }

        review.incrementHelpfulCount();
        return updateReview(review);
    }

    /**
     * Increment report count for a review
     * @param reviewId The review ID
     * @return true if successful, false otherwise
     */
    public boolean incrementReportCount(String reviewId) {
        Review review = getReviewById(reviewId);
        if (review == null) {
            return false;
        }

        review.incrementReportCount();
        return updateReview(review);
    }

    /**
     * Update photographer's rating based on approved reviews
     * @param photographerId The photographer ID
     * @return true if successful, false otherwise
     */
    private boolean updatePhotographerRating(String photographerId) {
        if (photographerId == null) {
            return false;
        }

        // Get approved reviews for the photographer
        List<Review> approvedReviews = getApprovedReviewsByPhotographer(photographerId);

        // Calculate average rating
        if (approvedReviews.isEmpty()) {
            // No approved reviews, reset rating to 0
            PhotographerManager photographerManager = new PhotographerManager();
            Photographer photographer = photographerManager.getPhotographerById(photographerId);

            if (photographer != null) {
                photographer.setRating(0.0);
                photographer.setReviewCount(0);
                return photographerManager.updatePhotographer(photographer);
            }

            return false;
        }

        // Calculate total and average rating
        int totalRating = 0;
        for (Review review : approvedReviews) {
            totalRating += review.getRating();
        }

        double averageRating = (double) totalRating / approvedReviews.size();

        // Update photographer's rating
        PhotographerManager photographerManager = new PhotographerManager();
        Photographer photographer = photographerManager.getPhotographerById(photographerId);

        if (photographer != null) {
            photographer.setRating(averageRating);
            photographer.setReviewCount(approvedReviews.size());
            return photographerManager.updatePhotographer(photographer);
        }

        return false;
    }

    /**
     * Check if user can review photographer
     * @param userId The user ID
     * @param photographerId The photographer ID
     * @return true if user can review, false otherwise
     */
    public boolean canUserReviewPhotographer(String userId, String photographerId) {
        if (userId == null || photographerId == null) {
            return false;
        }

        // Check if user has already reviewed this photographer
        List<Review> userReviews = getReviewsByReviewer(userId);
        for (Review review : userReviews) {
            if (review.getPhotographerId().equals(photographerId)) {
                return false; // User has already reviewed this photographer
            }
        }

        // In a real app, you would check if user has booked this photographer
        // For simplicity, we'll allow all users to review all photographers

        return true;
    }

    /**
     * Get average rating for a photographer
     * @param photographerId The photographer ID
     * @return Average rating or 0 if no approved reviews
     */
    public double getAverageRating(String photographerId) {
        List<Review> approvedReviews = getApprovedReviewsByPhotographer(photographerId);

        if (approvedReviews.isEmpty()) {
            return 0.0;
        }

        int totalRating = 0;
        for (Review review : approvedReviews) {
            totalRating += review.getRating();
        }

        return (double) totalRating / approvedReviews.size();
    }

    /**
     * Get rating distribution for a photographer
     * @param photographerId The photographer ID
     * @return Array of counts for each rating (index 0 = 1 star, index 4 = 5 stars)
     */
    public int[] getRatingDistribution(String photographerId) {
        List<Review> approvedReviews = getApprovedReviewsByPhotographer(photographerId);
        int[] distribution = new int[5]; // Index 0 = 1 star, index 4 = 5 stars

        for (Review review : approvedReviews) {
            if (review.getRating() >= 1 && review.getRating() <= 5) {
                distribution[review.getRating() - 1]++;
            }
        }

        return distribution;
    }
}