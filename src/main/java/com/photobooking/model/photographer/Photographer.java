package com.photobooking.model.photographer;

import java.io.Serializable;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Base Photographer class for the Event Photography System
 */
public class Photographer implements Serializable {
    private static final long serialVersionUID = 1L;

    // Photographer attributes
    private String photographerId;
    private String userId;
    private String businessName;
    private String biography;
    private List<String> specialties;
    private String location;
    private double basePrice;
    private double rating;
    private int reviewCount;
    private Map<LocalDate, List<TimeSlot>> availability;
    private List<String> portfolioImageUrls;
    private boolean isAvailableWeekends;
    private boolean isAvailableWeekdays;
    private boolean isVerified;
    private String contactPhone;
    private String websiteUrl;
    private String socialMediaLinks;
    private int yearsOfExperience;

    // Time slot class for availability
    public static class TimeSlot implements Serializable {
        private static final long serialVersionUID = 1L;
        private LocalTime startTime;
        private LocalTime endTime;
        private boolean isAvailable;

        public TimeSlot(LocalTime startTime, LocalTime endTime, boolean isAvailable) {
            this.startTime = startTime;
            this.endTime = endTime;
            this.isAvailable = isAvailable;
        }

        public LocalTime getStartTime() {
            return startTime;
        }

        public void setStartTime(LocalTime startTime) {
            this.startTime = startTime;
        }

        public LocalTime getEndTime() {
            return endTime;
        }

        public void setEndTime(LocalTime endTime) {
            this.endTime = endTime;
        }

        public boolean isAvailable() {
            return isAvailable;
        }

        public void setAvailable(boolean available) {
            isAvailable = available;
        }

        @Override
        public String toString() {
            return startTime + "-" + endTime + (isAvailable ? "(Available)" : "(Booked)");
        }
    }

    // Constructors
    public Photographer() {
        this.photographerId = UUID.randomUUID().toString();
        this.specialties = new ArrayList<>();
        this.availability = new HashMap<>();
        this.portfolioImageUrls = new ArrayList<>();
        this.rating = 0.0;
        this.reviewCount = 0;
        this.isAvailableWeekends = true;
        this.isAvailableWeekdays = true;
        this.isVerified = false;
    }

    public Photographer(String userId, String businessName, String biography, List<String> specialties,
                        String location, double basePrice) {
        this();
        this.userId = userId;
        this.businessName = businessName;
        this.biography = biography;
        if (specialties != null) {
            this.specialties.addAll(specialties);
        }
        this.location = location;
        this.basePrice = basePrice;
    }

    // Getters and Setters
    public String getPhotographerId() {
        return photographerId;
    }

