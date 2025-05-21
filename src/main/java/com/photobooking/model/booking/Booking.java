package com.photobooking.model.booking;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Represents a booking in the Event Photography System
 */
public class Booking implements Serializable {
    private static final long serialVersionUID = 1L;

    // Booking status enum
    public enum BookingStatus {
        PENDING, CONFIRMED, COMPLETED, CANCELLED
    }

    // Booking types
    public enum BookingType {
        WEDDING, CORPORATE, PORTRAIT, EVENT, FAMILY, PRODUCT, OTHER
    }

    // Booking attributes
    private String bookingId;
    private String clientId;
    private String photographerId;
    private String serviceId;
    private LocalDateTime bookingDateTime;
    private LocalDateTime eventDateTime;
    private String eventLocation;
    private String eventNotes;
    private BookingType eventType;
    private BookingStatus status;
    private double totalPrice;

    // Constructors
    public Booking() {
        this.bookingId = UUID.randomUUID().toString();
        this.status = BookingStatus.PENDING;
        this.bookingDateTime = LocalDateTime.now();
    }

    public Booking(String clientId, String photographerId, String serviceId,
                   LocalDateTime eventDateTime, String eventLocation,
                   BookingType eventType, double totalPrice) {
        this.bookingId = UUID.randomUUID().toString();
        this.clientId = clientId;
        this.photographerId = photographerId;
        this.serviceId = serviceId;
        this.bookingDateTime = LocalDateTime.now();
        this.eventDateTime = eventDateTime;
        this.eventLocation = eventLocation;
        this.eventType = eventType;
        this.totalPrice = totalPrice;
        this.status = BookingStatus.PENDING;
    }

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getPhotographerId() {
        return photographerId;
    }

    public void setPhotographerId(String photographerId) {
        this.photographerId = photographerId;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public LocalDateTime getBookingDateTime() {
        return bookingDateTime;
    }

    public void setBookingDateTime(LocalDateTime bookingDateTime) {
        this.bookingDateTime = bookingDateTime;
    }

    public LocalDateTime getEventDateTime() {
        return eventDateTime;
    }

    public void setEventDateTime(LocalDateTime eventDateTime) {
        this.eventDateTime = eventDateTime;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public String getEventNotes() {
        return eventNotes;
    }

    public void setEventNotes(String eventNotes) {
        this.eventNotes = eventNotes;
    }

    public BookingType getEventType() {
        return eventType;
    }

    public void setEventType(BookingType eventType) {
        this.eventType = eventType;
    }

    public BookingStatus getStatus() {
        return status;
    }

    public void setStatus(BookingStatus status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    // Convert booking to file string representation
    public String toFileString() {
        StringBuilder builder = new StringBuilder();
        builder.append(bookingId).append(",");
        builder.append(clientId).append(",");
        builder.append(photographerId).append(",");
        builder.append(serviceId != null ? serviceId : "").append(",");
        builder.append(bookingDateTime != null ? bookingDateTime.toString() : "").append(",");
        builder.append(eventDateTime != null ? eventDateTime.toString() : "").append(",");
        builder.append(eventLocation != null ? eventLocation.replaceAll(",", ";;") : "").append(",");
        builder.append(eventNotes != null ? eventNotes.replaceAll(",", ";;") : "").append(",");
        builder.append(eventType != null ? eventType.name() : "").append(",");
        builder.append(status != null ? status.name() : "").append(",");
        builder.append(String.valueOf(totalPrice));

        return builder.toString();
    }

    // Create booking from file string
    public static Booking fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length < 9) {
            // Not enough parts for a valid booking
            return null;
        }

        try {
            Booking booking = new Booking();

            int index = 0;
            booking.setBookingId(parts[index++]);
            booking.setClientId(parts[index++]);
            booking.setPhotographerId(parts[index++]);

            String serviceId = parts[index++];
            if (!serviceId.isEmpty()) {
                booking.setServiceId(serviceId);
            }

            String bookingDateTimeStr = parts[index++];
            if (!bookingDateTimeStr.isEmpty()) {
                booking.setBookingDateTime(LocalDateTime.parse(bookingDateTimeStr));
            }

            String eventDateTimeStr = parts[index++];
            if (!eventDateTimeStr.isEmpty()) {
                booking.setEventDateTime(LocalDateTime.parse(eventDateTimeStr));
            }

            String eventLocation = parts[index++];
            if (!eventLocation.isEmpty()) {
                booking.setEventLocation(eventLocation.replaceAll(";;", ","));
            }

            String eventNotes = parts[index++];
            if (!eventNotes.isEmpty()) {
                booking.setEventNotes(eventNotes.replaceAll(";;", ","));
            }

            String eventTypeStr = parts[index++];
            if (!eventTypeStr.isEmpty()) {
                booking.setEventType(BookingType.valueOf(eventTypeStr));
            }

            String statusStr = parts[index++];
            if (!statusStr.isEmpty()) {
                booking.setStatus(BookingStatus.valueOf(statusStr));
            }

            if (index < parts.length) {
                booking.setTotalPrice(Double.parseDouble(parts[index]));
            }

            return booking;
        } catch (Exception e) {
            System.err.println("Error parsing booking from file: " + e.getMessage());
            return null;
        }
    }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingId='" + bookingId + '\'' +
                ", clientId='" + clientId + '\'' +
                ", photographerId='" + photographerId + '\'' +
                ", serviceId='" + serviceId + '\'' +
                ", eventDateTime=" + eventDateTime +
                ", eventType=" + eventType +
                ", status=" + status +
                '}';
    }
}