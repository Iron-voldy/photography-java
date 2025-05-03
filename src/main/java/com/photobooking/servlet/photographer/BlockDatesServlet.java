package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.photographer.UnavailableDate;
import com.photobooking.model.photographer.UnavailableDateManager;
import com.photobooking.model.user.User;
import com.photobooking.util.ValidationUtil;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

/**
 * Servlet for blocking dates/times
 */
@WebServlet("/photographer/block-dates")
public class BlockDatesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        try {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String reason = ValidationUtil.cleanInput(request.getParameter("reason"));
            boolean allDay = "on".equals(request.getParameter("allDay"));

            if (startDateStr == null || startDateStr.isEmpty()) {
                JsonObject error = new JsonObject();
                error.addProperty("success", false);
                error.addProperty("message", "Start date is required");
                out.print(gson.toJson(error));
                return;
            }

            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = startDate;

            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDate.parse(endDateStr);
            }

            String photographerId = currentUser.getUserId();
            UnavailableDateManager unavailableManager = new UnavailableDateManager();
            JsonArray blockedDates = new JsonArray();

            // Block each date in the range
            for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
                UnavailableDate unavailableDate = new UnavailableDate(
                        photographerId,
                        date,
                        allDay ? true : false,
                        reason
                );

                if (!allDay) {
                    String startTime = request.getParameter("startTime");
                    String endTime = request.getParameter("endTime");

                    if (startTime != null && endTime != null) {
                        unavailableDate.setStartTime(startTime);
                        unavailableDate.setEndTime(endTime);
                    }
                }

                if (unavailableManager.addUnavailableDate(unavailableDate)) {
                    JsonObject dateObj = new JsonObject();
                    dateObj.addProperty("date", date.toString());
                    dateObj.addProperty("reason", reason);
                    blockedDates.add(dateObj);
                }
            }

            JsonObject response = new JsonObject();
            response.addProperty("success", true);
            response.add("blockedDates", blockedDates);

            out.print(gson.toJson(response));
        } catch (Exception e) {
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "Error processing request: " + e.getMessage());
            out.print(gson.toJson(error));
        }
    }
}