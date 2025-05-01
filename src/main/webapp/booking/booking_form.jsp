<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Photographer - SnapEvent</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Flatpickr Calendar -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_blue.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-hover: #3a56d4;
            --secondary-color: #7209b7;
            --accent-color: #f72585;
            --light-bg: #f8f9fa;
            --dark-bg: #212529;
            --text-color: #212529;
            --text-muted: #6c757d;
            --border-color: #dee2e6;
            --card-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f2f5;
            color: var(--text-color);
        }

        .booking-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            padding: 2rem 0;
            color: white;
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px;
            box-shadow: var(--card-shadow);
        }

        .page-title {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .booking-card {
            background-color: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: none;
            margin-bottom: 1.5rem;
        }

        .card-header-custom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--light-bg);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }

        .card-title-custom {
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 0;
            color: var(--primary-color);
        }

        .step-indicator {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
            position: relative;
            z-index: 1;
        }

        .step-indicator::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            height: 2px;
            width: 100%;
            background-color: var(--border-color);
            z-index: -1;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 1;
        }

        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: white;
            border: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .step-title {
            font-size: 0.9rem;
            font-weight: 500;
            text-align: center;
            color: var(--text-muted);
            transition: all 0.3s ease;
        }

        .step.active .step-number {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .step.active .step-title {
            color: var(--primary-color);
            font-weight: 600;
        }

        .step.completed .step-number {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .photographer-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
            background-color: white;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }

        .photographer-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .photographer-card.selected {
            border-color: var(--primary-color);
        }

        .photographer-header {
            height: 160px;
            position: relative;
        }

        .photographer-cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .photographer-avatar {
            position: absolute;
            bottom: -40px;
            left: 20px;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .photographer-body {
            padding: 2.5rem 1.5rem 1.5rem;
        }

        .photographer-name {
            font-weight: 600;
            font-size: 1.2rem;
            margin-bottom: 0.3rem;
        }

        .photographer-specialties {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 0.8rem;
        }

        .rating {
            display: flex;
            align-items: center;
            margin-bottom: 0.8rem;
        }

        .rating-value {
            font-weight: 600;
            margin-right: 0.3rem;
        }

        .rating-stars {
            color: #ffc107;
            font-size: 0.9rem;
        }

        .photographer-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid var(--border-color);
            padding-top: 1rem;
        }

        .price-range {
            font-weight: 600;
            color: var(--primary-color);
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            background-color: white;
            font-size: 1rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .btn-custom {
            padding: 0.6rem 1.2rem;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary-custom {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .btn-primary-custom:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .btn-outline-custom {
            border-color: var(--border-color);
            color: var(--text-color);
        }

        .btn-outline-custom:hover {
            background-color: var(--light-bg);
            color: var(--primary-color);
        }

        .package-card {
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .package-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .package-card.selected {
            border-color: var(--primary-color);
            background-color: rgba(67, 97, 238, 0.05);
        }

        .package-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .package-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 0.2rem;
        }

        .package-price {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .package-details {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .package-features {
            margin-top: 1rem;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .feature-icon {
            color: var(--primary-color);
            margin-right: 0.5rem;
        }

        .date-indicator {
            background-color: var(--light-bg);
            padding: 0.5rem 1rem;
            border-radius: 50px;
            display: inline-flex;
            align-items: center;
            font-weight: 500;
            margin-bottom: 1rem;
        }

        .date-indicator i {
            margin-right: 0.5rem;
            color: var(--primary-color);
        }

        .time-slot {
            display: inline-block;
            padding: 0.6rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .time-slot:hover {
            border-color: var(--primary-color);
            background-color: rgba(67, 97, 238, 0.05);
        }

        .time-slot.selected {
            border-color: var(--primary-color);
            background-color: var(--primary-color);
            color: white;
        }

        .time-slot.unavailable {
            background-color: var(--light-bg);
            color: var(--text-muted);
            cursor: not-allowed;
            opacity: 0.7;
        }

background-color: var(--light-bg);
            border-radius: 10px;
            padding: 1.5rem;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.8rem;
        }

        .summary-label {
            font-weight: 500;
            color: var(--text-muted);
        }

        .summary-value {
            font-weight: 600;
        }

        .summary-total {
            font-size: 1.2rem;
            border-top: 1px dashed var(--border-color);
            padding-top: 0.8rem;
            margin-top: 0.8rem;
        }

        .payment-method {
            display: block;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-method:hover {
            border-color: var(--primary-color);
        }

        .payment-method.selected {
            border-color: var(--primary-color);
            background-color: rgba(67, 97, 238, 0.05);
        }

        .payment-header {
            display: flex;
            align-items: center;
        }

        .payment-icon {
            width: 40px;
            height: 40px;
            margin-right: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--light-bg);
            border-radius: 8px;
            font-size: 1.5rem;
            color: var(--primary-color);
        }

        .payment-name {
            font-weight: 600;
            margin-bottom: 0;
        }

        .tab-content {
            margin-top: 1.5rem;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .booking-card {
                padding: 1.5rem;
            }

            .step-title {
                font-size: 0.8rem;
            }
        }

        @media (max-width: 768px) {
            .step-indicator {
                flex-wrap: wrap;
                justify-content: center;
            }

            .step {
                margin: 0 1rem 1rem;
            }

            .step-title {
                font-size: 0.7rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container">
        <!-- Booking Header -->
        <div class="booking-header">
            <div class="container">
                <h1 class="page-title">Book a Photographer</h1>
                <p class="mb-0 lead">Complete the steps below to schedule your photography session.</p>
            </div>
        </div>

        <!-- Include Messages -->
        <jsp:include page="/includes/messages.jsp" />

        <!-- Booking Form -->
        <form action="${pageContext.request.contextPath}/booking/BookingCreateServlet" method="post" id="bookingForm">
            <!-- Steps Indicator -->
            <div class="step-indicator">
                <div class="step active" data-step="1">
                    <div class="step-number">1</div>
                    <div class="step-title">Select Photographer</div>
                </div>
                <div class="step" data-step="2">
                    <div class="step-number">2</div>
                    <div class="step-title">Choose Package</div>
                </div>
                <div class="step" data-step="3">
                    <div class="step-number">3</div>
                    <div class="step-title">Date & Time</div>
                </div>
                <div class="step" data-step="4">
                    <div class="step-number">4</div>
                    <div class="step-title">Event Details</div>
                </div>
                <div class="step" data-step="5">
                    <div class="step-number">5</div>
                    <div class="step-title">Review & Pay</div>
                </div>
            </div>

            <!-- Step 1: Select Photographer -->
            <div class="booking-card" id="step1Content">
                <div class="card-header-custom">
                    <h5 class="card-title-custom">
                        <i class="bi bi-person me-2"></i>Select a Photographer
                    </h5>
                </div>

                <div class="card-body p-0">
                    <!-- Search and Filter Options -->
                    <div class="row mb-4">
                        <div class="col-md-4 mb-3 mb-md-0">
                            <input type="text" class="form-control" placeholder="Search by name..." id="photographerSearch">
                        </div>
                        <div class="col-md-4 mb-3 mb-md-0">
                            <select class="form-select" id="filterSpecialty">
                                <option value="">All Specialties</option>
                                <option value="Wedding">Wedding</option>
                                <option value="Portrait">Portrait</option>
                                <option value="Event">Event</option>
                                <option value="Family">Family</option>
                                <option value="Corporate">Corporate</option>
                                <option value="Landscape">Landscape</option>
                                <option value="Product">Product</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <select class="form-select" id="sortPhotographers">
                                <option value="rating">Sort by Rating</option>
                                <option value="price-low">Price: Low to High</option>
                                <option value="price-high">Price: High to Low</option>
                                <option value="experience">Experience</option>
                            </select>
                        </div>
                    </div>

                    <div class="row" id="photographersList">
                        <!-- Photographer 1 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="photographer-card" data-photographer-id="p456">
                                <div class="photographer-header">
                                    <img src="https://images.unsplash.com/photo-1524758631624-e2822e304c36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="John's Photography Cover" class="photographer-cover">
                                    <img src="https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1528&q=80" alt="John's Photography" class="photographer-avatar">
                                </div>
                                <div class="photographer-body">
                                    <h5 class="photographer-name">John's Photography</h5>
                                    <div class="photographer-specialties">Wedding | Portrait | Event</div>
                                    <div class="rating">
                                        <span class="rating-value">4.8</span>
                                        <span class="rating-stars">★★★★★</span>
                                        <span class="ms-2 text-muted">(47 reviews)</span>
                                    </div>
                                    <p class="small text-muted">Professional photography services with 5+ years of experience capturing special moments.</p>
                                    <div class="photographer-footer">
                                        <span class="price-range">$250-500</span>
                                        <a href="${pageContext.request.contextPath}/photographer/photographer_details.jsp?id=p456" class="btn btn-sm btn-outline-custom" target="_blank">View Profile</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Photographer 2 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="photographer-card" data-photographer-id="p222">
                                <div class="photographer-header">
                                    <img src="https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="NatureShots Cover" class="photographer-cover">
                                    <img src="https://images.unsplash.com/photo-1521038199265-bc482db0f923?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80" alt="NatureShots" class="photographer-avatar">
                                </div>
                                <div class="photographer-body">
                                    <h5 class="photographer-name">NatureShots</h5>
                                    <div class="photographer-specialties">Landscape | Wildlife | Family</div>
                                    <div class="rating">
                                        <span class="rating-value">4.6</span>
                                        <span class="rating-stars">★★★★★</span>
                                        <span class="ms-2 text-muted">(32 reviews)</span>
                                    </div>
                                    <p class="small text-muted">Specializing in outdoor photography with a focus on natural light and scenic backgrounds.</p>
                                    <div class="photographer-footer">
                                        <span class="price-range">$150-300</span>
                                        <a href="${pageContext.request.contextPath}/photographer/photographer_details.jsp?id=p222" class="btn btn-sm btn-outline-custom" target="_blank">View Profile</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Photographer 3 -->
                        <div class="col-lg-4 col-md-6">
                            <div class="photographer-card" data-photographer-id="p333">
                                <div class="photographer-header">
                                    <img src="https://images.unsplash.com/photo-1564501049412-61c2a3083791?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1932&q=80" alt="Corporate Imagery Cover" class="photographer-cover">
                                    <img src="https://images.unsplash.com/photo-1556157382-97eda2f9e946?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Corporate Imagery" class="photographer-avatar">
                                </div>
                                <div class="photographer-body">
                                    <h5 class="photographer-name">Corporate Imagery</h5>
                                    <div class="photographer-specialties">Corporate | Product | Headshot</div>
                                    <div class="rating">
                                        <span class="rating-value">4.9</span>
                                        <span class="rating-stars">★★★★★</span>
                                        <span class="ms-2 text-muted">(61 reviews)</span>
                                    </div>
                                    <p class="small text-muted">Professional business photography with 7+ years experience delivering high-quality corporate imagery.</p>
                                    <div class="photographer-footer">
                                        <span class="price-range">$300-800</span>
                                        <a href="${pageContext.request.contextPath}/photographer/photographer_details.jsp?id=p333" class="btn btn-sm btn-outline-custom" target="_blank">View Profile</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" name="photographerId" id="selectedPhotographer">
                </div>

                <div class="mt-4 d-flex justify-content-end">
                    <button type="button" class="btn btn-primary-custom" id="step1Next" disabled>Continue to Packages</button>
                </div>
            </div>

            <!-- Step 2: Choose Package -->
            <div class="booking-card" id="step2Content" style="display: none;">
                <div class="card-header-custom">
                    <h5 class="card-title-custom">
                        <i class="bi bi-camera me-2"></i>Choose a Photography Package
                    </h5>
                    <button type="button" class="btn btn-sm btn-outline-custom" id="step2Back">
                        <i class="bi bi-arrow-left me-1"></i>Back
                    </button>
                </div>

                <div class="card-body p-0">
                    <div class="mb-4">
                        <h6 class="mb-3">Selected Photographer: <span id="selectedPhotographerName" class="text-primary">John's Photography</span></h6>

                        <div id="photographerPackages">
                            <!-- Package 1 -->
                            <div class="package-card" data-package-id="s001">
                                <div class="package-header">
                                    <div>
                                        <h5 class="package-name">Silver Wedding Package</h5>
                                        <div class="package-category">Wedding Photography</div>
                                    </div>
                                    <div class="package-price">$1,200</div>
                                </div>
                                <div class="package-details">
                                    6-hour coverage with 2 photographers capturing your special day from preparation to reception.
                                </div>
                                <div class="package-features">
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>6 hours of photography coverage</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>2 professional photographers</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>All edited digital images with print release</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>Online gallery for sharing</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Package 2 -->
                            <div class="package-card" data-package-id="s002">
                                <div class="package-header">
                                    <div>
                                        <h5 class="package-name">Gold Wedding Package</h5>
                                        <div class="package-category">Wedding Photography</div>
                                    </div>
                                    <div class="package-price">$2,000</div>
                                </div>
                                <div class="package-details">
                                    Comprehensive 10-hour coverage including engagement session, ensuring no special moment is missed.
                                </div>
                                <div class="package-features">
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>10 hours of photography coverage</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>2 professional photographers</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>Engagement photoshoot session</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>Premium photo album</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>All edited digital images with print release</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>Online gallery for sharing</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Package 3 -->
                            <div class="package-card" data-package-id="s003">
                                <div class="package-header">
                                    <div>
                                        <h5 class="package-name">Family Portrait Session</h5>
                                        <div class="package-category">Portrait Photography</div>
                                    </div>
                                    <div class="package-price">$250</div>
                                </div>
                                <div class="package-details">
                                    1-hour outdoor session perfect for family portraits, capturing natural interactions and personalities.
                                </div>
                                <div class="package-features">
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>1 hour photography session</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>Location of your choice</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>20 edited digital images</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle feature-icon"></i>
                                        <span>Online gallery for downloading</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" name="packageId" id="selectedPackage">
                </div>

                <div class="mt-4 d-flex justify-content-end">
                    <button type="button" class="btn btn-primary-custom" id="step2Next" disabled>Continue to Date & Time</button>
                </div>
            </div>

            <!-- Step 3: Date & Time -->
            <div class="booking-card" id="step3Content" style="display: none;">
                <div class="card-header-custom">
                    <h5 class="card-title-custom">
                        <i class="bi bi-calendar-event me-2"></i>Select Date & Time
                    </h5>
                    <button type="button" class="btn btn-sm btn-outline-custom" id="step3Back">
                        <i class="bi bi-arrow-left me-1"></i>Back
                    </button>
                </div>

                <div class="card-body p-0">
                    <div class="mb-4">
                        <h6 class="mb-3">Selected Package: <span id="selectedPackageName" class="text-primary">Gold Wedding Package</span></h6>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="eventDate" class="form-label">Event Date</label>
                                <input type="text" class="form-control" id="eventDate" name="eventDate" placeholder="Select date" required>
                                <div class="form-text">Green dates show photographer availability</div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label class="form-label">Available Time Slots</label>
                                <div id="timeSlots">
                                    <div class="date-indicator">
                                        <i class="bi bi-calendar3"></i>
                                        <span>Select a date first</span>
                                    </div>
                                    <div id="availableTimeSlots" style="display: none;">
                                        <div class="time-slot" data-time="09:00">9:00 AM</div>
                                        <div class="time-slot" data-time="10:00">10:00 AM</div>
                                        <div class="time-slot" data-time="11:00">11:00 AM</div>
                                        <div class="time-slot unavailable" data-time="12:00">12:00 PM</div>
                                        <div class="time-slot" data-time="13:00">1:00 PM</div>
                                        <div class="time-slot" data-time="14:00">2:00 PM</div>
                                        <div class="time-slot" data-time="15:00">3:00 PM</div>
                                        <div class="time-slot unavailable" data-time="16:00">4:00 PM</div>
                                        <div class="time-slot" data-time="17:00">5:00 PM</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" name="startTime" id="selectedTime">
                </div>

                <div class="mt-4 d-flex justify-content-end">
                    <button type="button" class="btn btn-primary-custom" id="step3Next" disabled>Continue to Event Details</button>
                </div>
            </div>

            <!-- Step 4: Event Details -->
            <div class="booking-card" id="step4Content" style="display: none;">
                <div class="card-header-custom">
                    <h5 class="card-title-custom">
                        <i class="bi bi-info-circle me-2"></i>Event Details
                    </h5>
                    <button type="button" class="btn btn-sm btn-outline-custom" id="step4Back">
                        <i class="bi bi-arrow-left me-1"></i>Back
                    </button>
                </div>

                <div class="card-body p-0">
                    <div class="mb-3">
                        <div class="date-indicator mb-4">
                            <i class="bi bi-calendar-check"></i>
                            <span id="selectedDateDisplay">December 15, 2023</span>
                            <span class="mx-2">·</span>
                            <i class="bi bi-clock"></i>
                            <span id="selectedTimeDisplay">10:00 AM</span>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="eventType" class="form-label">Event Type</label>
                                <select class="form-select" id="eventType" name="eventType" required>
                                    <option value="">Select Event Type</option>
                                    <option value="WEDDING">Wedding</option>
                                    <option value="CORPORATE">Corporate Event</option>
                                    <option value="PORTRAIT">Portrait Session</option>
                                    <option value="FAMILY">Family Gathering</option>
                                    <option value="PRODUCT">Product Photoshoot</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="eventLocation" class="form-label">Event Location</label>
                                <input type="text" class="form-control" id="eventLocation" name="eventLocation" placeholder="Enter event location" required>
                            </div>

                            <div class="col-12 mb-3">
                                <label for="eventNotes" class="form-label">Special Requests or Notes</label>
                                <textarea class="form-control" id="eventNotes" name="eventNotes" rows="4" placeholder="Please share any special requests, specific shots you want, or additional information..."></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4 d-flex justify-content-end">
                    <button type="button" class="btn btn-primary-custom" id="step4Next">Review & Pay</button>
                </div>
            </div>

            <!-- Step 5: Review & Pay -->
            <div class="booking-card" id="step5Content" style="display: none;">
                <div class="card-header-custom">
                    <h5 class="card-title-custom">
                        <i class="bi bi-check-circle me-2"></i>Review & Pay
                    </h5>
                    <button type="button" class="btn btn-sm btn-outline-custom" id="step5Back">
                        <i class="bi bi-arrow-left me-1"></i>Back
                    </button>
                </div>

                <div class="card-body p-0">
                    <div class="row">
                        <div class="col-lg-7 mb-4">
                            <h6 class="mb-3">Booking Summary</h6>
                            <div class="booking-summary">
                                <div class="summary-item">
                                    <span class="summary-label">Photographer:</span>
                                    <span class="summary-value" id="summaryPhotographer">John's Photography</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Package:</span>
                                    <span class="summary-value" id="summaryPackage">Gold Wedding Package</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Date & Time:</span>
                                    <span class="summary-value" id="summaryDateTime">December 15, 2023 at 10:00 AM</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Event Type:</span>
                                    <span class="summary-value" id="summaryEventType">Wedding</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Location:</span>
                                    <span class="summary-value" id="summaryLocation">Park Plaza Hotel</span>
                                </div>
                                <div class="summary-item summary-total">
                                    <span class="summary-label">Total Amount:</span>
                                    <span class="summary-value" id="summaryTotal">$2,000</span>
                                </div>
                            </div>

                            <div class="mt-4">
                                <h6 class="mb-3">Cancellation Policy</h6>
                                <p class="small text-muted">
                                    Cancellations more than 30 days before the event date will receive a full refund.
                                    Cancellations within 15-30 days will receive a 50% refund.
                                    Cancellations less than 15 days before the event are non-refundable.
                                </p>
                            </div>
                        </div>

                        <div class="col-lg-5">
                            <h6 class="mb-3">Payment Method</h6>

                            <div class="payment-methods">
                                <label class="payment-method">
                                    <input type="radio" name="paymentMethod" value="credit-card" checked hidden>
                                    <div class="payment-header">
                                        <div class="payment-icon">
                                            <i class="bi bi-credit-card"></i>
                                        </div>
                                        <div>
                                            <h6 class="payment-name">Credit Card</h6>
                                            <span class="small text-muted">Visa, Mastercard, American Express</span>
                                        </div>
                                    </div>
                                </label>

                                <label class="payment-method">
                                    <input type="radio" name="paymentMethod" value="paypal" hidden>
                                    <div class="payment-header">
                                        <div class="payment-icon">
                                            <i class="bi bi-paypal"></i>
                                        </div>
                                        <div>
                                            <h6 class="payment-name">PayPal</h6>
                                            <span class="small text-muted">Pay using your PayPal account</span>
                                        </div>
                                    </div>
                                </label>
                            </div>

                            <!-- Credit Card Form - shows by default -->
                            <div class="tab-content mt-3">
                                <div class="tab-pane fade show active" id="creditCardTab">
                                    <div class="mb-3">
                                        <label for="cardName" class="form-label">Cardholder Name</label>
                                        <input type="text" class="form-control" id="cardName" placeholder="Name on card">
                                    </div>
                                    <div class="mb-3">
                                        <label for="cardNumber" class="form-label">Card Number</label>
                                        <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456">
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="cardExpiry" class="form-label">Expiry Date</label>
                                            <input type="text" class="form-control" id="cardExpiry" placeholder="MM/YY">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="cardCVC" class="form-label">CVC</label>
                                            <input type="text" class="form-control" id="cardCVC" placeholder="123">
                                        </div>
                                    </div>
                                </div>
                                                            </div>
                                                            <div class="tab-pane fade" id="paypalTab">
                                                                <div class="text-center py-3">
                                                                    <i class="bi bi-paypal text-primary" style="font-size: 3rem;"></i>
                                                                    <p class="mt-3">You'll be redirected to PayPal to complete your payment securely.</p>
                                                                </div>
                                                            </div>

                                                            <div class="form-check mt-4">
                                                                <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                                                <label class="form-check-label" for="termsCheck">
                                                                    I agree to the <a href="${pageContext.request.contextPath}/terms.jsp" target="_blank">Terms of Service</a> and
                                                                    <a href="${pageContext.request.contextPath}/privacy.jsp" target="_blank">Privacy Policy</a>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-4 d-flex justify-content-end">
                                                    <button type="submit" class="btn btn-primary-custom" id="completeBooking">Complete Booking</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                    <!-- Include Footer -->
                                    <jsp:include page="/includes/footer.jsp" />

                                    <!-- Flatpickr JS -->
                                    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

                                    <!-- Bootstrap Bundle with Popper -->
                                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                                    <script>
                                        document.addEventListener('DOMContentLoaded', function() {
                                            // ===== Step Navigation =====
                                            // Step 1 to Step 2
                                            document.getElementById('step1Next').addEventListener('click', function() {
                                                document.getElementById('step1Content').style.display = 'none';
                                                document.getElementById('step2Content').style.display = 'block';
                                                updateStepIndicator(2);
                                            });

                                            // Step 2 Back to Step 1
                                            document.getElementById('step2Back').addEventListener('click', function() {
                                                document.getElementById('step2Content').style.display = 'none';
                                                document.getElementById('step1Content').style.display = 'block';
                                                updateStepIndicator(1);
                                            });

                                            // Step 2 to Step 3
                                            document.getElementById('step2Next').addEventListener('click', function() {
                                                document.getElementById('step2Content').style.display = 'none';
                                                document.getElementById('step3Content').style.display = 'block';
                                                updateStepIndicator(3);
                                            });

                                            // Step 3 Back to Step 2
                                            document.getElementById('step3Back').addEventListener('click', function() {
                                                document.getElementById('step3Content').style.display = 'none';
                                                document.getElementById('step2Content').style.display = 'block';
                                                updateStepIndicator(2);
                                            });

                                            // Step 3 to Step 4
                                            document.getElementById('step3Next').addEventListener('click', function() {
                                                document.getElementById('step3Content').style.display = 'none';
                                                document.getElementById('step4Content').style.display = 'block';
                                                updateStepIndicator(4);
                                            });

                                            // Step 4 Back to Step 3
                                            document.getElementById('step4Back').addEventListener('click', function() {
                                                document.getElementById('step4Content').style.display = 'none';
                                                document.getElementById('step3Content').style.display = 'block';
                                                updateStepIndicator(3);
                                            });

                                            // Step 4 to Step 5
                                            document.getElementById('step4Next').addEventListener('click', function() {
                                                // Update summary information
                                                document.getElementById('summaryPhotographer').textContent = document.getElementById('selectedPhotographerName').textContent;
                                                document.getElementById('summaryPackage').textContent = document.getElementById('selectedPackageName').textContent;
                                                document.getElementById('summaryDateTime').textContent = document.getElementById('selectedDateDisplay').textContent + ' at ' + document.getElementById('selectedTimeDisplay').textContent;
                                                document.getElementById('summaryEventType').textContent = document.getElementById('eventType').options[document.getElementById('eventType').selectedIndex].text;
                                                document.getElementById('summaryLocation').textContent = document.getElementById('eventLocation').value;

                                                document.getElementById('step4Content').style.display = 'none';
                                                document.getElementById('step5Content').style.display = 'block';
                                                updateStepIndicator(5);
                                            });

                                            // Step 5 Back to Step 4
                                            document.getElementById('step5Back').addEventListener('click', function() {
                                                document.getElementById('step5Content').style.display = 'none';
                                                document.getElementById('step4Content').style.display = 'block';
                                                updateStepIndicator(4);
                                            });

                                            // Update Step Indicator
                                            function updateStepIndicator(activeStep) {
                                                const steps = document.querySelectorAll('.step');
                                                steps.forEach(function(step, index) {
                                                    const stepNumber = index + 1;
                                                    step.classList.remove('active', 'completed');

                                                    if (stepNumber === activeStep) {
                                                        step.classList.add('active');
                                                    } else if (stepNumber < activeStep) {
                                                        step.classList.add('completed');
                                                    }
                                                });
                                            }

                                            // ===== Photographer Selection =====
                                            const photographerCards = document.querySelectorAll('.photographer-card');
                                            photographerCards.forEach(function(card) {
                                                card.addEventListener('click', function() {
                                                    // Remove selected class from all cards
                                                    photographerCards.forEach(function(c) {
                                                        c.classList.remove('selected');
                                                    });

                                                    // Add selected class to clicked card
                                                    this.classList.add('selected');

                                                    // Set the selected photographer value
                                                    const photographerId = this.getAttribute('data-photographer-id');
                                                    document.getElementById('selectedPhotographer').value = photographerId;

                                                    // Update the photographer name for step 2
                                                    const photographerName = this.querySelector('.photographer-name').textContent;
                                                    document.getElementById('selectedPhotographerName').textContent = photographerName;

                                                    // Enable the next button
                                                    document.getElementById('step1Next').disabled = false;
                                                });
                                            });

                                            // ===== Package Selection =====
                                            const packageCards = document.querySelectorAll('.package-card');
                                            packageCards.forEach(function(card) {
                                                card.addEventListener('click', function() {
                                                    // Remove selected class from all cards
                                                    packageCards.forEach(function(c) {
                                                        c.classList.remove('selected');
                                                    });

                                                    // Add selected class to clicked card
                                                    this.classList.add('selected');

                                                    // Set the selected package value
                                                    const packageId = this.getAttribute('data-package-id');
                                                    document.getElementById('selectedPackage').value = packageId;

                                                    // Update the package name for step 3
                                                    const packageName = this.querySelector('.package-name').textContent;
                                                    document.getElementById('selectedPackageName').textContent = packageName;

                                                    // Enable the next button
                                                    document.getElementById('step2Next').disabled = false;
                                                });
                                            });

                                            // ===== Date & Time Selection =====
                                            // Initialize Flatpickr datepicker
                                            const fpInstance = flatpickr('#eventDate', {
                                                dateFormat: 'Y-m-d',
                                                minDate: 'today',
                                                disableMobile: true,
                                                enable: [
                                                    function(date) {
                                                        // Example: Enable only dates that are available
                                                        const availableDates = [
                                                            "2023-12-15", "2023-12-16", "2023-12-20",
                                                            "2023-12-22", "2023-12-23", "2023-12-27",
                                                            "2024-01-05", "2024-01-06", "2024-01-10",
                                                            "2024-01-12", "2024-01-13", "2024-01-19",
                                                            "2024-01-20", "2024-01-26", "2024-01-27"
                                                        ];

                                                        const currentDate = date.getFullYear() + "-" +
                                                                          String(date.getMonth() + 1).padStart(2, '0') + "-" +
                                                                          String(date.getDate()).padStart(2, '0');

                                                        return availableDates.includes(currentDate);
                                                    }
                                                ],
                                                onChange: function(selectedDates, dateStr) {
                                                    // Format date for display
                                                    const options = { year: 'numeric', month: 'long', day: 'numeric' };
                                                    const formattedDate = new Date(dateStr).toLocaleDateString('en-US', options);
                                                    document.getElementById('selectedDateDisplay').textContent = formattedDate;

                                                    // Show available time slots
                                                    const timeSlots = document.getElementById('availableTimeSlots');
                                                    if (timeSlots) {
                                                        // In real app, fetch time slots for the selected date
                                                        // For demo, we'll just show sample time slots
                                                        document.querySelector('#timeSlots .date-indicator').style.display = 'none';
                                                        timeSlots.style.display = 'block';
                                                    }
                                                }
                                            });

                                            // Time slot selection
                                            const timeSlots = document.querySelectorAll('.time-slot:not(.unavailable)');
                                            timeSlots.forEach(function(slot) {
                                                slot.addEventListener('click', function() {
                                                    // Remove selected class from all slots
                                                    timeSlots.forEach(function(s) {
                                                        s.classList.remove('selected');
                                                    });

                                                    // Add selected class to clicked slot
                                                    this.classList.add('selected');

                                                    // Set the selected time value
                                                    const timeValue = this.getAttribute('data-time');
                                                    document.getElementById('selectedTime').value = timeValue;

                                                    // Update the time display
                                                    document.getElementById('selectedTimeDisplay').textContent = this.textContent;

                                                    // Enable the next button
                                                    document.getElementById('step3Next').disabled = false;
                                                });
                                            });

                                            // ===== Payment Method Selection =====
                                            const paymentMethods = document.querySelectorAll('.payment-method');
                                            paymentMethods.forEach(function(method) {
                                                method.addEventListener('click', function() {
                                                    // Remove selected class from all methods
                                                    paymentMethods.forEach(function(m) {
                                                        m.classList.remove('selected');
                                                    });

                                                    // Add selected class to clicked method
                                                    this.classList.add('selected');

                                                    // Get the input value
                                                    const paymentMethod = this.querySelector('input[name="paymentMethod"]').value;

                                                    // Show appropriate payment form
                                                    if (paymentMethod === 'credit-card') {
                                                        document.getElementById('creditCardTab').classList.add('show', 'active');
                                                        document.getElementById('paypalTab').classList.remove('show', 'active');
                                                    } else if (paymentMethod === 'paypal') {
                                                        document.getElementById('creditCardTab').classList.remove('show', 'active');
                                                        document.getElementById('paypalTab').classList.add('show', 'active');
                                                    }
                                                });
                                            });

                                            // Auto-select first payment method
                                            if (paymentMethods.length > 0) {
                                                paymentMethods[0].classList.add('selected');
                                            }

                                            // ===== Search and Filter Photographers =====
                                            const photographerSearch = document.getElementById('photographerSearch');
                                            const filterSpecialty = document.getElementById('filterSpecialty');
                                            const sortPhotographers = document.getElementById('sortPhotographers');

                                            // Add event listeners
                                            if (photographerSearch) {
                                                photographerSearch.addEventListener('input', filterPhotographers);
                                            }

                                            if (filterSpecialty) {
                                                filterSpecialty.addEventListener('change', filterPhotographers);
                                            }

                                            if (sortPhotographers) {
                                                sortPhotographers.addEventListener('change', filterPhotographers);
                                            }

                                            function filterPhotographers() {
                                                const searchTerm = photographerSearch ? photographerSearch.value.toLowerCase() : '';
                                                const specialty = filterSpecialty ? filterSpecialty.value : '';

                                                // Loop through all photographer cards
                                                photographerCards.forEach(function(card) {
                                                    const name = card.querySelector('.photographer-name').textContent.toLowerCase();
                                                    const specialties = card.querySelector('.photographer-specialties').textContent.toLowerCase();

                                                    // Check if matches search and filter criteria
                                                    const matchesSearch = name.includes(searchTerm);
                                                    const matchesSpecialty = specialty === '' || specialties.includes(specialty.toLowerCase());

                                                    // Show or hide based on criteria
                                                    if (matchesSearch && matchesSpecialty) {
                                                        card.closest('.col-lg-4').style.display = 'block';
                                                    } else {
                                                        card.closest('.col-lg-4').style.display = 'none';
                                                    }
                                                });
                                            }

                                            // ===== Form Validation =====
                                            document.getElementById('bookingForm').addEventListener('submit', function(event) {
                                                // Validate photographer selection
                                                if (!document.getElementById('selectedPhotographer').value) {
                                                    event.preventDefault();
                                                    showToast('Please select a photographer', 'error');
                                                    document.getElementById('step1Content').style.display = 'block';
                                                    document.getElementById('step5Content').style.display = 'none';
                                                    updateStepIndicator(1);
                                                    return;
                                                }

                                                // Validate package selection
                                                if (!document.getElementById('selectedPackage').value) {
                                                    event.preventDefault();
                                                    showToast('Please select a package', 'error');
                                                    document.getElementById('step2Content').style.display = 'block';
                                                    document.getElementById('step5Content').style.display = 'none';
                                                    updateStepIndicator(2);
                                                    return;
                                                }

                                                // Validate date selection
                                                if (!document.getElementById('eventDate').value) {
                                                    event.preventDefault();
                                                    showToast('Please select an event date', 'error');
                                                    document.getElementById('step3Content').style.display = 'block';
                                                    document.getElementById('step5Content').style.display = 'none';
                                                    updateStepIndicator(3);
                                                    return;
                                                }

                                                // Validate time selection
                                                if (!document.getElementById('selectedTime').value) {
                                                    event.preventDefault();
                                                    showToast('Please select a time slot', 'error');
                                                    document.getElementById('step3Content').style.display = 'block';
                                                    document.getElementById('step5Content').style.display = 'none';
                                                    updateStepIndicator(3);
                                                    return;
                                                }

                                                // Validate event details
                                                if (!document.getElementById('eventType').value || !document.getElementById('eventLocation').value) {
                                                    event.preventDefault();
                                                    showToast('Please complete all event details', 'error');
                                                    document.getElementById('step4Content').style.display = 'block';
                                                    document.getElementById('step5Content').style.display = 'none';
                                                    updateStepIndicator(4);
                                                    return;
                                                }

                                                // Validate terms agreement
                                                if (!document.getElementById('termsCheck').checked) {
                                                    event.preventDefault();
                                                    showToast('Please agree to the Terms of Service', 'error');
                                                    return;
                                                }

                                                // In a real application, you would validate payment details here
                                            });

                                            // Helper function to show toast messages
                                            function showToast(message, type = 'info') {
                                                // Check if showToast function exists in the main.js
                                                if (typeof window.showToast === 'function') {
                                                    window.showToast(message, type);
                                                } else {
                                                    alert(message);
                                                }
                                            }
                                        });
                                    </script>
                                </body>
                                </html>