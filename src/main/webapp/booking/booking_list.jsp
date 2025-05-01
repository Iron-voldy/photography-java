<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - SnapEvent</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f4f6f9;
        }
        .booking-card {
            transition: transform 0.3s ease;
        }
        .booking-card:hover {
            transform: translateY(-5px);
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.3rem 0.6rem;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-5">
        <h1 class="mb-4">
            <c:choose>
                <c:when test="${sessionScope.userType == 'client'}">My Bookings</c:when>
                <c:when test="${sessionScope.userType == 'photographer'}">My Assignments</c:when>
                <c:otherwise>All Bookings</c:otherwise>
            </c:choose>
        </h1>

        <!-- Include Messages -->
        <jsp:include page="/includes/messages.jsp" />

        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="row">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="col-md-4 mb-4">
                            <div class="card booking-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="card-title mb-0">
                                            <c:choose>
                                                <c:when test="${sessionScope.userType == 'client'}">
                                                    ${booking.eventType} Photography
                                                </c:when>
                                                <c:otherwise>
                                                    Booking for ${booking.eventType}
                                                </c:otherwise>
                                            </c:choose>
                                        </h5>
                                        <span class="badge
                                            ${booking.status == 'PENDING' ? 'bg-warning' :
                                              (booking.status == 'CONFIRMED' ? 'bg-success' :
                                              (booking.status == 'COMPLETED' ? 'bg-primary' : 'bg-danger'))}">
                                            ${booking.status}
                                        </span>
                                    </div>
                                    <p class="card-text">
                                        <strong>Date:</strong>
                                        <fmt:parseDate value="${booking.eventDateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" />
                                        <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy 'at' h:mm a" />
                                    </p>
                                    <p class="card-text">
                                        <strong>Location:</strong> ${booking.eventLocation}
                                    </p>
                                    <a href="${pageContext.request.contextPath}/booking/details?id=${booking.bookingId}"
                                       class="btn btn-primary btn-sm">
                                        View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info text-center">
                    <p class="mb-0">
                        <c:choose>
                            <c:when test="${sessionScope.userType == 'client'}">
                                You have no bookings yet. <a href="${pageContext.request.contextPath}/booking/booking_form.jsp">Book a photographer</a>
                            </c:when>
                            <c:when test="${sessionScope.userType == 'photographer'}">
                                You have no upcoming assignments.
                            </c:when>
                            <c:otherwise>
                                No bookings found.
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>