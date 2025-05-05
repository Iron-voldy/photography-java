package com.photobooking.model.booking;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * A queue-based implementation to manage photography bookings.
 * This class implements a FIFO (First-In-First-Out) queue to process booking requests.
 * Provides operations to enqueue new bookings, dequeue bookings, and view pending bookings.
 */
public class BookingQueue {
    private LinkedList<Booking> bookingQueue;
    private BookingManager bookingManager;

    /**
     * Constructor initializes an empty booking queue.
     * @param bookingManager The booking manager to save processed bookings
     */
    public BookingQueue(BookingManager bookingManager) {
        this.bookingQueue = new LinkedList<>();
        this.bookingManager = bookingManager;
    }

    /**
     * Add a new booking to the end of the queue.
     * @param booking The booking to add to the queue
     * @return true if the booking was added successfully
     */
    public boolean enqueue(Booking booking) {
        if (booking == null) {
            return false;
        }

        // Set booking status to PENDING by default
        booking.setStatus(Booking.BookingStatus.PENDING);

        // Add booking to the queue
        return bookingQueue.add(booking);
    }

    /**
     * Process and remove the booking at the front of the queue.
     * @return The processed booking, or null if the queue is empty
     */
    public Booking dequeue() {
        if (bookingQueue.isEmpty()) {
            return null;
        }

        // Remove the first booking from the queue (FIFO)
        Booking booking = bookingQueue.removeFirst();

        // Save the booking to the database/file
        bookingManager.createBooking(booking);

        return booking;
    }

    /**
     * Process and remove a specific booking from the queue by ID.
     * @param bookingId The ID of the booking to process
     * @return The processed booking, or null if not found
     */
    public Booking processBookingById(String bookingId) {
        if (bookingId == null || bookingQueue.isEmpty()) {
            return null;
        }

        // Find the booking with the given ID
        for (int i = 0; i < bookingQueue.size(); i++) {
            Booking booking = bookingQueue.get(i);
            if (booking.getBookingId().equals(bookingId)) {
                // Remove the booking from the queue
                bookingQueue.remove(i);

                // Save the booking to the database/file
                bookingManager.createBooking(booking);

                return booking;
            }
        }

        return null; // Booking not found
    }

    /**
     * View the booking at the front of the queue without removing it.
     * @return The next booking in the queue, or null if the queue is empty
     */
    public Booking peek() {
        return bookingQueue.isEmpty() ? null : bookingQueue.getFirst();
    }

    /**
     * Get all bookings in the queue.
     * @return List of bookings currently in the queue
     */
    public List<Booking> getAllQueuedBookings() {
        return new LinkedList<>(bookingQueue);
    }

    /**
     * Get all bookings in the queue for a specific photographer.
     * @param photographerId The photographer's ID
     * @return List of bookings for the specified photographer
     */
    public List<Booking> getQueuedBookingsForPhotographer(String photographerId) {
        if (photographerId == null) {
            return new LinkedList<>();
        }

        return bookingQueue.stream()
                .filter(booking -> booking.getPhotographerId().equals(photographerId))
                .collect(Collectors.toList());
    }

    /**
     * Get all bookings in the queue for a specific client.
     * @param clientId The client's ID
     * @return List of bookings for the specified client
     */
    public List<Booking> getQueuedBookingsForClient(String clientId) {
        if (clientId == null) {
            return new LinkedList<>();
        }

        return bookingQueue.stream()
                .filter(booking -> booking.getClientId().equals(clientId))
                .collect(Collectors.toList());
    }

    /**
     * Check if the queue is empty.
     * @return true if the queue is empty, false otherwise
     */
    public boolean isEmpty() {
        return bookingQueue.isEmpty();
    }

    /**
     * Get the number of bookings in the queue.
     * @return The size of the queue
     */
    public int size() {
        return bookingQueue.size();
    }

    /**
     * Clear all bookings from the queue.
     */
    public void clear() {
        bookingQueue.clear();
    }

    /**
     * Process all bookings in the queue.
     * @return Number of bookings processed
     */
    public int processAllBookings() {
        int processedCount = 0;

        while (!isEmpty()) {
            Booking booking = dequeue();
            if (booking != null) {
                processedCount++;
            }
        }

        return processedCount;
    }
}