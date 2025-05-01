<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photographer Profile - SnapEvent</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container mt-4">
        <!-- Include Messages -->
        <jsp:include page="/includes/messages.jsp" />

        <!-- Profile Header -->
        <div class="bg-primary text-white p-4 rounded">
            <div class="row">
                <div class="col-md-3 text-center">
                    <c:choose>
                        <c:when test="${not empty photographer.portfolioImageUrls}">
                            <img src="${photographer.portfolioImageUrls[0]}" alt="${photographer.businessName}"
                                class="img-fluid rounded-circle" style="width: 200px; height: 200px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/images/default-avatar.jpg"
                                alt="${photographer.businessName}" class="img-fluid rounded-circle"
                                style="width: 200px; height: 200px; object-fit: cover;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-9">
                    <h1>${photographer.businessName}</h1>
                    <p><i class="bi bi-geo-alt-fill"></i> ${photographer.location}</p>

                    <div class="mb-3">
                        <c:forEach var="i" begin="1" end="5">
                            <c:choose>
                                <c:when test="${i <= photographer.rating}">
                                    <i class="bi bi-star-fill text-warning"></i>
                                </c:when>
                                <c:when test="${i > photographer.rating && i < photographer.rating + 1}">
                                    <i class="bi bi-star-half text-warning"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-star text-warning"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <span class="ms-2">${photographer.rating} (${photographer.reviewCount} reviews)</span>
                    </div>

                    <div class="mb-3">
                        <c:forEach var="specialty" items="${photographer.specialties}" varStatus="status">
                            <span class="badge bg-light text-dark me-2">${specialty}</span>
                        </c:forEach>
                    </div>

                    <div>
                        <a href="${pageContext.request.contextPath}/booking/booking_form.jsp?photographerId=${photographer.photographerId}"
                            class="btn btn-light">Book Now</a>
                        <a href="#contact" class="btn btn-outline-light ms-2">Contact</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs mt-4" id="profileTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="about-tab" data-bs-toggle="tab" data-bs-target="#about"
                        type="button" role="tab" aria-controls="about" aria-selected="true">
                    About
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="portfolio-tab" data-bs-toggle="tab" data-bs-target="#portfolio"
                        type="button" role="tab" aria-controls="portfolio" aria-selected="false">
                    Portfolio
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="services-tab" data-bs-toggle="tab" data-bs-target="#services"
                        type="button" role="tab" aria-controls="services" aria-selected="false">
                    Services
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews"
                        type="button" role="tab" aria-controls="reviews" aria-selected="false">
                    Reviews
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="availability-tab" data-bs-toggle="tab" data-bs-target="#availability"
                        type="button" role="tab" aria-controls="availability" aria-selected="false">
                    Availability
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact"
                        type="button" role="tab" aria-controls="contact" aria-selected="false">
                    Contact
                </button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content p-3 border border-top-0 rounded-bottom mb-4" id="profileTabsContent">
            <!-- About Tab -->
            <div class="tab-pane fade show active" id="about" role="tabpanel" aria-labelledby="about-tab">
                <div class="row">
                    <div class="col-md-8">
                        <h3>About ${photographer.businessName}</h3>
                        <c:choose>
                            <c:when test="${not empty photographer.biography}">
                                <p>${photographer.biography}</p>
                            </c:when>
                            <c:otherwise>
                                <p>Welcome to ${photographer.businessName}, where I capture the essence of life's most precious moments. With ${photographer.yearsOfExperience} years of experience in photography, I bring a unique blend of artistic vision and technical expertise to every shoot.</p>
                                <p>My style can be described as a mix of candid photojournalism and creative portraiture. I believe in capturing authentic emotions and creating timeless images that tell your story for generations to come.</p>
                            </c:otherwise>
                        </c:choose>

                        <h4 class="mt-4">Expertise</h4>
                        <ul>
                            <c:forEach var="specialty" items="${photographer.specialties}">
                                <li>${specialty} Photography</li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Quick Info</h5>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <strong><i class="bi bi-geo-alt me-2"></i>Location:</strong> ${photographer.location}
                                </li>
                                <li class="list-group-item">
                                    <strong><i class="bi bi-camera me-2"></i>Experience:</strong> ${photographer.yearsOfExperience} years
                                </li>
                                <li class="list-group-item">
                                    <strong><i class="bi bi-cash me-2"></i>Starting Price:</strong> $${photographer.basePrice}/hr
                                </li>
                                <c:if test="${not empty photographer.contactPhone}">
                                    <li class="list-group-item">
                                        <strong><i class="bi bi-telephone me-2"></i>Phone:</strong> ${photographer.contactPhone}
                                    </li>
                                </c:if>
                                <c:if test="${not empty photographer.websiteUrl}">
                                    <li class="list-group-item">
                                        <strong><i class="bi bi-globe me-2"></i>Website:</strong>
                                        <a href="${photographer.websiteUrl}" target="_blank">${photographer.websiteUrl}</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Portfolio Tab -->
            <div class="tab-pane fade" id="portfolio" role="tabpanel" aria-labelledby="portfolio-tab">
                <h3>Portfolio Galleries</h3>
                <div class="row">
                    <c:choose>
                        <c:when test="${not empty galleries}">
                            <c:forEach var="gallery" items="${galleries}">
                                <div class="col-md-4 mb-4">
                                    <div class="card">
                                        <c:choose>
                                            <c:when test="${not empty gallery.coverImage}">
                                                <img src="${gallery.coverImage.filePath}" class="card-img-top"
                                                    alt="${gallery.title}" style="height: 200px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/placeholder.jpg"
                                                    class="card-img-top" alt="Gallery placeholder"
                                                    style="height: 200px; object-fit: cover;">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="card-body">
                                            <h5 class="card-title">${gallery.title}</h5>
                                            <p class="card-text text-muted">${gallery.imageCount} photos • ${gallery.category}</p>
                                            <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=${gallery.galleryId}"
                                                class="btn btn-outline-primary">View Gallery</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Default portfolio galleries if none in database -->
                            <div class="col-md-4 mb-4">
                                <div class="card">
                                    <img src="https://images.unsplash.com/photo-1519741497674-611481863552"
                                        class="card-img-top" alt="Wedding Photography" style="height: 200px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Wedding Photography</h5>
                                        <p class="card-text text-muted">56 photos • Elegant ceremonies & receptions</p>
                                        <a href="#" class="btn btn-outline-primary">View Gallery</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-4">
                                <div class="card">
                                    <img src="https://images.unsplash.com/photo-1531123897727-8f129e1688ce"
                                        class="card-img-top" alt="Portrait Photography" style="height: 200px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Portrait Sessions</h5>
                                        <p class="card-text text-muted">42 photos • Individual & family portraits</p>
                                        <a href="#" class="btn btn-outline-primary">View Gallery</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-4">
                                <div class="card">
                                    <img src="https://images.unsplash.com/photo-1511795409834-ef04bbd61622"
                                        class="card-img-top" alt="Event Photography" style="height: 200px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Corporate Events</h5>
                                        <p class="card-text text-muted">38 photos • Professional business gatherings</p>
                                        <a href="#" class="btn btn-outline-primary">View Gallery</a>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Services Tab -->
            <div class="tab-pane fade" id="services" role="tabpanel" aria-labelledby="services-tab">
                <h3>Photography Services</h3>
                <div class="row">
                    <c:choose>
                        <c:when test="${not empty services}">
                            <c:forEach var="service" items="${services}">
                                <div class="col-md-6 mb-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <h4>${service.name}</h4>
                                            <h5 class="text-primary">$${service.price}</h5>
                                            <p>${service.description}</p>
                                            <ul>
                                                <c:forEach var="feature" items="${service.features}">
                                                    <li>${feature}</li>
                                                </c:forEach>
                                            </ul>
                                            <div class="text-center mt-3">
                                                <a href="${pageContext.request.contextPath}/booking/booking_form.jsp?photographerId=${photographer.photographerId}&packageId=${service.id}"
                                                    class="btn btn-primary">Book This Package</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Default service packages if none in database -->
                            <div class="col-md-6 mb-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h4>Silver Wedding Package</h4>
                                        <h5 class="text-primary">$1,800</h5>
                                        <p>Basic wedding coverage with essential services for couples on a budget.</p>
                                        <ul>
                                            <li>6 hours of coverage</li>
                                            <li>Two photographers</li>
                                            <li>Online gallery with digital downloads</li>
                                            <li>Engagement session (1 hour)</li>
                                            <li>100+ edited digital images</li>
                                        </ul>
                                        <div class="text-center mt-3">
                                            <a href="${pageContext.request.contextPath}/booking/booking_form.jsp?photographerId=${photographer.photographerId}&packageId=s001"
                                                class="btn btn-primary">Book This Package</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h4>Portrait Session</h4>
                                        <h5 class="text-primary">$350</h5>
                                        <p>Professional portrait photography session at a location of your choice.</p>
                                        <ul>
                                            <li>1-hour session at location of your choice</li>
                                            <li>Online gallery with digital downloads</li>
                                            <li>25+ edited digital images</li>
                                            <li>Print release</li>
                                            <li>One outfit change</li>
                                        </ul>
                                        <div class="text-center mt-3">
                                            <a href="${pageContext.request.contextPath}/booking/booking_form.jsp?photographerId=${photographer.photographerId}&packageId=s003"
                                                class="btn btn-primary">Book This Package</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Reviews Tab -->
            <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>Client Reviews</h3>
                    <c:if test="${canReview}">
                        <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#reviewModal">
                            Write a Review
                        </button>
                    </c:if>
                </div>

                <!-- Rating Summary -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-3 text-center">
                                <h1 class="display-4 fw-bold text-primary">${photographer.rating}</h1>
                                <div>
                                    <c:forEach var="i" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${i <= photographer.rating}">
                                                <i class="bi bi-star-fill text-warning"></i>
                                            </c:when>
                                            <c:when test="${i > photographer.rating && i < photographer.rating + 1}">
                                                <i class="bi bi-star-half text-warning"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star text-warning"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <p class="text-muted">${photographer.reviewCount} reviews</p>
                            </div>
                            <div class="col-md-9">
                                <c:if test="${not empty ratingDistribution}">
                                    <c:forEach var="i" begin="5" end="1" step="-1">
                                        <div class="d-flex align-items-center mb-2">
                                            <div style="width: 60px;">${i} stars</div>
                                            <div class="progress flex-grow-1 mx-2" style="height: 10px;">
                                                <div class="progress-bar" role="progressbar" style="width: ${ratingDistribution[i-1]}%"
                                                    aria-valuenow="${ratingDistribution[i-1]}" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <div style="width: 40px;">${ratingDistribution[i-1]}%</div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Reviews List -->
                <c:choose>
                    <c:when test="${not empty reviews}">
                        <c:forEach var="review" items="${reviews}">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div class="d-flex mb-3">
                                            <div class="flex-shrink-0">
                                                <img src="${pageContext.request.contextPath}/assets/images/default-avatar.jpg"
                                                    alt="${review.displayName}" class="rounded-circle" width="50" height="50">
                                            </div>
                                            <div class="ms-3">
                                                <h5 class="mb-0">${review.displayName}</h5>
                                                <p class="text-muted small mb-0">
                                                    <c:if test="${not empty review.bookingId}">
                                                        <span class="badge bg-success">Verified Client</span>
                                                    </c:if>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <div>
                                                <c:forEach var="i" begin="1" end="5">
                                                    <c:choose>
                                                        <c:when test="${i <= review.rating}">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="bi bi-star text-warning"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${review.reviewDate}" pattern="MMM d, yyyy" />
                                            </small>
                                        </div>
                                    </div>
                                    <p>${review.comment}</p>
                                    <c:if test="${review.hasResponse}">
                                        <div class="mt-3 p-3 bg-light rounded">
                                            <p class="mb-1"><strong>Response from ${photographer.businessName}:</strong></p>
                                            <p class="mb-0">${review.responseText}</p>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Example reviews if none in database -->
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div class="d-flex mb-3">
                                        <div class="flex-shrink-0">
                                            <img src="https://randomuser.me/api/portraits/women/32.jpg"
                                                alt="Sarah J." class="rounded-circle" width="50" height="50">
                                        </div>
                                        <div class="ms-3">
                                            <h5 class="mb-0">Sarah Johnson</h5>
                                            <p class="text-muted small mb-0">
                                                <span class="badge bg-success">Verified Client</span>
                                                Wedding Photography
                                            </p>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                        </div>
                                        <small class="text-muted">June 15, 2023</small>
                                    </div>
                                </div>
                                <p>Absolutely amazing! Captured all the special moments at our wedding and made everyone feel comfortable. The photos turned out stunning - better than we could have imagined.</p>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div class="d-flex mb-3">
                                        <div class="flex-shrink-0">
                                            <img src="https://randomuser.me/api/portraits/men/45.jpg"
                                                alt="Michael T." class="rounded-circle" width="50" height="50">
                                        </div>
                                        <div class="ms-3">
                                            <h5 class="mb-0">Michael Thompson</h5>
                                            <p class="text-muted small mb-0">
                                                <span class="badge bg-success">Verified Client</span>
                                                Corporate Event
                                            </p>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star-fill text-warning"></i>
                                            <i class="bi bi-star text-warning"></i>
                                        </div>
                                        <small class="text-muted">May 3, 2023</small>
                                    </div>
                                </div>
                                <p>Very professional and unobtrusive. Quick turnaround time with the photos. Would recommend!</p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Availability Tab -->
            <div class="tab-pane fade" id="availability" role="tabpanel" aria-labelledby="availability-tab">
                <h3>Availability Calendar</h3>
                <p>Check my availability and book your photography session. Green dates are available, red dates are booked or unavailable.</p>

                <div id="availabilityCalendar" class="mb-4" style="height: 400px;"></div>

                <div class="mt-3">
                    <div class="d-flex align-items-center mb-2">
                        <div class="me-2" style="width: 20px; height: 20px; background-color: #28a745; border-radius: 3px;"></div>
                        <span>Available</span>
                    </div>
                    <div class="d-flex align-items-center mb-2">
                        <div class="me-2" style="width: 20px; height: 20px; background-color: #dc3545; border-radius: 3px;"></div>
                        <span>Booked/Unavailable</span>
                    </div>
                    <div class="d-flex align-items-center">
                        <div class="me-2" style="width: 20px; height: 20px; background-color: #ffc107; border-radius: 3px;"></div>
                        <span>Limited Availability</span>
                    </div>
                </div>

                <div class="alert alert-info mt-4">
                    <i class="bi bi-info-circle-fill me-2"></i>
                    <strong>Available Hours:</strong> Typically available from 9 AM to 7 PM. Early morning and late evening sessions may be available upon request for golden hour photography.
                </div>

                <div class="d-grid mt-4">
                    <a href="${pageContext.request.contextPath}/booking/booking_form.jsp?photographerId=${photographer.photographerId}"
                        class="btn btn-primary btn-lg">
                        <i class="bi bi-calendar-plus me-2"></i>Book a Session
                    </a>
                </div>
            </div>

            <!-- Contact Tab -->
            <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                <div class="row">
                    <div class="col-md-6">
                        <h3>Contact ${photographer.businessName}</h3>
                        <p>Have questions or want to discuss a custom photography package? Send a message directly.</p>

                        <form action="${pageContext.request.contextPath}/message/send" method="post">
                            <input type="hidden" name="photographerId" value="${photographer.photographerId}">

                            <div class="mb-3">
                                <label for="name" class="form-label">Your Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone">
                            </div>

                            <div class="mb-3">
                                <label for="inquiryType" class="form-label">Inquiry Type</label>
                                <select class="form-select" id="inquiryType" name="inquiryType" required>
                                    <option value="" selected disabled>Select inquiry type</option>
                                    <option value="WEDDING">Wedding Information</option>
                                    <option value="PORTRAIT">Portrait Session</option>
                                    <option value="EVENT">Event Coverage</option>
                                    <option value="PRICING">Pricing Question</option>
                                    <option value="AVAILABILITY">Check Availability</option>
                                    <option value="OTHER">Other Question</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="message" class="form-label">Your Message</label>
                                <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-send me-2"></i>Send Message
                            </button>
                        </form>
                    </div>

                    <div class="col-md-6">
                        <h4 class="mt-4 mt-md-0">Contact Information</h4>
                        <div class="mb-4">
                            <div class="d-flex mb-3">
                                <i class="bi bi-envelope-fill text-primary me-3 fs-4"></i>
                                <div>
                                    <h5>Email</h5>
                                    <p>${photographer.email}</p>
                                </div>
                            </div>
                            <c:if test="${not empty photographer.contactPhone}">
                                <div class="d-flex mb-3">
                                    <i class="bi bi-telephone-fill text-primary me-3 fs-4"></i>
                                    <div>
                                        <h5>Phone</h5>
                                        <p>${photographer.contactPhone}</p>
                                    </div>
                                </div>
                            </c:if>
                            <div class="d-flex mb-3">
                                <i class="bi bi-geo-alt-fill text-primary me-3 fs-4"></i>
                                <div>
                                    <h5>Location</h5>
                                    <p>${photographer.location} (Available for travel)</p>
                                </div>
                            </div>
                            <div class="d-flex mb-3">
                                <i class="bi bi-clock-fill text-primary me-3 fs-4"></i>
                                <div>
                                    <h5>Response Time</h5>
                                    <p>Usually within 24 hours</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Review Modal -->
    <div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="reviewModalLabel">Write a Review</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/review/add" method="post" id="reviewForm">
                        <input type="hidden" name="photographerId" value="${photographer.photographerId}">

                        <div class="mb-3">
                            <label class="form-label">Your Rating</label>
                            <div class="rating-input d-flex">
                                <div class="btn-group" role="group">
                                    <input type="radio" class="btn-check" name="rating" id="star5" value="5" autocomplete="off" checked>
                                    <label class="btn btn-outline-warning" for="star5">5 ★</label>

                                    <input type="radio" class="btn-check" name="rating" id="star4" value="4" autocomplete="off">
                                    <label class="btn btn-outline-warning" for="star4">4 ★</label>

                                    <input type="radio" class="btn-check" name="rating" id="star3" value="3" autocomplete="off">
                                    <label class="btn btn-outline-warning" for="star3">3 ★</label>

                                    <input type="radio" class="btn-check" name="rating" id="star2" value="2" autocomplete="off">
                                    <label class="btn btn-outline-warning" for="star2">2 ★</label>

                                    <input type="radio" class="btn-check" name="rating" id="star1" value="1" autocomplete="off">
                                    <label class="btn btn-outline-warning" for="star1">1 ★</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="serviceType" class="form-label">Service Type</label>
                            <select class="form-select" id="serviceType" name="serviceType" required>
                                <option value="" selected disabled>Select service type</option>
                                <option value="WEDDING">Wedding Photography</option>
                                <option value="PORTRAIT">Portrait Session</option>
                                <option value="EVENT">Event Photography</option>
                                <option value="CORPORATE">Corporate Photography</option>
                                <option value="FAMILY">Family Photography</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="reviewText" class="form-label">Your Review</label>
                            <textarea class="form-control" id="reviewText" name="comment" rows="5"
                                    placeholder="Share your experience with this photographer..." required></textarea>
                            <div class="form-text">Minimum 20 characters. Be honest and detailed in your review.</div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="reviewForm" class="btn btn-primary">Submit Review</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize FullCalendar
            const calendarEl = document.getElementById('availabilityCalendar');

            if (calendarEl) {
                const calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth'
                    },
                    height: '100%',
                    events: ${availabilityJson != null ? availabilityJson : '[]'}
                });

                calendar.render();
            }

            // Favorite button functionality
            const favoriteBtn = document.getElementById('favoriteBtn');
            if (favoriteBtn) {
                favoriteBtn.addEventListener('click', function(event) {
                    event.preventDefault();

                    const photographerId = this.getAttribute('data-photographer-id');
                    const isFavorite = this.classList.contains('active');

                    // Call backend to toggle favorite status
                    fetch('${pageContext.request.contextPath}/user/toggle-favorite', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'photographerId=' + photographerId + '&action=' + (isFavorite ? 'remove' : 'add')
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Toggle active class
                            this.classList.toggle('active');

                            // Toggle heart icon
                            const heartIcon = this.querySelector('i');
                            if (heartIcon.classList.contains('bi-heart')) {
                                heartIcon.classList.remove('bi-heart');
                                heartIcon.classList.add('bi-heart-fill');
                            } else {
                                heartIcon.classList.remove('bi-heart-fill');
                                heartIcon.classList.add('bi-heart');
                            }
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
                });
            }
        });
    </script>
</body>
</html>