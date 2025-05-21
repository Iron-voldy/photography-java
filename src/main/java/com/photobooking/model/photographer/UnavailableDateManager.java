package com.photobooking.model.photographer;

import com.photobooking.util.FileHandler;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.util.stream.Collectors;

/**
 * Manages photographer unavailable dates
 */
public class UnavailableDateManager {
    private static final Logger LOGGER = Logger.getLogger(UnavailableDateManager.class.getName());
    private static final String UNAVAILABLE_DATES_FILE = "unavailable_dates.txt";
    private List<UnavailableDate> unavailableDates;

    public UnavailableDateManager() {
        this.unavailableDates = loadUnavailableDates();
    }

    /**
     * Load unavailable dates from file
     * @return List of unavailable dates
     */
    private List<UnavailableDate> loadUnavailableDates() {
        try {
            // Ensure file exists
            FileHandler.ensureFileExists(UNAVAILABLE_DATES_FILE);

            // Read lines from file
            List<String> lines = FileHandler.readLines(UNAVAILABLE_DATES_FILE);
            List<UnavailableDate> dates = new ArrayList<>();

            for (String line : lines) {
                if (!line.trim().isEmpty()) {
                    try {
                        UnavailableDate date = UnavailableDate.fromFileString(line);
                        if (date != null) {
                            dates.add(date);
                        }
                    } catch (Exception e) {
                        LOGGER.log(Level.WARNING, "Error parsing unavailable date: " + line, e);
                    }
                }
            }

            LOGGER.info("Loaded " + dates.size() + " unavailable dates");
            return dates;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error loading unavailable dates", e);
            return new ArrayList<>();
        }
    }

    /**
     * Save unavailable dates to file
     * @return true if save was successful, false otherwise
     */
    private boolean saveUnavailableDates() {
        try {
            // Create a backup of the existing file first
            if (FileHandler.fileExists(UNAVAILABLE_DATES_FILE)) {
                FileHandler.copyFile(UNAVAILABLE_DATES_FILE, UNAVAILABLE_DATES_FILE + ".bak");
            }

            // Delete existing file
            FileHandler.deleteFile(UNAVAILABLE_DATES_FILE);

            // Ensure file exists
            FileHandler.ensureFileExists(UNAVAILABLE_DATES_FILE);

            // Write each unavailable date
            StringBuilder content = new StringBuilder();
            for (UnavailableDate date : unavailableDates) {
                content.append(date.toFileString()).append(System.lineSeparator());
            }

            boolean result = FileHandler.writeToFile(UNAVAILABLE_DATES_FILE, content.toString(), false);

            LOGGER.info("Successfully saved " + unavailableDates.size() + " unavailable dates");
            return result;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error saving unavailable dates", e);

            // Try to restore from backup if available
            try {
                if (FileHandler.fileExists(UNAVAILABLE_DATES_FILE + ".bak")) {
                    FileHandler.copyFile(UNAVAILABLE_DATES_FILE + ".bak", UNAVAILABLE_DATES_FILE);
                    LOGGER.info("Restored from backup after save failure");
                }
            } catch (Exception restoreEx) {
                LOGGER.log(Level.SEVERE, "Failed to restore from backup", restoreEx);
            }

            return false;
        }
    }

    /**
     * Add a new unavailable date
     * @param date UnavailableDate to add
     * @return true if added successfully, false otherwise
     */
    public boolean addUnavailableDate(UnavailableDate date) {
        if (date == null) {
            LOGGER.warning("Attempted to add null unavailable date");
            return false;
        }

        // Check for duplicates based on photographer ID, date, and time slots
        boolean exists = unavailableDates.stream()
                .anyMatch(existingDate ->
                        existingDate.getPhotographerId().equals(date.getPhotographerId()) &&
                                existingDate.getDate().equals(date.getDate()) &&
                                existingDate.isAllDay() == date.isAllDay() &&
                                ((existingDate.isAllDay() && date.isAllDay()) ||
                                        (existingDate.getStartTime() != null && existingDate.getStartTime().equals(date.getStartTime()) &&
                                                existingDate.getEndTime() != null && existingDate.getEndTime().equals(date.getEndTime())))
                );

        if (exists) {
            LOGGER.info("Duplicate unavailable date not added");
            return false;
        }

        unavailableDates.add(date);
        return saveUnavailableDates();
    }

