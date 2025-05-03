package com.photobooking.model.review;

import com.photobooking.util.FileHandler;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Manages reviews for photographers
 */
public class ReviewManager {
    private static final String REVIEWS_FILE = "reviews.txt";
    private List<Review> reviews;

    public ReviewManager() {
        this.reviews = loadReviews();
    }

    private List<Review> loadReviews() {
        List<String> lines = FileHandler.readLines(REVIEWS_FILE);
        List<Review> loadedReviews = new ArrayList<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Review review = Review.fromFileString(line);
                if (review != null) {
                    loadedReviews.add(review);
                }
            }
        }

        return loadedReviews;
    }

    private boolean saveReviews() {
        try {
            FileHandler.deleteFile(REVIEWS_FILE);
            for (Review review : reviews) {
                FileHandler.appendLine(REVIEWS_FILE, review.toFileString());
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error saving reviews: " + e.getMessage());
            return false;
        }
    }

    public boolean addReview(Review review) {
        reviews.add(review);
        return saveReviews();
    }

    public List<Review> getPhotographerReviews(String photographerId) {
        return reviews.stream()
                .filter(review -> review.getPhotographerId().equals(photographerId))
                .sorted((r1, r2) -> r2.getReviewDate().compareTo(r1.getReviewDate()))
                .collect(Collectors.toList());
    }

    public double getAverageRating(String photographerId) {
        List<Review> photographerReviews = getPhotographerReviews(photographerId);
        if (photographerReviews.isEmpty()) {
            return 0.0;
        }

        double sum = photographerReviews.stream()
                .mapToInt(Review::getRating)
                .sum();
        return sum / photographerReviews.size();
    }

    public int[] getRatingDistribution(String photographerId) {
        int[] distribution = new int[5]; // For ratings 1-5

        getPhotographerReviews(photographerId).forEach(review -> {
            if (review.getRating() >= 1 && review.getRating() <= 5) {
                distribution[review.getRating() - 1]++;
            }
        });

        return distribution;
    }
}