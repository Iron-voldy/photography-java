package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.user.User;
import com.photobooking.model.photographer.UnavailableDateManager;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet("/photographer/remove-blocked-date")
public class RemoveUnavailableDateServlet extends HttpServlet {
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

        // Get dateId from request
        String dateId = request.getParameter("dateId");
        if (dateId == null || dateId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Date ID is required");
            return;
        }

        try {
            UnavailableDateManager unavailableDateManager = new UnavailableDateManager();
            boolean removed = unavailableDateManager.removeUnavailableDate(dateId);

            // Prepare JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", removed);
            if (!removed) {
                jsonResponse.addProperty("message", "Failed to remove unavailable date");
            }

            out.print(new Gson().toJson(jsonResponse));
            out.flush();

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error removing unavailable date: " + e.getMessage());
        }
    }
}