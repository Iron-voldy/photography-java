<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SnapEvent - Professional Photography Services</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS from CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- AOS - Animate On Scroll Library -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <!-- Owl Carousel -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

    <style>
        /* Additional page-specific styles */
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1519741497674-611481863552?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            height: 85vh;
            display: flex;
            align-items: center;
            color: white;
            text-shadow: 0 2px 4px rgba(0,0,0,0.5);
        }

        .event-type-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
        }

        .event-type-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .event-type-img {
            height: 200px;
            object-fit: cover;
        }

        .testimonial-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
            margin: 0 auto 1rem;
            border: 3px solid #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .testimonial-card {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 2rem;
            text-align: center;
            margin: 1rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .stats-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            padding: 5rem 0;
            color: white;
        }

        .stat-card {
            text-align: center;
            padding: 2rem;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
        }

        .cta-section {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 5rem 0;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <!-- Include Messages -->
    <jsp:include page="/includes/messages.jsp" />

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-7" data-aos="fade-right" data-aos-duration="1000">
                    <h1 class="display-4 fw-bold mb-4">Capture Your Special Moments</h1>
                    <p class="lead mb-4">Connect with professional photographers to beautifully document your events, celebrations, and milestones.</p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/booking/booking_form.jsp" class="btn btn-primary btn-lg">Book Now</a>
                        <a href="${pageContext.request.contextPath}/photographer/photographer_list.jsp" class="btn btn-outline-light btn-lg">Find Photographers</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Event Types Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold" data-aos="fade-up">Event Types</h2>
                <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">Professional photography services for every occasion</p>
            </div>

            <div class="row g-4">
                <!-- Wedding Photography -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card event-type-card h-100">
                        <img src="https://images.unsplash.com/photo-1583939003579-730e3918a45a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80" class="card-img-top event-type-img" alt="Wedding Photography">
                        <div class="card-body">
                            <h5 class="card-title">Wedding Photography</h5>
                            <p class="card-text">Capture every magical moment of your special day, from preparation to reception.</p>
                            <a href="${pageContext.request.contextPath}/services/wedding.jsp" class="btn btn-sm btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>

                <!-- Corporate Events -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="card event-type-card h-100">
                        <img src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80" class="card-img-top event-type-img" alt="Corporate Events">
                        <div class="card-body">
                            <h5 class="card-title">Corporate Events</h5>
                            <p class="card-text">Professional photography for conferences, team buildings, and corporate celebrations.</p>
                            <a href="${pageContext.request.contextPath}/services/corporate.jsp" class="btn btn-sm btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>

                <!-- Family Portraits -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="card event-type-card h-100">
                        <img src="https://images.unsplash.com/photo-1576014131795-d440191a8e8b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80" class="card-img-top event-type-img" alt="Family Portraits">
                        <div class="card-body">
                            <h5 class="card-title">Family Portraits</h5>
                            <p class="card-text">Beautiful family photos that capture the personality and connection of your loved ones.</p>
                            <a href="${pageContext.request.contextPath}/services/family.jsp" class="btn btn-sm btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/services.jsp" class="btn btn-primary">View All Services</a>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section class="bg-light py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold" data-aos="fade-up">How It Works</h2>
                <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">Book your photographer in just a few simple steps</p>
            </div>

            <div class="row g-4">
                <!-- Step 1 -->
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4" style="width: 80px; height: 80px;">
                            <i class="bi bi-search text-white fs-1"></i>
                        </div>
                        <h5>Find a Photographer</h5>
                        <p class="text-muted">Browse our collection of professional photographers based on specialty and reviews.</p>
                    </div>
                </div>

                <!-- Step 2 -->
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center">
                        <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4" style="width: 80px; height: 80px;">
                            <i class="bi bi-calendar-check text-white fs-1"></i>
                        </div>
                        <h5>Request Booking</h5>
                        <p class="text-muted">Fill out our simple booking form with your event details and preferences.</p>
                    </div>
                </div>

                <!-- Step 3 -->
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="400">
                    <div class="text-center">
                        <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4" style="width: 80px; height: 80px;">
                            <i class="bi bi-credit-card text-white fs-1"></i>
                        </div>
                        <h5>Confirm & Pay</h5>
                        <p class="text-muted">Secure your booking with a deposit and finalize the event details.</p>
                    </div>
                </div>

                <!-- Step 4 -->
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="500">
                    <div class="text-center">
                        <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4" style="width: 80px; height: 80px;">
                            <i class="bi bi-camera text-white fs-1"></i>
                        </div>
                        <h5>Enjoy Your Event</h5>
                        <p class="text-muted">Relax while your photographer captures beautiful moments of your special day.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Photographers -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold" data-aos="fade-up">Featured Photographers</h2>
                <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">Discover our top-rated photography professionals</p>
            </div>

            <div class="row g-4">
                <!-- Photographer 1 -->
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="card h-100">
                        <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" class="card-img-top" alt="Photographer" style="height: 280px; object-fit: cover;">
                        <div class="card-body text-center">
                            <h5 class="card-title mb-1">James Wilson</h5>
                            <p class="text-muted small mb-2">Wedding Specialist</p>
                            <div class="mb-2">
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-half text-warning"></i>
                                <span class="ms-1">4.5</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/photographer/photographer_profile.jsp?id=1" class="btn btn-outline-primary btn-sm">View Profile</a>
                        </div>
                    </div>
                </div>

                <!-- Photographer 2 -->
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="card h-100">
                        <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" class="card-img-top" alt="Photographer" style="height: 280px; object-fit: cover;">
                        <div class="card-body text-center">
                            <h5 class="card-title mb-1">Emily Rodriguez</h5>
                            <p class="text-muted small mb-2">Portrait Expert</p>
                            <div class="mb-2">
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <span class="ms-1">5.0</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/photographer/photographer_profile.jsp?id=2" class="btn btn-outline-primary btn-sm">View Profile</a>
                        </div>
                    </div>
                </div>

                <!-- Photographer 3 -->
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="card h-100">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" class="card-img-top" alt="Photographer" style="height: 280px; object-fit: cover;">
                        <div class="card-body text-center">
                            <h5 class="card-title mb-1">Michael Chen</h5>
                            <p class="text-muted small mb-2">Corporate Specialist</p>
                            <div class="mb-2">
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star text-warning"></i>
                                <span class="ms-1">4.0</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/photographer/photographer_profile.jsp?id=3" class="btn btn-outline-primary btn-sm">View Profile</a>
                        </div>
                    </div>
                </div>

                <!-- Photographer 4 -->
                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="card h-100">
                        <img src="https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" class="card-img-top" alt="Photographer" style="height: 280px; object-fit: cover;">
                        <div class="card-body text-center">
                            <h5 class="card-title mb-1">Sophia Thomas</h5>
                            <p class="text-muted small mb-2">Family Photographer</p>
                            <div class="mb-2">
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-fill text-warning"></i>
                                <i class="bi bi-star-half text-warning"></i>
                                <span class="ms-1">4.7</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/photographer/photographer_profile.jsp?id=4" class="btn btn-outline-primary btn-sm">View Profile</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/photographer/photographer_list.jsp" class="btn btn-primary">View All Photographers</a>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="bg-light py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold" data-aos="fade-up">Client Testimonials</h2>
                <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">What our clients say about our photography services</p>
            </div>

            <div class="owl-carousel testimonial-carousel">
                <!-- Testimonial 1 -->
                <div class="testimonial-card">
                    <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80" alt="Client" class="testimonial-img">
                    <div class="mb-3">
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                    </div>
                    <p class="mb-3">"We couldn't be happier with our wedding photos! Emily captured every special moment beautifully, and the entire process was smooth from booking to receiving our gallery."</p>
                    <h5 class="mb-1">Sarah Johnson</h5>
                    <p class="text-muted small">Wedding Client</p>
                </div>

                <!-- Testimonial 2 -->
                <div class="testimonial-card">
                    <img src="https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" alt="Client" class="testimonial-img">
                    <div class="mb-3">
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-half text-warning"></i>
                    </div>
                    <p class="mb-3">"Michael was exceptional for our annual corporate event. He was professional, unobtrusive, and delivered high-quality photos that perfectly captured our company culture."</p>
                    <h5 class="mb-1">Robert Davis</h5>
                    <p class="text-muted small">Corporate Client</p>
                </div>

                <!-- Testimonial 3 -->
                <div class="testimonial-card">
                    <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=761&q=80" alt="Client" class="testimonial-img">
                    <div class="mb-3">
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                    </div>
                    <p class="mb-3">"Sophia took our family portraits and we couldn't be more thrilled! She was amazing with our kids and captured authentic smiles. The photos are treasures we'll cherish forever."</p>
                    <h5 class="mb-1">Jennifer Lopez</h5>
                    <p class="text-muted small">Family Portrait Client</p>
                </div>

                <!-- Testimonial 4 -->
                <div class="testimonial-card">
                    <img src="https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80" alt="Client" class="testimonial-img">
                    <div class="mb-3">
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star-fill text-warning"></i>
                        <i class="bi bi-star text-warning"></i>
                    </div>
                    <p class="mb-3">"The booking process was so easy! I found a photographer who perfectly matched my style preferences, and the results exceeded my expectations. Highly recommend this service!"</p>
                    <h5 class="mb-1">Marcus Chen</h5>
                    <p class="text-muted small">Engagement Shoot Client</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center g-4">
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-card">
                        <i class="bi bi-camera fs-1 mb-3"></i>
                        <h3 class="fw-bold">200+</h3>
                        <p>Professional Photographers</p>
                    </div>
                </div>

                <div class="col-md-3" data-aos="fade-up" data-aos-delay="200">
                    <div class="stat-card">
                        <i class="bi bi-calendar-check fs-1 mb-3"></i>
                        <h3 class="fw-bold">5,000+</h3>
                        <p>Events Photographed</p>
                    </div>
                </div>

                <div class="col-md-3" data-aos="fade-up" data-aos-delay="300">
                    <div class="stat-card">
                        <i class="bi bi-people fs-1 mb-3"></i>
                        <h3 class="fw-bold">10,000+</h3>
                        <p>Happy Clients</p>
                    </div>
                </div>

                <div class="col-md-3" data-aos="fade-up" data-aos-delay="400">
                    <div class="stat-card">
                        <i class="bi bi-star fs-1 mb-3"></i>
                        <h3 class="fw-bold">4.8</h3>
                        <p>Average Rating</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Recent Galleries Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold" data-aos="fade-up">Recent Galleries</h2>
                <p class="lead text-muted" data-aos="fade-up" data-aos-delay="100">Explore our latest event photography</p>
            </div>

            <div class="row g-4">
                <!-- Gallery 1 -->
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="card h-100">
                        <img src="https://images.unsplash.com/photo-1537633552985-df8429e8048b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80" class="card-img-top" alt="Gallery" style="height: 250px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Johnson Wedding</h5>
                            <p class="card-text text-muted">A beautiful summer wedding at