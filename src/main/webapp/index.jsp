<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SnapEvent - Professional Photography & Videography</title>

    <!-- Favicon -->
    <link rel="icon" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/icons/camera.svg" type="image/svg+xml">

    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <!-- Custom Dark Theme CSS -->
    <style>
        :root {
            --dark-bg: #121212;
            --dark-card: #1E1E1E;
            --primary-color: #BB86FC;
            --secondary-color: #03DAC6;
        }

        body {
            background-color: var(--dark-bg);
            color: #ffffff;
            font-family: 'Arial', sans-serif;
        }

        .navbar {
            background-color: rgba(30, 30, 30, 0.9) !important;
            backdrop-filter: blur(10px);
        }

        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
                        url('https://images.unsplash.com/photo-1516035069371-29a1b244cc32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1964&q=80');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .dark-card {
            background-color: var(--dark-card);
            border: 1px solid rgba(255,255,255,0.1);
            transition: transform 0.3s ease;
        }

        .dark-card:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(187,134,252,0.2);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--dark-bg);
        }

        .btn-outline-light {
            border-color: var(--secondary-color);
            color: var(--secondary-color);
        }

        .video-gallery .card-img-overlay {
            background: rgba(0,0,0,0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .video-gallery .card:hover .card-img-overlay {
            opacity: 1;
        }
    </style>
</head>
<body>
    <!-- Header Navigation -->
    <jsp:include page="/includes/header.jsp" />

    <!-- Hero Section -->
    <section class="hero-section text-center text-white">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8" data-aos="fade-up">
                    <h1 class="display-3 mb-4">Capture Every Moment</h1>
                    <p class="lead mb-5">Professional Photography and Videography Services</p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="#services" class="btn btn-primary btn-lg">Our Services</a>
                        <a href="#contact" class="btn btn-outline-light btn-lg">Book Now</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5 text-white" data-aos="fade-up">Our Services</h2>
            <div class="row g-4">
                <!-- Photography Services -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="card dark-card h-100">
                        <img src="https://images.unsplash.com/photo-1516035069371-29a1b244cc32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1964&q=80"
                             class="card-img-top" alt="Photography">
                        <div class="card-body">
                            <h5 class="card-title text-white">Photography</h5>
                            <p class="card-text text-muted">Professional photography for weddings, events, portraits, and more.</p>
                        </div>
                    </div>
                </div>

                <!-- Videography Services -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card dark-card h-100">
                        <img src="https://images.unsplash.com/photo-1594904351111-a072f80c1a6d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1935&q=80"
                             class="card-img-top" alt="Videography">
                        <div class="card-body">
                            <h5 class="card-title text-white">Videography</h5>
                            <p class="card-text text-muted">Cinematic video production for weddings, documentaries, and corporate events.</p>
                        </div>
                    </div>
                </div>

                <!-- Drone Videography -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="card dark-card h-100">
                        <img src="https://images.unsplash.com/photo-1530577197743-7adf14294584?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80"
                             class="card-img-top" alt="Drone Videography">
                        <div class="card-body">
                            <h5 class="card-title text-white">Drone Videography</h5>
                            <p class="card-text text-muted">Stunning aerial shots and panoramic views for unique perspectives.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Video Gallery Section -->
    <section class="py-5 video-gallery">
        <div class="container">
            <h2 class="text-center mb-5 text-white" data-aos="fade-up">Video Showcase</h2>
            <div class="row g-4">
                <!-- Video 1 -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="card dark-card position-relative">
                        <img src="https://images.unsplash.com/photo-1460776960861-75de890d1538?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"
                             class="card-img" alt="Wedding Video">
                        <div class="card-img-overlay">
                            <a href="#" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#videoModal1">
                                <i class="bi bi-play-fill"></i> Watch Video
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Video 2 -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card dark-card position-relative">
                        <img src="https://images.unsplash.com/photo-1519120944692-1a8d8cfc107f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1936&q=80"
                             class="card-img" alt="Corporate Event Video">
                        <div class="card-img-overlay">
                            <a href="#" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#videoModal2">
                                <i class="bi bi-play-fill"></i> Watch Video
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Video 3 -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="card dark-card position-relative">
                        <img src="https://images.unsplash.com/photo-1581291518857-4e27b48ff24e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80"
                             class="card-img" alt="Drone Videography">
                        <div class="card-img-overlay">
                            <a href="#" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#videoModal3">
                                <i class="bi bi-play-fill"></i> Watch Video
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center" data-aos="fade-up">
                    <h2 class="mb-4 text-white">Book Your Shoot</h2>
                    <p class="lead mb-5 text-muted">Ready to create lasting memories? Contact us today!</p>
                    <a href="#" class="btn btn-primary btn-lg">Get Started</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Video Modals -->
    <div class="modal fade" id="videoModal1" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content bg-dark">
                <div class="modal-header border-0">
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="ratio ratio-16x9">
                        <iframe src="https://www.youtube.com/embed/dQw4w9WgXcQ"
                                title="Wedding Video" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- AOS Animation Library -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

    <script>
        // Initialize AOS
        AOS.init({
            duration: 1000,
            once: true
        });
    </script>
</body>
</html>