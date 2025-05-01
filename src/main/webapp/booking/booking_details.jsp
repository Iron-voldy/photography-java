<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - SnapEvent</title>

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
        .booking-details-card {
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .profile-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card booking-details-card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Booking Details</h3>
                    </div>
                    <div class="card-body">
                        <!-- Booking Status -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="badge
                                ${booking.status == 'PENDING' ? 'bg-warning' :
                                  (booking.status == 'CONFIRMED' ? 'bg-success' :
                                  (booking.status == 'COMPLETED' ? 'bg-primary' : 'bg-danger'))}">
                                ${booking.status}
                            </span>

                            <!-- Status Update Options (for photographer or admin) -->
                            <c:if test="${sessionScope.userType == 'photographer' || sessionScope.userType == 'admin'}">
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                            type="button"
                                            id="statusUpdateDropdown"
                                            data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                        Update Status
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="statusUpdateDropdown">
                                        <li><a class="dropdown-item" href="#" onclick="updateStatus('CONFIRMED')">Confirm</a></li>
                                        <li><a class="dropdown-item" href="#" onclick="updateStatus('COMPLETED')">Complete</a></li>
                                        <li><a class="dropdown-item" href="#" onclick="updateStatus('CANCELLED')">Cancel</a></li>
                                    </ul>
                                </div>
                            </c:if>
                        </div>

                        <!-- Event Details -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <h5>Event Details</h5>
                                <p class="mb-1">
                                    <strong>Type:</strong> ${booking.eventType}
                                </p>
                                <p class="mb-1">
                                    <strong>Date:</strong>
                                    <fmt:parseDate value="${booking.eventDateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" />
                                    <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy 'at' h:mm a" />
                                </p>
                                <p class="mb-1">
                                    <strong>Location:</strong> ${booking.eventLocation}
                                </p>
                            </div>

                            <!-- Notes -->
                            <div class="col-md-6">
                                <h5>Additional Notes</h5>
                                <p>${not empty booking.eventNotes ? booking.eventNotes : 'No additional notes'}</p>
                            </div>
                        </div>

                        <!-- Client & Photographer Details -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <h5>Client Details</h5>
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/assets/images/default-avatar.jpg"
                                         alt="Client Avatar" class="profile-img me-3">
                                    <div>
                                        <p class="mb-1"><strong>${client.fullName}</strong></p>
                                        <p class="text-muted mb-0">${client.email}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h5>Photographer Details</h5>
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/assets/images/default-avatar.jpg"
                                         alt="Photographer Avatar" class="profile-img me-3">
                                    <div>
                                        <p class="mb-1"><strong>${photographer.fullName}</strong></p>
                                        <p class="text-muted mb-0">${photographer.email}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pricing -->
                        <div class="mt-4 text-end">
                            <h5>Total Cost: $${booking.totalPrice}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function updateStatus(status) {
            if (confirm('Are you sure you want to update the booking status to ' + status + '?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/booking/details';

                const bookingIdInput = document.createElement('input');
                bookingIdInput.type = 'hidden';
                bookingIdInput.name = 'bookingId';
                bookingIdInput.value = '${booking.bookingId}';
                form.appendChild(bookingIdInput);

                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = status;
                form.appendChild(statusInput);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>