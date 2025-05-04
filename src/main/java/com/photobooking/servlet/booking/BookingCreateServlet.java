package com.photobooking.servlet.booking;

import java.io.IOException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.booking.Booking;
import com.photobooking.model.booking.BookingManager;
import com.photobooking.model.user.User;
import com.photobooking.util.ValidationUtil;
import com.photobooking.model.photographer.PhotographerManager;
import com.photobooking.model.photographer.Photographer;

@WebServlet("/booking/create")
public class BookingCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        try {
            // Get form parameters
            String photographerId = request.getParameter("photographerId");
            String serviceId = request.getParameter("packageId");
            String eventDateStr = request.getParameter("eventDate");
            String eventTimeStr = request.getParameter("startTime");
            String eventLocation = request.getParameter("eventLocation");
            String eventType = request.getParameter("eventType");
            String eventNotes = request.getParameter("eventNotes");

            // Validate inputs
            if (ValidationUtil.isNullOrEmpty(photographerId) ||
                    ValidationUtil.isNullOrEmpty(serviceId) ||
                    ValidationUtil.isNullOrEmpty(eventDateStr) ||
                    ValidationUtil.isNullOrEmpty(eventTimeStr)) {

                session.setAttribute("errorMessage", "Missing required booking details");
                response.sendRedirect(request.getContextPath() + "/booking/booking_form.jsp");
                return;
            }

            // Check if photographer exists
            PhotographerManager photographerManager = new PhotographerManager();
            Photographer photographer = photographerManager.getPhotographerByUserId(photographerId);

            if (photographer == null) {
                session.setAttribute("errorMessage", "Selected photographer not found");
                response.sendRedirect(request.getContextPath() + "/booking/booking_form.jsp");
                return;
            }

            // Parse date and time
            LocalDateTime eventDateTime = LocalDateTime.parse(eventDateStr + "T" + eventTimeStr);

            // Create booking
            Booking booking = new Booking();
            booking.setClientId(currentUser.getUserId());
            booking.setPhotographerId(photographerId);
            booking.setServiceId(serviceId);
            booking.setEventDateTime(eventDateTime);
            booking.setEventLocation(eventLocation);
            booking.setEventType(Booking.BookingType.valueOf(eventType));
            booking.setEventNotes(eventNotes);

            // Set a default price (in a real app, this would come from the service)
            booking.setTotalPrice(1000.00);

            // Save booking
            BookingManager bookingManager = new BookingManager();
            if (bookingManager.createBooking(booking)) {
                session.setAttribute("successMessage", "Booking created successfully!");
                response.sendRedirect(request.getContextPath() + "/booking/booking_details?id=" + booking.getBookingId());
            } else {
                session.setAttribute("errorMessage", "Failed to create booking");
                response.sendRedirect(request.getContextPath() + "/booking/booking_form.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/booking/booking_form.jsp");
        }
    }
}