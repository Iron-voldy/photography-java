package com.photobooking.servlet.photographer;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
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
import com.photobooking.util.FileHandler;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Servlet for photographer dashboard display
 */
@WebServlet("/photographer/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(DashboardServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize necessary data directories and files
        FileHandler.createDirectory("data");
    }

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

        // Ensure files exist
        FileHandler.ensureFileExists("photographers.txt");
        FileHandler.ensureFileExists("services.txt");

        String userId = currentUser.getUserId();

        // Get photographer profile
        PhotographerManager photographerManager = new PhotographerManager();
        Photographer photographer = photographerManager.getPhotographerByUserId(userId);

        // If photographer profile doesn't exist, create one
        if (photographer == null) {
            try {
                photographer = new Photographer();
                photographer.setUserId(userId);
                photographer.setBusinessName(currentUser.getFullName() + "'s Photography");
                photographer.setBiography("Professional photographer offering various photography services.");
                photographer.setSpecialties(new ArrayList<>());
                photographer.getSpecialties().add("General");
                photographer.setLocation("Not specified");
                photographer.setBasePrice(100.0); // Default base price
                photographer.setEmail(currentUser.getEmail());

                // Save the photographer profile
                boolean profileCreated = photographerManager.addPhotographer(photographer);

                if (profileCreated) {
                    LOGGER.info("Created missing photographer profile for user: " + currentUser.getUsername());

                    try {
                        // Create default services for the photographer
                        PhotographerServiceManager serviceManager = new PhotographerServiceManager();
                        serviceManager.createDefaultServices(photographer.getPhotographerId());
                    } catch (Exception e) {
                        LOGGER.log(Level.WARNING, "Error creating default services: " + e.getMessage(), e);
                    }

                    // Set photographerId in session
                    session.setAttribute("photographerId", photographer.getPhotographerId());
                } else {
                    LOGGER.log(Level.SEVERE, "Failed to create photographer profile for user: " + currentUser.getUsername());
                    session.setAttribute("errorMessage", "Failed to create photographer profile. Please contact support.");
                    response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
                    return;
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error creating photographer profile: " + e.getMessage(), e);
                session.setAttribute("errorMessage", "Error creating photographer profile: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
                return;
            }
        } else {
            // Set photographerId in session if it's not already there
            if (session.getAttribute("photographerId") == null) {
                session.setAttribute("photographerId", photographer.getPhotographerId());
            }
        }

        try {
            // Get dashboard statistics
            BookingManager bookingManager = new BookingManager();
            List<Booking> upcomingBookings = bookingManager.getUpcomingBookings(userId, true);
            List<Booking> allBookings = bookingManager.getBookingsByPhotographer(userId);

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
            request.setAttribute("upcomingBookingsCount", upcomingBookings.size());
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("completedBookings", completedBookings);
            request.setAttribute("recentReviews", recentReviews);
            request.setAttribute("calendarEvents", calendarEvents.toString());

            request.getRequestDispatcher("/photographer/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error loading dashboard data: " + e.getMessage(), e);
            session.setAttribute("errorMessage", "Error loading dashboard data: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
        }
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