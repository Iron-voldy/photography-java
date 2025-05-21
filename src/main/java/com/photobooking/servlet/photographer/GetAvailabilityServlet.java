package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.booking.BookingManager;
import com.photobooking.model.user.User;
import com.photobooking.model.photographer.UnavailableDateManager;
import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * AJAX endpoint for getting photographer availability for a specific date
 */
@WebServlet("/photographer/get-availability")
public class GetAvailabilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        HttpSession session = request.getSession(false);

        // Check if user is logged in and is a photographer
        if (session == null || session.getAttribute("user") == null) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "Not logged in");
            out.print(gson.toJson(error));
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "Access denied");
            out.print(gson.toJson(error));
            return;
        }

        String dateStr = request.getParameter("date");
        if (dateStr == null) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "Date parameter is required");
            out.print(gson.toJson(error));
            return;
        }

        try {
            LocalDate date = LocalDate.parse(dateStr);

            // Get photographerId (first try session, then database)
            String photographerId = (String) session.getAttribute("photographerId");
            if (photographerId == null) {
                // Try to get photographer from database
                PhotographerManager photographerManager = new PhotographerManager();
                Photographer photographer = photographerManager.getPhotographerByUserId(currentUser.getUserId());
                if (photographer != null) {
                    photographerId = photographer.getPhotographerId();
                    session.setAttribute("photographerId", photographerId);
                } else {
                    // If still no photographer ID, use user ID
                    photographerId = currentUser.getUserId();
                }
            }

            // Standard time slots
            List<String> timeSlots = new ArrayList<>();
            timeSlots.add("09:00");
            timeSlots.add("10:00");
            timeSlots.add("11:00");
            timeSlots.add("12:00");
            timeSlots.add("13:00");
            timeSlots.add("14:00");
            timeSlots.add("15:00");
            timeSlots.add("16:00");
            timeSlots.add("17:00");
            timeSlots.add("18:00");
            timeSlots.add("19:00");
            timeSlots.add("20:00");

            // Check if the date is completely blocked
            UnavailableDateManager unavailableDateManager = new UnavailableDateManager();
            boolean isFullyBlocked = unavailableDateManager.isDateUnavailable(photographerId, date);

            // Get all time-specific blocks
            List<String> unavailableTimeSlots = unavailableDateManager.getUnavailableTimeSlots(photographerId, date);

            // Check bookings for unavailability
            BookingManager bookingManager = new BookingManager();
            List<String> availableTimeSlots = new ArrayList<>();

            for (String timeSlot : timeSlots) {
                if (isFullyBlocked || unavailableTimeSlots.contains(timeSlot)) {
                    // Skip this slot if it's already marked as unavailable
                    continue;
                }

                // Check booking availability
                try {
                    LocalTime time = LocalTime.parse(timeSlot);
                    LocalDateTime dateTime = LocalDateTime.of(date, time);

                    if (bookingManager.isPhotographerAvailable(photographerId, dateTime, 1)) {
                        availableTimeSlots.add(timeSlot);
                    }
                } catch (Exception e) {
                    // Log and skip in case of parsing errors
                    System.out.println("Error checking time slot: " + timeSlot + " - " + e.getMessage());
                }
            }

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.add("availableTimeSlots", gson.toJsonTree(availableTimeSlots));
            jsonResponse.add("unavailableTimeSlots", gson.toJsonTree(unavailableTimeSlots));
            jsonResponse.addProperty("isFullyBlocked", isFullyBlocked);

            out.print(gson.toJson(jsonResponse));
        } catch (DateTimeParseException e) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "Invalid date format. Use YYYY-MM-DD format.");
            out.print(gson.toJson(error));
        } catch (Exception e) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "Error processing request: " + e.getMessage());
            out.print(gson.toJson(error));
        }
    }
}