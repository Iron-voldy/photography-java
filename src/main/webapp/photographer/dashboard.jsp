<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photographer Dashboard - SnapEvent</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }

        .dashboard-container {
            padding: 20px;
        }

        .dashboard-header {
            background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
        }

        .dashboard-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
            height: 100%;
        }

        .dashboard-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        .dashboard-card-title {
            font-weight: 600;
            color: #4361ee;
            margin-bottom: 0;
        }

        .stat-card {
            padding: 20px;
            border-radius: 15px;
            color: white;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .stat-card-primary {
            background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
        }

        .stat-card-success {
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
        }

        .stat-card-warning {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
        }

        .stat-card-info {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
        }

        .stat-label {
            font-size: 1rem;
            opacity: 0.8;
        }

        .activity-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .activity-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .activity-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #eef2ff;
            color: #4361ee;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .activity-content {
            flex-grow: 1;
        }

        .activity-title {
            font-weight: 500;
            margin-bottom: 0;
        }

        .activity-time {
            font-size: 0.8rem;
            color: #6c757d;
        }

        .booking-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .booking-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .booking-date {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 60px;
            height: 60px;
            background-color: #4361ee;
            color: white;
            border-radius: 10px;
            margin-right: 15px;
            text-align: center;
            flex-shrink: 0;
        }

        .booking-day {
            font-size: 1.5rem;
            font-weight: 700;
            line-height: 1;
        }

        .booking-month {
            font-size: 0.8rem;
            text-transform: uppercase;
        }

        .booking-details {
            flex-grow: 1;
        }

        .booking-title {
            font-weight: 500;
            margin-bottom: 2px;
        }

        .booking-location {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 5px;
        }

        .badge-booking-status {
            font-size: 0.75rem;
            font-weight: 500;
            padding: 5px 10px;
        }

        .calendar-container {
            height: 400px;
        }

        .review-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .review-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .review-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .review-content {
            flex-grow: 1;
        }

        .review-author {
            font-weight: 500;
            margin-bottom: 2px;
        }

        .review-date {
            font-size: 0.8rem;
            color: #6c757d;
            margin-bottom: 5px;
        }

        .review-stars {
            color: #f39c12;
            margin-bottom: 5px;
        }

        .btn-view-all {
            color: #4361ee;
            background-color: transparent;
            border: none;
            font-weight: 500;
            padding: 0;
        }

        .btn-view-all:hover {
            color: #3a0ca3;
            text-decoration: underline;
        }

        .nav-link.active {
            background-color: #4361ee;
            color: white !important;
            border-radius: 0.25rem;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <!-- Include Sidebar with "dashboard" as active page -->
            <c:set var="activePage" value="dashboard" scope="request"/>
            <jsp:include page="/includes/sidebar.jsp" />

            <!-- Main Content Area -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="dashboard-container">
                    <!-- Include Messages for notifications -->
                    <jsp:include page="/includes/messages.jsp" />

                    <!-- Dashboard Header -->
                    <div class="dashboard-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h1 class="h3 mb-0">Photographer Dashboard</h1>
                                <p class="mb-0">Welcome back, ${sessionScope.user.fullName}</p>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/photographer/availability_calendar.jsp" class="btn btn-light me-2">
                                    <i class="bi bi-calendar-week me-2"></i>Manage Availability
                                </a>
                                <a href="${pageContext.request.contextPath}/gallery/upload_photos.jsp" class="btn btn-light">
                                    <i class="bi bi-cloud-upload me-2"></i>Upload Photos
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Stats Cards Row -->
                    <div class="row g-4 mb-4">
                        <!-- Total Bookings Stat -->
                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card stat-card-primary">
                                <div>
                                    <div class="stat-value">24</div>
                                    <div class="stat-label">Total Bookings</div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-white text-primary">+12% this month</span>
                                </div>
                            </div>
                        </div>

                        <!-- Completed Bookings Stat -->
                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card stat-card-success">
                                <div>
                                    <div class="stat-value">18</div>
                                    <div class="stat-label">Completed</div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-white text-success">75% completion rate</span>
                                </div>
                            </div>
                        </div>

                        <!-- Upcoming Bookings Stat -->
                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card stat-card-warning">
                                <div>
                                    <div class="stat-value">5</div>
                                    <div class="stat-label">Upcoming</div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-white text-warning">Next: Today</span>
                                </div>
                            </div>
                        </div>

                        <!-- Reviews Stat -->
                        <div class="col-md-6 col-lg-3">
                            <div class="stat-card stat-card-info">
                                <div>
                                    <div class="stat-value">4.8</div>
                                    <div class="stat-label">Average Rating</div>
                                </div>
                                <div class="mt-3">
                                    <span class="badge bg-white text-info">42 reviews</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Main Content Row -->
                    <div class="row g-4">
                        <!-- Left Column -->
                        <div class="col-lg-8">
                            <!-- Upcoming Bookings Card -->
                            <div class="dashboard-card mb-4">
                                <div class="dashboard-card-header">
                                    <h5 class="dashboard-card-title">Upcoming Bookings</h5>
                                    <a href="${pageContext.request.contextPath}/booking/booking_list.jsp" class="btn-view-all">View All</a>
                                </div>
                                <div>
                                    <!-- Booking 1 -->
                                    <div class="booking-item">
                                        <div class="booking-date">
                                            <div class="booking-day">15</div>
                                            <div class="booking-month">Dec</div>
                                        </div>
                                        <div class="booking-details">
                                            <h6 class="booking-title">Johnson Wedding</h6>
                                            <p class="booking-location"><i class="bi bi-geo-alt me-1"></i>Central Park, New York</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="text-muted">2:00 PM - 8:00 PM</span>
                                                <span class="badge bg-success badge-booking-status">Confirmed</span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Booking 2 -->
                                    <div class="booking-item">
                                        <div class="booking-date">
                                            <div class="booking-day">20</div>
                                            <div class="booking-month">Jan</div>
                                        </div>
                                        <div class="booking-details">
                                            <h6 class="booking-title">Corporate Headshots</h6>
                                            <p class="booking-location"><i class="bi bi-geo-alt me-1"></i>ABC Company, 123 Business St</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="text-muted">9:00 AM - 5:00 PM</span>
                                                <span class="badge bg-success badge-booking-status">Confirmed</span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Booking 3 -->
                                    <div class="booking-item">
                                        <div class="booking-date">
                                            <div class="booking-day">05</div>
                                            <div class="booking-month">Feb</div>
                                        </div>
                                        <div class="booking-details">
                                            <h6 class="booking-title">Product Photoshoot</h6>
                                            <p class="booking-location"><i class="bi bi-geo-alt me-1"></i>Studio B, 456 Creative Ave</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="text-muted">10:00 AM - 3:00 PM</span>
                                                <span class="badge bg-warning text-dark badge-booking-status">Pending</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Availability Calendar Card -->
                            <div class="dashboard-card">
                                <div class="dashboard-card-header">
                                    <h5 class="dashboard-card-title">Availability Calendar</h5>
                                    <a href="${pageContext.request.contextPath}/photographer/availability_calendar.jsp" class="btn-view-all">Manage</a>
                                </div>
                                <div class="calendar-container" id="calendar"></div>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="col-lg-4">
                            <!-- Recent Reviews Card -->
                            <div class="dashboard-card mb-4">
                                <div class="dashboard-card-header">
                                    <h5 class="dashboard-card-title">Recent Reviews</h5>
                                    <a href="${pageContext.request.contextPath}/review/view_reviews.jsp?photographerId=${sessionScope.user.userId}" class="btn-view-all">View All</a>
                                </div>
                                <div>
                                    <!-- Review 1 -->
                                    <div class="review-item">
                                        <img src="https://randomuser.me/api/portraits/women/32.jpg" alt="Sarah J." class="review-avatar">
                                        <div class="review-content">
                                            <h6 class="review-author">Sarah Johnson</h6>
                                            <span class="review-date">June 15, 2023</span>
                                            <div class="review-stars">
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                            </div>
                                            <p class="small mb-0">"Absolutely amazing! Captured all the special moments at our wedding and made everyone feel comfortable."</p>
                                        </div>
                                    </div>

                                    <!-- Review 2 -->
                                    <div class="review-item">
                                        <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Michael T." class="review-avatar">
                                        <div class="review-content">
                                            <h6 class="review-author">Michael Thompson</h6>
                                            <span class="review-date">May 3, 2023</span>
                                            <div class="review-stars">
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star"></i>
                                            </div>
                                            <p class="small mb-0">"Very professional and unobtrusive. Quick turnaround time with the photos. Would recommend!"</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Recent Activity Card -->
                            <div class="dashboard-card mb-4">
                                <div class="dashboard-card-header">
                                    <h5 class="dashboard-card-title">Recent Activity</h5>
                                </div>
                                <div>
                                    <!-- Activity 1 -->
                                    <div class="activity-item">
                                        <div class="activity-icon">
                                            <i class="bi bi-calendar-check"></i>
                                        </div>
                                        <div class="activity-content">
                                            <h6 class="activity-title">New Booking Received</h6>
                                            <p class="activity-time">2 hours ago</p>
                                        </div>
                                    </div>

                                    <!-- Activity 2 -->
                                    <div class="activity-item">
                                        <div class="activity-icon">
                                            <i class="bi bi-star"></i>
                                        </div>
                                        <div class="activity-content">
                                            <h6 class="activity-title">New Review (5 stars)</h6>
                                            <p class="activity-time">Yesterday</p>
                                        </div>
                                    </div>

                                    <!-- Activity 3 -->
                                    <div class="activity-item">
                                        <div class="activity-icon">
                                            <i class="bi bi-upload"></i>
                                        </div>
                                        <div class="activity-content">
                                            <h6 class="activity-title">Gallery 'Smith Wedding' Uploaded</h6>
                                            <p class="activity-time">June 10, 2023</p>
                                        </div>
                                    </div>

                                    <!-- Activity 4 -->
                                    <div class="activity-item">
                                        <div class="activity-icon">
                                            <i class="bi bi-cash-coin"></i>
                                        </div>
                                        <div class="activity-content">
                                            <h6 class="activity-title">Payment Received - $1,200</h6>
                                            <p class="activity-time">June 8, 2023</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Links Card -->
                            <div class="dashboard-card">
                                <div class="dashboard-card-header">
                                    <h5 class="dashboard-card-title">Quick Links</h5>
                                </div>
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/photographer/service_management.jsp" class="btn btn-outline-primary">
                                        <i class="bi bi-camera me-2"></i>Manage Your Services
                                    </a>
                                    <a href="${pageContext.request.contextPath}/gallery/upload_photos.jsp" class="btn btn-outline-primary">
                                        <i class="bi bi-cloud-upload me-2"></i>Upload New Photos
                                    </a>
                                    <a href="${pageContext.request.contextPath}/booking/booking_list.jsp" class="btn btn-outline-primary">
                                        <i class="bi bi-calendar-check me-2"></i>View All Bookings
                                    </a>
                                    <a href="${pageContext.request.contextPath}/photographer/earnings.jsp" class="btn btn-outline-primary">
                                        <i class="bi bi-cash-coin me-2"></i>View Earnings Report
                                    </a>
                                    <a href="${pageContext.request.contextPath}/gallery/gallery_list.jsp?userOnly=true" class="btn btn-outline-primary">
                                        <i class="bi bi-images me-2"></i>Manage Your Galleries
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize FullCalendar
            const calendarEl = document.getElementById('calendar');

            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth'
                },
                height: '100%',
                events: [
                    // Existing bookings (confirmed)
                    {
                        id: 'booking-1',
                        title: 'Johnson Wedding',
                        start: '2023-12-15',
                        end: '2023-12-16',
                        backgroundColor: '#2ecc71',
                        borderColor: '#2ecc71'
                    },
                    {
                        id: 'booking-2',
                        title: 'Corporate Headshots',
                        start: '2024-01-20',
                        backgroundColor: '#2ecc71',
                        borderColor: '#2ecc71'
                    },
                    {
                        id: 'booking-3',
                        title: 'Product Photoshoot',
                        start: '2024-02-05',
                        backgroundColor: '#f39c12',
                        borderColor: '#f39c12'
                    },

                    // Unavailable dates (blocked by photographer)
                    {
                        title: 'Unavailable',
                        start: '2023-12-24',
                        end: '2023-12-26',
                        backgroundColor: '#e74c3c',
                        borderColor: '#e74c3c'
                    },
                    {
                        title: 'Unavailable',
                        start: '2023-12-31',
                        backgroundColor: '#e74c3c',
                        borderColor: '#e74c3c'
                    }
                ],
                eventClick: function(info) {
                    // If it's a booking event, redirect to booking details
                    if (info.event.id && info.event.id.startsWith('booking-')) {
                        const bookingId = info.event.id.replace('booking-', 'b00');
                        window.location.href = '${pageContext.request.contextPath}/booking/booking_details.jsp?id=' + bookingId;
                    }
                }
            });

            calendar.render();
        });
    </script>
</body>
</html>