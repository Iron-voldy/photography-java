<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar bg-light border-end">
    <div class="position-sticky pt-3">
        <!-- User Profile Summary -->
        <div class="text-center p-3 mb-3 border-bottom">
            <div class="avatar-circle mb-3">
                <img src="${pageContext.request.contextPath}/assets/images/default-avatar.jpg" alt="Profile" class="rounded-circle img-fluid" style="width: 80px; height: 80px; object-fit: cover;">
            </div>
            <h6 class="mb-1">${sessionScope.user.fullName}</h6>
            <p class="text-muted small mb-2">@${sessionScope.user.username}</p>

            <c:choose>
                <c:when test="${sessionScope.userType == 'client'}">
                    <span class="badge bg-primary">Client</span>
                </c:when>
                <c:when test="${sessionScope.userType == 'photographer'}">
                    <span class="badge bg-success">Photographer</span>
                </c:when>
                <c:when test="${sessionScope.userType == 'admin'}">
                    <span class="badge bg-danger">Administrator</span>
                </c:when>
            </c:choose>
        </div>

        <!-- Navigation Items -->
        <ul class="nav flex-column">
            <!-- Common Navigation Items -->
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard.jsp">
                    <i class="bi bi-speedometer2 me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/profile.jsp">
                    <i class="bi bi-person me-2"></i> My Profile
                </a>
            </li>

            <!-- Client-specific Navigation Items -->
            <c:if test="${sessionScope.userType == 'client'}">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/booking/booking_list.jsp">
                        <i class="bi bi-calendar-check me-2"></i> My Bookings
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/booking/booking_form.jsp">
                        <i class="bi bi-plus-circle me-2"></i> Book Photographer
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/gallery/gallery_list.jsp?userOnly=true">
                        <i class="bi bi-images me-2"></i> My Galleries
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/payment/transaction_history.jsp">
                        <i class="bi bi-credit-card me-2"></i> Payment History
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/favorites.jsp">
                        <i class="bi bi-heart me-2"></i> Favorite Photographers
                    </a>
                </li>
            </c:if>

            <!-- Photographer-specific Navigation Items -->
            <c:if test="${sessionScope.userType == 'photographer'}">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/booking/booking_list.jsp">
                        <i class="bi bi-calendar-check me-2"></i> My Assignments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/photographer/availability_calendar.jsp">
                        <i class="bi bi-calendar me-2"></i> Manage Availability
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/gallery/upload_form.jsp">
                        <i class="bi bi-cloud-upload me-2"></i> Upload Photos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/gallery/gallery_list.jsp?userOnly=true">
                        <i class="bi bi-images me-2"></i> My Galleries
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/payment/earnings.jsp">
                        <i class="bi bi-cash-coin me-2"></i> My Earnings
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/review/view_reviews.jsp?photographerId=${sessionScope.user.userId}">
                        <i class="bi bi-star me-2"></i> My Reviews
                    </a>
                </li>
            </c:if>

            <!-- Admin-specific Navigation Items -->
            <c:if test="${sessionScope.userType == 'admin'}">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user_management.jsp">
                        <i class="bi bi-people me-2"></i> User Management
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/booking_management.jsp">
                        <i class="bi bi-calendar-check me-2"></i> Booking Management
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/review_moderation.jsp">
                        <i class="bi bi-star me-2"></i> Review Moderation
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/payment_reports.jsp">
                        <i class="bi bi-graph-up me-2"></i> Payment Reports
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/site_settings.jsp">
                        <i class="bi bi-gear me-2"></i> Site Settings
                    </a>
                </li>
            </c:if>

            <!-- Settings and Logout -->
            <li><hr class="dropdown-divider"></li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/settings.jsp">
                    <i class="bi bi-gear me-2"></i> Settings
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                </a>
            </li>
        </ul>

        <!-- Help & Support Section -->
        <div class="p-3 mt-4 bg-light rounded border">
            <h6 class="sidebar-heading d-flex justify-content-between align-items-center text-muted">
                <span>Help & Support</span>
            </h6>
            <ul class="nav flex-column small">
                <li class="nav-item">
                    <a class="nav-link text-muted" href="${pageContext.request.contextPath}/help/faq.jsp">
                        <i class="bi bi-question-circle me-2"></i> FAQ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-muted" href="${pageContext.request.contextPath}/help/contact-support.jsp">
                        <i class="bi bi-headset me-2"></i> Contact Support
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>