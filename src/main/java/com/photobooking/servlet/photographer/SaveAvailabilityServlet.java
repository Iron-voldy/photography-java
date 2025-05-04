package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.photographer.UnavailableDate;
import com.photobooking.model.photographer.UnavailableDateManager;
import com.photobooking.model.user.User;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

@WebServlet("/photographer/save-availability")
public class SaveAvailabilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in and is a photographer
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Not logged in");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Read JSON input
        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        try (java.io.BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        try {
            // Parse JSON input
            JsonObject jsonInput = JsonParser.parseString(jsonBuffer.toString()).getAsJsonObject();
            String dateStr = jsonInput.get("date").getAsString();
            JsonArray unavailableTimeSlotsJson = jsonInput.getAsJsonArray("unavailableTimeSlots");

            // Convert to Java objects
            LocalDate date = LocalDate.parse(dateStr);
            List<String> unavailableTimeSlots = new ArrayList<>();
            for (int i = 0; i < unavailableTimeSlotsJson.size(); i++) {
                unavailableTimeSlots.add(unavailableTimeSlotsJson.get(i).getAsString());
            }

            String photographerId = currentUser.getUserId();
            UnavailableDateManager unavailableDateManager = new UnavailableDateManager();

            // Check if we need to block the whole day
            if (unavailableTimeSlots.size() == 12) { // All time slots are blocked
                UnavailableDate allDayUnavailable = new UnavailableDate(
                        photographerId,
                        date,
                        true,
                        "Blocked entire day"
                );
                unavailableDateManager.addUnavailableDate(allDayUnavailable);
            } else {
                // Block specific time slots
                for (String timeSlot : unavailableTimeSlots) {
                    UnavailableDate partialUnavailable = new UnavailableDate(
                            photographerId,
                            date,
                            false,
                            "Blocked time slot"
                    );
                    partialUnavailable.setStartTime(timeSlot);
                    partialUnavailable.setEndTime(getNextTimeSlot(timeSlot));
                    unavailableDateManager.addUnavailableDate(partialUnavailable);
                }
            }

            // Prepare JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Availability updated successfully");

            out.print(new Gson().toJson(jsonResponse));
            out.flush();

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error saving availability: " + e.getMessage());
        }
    }

    /**
     * Get the next time slot
     * @param currentTimeSlot Current time slot (HH:mm)
     * @return Next time slot (HH:mm)
     */
    private String getNextTimeSlot(String currentTimeSlot) {
        int currentHour = Integer.parseInt(currentTimeSlot.split(":")[0]);
        int nextHour = currentHour + 1;
        return String.format("%02d:00", nextHour);
    }
}