package com.photobooking.model.photographer;

import com.photobooking.util.FileHandler;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Manages photographer unavailable dates
 */
public class UnavailableDateManager {
    private static final String UNAVAILABLE_DATES_FILE = "unavailable_dates.txt";
    private List<UnavailableDate> unavailableDates;

    public UnavailableDateManager() {
        this.unavailableDates = loadUnavailableDates();
    }

    private List<UnavailableDate> loadUnavailableDates() {
        List<String> lines = FileHandler.readLines(UNAVAILABLE_DATES_FILE);
        List<UnavailableDate> dates = new ArrayList<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                UnavailableDate date = UnavailableDate.fromFileString(line);
                if (date != null) {
                    dates.add(date);
                }
            }
        }

        return dates;
    }

    private boolean saveUnavailableDates() {
        try {
            FileHandler.deleteFile(UNAVAILABLE_DATES_FILE);
            for (UnavailableDate date : unavailableDates) {
                FileHandler.appendLine(UNAVAILABLE_DATES_FILE, date.toFileString());
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error saving unavailable dates: " + e.getMessage());
            return false;
        }
    }

    public boolean addUnavailableDate(UnavailableDate date) {
        unavailableDates.add(date);
        return saveUnavailableDates();
    }

    public List<UnavailableDate> getUnavailableDatesForPhotographer(String photographerId) {
        return unavailableDates.stream()
                .filter(date -> date.getPhotographerId().equals(photographerId))
                .collect(Collectors.toList());
    }

    public boolean removeUnavailableDate(String dateId) {
        boolean removed = unavailableDates.removeIf(date -> date.getId().equals(dateId));
        if (removed) {
            return saveUnavailableDates();
        }
        return false;
    }

    public boolean isDateUnavailable(String photographerId, LocalDate date) {
        return unavailableDates.stream()
                .anyMatch(ud -> ud.getPhotographerId().equals(photographerId) &&
                        ud.getDate().equals(date) &&
                        ud.isAllDay());
    }
}