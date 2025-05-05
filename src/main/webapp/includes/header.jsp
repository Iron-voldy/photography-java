<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="bi bi-camera me-2"></i>SnapEvent
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/photographer/list">Photographers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/gallery/gallery_list.jsp">Galleries</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                </li>
            </ul>

            <!-- User Menu -->
            <div class="d-flex">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <!-- Not logged in -->
                        <a href="${pageContext.request.contextPath}/user/login.jsp" class="btn btn-outline-light me-2">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Login
                        </a>
                        <a href="${pageContext.request.contextPath}/user/register.jsp" class="btn btn-primary">
                            <i class="bi bi-person-plus me-1"></i>Register
                        </a>
                    </c:when>
                    <c:otherwise>
                        <!-- Logged in -->
                        <div class="dropdown">
                            <button class="btn btn-outline-light dropdown-toggle" type="button"
                                    id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle me-1"></i>${sessionScope.user.fullName}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <c:if test="${sessionScope.userType == 'client'}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard.jsp">
                                            <i class="bi bi-speedometer2 me-2"></i>My Dashboard
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/booking/booking_list.jsp">
                                            <i class="bi bi-calendar-check me-2"></i>My Bookings
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/review/myreviews">
                                            <i class="bi bi-star me-2"></i>My Reviews
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.userType == 'photographer'}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/photographer/dashboard.jsp">
                                            <i class="bi bi-speedometer2 me-2"></i>Photographer Dashboard
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/booking/booking_list.jsp">
                                            <i class="bi bi-calendar-check me-2"></i>My Assignments
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/photographer/service_management.jsp">
                                            <i class="bi bi-camera me-2"></i>My Services
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/gallery/gallery_list.jsp?userOnly=true">
                                            <i class="bi bi-images me-2"></i>My Galleries
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/review/myreviews">
                                            <i class="bi bi-star me-2"></i>My Reviews
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.userType == 'admin'}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                                            <i class="bi bi-speedometer2 me-2"></i>Admin Dashboard
                                        </a>
                                    </li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile.jsp">
                                        <i class="bi bi-person me-2"></i>My Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right me-2"></i>Logout
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>