package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.booking.Booking;
import com.photobooking.model.booking.BookingManager;
import com.photobooking.model.user.User;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

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

        // Convert bookings to calendar events
        JsonArray calendarEvents = new JsonArray();

        for (Booking booking : upcomingBookings) {
            JsonObject event = new JsonObject();
            event.addProperty("id", "booking-" + booking.getBookingId());
            event.addProperty("title", getBookingTypeDisplayName(booking.getEventType()));
            event.addProperty("start", booking.getEventDateTime().toString());

            // Set event color based on status
            String backgroundColor;
            switch (booking.getStatus()) {
                case CONFIRMED:
                    backgroundColor = "#28a745"; // Green
                    break;
                case PENDING:
                    backgroundColor = "#ffc107"; // Yellow
                    break;
                default:
                    backgroundColor = "#6c757d"; // Gray
            }
            event.addProperty("backgroundColor", backgroundColor);
            event.addProperty("borderColor", backgroundColor);

            calendarEvents.add(event);
        }

        // Set attributes for JSP
        request.setAttribute("upcomingBookings", upcomingBookings);
        request.setAttribute("calendarEventsJson", calendarEvents.toString());

        request.getRequestDispatcher("/photographer/availability_calendar.jsp").forward(request, response);
    }

    private String getBookingTypeDisplayName(Booking.BookingType type) {
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
}