    /**
     * Get all unavailable dates for a photographer
     * @param photographerId Photographer's ID
     * @return List of unavailable dates
     */
    public List<UnavailableDate> getUnavailableDatesForPhotographer(String photographerId) {
        if (photographerId == null) {
            return new ArrayList<>();
        }

        LOGGER.info("Fetching unavailable dates for photographer ID: " + photographerId);

        // Force reload from file to get the latest data
        this.unavailableDates = loadUnavailableDates();

        List<UnavailableDate> photographerDates = unavailableDates.stream()
                .filter(date -> date.getPhotographerId().equals(photographerId))
                .collect(Collectors.toList());

        LOGGER.info("Found " + photographerDates.size() + " unavailable dates for photographer ID: " + photographerId);

        return photographerDates;
    }

    /**
     * Remove an unavailable date by its ID
     * @param dateId ID of the unavailable date to remove
     * @return true if removed successfully, false otherwise
     */
    public boolean removeUnavailableDate(String dateId) {
        if (dateId == null) {
            LOGGER.warning("Attempted to remove null dateId");
            return false;
        }

        int originalSize = unavailableDates.size();
        unavailableDates.removeIf(date -> date.getId().equals(dateId));

        boolean removed = unavailableDates.size() < originalSize;

        if (removed) {
            LOGGER.info("Removed unavailable date with ID: " + dateId);
            return saveUnavailableDates();
        }

        LOGGER.warning("Failed to remove unavailable date with ID: " + dateId);
        return false;
    }

    /**
     * Check if a date is unavailable for a photographer
     * @param photographerId Photographer's ID
     * @param date Date to check
     * @return true if date is unavailable, false otherwise
     */
    public boolean isDateUnavailable(String photographerId, LocalDate date) {
        if (photographerId == null || date == null) {
            return false;
        }

        return unavailableDates.stream()
                .anyMatch(ud ->
                        ud.getPhotographerId().equals(photographerId) &&
                                ud.getDate().equals(date) &&
                                ud.isAllDay()
                );
    }

    /**
     * Get all time slots that are unavailable for a specific date
     * @param photographerId Photographer's ID
     * @param date Date to check
     * @return List of unavailable time slots (in format "HH:MM")
     */
    public List<String> getUnavailableTimeSlots(String photographerId, LocalDate date) {
        if (photographerId == null || date == null) {
            return new ArrayList<>();
        }

        List<String> unavailableSlots = new ArrayList<>();

        // First check if the entire day is blocked
        if (isDateUnavailable(photographerId, date)) {
            // Add all standard time slots if the day is fully blocked
            unavailableSlots.add("09:00");
            unavailableSlots.add("10:00");
            unavailableSlots.add("11:00");
            unavailableSlots.add("12:00");
            unavailableSlots.add("13:00");
            unavailableSlots.add("14:00");
            unavailableSlots.add("15:00");
            unavailableSlots.add("16:00");
            unavailableSlots.add("17:00");
            unavailableSlots.add("18:00");
            unavailableSlots.add("19:00");
            unavailableSlots.add("20:00");
            return unavailableSlots;
        }

        // Then check for specific time slot blocks
        for (UnavailableDate ud : unavailableDates) {
            if (ud.getPhotographerId().equals(photographerId) &&
                    ud.getDate().equals(date) &&
                    !ud.isAllDay() &&
                    ud.getStartTime() != null) {

                String startTime = ud.getStartTime();
                // Only add the start time if it's in our standard format (HH:MM)
                if (startTime.matches("\\d{2}:\\d{2}")) {
                    unavailableSlots.add(startTime);
                }
            }
        }

        return unavailableSlots;
    }
}