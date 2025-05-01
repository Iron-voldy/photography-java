<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - SnapEvent</title>

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
        .confirmation-card {
            max-width: 600px;
            margin: 50px auto;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .confirmation-icon {
            font-size: 5rem;
            color: #28a745;
        }
        .booking-details {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container">
        <div class="card confirmation-card">
            <div class="card-body text-center">
                <i class="bi bi-check-circle confirmation-icon mb-4"></i>
                <h2 class="card-title mb-4">Booking Confirmed!</h2>

                <div class="booking-details mb-4">
                    <c:choose>
                        <c:when test="${not empty booking}">
                            <h4 class="mb-3">${booking.eventType} Photography</h4>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <strong>Date:</strong>
                                    <fmt:parseDate value="${booking.eventDateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" />
                                    <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy 'at' h:mm a" />
                                </div>
                                <div class="col-md-6 mb-2">
                                    <strong>Location:</strong> ${booking.eventLocation}
                                </div>
                                <div class="col-md-6 mb-2">
                                    <strong>Photographer:</strong> ${photographer.fullName}
                                </div>
                                <div class="col-md-6 mb-2">
                                    <strong>Total Cost:</strong> $${booking.totalPrice}
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">Booking details not available</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="d-flex justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/booking/details?id=${booking.bookingId}"
                       class="btn btn-primary">
                        View Booking Details
                    </a>
                    <a href="${pageContext.request.contextPath}/user/dashboard.jsp"
                       class="btn btn-outline-secondary">
                        Go to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Email Confirmation Script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Optional: Send email confirmation via AJAX
            function sendEmailConfirmation() {
                fetch('${pageContext.request.contextPath}/booking/send-confirmation', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        bookingId: '${booking.bookingId}',
                        email: '${sessionScope.user.email}'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        console.log('Confirmation email sent');
                    }
                })
                .catch(error => {
                    console.error('Error sending confirmation:', error);
                });
            }

            // Uncomment to enable email confirmation
            // sendEmailConfirmation();
        });
    </script>
</body>
</html>