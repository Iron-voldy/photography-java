package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import com.photobooking.model.booking.Booking;
import com.photobooking.model.booking.BookingManager;
import com.photobooking.model.user.User;
import com.photobooking.model.photographer.UnavailableDate;
import com.photobooking.model.photographer.UnavailableDateManager;

/**
 * Servlet for handling photographer availability calendar
 */
@WebServlet("/photographer/availability")
public class PhotographerAvailabilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in and is a photographer
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
            session.setAttribute("errorMessage", "Access denied");
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }

        String photographerId = currentUser.getUserId();

        // Get upcoming bookings for calendar
        BookingManager bookingManager = new BookingManager();
        List<Booking> upcomingBookings = bookingManager.getUpcomingBookings(photographerId, true);

        // Get unavailable dates for photographer
        UnavailableDateManager unavailableDateManager = new UnavailableDateManager();
        List<UnavailableDate> unavailableDates = unavailableDateManager.getUnavailableDatesForPhotographer(photographerId);

        // Convert bookings and unavailable dates to calendar events
        Gson gson = new Gson();
        JsonArray calendarEvents = new JsonArray();

        // Add booked events
        for (Booking booking : upcomingBookings) {
            JsonObject event = new JsonObject();
            event.addProperty("id", "booking-" + booking.getBookingId());
            event.addProperty("title", getBookingTypeDisplayName(booking.getEventType()));
            event.addProperty("start", booking.getEventDateTime().toString());
            event.addProperty("backgroundColor", getBookingStatusColor(booking.getStatus()));
            event.addProperty("borderColor", getBookingStatusColor(booking.getStatus()));

            calendarEvents.add(event);
        }

        // Add unavailable dates
        for (UnavailableDate date : unavailableDates) {
            JsonObject event = new JsonObject();
            event.addProperty("id", "unavailable-" + date.getId());
            event.addProperty("title", date.getReason() != null ? date.getReason() : "Unavailable");
            event.addProperty("start", date.getDate().toString());
            event.addProperty("backgroundColor", "#dc3545");  // Red color for unavailable dates
            event.addProperty("borderColor", "#dc3545");
            event.addProperty("allDay", true);

            calendarEvents.add(event);
        }

        // Set attributes for JSP
        request.setAttribute("upcomingBookings", upcomingBookings);
        request.setAttribute("unavailableDates", unavailableDates);
        request.setAttribute("calendarEventsJson", gson.toJson(calendarEvents));

        request.getRequestDispatcher("/photographer/availability_calendar.jsp").forward(request, response);
    }

    /**
     * Get booking type display name
     */
    private String getBookingTypeDisplayName(Booking.BookingType type) {
        if (type == null) return "Photography Session";

        switch (type) {
            case WEDDING:
                return "Wedding Photography";
            case CORPORATE:
                return "Corporate Event";
            case PORTRAIT:
                return "Portrait Session";
            case EVENT:
                return "Event Photography";
            case FAMILY:
                return "Family Photography";
            case PRODUCT:
                return "Product Photography";
            default:
                return "Photography Session";
        }
    }

    /**
     * Get booking status color
     */
    private String getBookingStatusColor(Booking.BookingStatus status) {
        if (status == null) return "#6c757d";  // Gray

        switch (status) {
            case CONFIRMED:
                return "#28a745";  // Green
            case PENDING:
                return "#ffc107";  // Yellow
            case CANCELLED:
                return "#dc3545";  // Red
            case COMPLETED:
                return "#007bff";  // Blue
            default:
                return "#6c757d";  // Gray
        }
    }
}