    public void setPhotographerId(String photographerId) {
        this.photographerId = photographerId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public List<String> getSpecialties() {
        return specialties;
    }

    public void setSpecialties(List<String> specialties) {
        this.specialties = specialties;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public int getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }

    public Map<LocalDate, List<TimeSlot>> getAvailability() {
        return availability;
    }

    public void setAvailability(Map<LocalDate, List<TimeSlot>> availability) {
        this.availability = availability;
    }

    public List<String> getPortfolioImageUrls() {
        return portfolioImageUrls;
    }

    public void setPortfolioImageUrls(List<String> portfolioImageUrls) {
        this.portfolioImageUrls = portfolioImageUrls;
    }

    public boolean isAvailableWeekends() {
        return isAvailableWeekends;
    }

    public void setAvailableWeekends(boolean availableWeekends) {
        isAvailableWeekends = availableWeekends;
    }

    public boolean isAvailableWeekdays() {
        return isAvailableWeekdays;
    }

    public void setAvailableWeekdays(boolean availableWeekdays) {
        isAvailableWeekdays = availableWeekdays;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getWebsiteUrl() {
        return websiteUrl;
    }

    public void setWebsiteUrl(String websiteUrl) {
        this.websiteUrl = websiteUrl;
    }

    public String getSocialMediaLinks() {
        return socialMediaLinks;
    }

    public void setSocialMediaLinks(String socialMediaLinks) {
        this.socialMediaLinks = socialMediaLinks;
    }

    public int getYearsOfExperience() {
        return yearsOfExperience;
    }

    public void setYearsOfExperience(int yearsOfExperience) {
        this.yearsOfExperience = yearsOfExperience;
    }

    // Business methods
    /**
     * Calculate price for a specific booking type
     * @param hours Number of hours
     * @param bookingType Type of booking
     * @return Price for the booking
     */
    public double calculatePrice(int hours, String bookingType) {
        double price = basePrice * hours;

        // Apply multiplier based on booking type
        switch (bookingType) {
            case "WEDDING":
                price *= 1.5; // 50% premium for weddings
                break;
            case "CORPORATE":
                price *= 1.25; // 25% premium for corporate events
                break;
            case "PRODUCT":
                price *= 1.1; // 10% premium for product photography
                break;
        }

        return price;
    }

    /**
     * Add a new review rating
     * @param newRating Rating from 1-5
     */
    public void addReview(double newRating) {
        if (newRating < 1 || newRating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }

        // Calculate new average rating
        double totalRating = this.rating * this.reviewCount;
        totalRating += newRating;
        this.reviewCount++;
        this.rating = totalRating / this.reviewCount;
    }

    /**
     * Check if photographer is available on a specific date
     * @param date The date to check
     * @return true if available, false otherwise
     */
    public boolean isAvailableOnDate(LocalDate date) {
        if (date == null) return false;

        // Check if date is a weekend and if photographer works weekends
        boolean isWeekend = date.getDayOfWeek() == DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY;
        if (isWeekend && !isAvailableWeekends) return false;
        if (!isWeekend && !isAvailableWeekdays) return false;

        // Check if date has specific availability set
        if (availability.containsKey(date)) {
            List<TimeSlot> timeSlots = availability.get(date);
            // Check if there's at least one available time slot
            return timeSlots.stream().anyMatch(TimeSlot::isAvailable);
        }

        // No specific availability set for this date, default to available
        return true;
    }

    /**
     * Add a portfolio image URL
     * @param imageUrl The image URL to add
     */
    public void addPortfolioImage(String imageUrl) {
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            portfolioImageUrls.add(imageUrl);
        }
    }

    /**
     * Set availability for a specific date
     * @param date The date
     * @param timeSlots List of time slots for that date
     */
    public void setAvailabilityForDate(LocalDate date, List<TimeSlot> timeSlots) {
        if (date != null && timeSlots != null) {
            availability.put(date, timeSlots);
        }
    }

    /**
     * Block off a date (mark as unavailable)
     * @param date The date to block
     */
    public void blockDate(LocalDate date) {
        if (date != null) {
            // Create a time slot for the entire day marked as unavailable
            List<TimeSlot> blockedDay = new ArrayList<>();
            blockedDay.add(new TimeSlot(LocalTime.of(0, 0), LocalTime.of(23, 59), false));
            availability.put(date, blockedDay);
        }
    }

    /**
     * Convert photographer to file string representation
     * @return String representation for file storage
     */
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(photographerId).append(",");
        sb.append(userId).append(",");
        sb.append(businessName).append(",");
        sb.append(biography.replace(",", ";;")).append(","); // Escape commas in biography

        // Join specialties with |
        sb.append(String.join("|", specialties)).append(",");

        sb.append(location).append(",");
        sb.append(basePrice).append(",");
        sb.append(rating).append(",");
        sb.append(reviewCount).append(",");

        // Availability is complex - we'll store dates in ISO format with time slots
        // Skip for simplicity - would require custom parsing
        sb.append("AVAILABILITY_PLACEHOLDER").append(",");

        // Join portfolio URLs with |
        sb.append(String.join("|", portfolioImageUrls)).append(",");

        sb.append(isAvailableWeekends).append(",");
        sb.append(isAvailableWeekdays).append(",");
        sb.append(isVerified).append(",");
        sb.append(contactPhone != null ? contactPhone : "").append(",");
        sb.append(websiteUrl != null ? websiteUrl : "").append(",");
        sb.append(socialMediaLinks != null ? socialMediaLinks : "").append(",");
        sb.append(yearsOfExperience);

        return sb.toString();
    }

    /**
     * Create photographer from file string
     * @param fileString String representation from file
     * @return Photographer object
     */
    public static Photographer fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length < 15) {
            return null; // Not enough parts for a valid photographer
        }

        Photographer photographer = new Photographer();
        int index = 0;

        photographer.setPhotographerId(parts[index++]);
        photographer.setUserId(parts[index++]);
        photographer.setBusinessName(parts[index++]);
        photographer.setBiography(parts[index++].replace(";;", ",")); // Unescape commas

        // Parse specialties
        String specialtiesStr = parts[index++];
        if (!specialtiesStr.isEmpty()) {
            String[] specialtiesArr = specialtiesStr.split("\\|");
            for (String specialty : specialtiesArr) {
                photographer.getSpecialties().add(specialty);
            }
        }

        photographer.setLocation(parts[index++]);
        photographer.setBasePrice(Double.parseDouble(parts[index++]));
        photographer.setRating(Double.parseDouble(parts[index++]));
        photographer.setReviewCount(Integer.parseInt(parts[index++]));

        // Skip availability parsing (complex)
        index++; // AVAILABILITY_PLACEHOLDER

        // Parse portfolio URLs
        String portfolioStr = parts[index++];
        if (!portfolioStr.isEmpty()) {
            String[] portfolioArr = portfolioStr.split("\\|");
            for (String url : portfolioArr) {
                photographer.getPortfolioImageUrls().add(url);
            }
        }

        photographer.setAvailableWeekends(Boolean.parseBoolean(parts[index++]));
        photographer.setAvailableWeekdays(Boolean.parseBoolean(parts[index++]));
        photographer.setVerified(Boolean.parseBoolean(parts[index++]));
        photographer.setContactPhone(parts[index++]);
        photographer.setWebsiteUrl(parts[index++]);
        photographer.setSocialMediaLinks(parts[index++]);

        if (index < parts.length) {
            photographer.setYearsOfExperience(Integer.parseInt(parts[index]));
        }

        return photographer;
    }

    @Override
    public String toString() {
        return "Photographer{" +
                "photographerId='" + photographerId + '\'' +
                ", businessName='" + businessName + '\'' +
                ", location='" + location + '\'' +
                ", rating=" + rating +
                ", reviewCount=" + reviewCount +
                '}';
    }
}