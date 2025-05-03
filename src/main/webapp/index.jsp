<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SnapEvent - Professional Photography Services</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <!-- Hero Section -->
    <section class="bg-primary text-white p-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold">Find Your Perfect Photographer</h1>
                    <p class="lead mb-4">Professional photography services for every occasion</p>
                    <div class="d-grid gap-3 d-sm-flex">
                        <a href="${pageContext.request.contextPath}/photographer/photographer_list.jsp" class="btn btn-light btn-lg">Find Photographers</a>
                        <a href="${pageContext.request.contextPath}/user/register.jsp" class="btn btn-outline-light btn-lg">Get Started</a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <img src="https://images.unsplash.com/photo-1452587925148-ce544e77e70d" alt="Photography" class="img-fluid rounded">
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Our Photography Services</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-camera-reels fs-1 text-primary mb-3"></i>
                            <h3 class="card-title">Wedding Photography</h3>
                            <p class="card-text">Capture your special day with professional wedding photographers</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-people fs-1 text-primary mb-3"></i>
                            <h3 class="card-title">Portrait Photography</h3>
                            <p class="card-text">Professional portraits for individuals, couples, and families</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-calendar-event fs-1 text-primary mb-3"></i>
                            <h3 class="card-title">Event Photography</h3>
                            <p class="card-text">Document your corporate events, parties, and special occasions</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">How It Works</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="text-center">
                        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 60px; height: 60px;">
                            <span class="fs-4">1</span>
                        </div>
                        <h4>Find Your Photographer</h4>
                        <p>Browse through our selection of professional photographers</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 60px; height: 60px;">
                            <span class="fs-4">2</span>
                        </div>
                        <h4>Book Your Session</h4>
                        <p>Choose the perfect package and schedule your photo session</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 60px; height: 60px;">
                            <span class="fs-4">3</span>
                        </div>
                        <h4>Get Your Photos</h4>
                        <p>Receive your professionally edited photos and memories</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5 bg-primary text-white">
        <div class="container text-center">
            <h2 class="mb-4">Ready to Book Your Photography Session?</h2>
            <p class="lead mb-4">Join thousands of satisfied clients who trust SnapEvent for their photography needs</p>
            <a href="${pageContext.request.contextPath}/photographer/photographer_list.jsp" class="btn btn-light btn-lg">Browse Photographers</a>
        </div>
    </section>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>