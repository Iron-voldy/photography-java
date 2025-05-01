package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;
import com.photobooking.model.user.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 * Servlet for handling photographer availability operations
 */
@WebServlet("/photographer/availability")
public class PhotographerAvailabilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests - get availability for a date
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        // Only photographers can access this functionality
        if (currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Get date parameter
        String dateStr = request.getParameter("date");
        if (dateStr == null || dateStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // Parse date
        LocalDate date;
        try {
            date = LocalDate.parse(dateStr);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // Get photographer
        PhotographerManager photographerManager = new PhotographerManager();
        Photographer photographer = photographerManager.getPhotographerByUserId(currentUser.getUserId());

        if (photographer == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Get availability for date
        List<Photographer.TimeSlot> timeSlots = photographerManager.getPhotographerAvailability(
                photographer.getPhotographerId(), date);

        // If no time slots exist for this date, create default ones
        if (timeSlots == null) {
            timeSlots = photographerManager.createDefaultTimeSlots();
        }

        // Create JSON response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JSONObject jsonResponse = new JSONObject();
        JSONArray availableTimeSlots = new JSONArray();

        for (Photographer.TimeSlot timeSlot : timeSlots) {
            if (timeSlot.isAvailable()) {
                availableTimeSlots.add(timeSlot.getStartTime().toString());
            }
        }

        jsonResponse.put("success", true);
        jsonResponse.put("date", dateStr);
        jsonResponse.put("availableTimeSlots", availableTimeSlots);

        out.print(jsonResponse.toJSONString());
        out.flush();
    }

    /**
     * Handles POST requests - save availability for a date
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        // Only photographers can access this functionality
        if (currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            // Parse request body
            StringBuilder requestBody = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                requestBody.append(line);
            }

            JSONParser parser = new JSONParser();
            JSONObject jsonRequest = (JSONObject) parser.parse(requestBody.toString());

            // Get date and unavailable time slots
            String dateStr = (String) jsonRequest.get("date");
            JSONArray unavailableTimeSlotsArray = (JSONArray) jsonRequest.get("unavailableTimeSlots");

            if (dateStr == null || unavailableTimeSlotsArray == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            // Parse date
            LocalDate date = LocalDate.parse(dateStr);

            // Create map of time slots
            Map<String, Boolean> timeSlotMap = new HashMap<>();

            // Default all time slots to available
            for (int hour = 9; hour <= 20; hour++) {
                String time = String.format("%02d:00", hour);
                timeSlotMap.put(time, true);
            }

            // Mark unavailable time slots
            for (Object timeObj : unavailableTimeSlotsArray) {
                String time = (String) timeObj;
                timeSlotMap.put(time, false);
            }

            // Create time slots list
            List<Photographer.TimeSlot> timeSlots = new ArrayList<>();

            for (int hour = 9; hour <= 20; hour++) {
                String startTime = String.format("%02d:00", hour);
                String endTime = String.format("%02d:00", hour + 1);

                LocalTime start = LocalTime.parse(startTime);
                LocalTime end = LocalTime.parse(endTime);
                boolean isAvailable = timeSlotMap.getOrDefault(startTime, true);

                timeSlots.add(new Photographer.TimeSlot(start, end, isAvailable));
            }

            // Get photographer
            PhotographerManager photographerManager = new PhotographerManager();
            Photographer photographer = photographerManager.getPhotographerByUserId(currentUser.getUserId());

            if (photographer == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Save availability
            boolean success = photographerManager.setPhotographerAvailability(
                    photographer.getPhotographerId(), date, timeSlots);

            // Create JSON response
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", success);

            if (success) {
                jsonResponse.put("message", "Availability saved successfully");
            } else {
                jsonResponse.put("message", "Failed to save availability");
            }

            out.print(jsonResponse.toJSONString());
            out.flush();

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}