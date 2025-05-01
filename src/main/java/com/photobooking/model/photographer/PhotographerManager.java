package com.photobooking.model.photographer;

import com.photobooking.util.FileHandler;
import com.photobooking.model.booking.Booking;
import com.photobooking.model.booking.BookingManager;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Manages photographer-related operations for the Event Photography System
 */
public class PhotographerManager {
    private static final String PHOTOGRAPHER_FILE = "photographers.txt";
    private List<Photographer> photographers;

    /**
     * Constructor initializes the manager and loads photographers
     */
    public PhotographerManager() {
        this.photographers = loadPhotographers();
    }

    /**
     * Load photographers from file
     * @return List of photographers
     */
    private List<Photographer> loadPhotographers() {
        List<String> lines = FileHandler.readLines(PHOTOGRAPHER_FILE);
        List<Photographer> loadedPhotographers = new ArrayList<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                // Determine the type of photographer based on the line content
                Photographer photographer = null;

                if (line.contains("FREELANCE,")) {
                    photographer = FreelancePhotographer.fromFileString(line);
                } else if (line.contains("AGENCY,")) {
                    photographer = AgencyPhotographer.fromFileString(line);
                } else {
                    photographer = Photographer.fromFileString(line);
                }

                if (photographer != null) {
                    loadedPhotographers.add(photographer);
                }
            }
        }

        return loadedPhotographers;
    }

    /**
     * Save all photographers to file
     * @return true if successful, false otherwise
     */
    private boolean savePhotographers() {
        try {
            // Delete existing file content
            FileHandler.deleteFile(PHOTOGRAPHER_FILE);

            // Write each photographer to file
            for (Photographer photographer : photographers) {
                FileHandler.appendLine(PHOTOGRAPHER_FILE, photographer.toFileString());
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error saving photographers: " + e.getMessage());
            return false;
        }
    }

    /**
     * Add a new photographer
     * @param photographer The photographer to add
     * @return true if successful, false otherwise
     */
    public boolean addPhotographer(Photographer photographer) {
        if (photographer == null || photographer.getUserId() == null) {
            return false;
        }

        // Check if photographer with same user ID already exists
        if (getPhotographerByUserId(photographer.getUserId()) != null) {
            return false; // Photographer already exists
        }

        photographers.add(photographer);
        return savePhotographers();
    }

    /**
     * Get photographer by ID
     * @param photographerId The photographer ID
     * @return The photographer or null if not found
     */
    public Photographer getPhotographerById(String photographerId) {
        if (photographerId == null) return null;

        return photographers.stream()
                .filter(p -> p.getPhotographerId().equals(photographerId))
                .findFirst()
                .orElse(null);
    }

    /**
     * Get photographer by user ID
     * @param userId The user ID
     * @return The photographer or null if not found
     */
    public Photographer getPhotographerByUserId(String userId) {
        if (userId == null) return null;

        return photographers.stream()
                .filter(p -> p.getUserId().equals(userId))
                .findFirst()
                .orElse(null);
    }

    /**
     * Update an existing photographer
     * @param updatedPhotographer The updated photographer
     * @return true if successful, false otherwise
     */
    public boolean updatePhotographer(Photographer updatedPhotographer) {
        if (updatedPhotographer == null || updatedPhotographer.getPhotographerId() == null) {
            return false;
        }

        for (int i = 0; i < photographers.size(); i++) {
            if (photographers.get(i).getPhotographerId().equals(updatedPhotographer.getPhotographerId())) {
                photographers.set(i, updatedPhotographer);
                return savePhotographers();
            }
        }

        return false; // Photographer not found
    }

    /**
     * Delete a photographer
     * @param photographerId The photographer ID
     * @return true if successful, false otherwise
     */
    public boolean deletePhotographer(String photographerId) {
        if (photographerId == null) {
            return false;
        }

        boolean removed = photographers.removeIf(p -> p.getPhotographerId().equals(photographerId));
        if (removed) {
            return savePhotographers();
        }

        return false; // Photographer not found
    }

    /**
     * Get all photographers
     * @return List of all photographers
     */
    public List<Photographer> getAllPhotographers() {
        return new ArrayList<>(photographers);
    }

    /**
     * Get photographers by specialty
     * @param specialty The specialty to filter by
     * @return List of photographers with the given specialty
     */
    public List<Photographer> getPhotographersBySpecialty(String specialty) {
        if (specialty == null) return new ArrayList<>();

        return photographers.stream()
                .filter(p -> p.getSpecialties().contains(specialty))
                .collect(Collectors.toList());
    }

    /**
     * Get photographers by location
     * @param location The location to filter by
     * @return List of photographers in the given location
     */
    public List<Photographer> getPhotographersByLocation(String location) {
        if (location == null) return new ArrayList<>();

        return photographers.stream()
                .filter(p -> p.getLocation() != null && p.getLocation().toLowerCase().contains(location.toLowerCase()))
                .collect(Collectors.toList());
    }

    /**
     * Get photographers by availability on a specific date
     * @param date The date to check availability for
     * @return List of photographers available on the given date
     */
    public List<Photographer> getAvailablePhotographers(LocalDate date) {
        if (date == null) return new ArrayList<>();

        return photographers.stream()
                .filter(p -> p.isAvailableOnDate(date))
                .collect(Collectors.toList());
    }

    /**
     * Get photographers by availability and specialty
     * @param date The date to check availability for
     * @param specialty The specialty to filter by
     * @return List of photographers available on the given date with the given specialty
     */
    public List<Photographer> getAvailablePhotographersBySpecialty(LocalDate date, String specialty) {
        if (date == null || specialty == null) return new ArrayList<>();

        return photographers.stream()
                .filter(p -> p.isAvailableOnDate(date))
                .filter(p -> p.getSpecialties().contains(specialty))
                .collect(Collectors.toList());
    }

    /**
     * Get top rated photographers (rating >= 4.0)
     * @param limit Maximum number of photographers to return
     * @return List of top rated photographers
     */
    public List<Photographer> getTopRatedPhotographers(int limit) {
        return photographers.stream()
                .filter(p -> p.getRating() >= 4.0 && p.getReviewCount() > 0)
                .sorted((p1, p2) -> Double.compare(p2.getRating(), p1.getRating())) // Sort by rating (descending)
                .limit(limit)
                .collect(Collectors.toList());
    }

    /**
     * Sort photographers by rating (bubble sort implementation)
     * @param photographerList List of photographers to sort
     * @param ascending If true, sort in ascending order; otherwise, sort in descending order
     * @return Sorted list of photographers
     */
    public List<Photographer> sortPhotographersByRating(List<Photographer> photographerList, boolean ascending) {
        if (photographerList == null || photographerList.isEmpty()) {
            return new ArrayList<>();
        }

        List<Photographer> sortedList = new ArrayList<>(photographerList);
        int n = sortedList.size();
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                boolean shouldSwap;
                if (ascending) {
                    shouldSwap = sortedList.get(j).getRating() > sortedList.get(j + 1).getRating();
                } else {
                    shouldSwap = sortedList.get(j).getRating() < sortedList.get(j + 1).getRating();
                }

                if (shouldSwap) {
                    // Swap elements
                    Photographer temp = sortedList.get(j);
                    sortedList.set(j, sortedList.get(j + 1));
                    sortedList.set(j + 1, temp);
                    swapped = true;
                }
            }

            // If no swapping occurred in this pass, array is sorted
            if (!swapped) {
                break;
            }
        }

        return sortedList;
    }

    /**
     * Search photographers by keyword (in name, biography, or specialties)
     * @param keyword The keyword to search for
     * @return List of photographers matching the keyword
     */
    public List<Photographer> searchPhotographers(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return new ArrayList<>(photographers);
        }

        String searchTerm = keyword.toLowerCase().trim();

        return photographers.stream()
                .filter(p -> {
                    // Search in business name
                    if (p.getBusinessName() != null &&
                            p.getBusinessName().toLowerCase().contains(searchTerm)) {
                        return true;
                    }

                    // Search in biography
                    if (p.getBiography() != null &&
                            p.getBiography().toLowerCase().contains(searchTerm)) {
                        return true;
                    }

                    // Search in specialties
                    for (String specialty : p.getSpecialties()) {
                        if (specialty.toLowerCase().contains(searchTerm)) {
                            return true;
                        }
                    }

                    // Search in location
                    if (p.getLocation() != null &&
                            p.getLocation().toLowerCase().contains(searchTerm)) {
                        return true;
                    }

                    return false;
                })
                .collect(Collectors.toList());
    }

    /**
     * Check if a photographer is available for a booking
     * @param photographerId The photographer ID
     * @param bookingDate The booking date
     * @return true if available, false otherwise
     */
    public boolean isPhotographerAvailableForBooking(String photographerId, LocalDate bookingDate) {
        // First, check if photographer exists
        Photographer photographer = getPhotographerById(photographerId);
        if (photographer == null || bookingDate == null) {
            return false;
        }

        // Check photographer's general availability
        if (!photographer.isAvailableOnDate(bookingDate)) {
            return false;
        }

        // Check for existing bookings on that date
        BookingManager bookingManager = new BookingManager();
        List<Booking> photographerBookings = bookingManager.getBookingsByPhotographer(photographerId);

        for (Booking booking : photographerBookings) {
            LocalDate bookingEventDate = booking.getEventDateTime().toLocalDate();

            // If there's a booking on the same day and it's not cancelled, photographer is not available
            if (bookingEventDate.equals(bookingDate) &&
                    booking.getStatus() != Booking.BookingStatus.CANCELLED) {
                return false;
            }
        }

        return true;
    }

    /**
     * Verify a photographer (e.g., after admin review)
     * @param photographerId The photographer ID
     * @return true if successful, false otherwise
     */
    public boolean verifyPhotographer(String photographerId) {
        Photographer photographer = getPhotographerById(photographerId);
        if (photographer == null) {
            return false;
        }

        photographer.setVerified(true);
        return updatePhotographer(photographer);
    }

    /**
     * Add a review for a photographer
     * @param photographerId The photographer ID
     * @param rating Rating (1-5)
     * @return true if successful, false otherwise
     */
    public boolean addReviewForPhotographer(String photographerId, double rating) {
        if (rating < 1 || rating > 5) {
            return false;
        }

        Photographer photographer = getPhotographerById(photographerId);
        if (photographer == null) {
            return false;
        }

        try {
            photographer.addReview(rating);
            return updatePhotographer(photographer);
        } catch (Exception e) {
            System.err.println("Error adding review: " + e.getMessage());
            return false;
        }
    }

    /**
     * Add a portfolio image for a photographer
     * @param photographerId The photographer ID
     * @param imageUrl The image URL to add
     * @return true if successful, false otherwise
     */
    public boolean addPortfolioImage(String photographerId, String imageUrl) {
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            return false;
        }

        Photographer photographer = getPhotographerById(photographerId);
        if (photographer == null) {
            return false;
        }

        photographer.addPortfolioImage(imageUrl);
        return updatePhotographer(photographer);
    }

    /**
     * Block a date for a photographer
     * @param photographerId The photographer ID
     * @param date The date to block
     * @return true if successful, false otherwise
     */
    public boolean blockDateForPhotographer(String photographerId, LocalDate date) {
        if (date == null) {
            return false;
        }

        Photographer photographer = getPhotographerById(photographerId);
        if (photographer == null) {
            return false;
        }

        photographer.blockDate(date);
        return updatePhotographer(photographer);
    }

    /**
     * Set a photographer's availability for a specific date
     * @param photographerId The photographer ID
     * @param date The date
     * @param timeSlots The time slots
     * @return true if successful, false otherwise
     */
    public boolean setPhotographerAvailability(String photographerId, LocalDate date,
                                               List<Photographer.TimeSlot> timeSlots) {
        if (date == null || timeSlots == null) {
            return false;
        }

        Photographer photographer = getPhotographerById(photographerId);
        if (photographer == null) {
            return false;
        }

        photographer.setAvailabilityForDate(date, timeSlots);
        return updatePhotographer(photographer);
    }

    /**
     * Get a photographer's availability for a specific date
     * @param photographerId The photographer ID
     * @param date The date
     * @return List of time slots, or null if photographer or date not found
     */
    public List<Photographer.TimeSlot> getPhotographerAvailability(String photographerId, LocalDate date) {
        if (date == null) {
            return null;
        }

        Photographer photographer = getPhotographerById(photographerId);
        if (photographer == null) {
            return null;
        }

        return photographer.getAvailability().get(date);
    }

    /**
     * Create default time slots for a date (9AM to 5PM, all available)
     * @return List of default time slots
     */
    public List<Photographer.TimeSlot> createDefaultTimeSlots() {
        List<Photographer.TimeSlot> timeSlots = new ArrayList<>();
        LocalTime startTime = LocalTime.of(9, 0); // 9:00 AM

        for (int i = 0; i < 8; i++) { // 8 hours from 9AM to 5PM
            LocalTime endTime = startTime.plusHours(1);
            timeSlots.add(new Photographer.TimeSlot(startTime, endTime, true));
            startTime = endTime;
        }

        return timeSlots;
    }

    /**
     * Format date for display
     * @param date The date to format
     * @return Formatted date string
     */
    public String formatDateForDisplay(LocalDate date) {
        if (date == null) {
            return "";
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM d, yyyy");
        return date.format(formatter);
    }

    /**
     * Sort photographers by price
     * @param ascending If true, sort in ascending order; otherwise, sort in descending order
     * @return Sorted list of photographers
     */
    public List<Photographer> sortPhotographersByPrice(boolean ascending) {
        Comparator<Photographer> comparator = Comparator.comparing(Photographer::getBasePrice);

        if (!ascending) {
            comparator = comparator.reversed();
        }

        return photographers.stream()
                .sorted(comparator)
                .collect(Collectors.toList());
    }

    /**
     * Sort photographers by experience
     * @param ascending If true, sort in ascending order; otherwise, sort in descending order
     * @return Sorted list of photographers
     */
    public List<Photographer> sortPhotographersByExperience(boolean ascending) {
        Comparator<Photographer> comparator = Comparator.comparing(Photographer::getYearsOfExperience);

        if (!ascending) {
            comparator = comparator.reversed();
        }

        return photographers.stream()
                .sorted(comparator)
                .collect(Collectors.toList());
    }

    /**
     * Sort photographers by name
     * @param ascending If true, sort in ascending order; otherwise, sort in descending order
     * @return Sorted list of photographers
     */
    public List<Photographer> sortPhotographersByName(boolean ascending) {
        Comparator<Photographer> comparator = Comparator.comparing(
                p -> p.getBusinessName() != null ? p.getBusinessName().toLowerCase() : "");

        if (!ascending) {
            comparator = comparator.reversed();
        }

        return photographers.stream()
                .sorted(comparator)
                .collect(Collectors.toList());
    }

    /**
     * Create a new photographer profile for a user
     * @param userId User ID
     * @param businessName Business name
     * @param biography Biography
     * @param specialtiesList List of specialties
     * @param location Location
     * @param basePrice Base price
     * @param photographerType Type of photographer (freelance or agency)
     * @return The created photographer, or null if creation failed
     */
    public Photographer createPhotographerProfile(String userId, String businessName, String biography,
                                                  List<String> specialtiesList, String location,
                                                  double basePrice, String photographerType,
                                                  String email) {
        if (userId == null || photographerType == null) {
            return null;
        }

        Photographer photographer;

        if ("freelance".equalsIgnoreCase(photographerType)) {
            photographer = new FreelancePhotographer(userId, businessName, biography,
                    specialtiesList, location, basePrice);
        } else if ("agency".equalsIgnoreCase(photographerType)) {
            photographer = new AgencyPhotographer(userId, businessName, biography,
                    specialtiesList, location, basePrice,
                    "", ""); // Empty agency name and ID for now
        } else {
            photographer = new Photographer(userId, businessName, biography,
                    specialtiesList, location, basePrice);
        }

        photographer.setEmail(email);

        if (addPhotographer(photographer)) {
            return photographer;
        } else {
            return null;
        }
    }
}