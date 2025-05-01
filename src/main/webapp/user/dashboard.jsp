<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - SnapEvent</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Fullcalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-hover: #3a56d4;
            --secondary-color: #7209b7;
            --accent-color: #f72585;
            --light-bg: #f8f9fa;
            --dark-bg: #212529;
            --text-color: #212529;
            --text-muted: #6c757d;
            --border-color: #dee2e6;
            --card-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f2f5;
            color: var(--text-color);
        }

        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            padding: 2rem 0;
            color: white;
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px;
            box-shadow: var(--card-shadow);
        }

        .welcome-message {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .dashboard-card {
            background-color: white;
            border-radius: 15px;
            padding: 1.5rem;
            height: 100%;
            box-shadow: var(--card-shadow);
            border: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .card-header-custom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--light-bg);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }

        .card-title-custom {
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 0;
            color: var(--primary-color);
        }

        .card-icon {
            width: 45px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--light-bg);
            color: var(--primary-color);
            border-radius: 12px;
            font-size: 1.5rem;
        }

        .btn-custom {
            padding: 0.6rem 1.2rem;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary-custom {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .btn-primary-custom:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .btn-outline-custom {
            border-color: var(--border-color);
            color: var(--text-color);
        }

        .btn-outline-custom:hover {
            background-color: var(--light-bg);
            color: var(--primary-color);
        }

        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-confirmed {
            background-color: rgba(25, 135, 84, 0.1);
            color: #198754;
        }

        .status-pending {
            background-color: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .status-completed {
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
        }

        .status-cancelled {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .booking-item {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            background-color: var(--light-bg);
            transition: all 0.3s ease;
        }

        .booking-item:hover {
            background-color: #eef2ff;
            transform: translateX(5px);
        }

        .booking-item:last-child {
            margin-bottom: 0;
        }

        .booking-title {
            font-weight: 600;
            margin-bottom: 0.3rem;
        }

        .booking-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.5rem;
        }

        .gallery-item {
            position: relative;
            border-radius: 8px;
            overflow: hidden;
            height: 0;
            padding-top: 100%; /* 1:1 Aspect Ratio */
        }

        .gallery-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .gallery-img:hover {
            transform: scale(1.05);
        }

        .stat-card {
            text-align: center;
            border-radius: 15px;
            padding: 1.2rem;
            background-color: var(--light-bg);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .stat-card:hover .stat-icon {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: white;
            color: var(--primary-color);
            border-radius: 50%;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
            transition: all 0.3s ease;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.2rem;
        }

        .stat-label {
            font-size: 0.9rem;
            color: inherit;
            opacity: 0.8;
        }

        .calendar-card {
            min-height: 400px;
        }

        #calendar {
            height: 100%;
        }

        .fc-theme-standard .fc-scrollgrid {
            border: none;
        }

        .fc .fc-toolbar-title {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .fc .fc-button-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .fc .fc-button-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }

        .fc .fc-button-primary:not(:disabled).fc-button-active,
        .fc .fc-button-primary:not(:disabled):active {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .fc-event {
            cursor: pointer;
            border-radius: 5px;
        }

        .photographer-preview {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.75rem;
            border-radius: 10px;
            background-color: var(--light-bg);
            transition: all 0.3s ease;
        }

        .photographer-preview:hover {
            background-color: #eef2ff;
            transform: translateX(5px);
        }

        .photographer-preview:last-child {
            margin-bottom: 0;
        }

        .photographer-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
            border: 3px solid white;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .photographer-info {
            flex: 1;
        }

        .photographer-name {
            font-weight: 600;
            margin-bottom: 0.2rem;
        }

        .photographer-specialties {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .rating {
            display: flex;
            align-items: center;
        }

        .rating-value {
            font-weight: 600;
            margin-right: 0.3rem;
        }

        .rating-stars {
            color: #ffc107;
        }

        @media (max-width: 992px) {
            .gallery-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .dashboard-card {
                padding: 1rem;
            }

            .card-title-custom {
                font-size: 1.1rem;
            }

            .gallery-grid {
                grid-template-columns: repeat(1, 1fr);
            }
        }

        /* Animation classes */
        .fade-in {
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container-fluid fade-in mb-5">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1 class="welcome-message">Welcome, ${sessionScope.user.fullName}!</h1>
                        <p class="mb-0 lead">Here's what's happening with your photography events.</p>
                    </div>
                    <div class="col-md-4 text-md-end mt-3 mt-md-0">
                        <c:choose>
                            <c:when test="${sessionScope.userType == 'client'}">
                                <a href="${pageContext.request.contextPath}/booking/booking_form.jsp" class="btn btn-light btn-custom">
                                    <i class="bi bi-plus-circle me-2"></i>Book a Photographer
                                </a>
                            </c:when>
                            <c:when test="${sessionScope.userType == 'photographer'}">
                                <a href="${pageContext.request.contextPath}/photographer/availability_calendar.jsp" class="btn btn-light btn-custom">
                                    <i class="bi bi-calendar-plus me-2"></i>Manage Availability
                                </a>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- Include Messages -->
            <jsp:include page="/includes/messages.jsp" />

            <!-- Client Dashboard -->
            <c:if test="${sessionScope.userType == 'client'}">
                <!-- Stats Row -->
                <div class="row mb-4">
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                            <div class="stat-value">5</div>
                            <div class="stat-label">Total Bookings</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-camera"></i>
                            </div>
                            <div class="stat-value">3</div>
                            <div class="stat-label">Completed Sessions</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-images"></i>
                            </div>
                            <div class="stat-value">243</div>
                            <div class="stat-label">Photos Received</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-heart"></i>
                            </div>
                            <div class="stat-value">7</div>
                            <div class="stat-label">Saved Photographers</div>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <!-- Upcoming Bookings -->
                    <div class="col-xl-6 mb-4">
                        <div class="dashboard-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-calendar-event me-2"></i>Upcoming Bookings
                                </h5>
                                <a href="${pageContext.request.contextPath}/booking/booking_list.jsp" class="btn btn-sm btn-outline-custom">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <!-- Booking 1 -->
                                <div class="booking-item">
                                    <div class="booking-info">
                                        <span class="status-badge status-confirmed">Confirmed</span>
                                        <span><i class="bi bi-calendar3 me-1"></i>Dec 15, 2023</span>
                                    </div>
                                    <h6 class="booking-title">Wedding Photography - Park Plaza Hotel</h6>
                                    <div class="booking-info">
                                        <span><i class="bi bi-person me-1"></i>John's Photography</span>
                                        <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b001" class="text-primary">View Details</a>
                                    </div>
                                </div>
                                <!-- Booking 2 -->
                                <div class="booking-item">
                                    <div class="booking-info">
                                        <span class="status-badge status-pending">Pending</span>
                                        <span><i class="bi bi-calendar3 me-1"></i>Jan 10, 2024</span>
                                    </div>
                                    <h6 class="booking-title">Family Reunion - Beachside Resort</h6>
                                    <div class="booking-info">
                                        <span><i class="bi bi-person me-1"></i>NatureShots</span>
                                        <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b003" class="text-primary">View Details</a>
                                    </div>
                                </div>
                                <!-- Empty State (hidden when there are bookings) -->
                                <div class="text-center p-4" style="display: none;">
                                    <img src="${pageContext.request.contextPath}/assets/images/empty-calendar.svg" alt="No Bookings" class="mb-3" width="80">
                                    <h6>No Upcoming Bookings</h6>
                                    <p class="text-muted small">Book a photographer to capture your special moments.</p>
                                    <a href="${pageContext.request.contextPath}/booking/booking_form.jsp" class="btn btn-primary-custom btn-sm">Book Now</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Galleries -->
                    <div class="col-xl-6 mb-4">
                        <div class="dashboard-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-images me-2"></i>Recent Galleries
                                </h5>
                                <a href="${pageContext.request.contextPath}/gallery/gallery_list.jsp?userOnly=true" class="btn btn-sm btn-outline-custom">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <!-- Gallery Preview -->
                                <div class="mb-3">
                                    <h6 class="mb-2">Johnson Corporate Event - Nov 5, 2023</h6>
                                    <div class="gallery-grid">
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g002&photoId=ph001" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Corporate Event" class="gallery-img">
                                        </a>
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g002&photoId=ph002" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1674&q=80" alt="Corporate Event" class="gallery-img">
                                        </a>
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g002&photoId=ph003" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1576267423445-b2e0074d68a4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Corporate Event" class="gallery-img">
                                        </a>
                                    </div>
                                    <div class="mt-2 text-end">
                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g002" class="btn btn-sm btn-outline-custom">View Gallery</a>
                                    </div>
                                </div>
                                <!-- Empty State (hidden when there are galleries) -->
                                <div class="text-center p-4" style="display: none;">
                                    <img src="${pageContext.request.contextPath}/assets/images/empty-gallery.svg" alt="No Galleries" class="mb-3" width="80">
                                    <h6>No Galleries Yet</h6>
                                    <p class="text-muted small">Your photo galleries will appear here after your events.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recommended Photographers -->
                    <div class="col-lg-6 mb-4">
                        <div class="dashboard-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-camera me-2"></i>Recommended Photographers
                                </h5>
                                <a href="${pageContext.request.contextPath}/photographer/photographer_list.jsp" class="btn btn-sm btn-outline-custom">Browse All</a>
                            </div>
                            <div class="card-body p-0">
                                <!-- Photographer 1 -->
                                <div class="photographer-preview">
                                    <img src="https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1528&q=80" alt="John's Photography" class="photographer-avatar">
                                    <div class="photographer-info">
                                        <h6 class="photographer-name">John's Photography</h6>
                                        <div class="photographer-specialties">Wedding | Portrait | Event</div>
                                        <div class="d-flex justify-content-between align-items-center mt-1">
                                            <div class="rating">
                                                <span class="rating-value">4.8</span>
                                                <span class="rating-stars">★★★★★</span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/photographer/photographer_details.jsp?id=p456" class="btn btn-sm btn-outline-custom">View Profile</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Photographer 2 -->
                                <div class="photographer-preview">
                                    <img src="https://images.unsplash.com/photo-1521038199265-bc482db0f923?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80" alt="NatureShots" class="photographer-avatar">
                                    <div class="photographer-info">
                                        <h6 class="photographer-name">NatureShots</h6>
                                        <div class="photographer-specialties">Landscape | Wildlife | Family</div>
                                        <div class="d-flex justify-content-between align-items-center mt-1">
                                            <div class="rating">
                                                <span class="rating-value">4.6</span>
                                                <span class="rating-stars">★★★★★</span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/photographer/photographer_details.jsp?id=p222" class="btn btn-sm btn-outline-custom">View Profile</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Calendar View -->
                    <div class="col-lg-6 mb-4">
                        <div class="dashboard-card calendar-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-calendar3 me-2"></i>Event Calendar
                                </h5>
                            </div>
                            <div class="card-body p-0">
                                <div id="calendar"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Photographer Dashboard -->
            <c:if test="${sessionScope.userType == 'photographer'}">
                <!-- Stats Row -->
                <div class="row mb-4">
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                            <div class="stat-value">24</div>
                            <div class="stat-label">Total Bookings</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-star"></i>
                            </div>
                            <div class="stat-value">4.9</div>
                            <div class="stat-label">Average Rating</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-images"></i>
                            </div>
                            <div class="stat-value">8</div>
                            <div class="stat-label">Active Galleries</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-4 mb-md-0">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-cash-coin"></i>
                            </div>
                            <div class="stat-value">$8.5K</div>
                            <div class="stat-label">Total Earnings</div>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <!-- Upcoming Assignments -->
                    <div class="col-xl-6 mb-4">
                        <div class="dashboard-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-calendar-event me-2"></i>Upcoming Assignments
                                </h5>
                                <a href="${pageContext.request.contextPath}/booking/booking_list.jsp" class="btn btn-sm btn-outline-custom">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <!-- Assignment 1 -->
                                <div class="booking-item">
                                    <div class="booking-info">
                                        <span class="status-badge status-confirmed">Confirmed</span>
                                        <span><i class="bi bi-calendar3 me-1"></i>Dec 15, 2023</span>
                                    </div>
                                    <h6 class="booking-title">Smith Wedding - Park Plaza Hotel</h6>
                                    <div class="booking-info">
                                        <span><i class="bi bi-person me-1"></i>Client: James Smith</span>
                                        <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b001" class="text-primary">View Details</a>
                                    </div>
                                </div>
                                <!-- Assignment 2 -->
                                <div class="booking-item">
                                    <div class="booking-info">
                                        <span class="status-badge status-pending">Pending</span>
                                        <span><i class="bi bi-calendar3 me-1"></i>Jan 20, 2024</span>
                                    </div>
                                    <h6 class="booking-title">Corporate Headshots - Tech Solutions Inc.</h6>
                                    <div class="booking-info">
                                        <span><i class="bi bi-person me-1"></i>Client: Sarah Johnson</span>
                                        <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b004" class="text-primary">View Details</a>
                                    </div>
                                </div>
                                <!-- Assignment 3 -->
                                <div class="booking-item">
                                    <div class="booking-info">
                                        <span class="status-badge status-confirmed">Confirmed</span>
                                        <span><i class="bi bi-calendar3 me-1"></i>Feb 5, 2024</span>
                                    </div>
<h6 class="booking-title">Product Photoshoot - Fashion Brand Inc.</h6>
                                    <div class="booking-info">
                                        <span><i class="bi bi-person me-1"></i>Client: Michael Chen</span>
                                        <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b005" class="text-primary">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Galleries -->
                    <div class="col-xl-6 mb-4">
                        <div class="dashboard-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-images me-2"></i>Recent Galleries
                                </h5>
                                <a href="${pageContext.request.contextPath}/gallery/gallery_list.jsp?userOnly=true" class="btn btn-sm btn-outline-custom">Manage Galleries</a>
                            </div>
                            <div class="card-body p-0">
                                <!-- Gallery Preview -->
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Johnson Corporate Event</h6>
                                        <span class="badge bg-success">Published</span>
                                    </div>
                                    <div class="gallery-grid">
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g002&photoId=ph001" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Corporate Event" class="gallery-img">
                                        </a>
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g002&photoId=ph002" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1674&q=80" alt="Corporate Event" class="gallery-img">
                                        </a>
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g002&photoId=ph003" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1576267423445-b2e0074d68a4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Corporate Event" class="gallery-img">
                                        </a>
                                    </div>
                                    <div class="mt-2 d-flex justify-content-between align-items-center">
                                        <span class="small text-muted">94 photos • Nov 5, 2023</span>
                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g002" class="btn btn-sm btn-outline-custom">Manage Gallery</a>
                                    </div>
                                </div>

                                <!-- Gallery Preview 2 -->
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Nature Portfolio</h6>
                                        <span class="badge bg-success">Published</span>
                                    </div>
                                    <div class="gallery-grid">
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g003&photoId=ph001" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1470770841072-f978cf4d019e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Nature" class="gallery-img">
                                        </a>
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g003&photoId=ph002" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1472214103451-9374bd1c798e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Nature" class="gallery-img">
                                        </a>
                                        <a href="${pageContext.request.contextPath}/gallery/photo_viewer.jsp?galleryId=g003&photoId=ph003" class="gallery-item">
                                            <img src="https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Nature" class="gallery-img">
                                        </a>
                                    </div>
                                    <div class="mt-2 d-flex justify-content-between align-items-center">
                                        <span class="small text-muted">52 photos • Sep 15, 2023</span>
                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g003" class="btn btn-sm btn-outline-custom">Manage Gallery</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Calendar View -->
                    <div class="col-lg-8 mb-4">
                        <div class="dashboard-card calendar-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-calendar3 me-2"></i>Bookings Calendar
                                </h5>
                                <a href="${pageContext.request.contextPath}/photographer/availability_calendar.jsp" class="btn btn-sm btn-outline-custom">
                                    <i class="bi bi-pencil me-1"></i>Manage Availability
                                </a>
                            </div>
                            <div class="card-body p-0">
                                <div id="calendar"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Latest Reviews -->
                    <div class="col-lg-4 mb-4">
                        <div class="dashboard-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-star me-2"></i>Latest Reviews
                                </h5>
                                <a href="${pageContext.request.contextPath}/review/view_reviews.jsp?photographerId=${sessionScope.user.userId}" class="btn btn-sm btn-outline-custom">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <!-- Review 1 -->
                                <div class="p-3 border-bottom">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">James Smith</h6>
                                        <div class="rating-stars">★★★★★</div>
                                    </div>
                                    <p class="small mb-1">"John was amazing at our wedding! He captured all the special moments and made everyone feel comfortable. The photos are stunning!"</p>
                                    <div class="small text-muted">Dec 20, 2023</div>
                                </div>
                                <!-- Review 2 -->
                                <div class="p-3 border-bottom">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Sarah Johnson</h6>
                                        <div class="rating-stars">★★★★★</div>
                                    </div>
                                    <p class="small mb-1">"Very professional and delivered high-quality corporate headshots for our entire team. Will definitely book again!"</p>
                                    <div class="small text-muted">Nov 8, 2023</div>
                                </div>
                                <!-- Review 3 -->
                                <div class="p-3">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Michael Chen</h6>
                                        <div class="rating-stars">★★★★<span class="text-muted">★</span></div>
                                    </div>
                                    <p class="small mb-1">"Great product photography for our new clothing line. Turnaround time was slightly longer than expected, but the quality made up for it."</p>
                                    <div class="small text-muted">Oct 15, 2023</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Services and Packages -->
                    <div class="col-12 mb-4">
                        <div class="dashboard-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-camera me-2"></i>Your Services & Packages
                                </h5>
                                <a href="${pageContext.request.contextPath}/photographer/service_management.jsp" class="btn btn-sm btn-primary-custom">
                                    <i class="bi bi-plus me-1"></i>Add New Service
                                </a>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Package Name</th>
                                                <th>Category</th>
                                                <th>Duration</th>
                                                <th>Price</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Silver Wedding Package</td>
                                                <td>WEDDING</td>
                                                <td>6 hours</td>
                                                <td>$1,200</td>
                                                <td><span class="badge bg-success">Active</span></td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/photographer/service_management.jsp?id=s001&action=edit" class="btn btn-sm btn-outline-custom me-1">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Gold Wedding Package</td>
                                                <td>WEDDING</td>
                                                <td>10 hours</td>
                                                <td>$2,000</td>
                                                <td><span class="badge bg-success">Active</span></td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/photographer/service_management.jsp?id=s002&action=edit" class="btn btn-sm btn-outline-custom me-1">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Corporate Headshots</td>
                                                <td>CORPORATE</td>
                                                <td>4 hours</td>
                                                <td>$800</td>
                                                <td><span class="badge bg-success">Active</span></td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/photographer/service_management.jsp?id=s004&action=edit" class="btn btn-sm btn-outline-custom me-1">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <button class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize FullCalendar
            const calendarEl = document.getElementById('calendar');
            if (calendarEl) {
                const calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek'
                    },
                    height: 'auto',
                    events: [
                        <c:if test="${sessionScope.userType == 'client'}">
                        {
                            title: 'Wedding Photography',
                            start: '2023-12-15',
                            end: '2023-12-16',
                            backgroundColor: '#4361ee',
                            borderColor: '#4361ee',
                            url: '${pageContext.request.contextPath}/booking/booking_details.jsp?id=b001'
                        },
                        {
                            title: 'Family Reunion',
                            start: '2024-01-10',
                            backgroundColor: '#ffc107',
                            borderColor: '#ffc107',
                            url: '${pageContext.request.contextPath}/booking/booking_details.jsp?id=b003'
                        }
                        </c:if>
                        <c:if test="${sessionScope.userType == 'photographer'}">
                        {
                            title: 'Smith Wedding',
                            start: '2023-12-15',
                            end: '2023-12-16',
                            backgroundColor: '#4361ee',
                            borderColor: '#4361ee',
                            url: '${pageContext.request.contextPath}/booking/booking_details.jsp?id=b001'
                        },
                        {
                            title: 'Corporate Headshots',
                            start: '2024-01-20',
                            backgroundColor: '#ffc107',
                            borderColor: '#ffc107',
                            url: '${pageContext.request.contextPath}/booking/booking_details.jsp?id=b004'
                        },
                        {
                            title: 'Product Photoshoot',
                            start: '2024-02-05',
                            backgroundColor: '#4361ee',
                            borderColor: '#4361ee',
                            url: '${pageContext.request.contextPath}/booking/booking_details.jsp?id=b005'
                        },
                        // Unavailable days
                        {
                            title: 'Unavailable',
                            start: '2023-12-24',
                            end: '2023-12-26',
                            backgroundColor: '#dc3545',
                            borderColor: '#dc3545',
                            display: 'background'
                        }
                        </c:if>
                    ],
                    eventClick: function(info) {
                        if (info.event.url) {
                            info.jsEvent.preventDefault();
                            window.location.href = info.event.url;
                        }
                    }
                });
                calendar.render();
            }
        });
    </script>
</body>
</html>