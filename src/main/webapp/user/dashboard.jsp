<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user-management.css">

    <style>
        .dashboard-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .quick-action-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="/includes/sidebar.jsp" />

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-4">
                <!-- Page Title -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h2">Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <c:choose>
                                <c:when test="${sessionScope.userType == 'client'}">
                                    <a href="${pageContext.request.contextPath}/booking/booking_form.jsp"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-plus"></i> Book Photographer
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.userType == 'photographer'}">
                                    <a href="${pageContext.request.contextPath}/booking/availability_calendar.jsp"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-calendar-check"></i> Manage Availability
                                    </a>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Include Messages -->
                <jsp:include page="/includes/messages.jsp" />

                <!-- Client Dashboard -->
                <c:if test="${sessionScope.userType == 'client'}">
                    <div class="row">
                        <!-- Quick Actions -->
                        <div class="col-md-4 mb-4">
                            <div class="dashboard-section quick-action-card">
                                <h5 class="mb-3">
                                    <i class="bi bi-calendar-check me-2"></i>My Bookings
                                </h5>
                                <p>Upcoming and past event bookings</p>
                                <a href="${pageContext.request.contextPath}/booking/booking_list.jsp"
                                   class="btn btn-primary btn-sm">View Bookings</a>
                            </div>
                        </div>

                        <!-- Favorite Photographers -->
                        <div class="col-md-4 mb-4">
                            <div class="dashboard-section quick-action-card">
                                <h5 class="mb-3">
                                    <i class="bi bi-heart me-2"></i>Favorite Photographers
                                </h5>
                                <p>Manage your saved photographers</p>
                                <a href="${pageContext.request.contextPath}/user/favorites.jsp"
                                   class="btn btn-primary btn-sm">View Favorites</a>
                            </div>
                        </div>

                        <!-- Galleries -->
                        <div class="col-md-4 mb-4">
                            <div class="dashboard-section quick-action-card">
                                <h5 class="mb-3">
                                    <i class="bi bi-images me-2"></i>My Galleries
                                </h5>
                                <p>View and manage your event photos</p>
                                <a href="${pageContext.request.contextPath}/gallery/gallery_list.jsp?userOnly=true"
                                   class="btn btn-primary btn-sm">Browse Galleries</a>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Photographer Dashboard -->
                <c:if test="${sessionScope.userType == 'photographer'}">
                    <div class="row">
                        <!-- Upcoming Assignments -->
                        <div class="col-md-4 mb-4">
                            <div class="dashboard-section quick-action-card">
                                <h5 class="mb-3">
                                    <i class="bi bi-calendar-event me-2"></i>Upcoming Assignments
                                </h5>
                                <p>View and manage your booked events</p>
                                <a href="${pageContext.request.contextPath}/booking/booking_list.jsp"
                                   class="btn btn-primary btn-sm">View Assignments</a>
                            </div>
                        </div>

                        <!-- Portfolio -->
                        <div class="col-md-4 mb-4">
                            <div class="dashboard-section quick-action-card">
                                <h5 class="mb-3">
                                    <i class="bi bi-file-earmark-richtext me-2"></i>My Portfolio
                                </h5>
                                <p>Showcase your best work</p>
                                <a href="${pageContext.request.contextPath}/gallery/upload_form.jsp"
                                   class="btn btn-primary btn-sm">Manage Portfolio</a>
                            </div>
                        </div>

                        <!-- Earnings -->
                        <div class="col-md-4 mb-4">
                            <div class="dashboard-section quick-action-card">
                                <h5 class="mb-3">
                                    <i class="bi bi-cash-coin me-2"></i>Earnings
                                </h5>
                                <p>Track your financial performance</p>
                                <a href="${pageContext.request.contextPath}/payment/earnings.jsp"
                                   class="btn btn-primary btn-sm">View Earnings</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>