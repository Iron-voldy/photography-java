<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Event Photography System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }

        .dashboard-header {
            background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }

        .dashboard-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            margin-bottom: 1.5rem;
            padding: 1.5rem;
        }

        .dashboard-card-header {
            border-bottom: 1px solid #e9ecef;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
        }

        .booking-item {
            border-bottom: 1px solid #e9ecef;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
        }

        .booking-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .status-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <div class="container">
            <h1 class="display-6">Welcome, ${sessionScope.user.fullName}</h1>
            <p class="lead">Manage your photography bookings and services</p>
        </div>
    </div>

    <div class="container">
        <!-- Include Messages -->
        <jsp:include page="/includes/messages.jsp" />

        <div class="row">
            <!-- Left Column -->
            <div class="col-md-8">
                <!-- Upcoming Bookings Card -->
                <div class="dashboard-card">
                    <div class="dashboard-card-header d-flex justify-content-between align-items-center">
                        <h2 class="h5 mb-0">Your Upcoming Bookings</h2>
                        <a href="${pageContext.request.contextPath}/booking/booking_list.jsp" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>

                    <c:choose>
                        <c:when test="${not empty upcomingBookings}">
                            <c:forEach var="booking" items="${upcomingBookings}">
                                <div class="booking-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-8">
                                            <h6 class="mb-1">${booking.eventType}</h6>
                                            <p class="text-muted mb-1">
                                                <i class="bi bi-calendar3 me-2"></i>
                                                ${booking.eventDateTime.format(java.time.format.DateTimeFormatter.ofPattern("MMMM d, yyyy 'at' h:mm a"))}
                                            </p>
                                            <p class="text-muted mb-1">
                                                <i class="bi bi-geo-alt me-2"></i>${booking.eventLocation}
                                            </p>
                                        </div>
                                        <div class="col-md-4 text-md-end">
                                            <span class="badge bg-${booking.status == 'CONFIRMED' ? 'success' : booking.status == 'PENDING' ? 'warning' : 'secondary'} status-badge">
                                                ${booking.status}
                                            </span>
                                            <div class="mt-2">
                                                <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=${booking.bookingId}" class="btn btn-sm btn-primary">View Details</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                You have no upcoming bookings. <a href="${pageContext.request.contextPath}/photographer/list.jsp">Browse photographers</a> to book your next event!
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Recent Activity Card -->
                <div class="dashboard-card">
                    <div class="dashboard-card-header">
                        <h2 class="h5 mb-0">Recent Activity</h2>
                    </div>

                    <c:choose>
                        <c:when test="${not empty recentActivity}">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="activity" items="${recentActivity}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent px-0">
                                        <div>
                                            <h6 class="mb-1">${activity.description}</h6>
                                            <small class="text-muted">
                                                <c:if test="${not empty activity.date}">
                                                    ${activity.date.format(java.time.format.DateTimeFormatter.ofPattern("MMMM d, yyyy"))}
                                                </c:if>
                                            </small>
                                        </div>
                                        <span class="badge bg-${activity.type == 'BOOKING' ? 'primary' : activity.type == 'PAYMENT' ? 'success' : 'info'} rounded-pill">
                                            ${activity.type}
                                        </span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                No recent activity to display.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-md-4">
                <!-- User Profile Card -->
                <div class="dashboard-card text-center">
                    <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png" alt="Profile" class="rounded-circle mb-3" width="100">
                    <h3 class="h5">${sessionScope.user.fullName}</h3>
                    <p class="text-muted mb-3">${sessionScope.user.email}</p>
                    <a href="${pageContext.request.contextPath}/user/profile.jsp" class="btn btn-sm btn-outline-primary">Edit Profile</a>
                </div>

                <!-- Quick Actions Card -->
                <div class="dashboard-card">
                    <div class="dashboard-card-header">
                        <h2 class="h5 mb-0">Quick Actions</h2>
                    </div>

                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/photographer/list.jsp" class="btn btn-primary">
                            <i class="bi bi-camera me-2"></i>Find Photographers
                        </a>
                        <a href="${pageContext.request.contextPath}/gallery/gallery_list.jsp" class="btn btn-outline-primary">
                            <i class="bi bi-images me-2"></i>Browse Galleries
                        </a>
                        <c:if test="${sessionScope.user.userType == 'PHOTOGRAPHER'}">
                            <a href="${pageContext.request.contextPath}/gallery/upload_photos.jsp" class="btn btn-outline-primary">
                                <i class="bi bi-cloud-upload me-2"></i>Upload Photos
                            </a>
                            <a href="${pageContext.request.contextPath}/photographer/service_management.jsp" class="btn btn-outline-primary">
                                <i class="bi bi-gear me-2"></i>Manage Services
                            </a>
                        </c:if>
                    </div>
                </div>

                <!-- Notifications Card -->
                <div class="dashboard-card">
                    <div class="dashboard-card-header d-flex justify-content-between align-items-center">
                        <h2 class="h5 mb-0">Notifications</h2>
                        <span class="badge bg-primary rounded-pill">${notifications.size()}</span>
                    </div>

                    <c:choose>
                        <c:when test="${not empty notifications}">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="notification" items="${notifications}">
                                    <li class="list-group-item d-flex justify-content-between align-items-start bg-transparent px-0">
                                        <div class="ms-2 me-auto">
                                            <div class="fw-bold">${notification.title}</div>
                                            ${notification.message}
                                        </div>
                                        <small class="text-muted">
                                            <c:if test="${not empty notification.time}">
                                                ${notification.time.format(java.time.format.DateTimeFormatter.ofPattern("h:mm a"))}
                                            </c:if>
                                        </small>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                No new notifications.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>