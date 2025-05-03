package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.photobooking.model.booking.Booking;
import com.photobooking.model.booking.BookingManager;
import com.photobooking.model.photographer.Photographer;
import com.photobooking.model.photographer.PhotographerManager;
import com.photobooking.model.photographer.PhotographerService;
import com.photobooking.model.photographer.PhotographerServiceManager;
import com.photobooking.model.review.Review;
import com.photobooking.model.review.ReviewManager;
import com.photobooking.model.user.User;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

/**
 * Servlet for photographer dashboard display
 */
@WebServlet("/photographer/dashboard")
public class DashboardServlet extends HttpServlet {
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

        // Get photographer profile
        PhotographerManager photographerManager = new PhotographerManager();
        Photographer photographer = photographerManager.getPhotographerByUserId(photographerId);

        if (photographer == null) {
            session.setAttribute("errorMessage", "Photographer profile not found");
            response.sendRedirect(request.getContextPath() + "/photographer/register.jsp");
            return;
        }

        // Get dashboard statistics
        BookingManager bookingManager = new BookingManager();
        List<Booking> upcomingBookings = bookingManager.getUpcomingBookings(photographerId, true);
        List<Booking> allBookings = bookingManager.getBookingsByPhotographer(photographerId);

        // Calculate statistics
        int totalBookings = allBookings.size();
        int completedBookings = 0;
        for (Booking booking : allBookings) {
            if (booking.getStatus() == Booking.BookingStatus.COMPLETED) {
                completedBookings++;
            }
        }

        // Get recent reviews
        ReviewManager reviewManager = new ReviewManager();
        List<Review> recentReviews = reviewManager.getPhotographerReviews(photographer.getPhotographerId());

        // Prepare calendar events
        JsonArray calendarEvents = prepareCalendarEvents(upcomingBookings, bookingManager);

        // Set attributes for JSP
        request.setAttribute("photographer", photographer);
        request.setAttribute("upcomingBookings", upcomingBookings);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("completedBookings", completedBookings);
        request.setAttribute("recentReviews", recentReviews);
        request.setAttribute("calendarEvents", calendarEvents.toString());

        request.getRequestDispatcher("/photographer/dashboard.jsp").forward(request, response);
    }

    private JsonArray prepareCalendarEvents(List<Booking> bookings, BookingManager bookingManager) {
        JsonArray events = new JsonArray();

        for (Booking booking : bookings) {
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

            events.add(event);
        }

        return events;
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