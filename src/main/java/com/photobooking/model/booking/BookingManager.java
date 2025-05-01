package com.photobooking.model.booking;

import com.photobooking.util.FileHandler;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class BookingManager {
    private static final String BOOKING_FILE = "bookings.txt";
    private List<Booking> bookings;

    public BookingManager() {
        this.bookings = loadBookings();
    }

    // Load bookings from file
    private List<Booking> loadBookings() {
        List<String> lines = FileHandler.readLines(BOOKING_FILE);
        return lines.stream()
                .filter(line -> !line.trim().isEmpty())
                .map(Booking::fromFileString)
                .collect(Collectors.toList());
    }

    // Save bookings to file
    private void saveBookings() {
        FileHandler.deleteFile(BOOKING_FILE);
        bookings.forEach(booking ->
                FileHandler.appendLine(BOOKING_FILE, booking.toFileString())
        );
    }

    // Create a new booking
    public boolean createBooking(Booking booking) {
        // Basic validation
        if (booking == null || booking.getClientId() == null) {
            return false;
        }

        bookings.add(booking);
        saveBookings();
        return true;
    }

    // Get booking by ID
    public Booking getBookingById(String bookingId) {
        return bookings.stream()
                .filter(b -> b.getBookingId().equals(bookingId))
                .findFirst()
                .orElse(null);
    }

    // Get bookings for a client
    public List<Booking> getBookingsByClient(String clientId) {
        return bookings.stream()
                .filter(b -> b.getClientId().equals(clientId))
                .collect(Collectors.toList());
    }

    // Get bookings for a photographer
    public List<Booking> getBookingsByPhotographer(String photographerId) {
        return bookings.stream()
                .filter(b -> b.getPhotographerId().equals(photographerId))
                .collect(Collectors.toList());
    }

    // Update booking status
    public boolean updateBookingStatus(String bookingId, Booking.BookingStatus newStatus) {
        for (Booking booking : bookings) {
            if (booking.getBookingId().equals(bookingId)) {
                booking.setStatus(newStatus);
                saveBookings();
                return true;
            }
        }
        return false;
    }

    // Cancel a booking
    public boolean cancelBooking(String bookingId) {
        return updateBookingStatus(bookingId, Booking.BookingStatus.CANCELLED);
    }
}