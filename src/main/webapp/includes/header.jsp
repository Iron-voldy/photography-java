<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Navigation -->
<header class="header">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="SnapEvent" width="40" height="40" class="d-inline-block align-text-top me-2">
                SnapEvent
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/photographer/photographer_list.jsp">Photographers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/gallery/gallery_list.jsp">Galleries</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/booking/booking_form.jsp">Book Now</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                    </li>
                </ul>

                <!-- User Auth Menu -->
                <ul class="navbar-nav ms-auto">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <!-- User is logged in -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle me-1"></i>${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard.jsp">Dashboard</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile.jsp">My Profile</a></li>

                                    <c:if test="${sessionScope.userType == 'client'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/booking/booking_list.jsp">My Bookings</a></li>
                                    </c:if>

                                    <c:if test="${sessionScope.userType == 'photographer'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/booking/booking_list.jsp">My Assignments</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/gallery/upload_form.jsp">Upload Photos</a></li>
                                    </c:if>

                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- User is not logged in -->
                            <li class="nav-item">
                                  <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
                            </li>
                            <li class="nav-item">
                                  <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
</header>

<!-- Add spacing below the fixed header -->
<div class="header-space" style="margin-top: 76px;"></div>