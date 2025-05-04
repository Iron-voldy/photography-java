<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${photographer.businessName} - Photographer Profile</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .profile-header {
            background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        .profile-content {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            padding: 30px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="profile-header">
        <div class="container">
            <div class="row">
                <div class="col-md-3 text-center">
                    <!-- Replace portfolioImageUrls with a default image since that property doesn't exist -->
                    <img src="${pageContext.request.contextPath}/assets/images/default-photographer.jpg"
                         alt="${photographer.businessName}"
                         class="img-fluid rounded-circle"
                         style="width: 200px; height: 200px; object-fit: cover;">
                </div>
                <div class="col-md-9">
                    <h1>${photographer.businessName}</h1>
                    <p class="lead">${photographer.location}</p>
                    <div class="d-flex align-items-center mb-3">
                        <div class="me-3">
                            <c:forEach begin="1" end="5" var="i">
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
                        <div>
                            <c:if test="${photographer.verified}">
                                <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Verified</span>
                            </c:if>
                        </div>
                    </div>
                    <div class="mb-3">
                        <c:forEach var="specialty" items="${photographer.specialties}">
                            <span class="badge bg-primary me-1">${specialty}</span>
                        </c:forEach>
                    </div>
                    <p>${photographer.biography}</p>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <!-- Services Section -->
                <div class="profile-content">
                    <h3 class="mb-4">Services</h3>
                    <c:choose>
                        <c:when test="${not empty services}">
                            <div class="row g-4">
                                <c:forEach var="service" items="${services}">
                                    <div class="col-md-6">
                                        <div class="card h-100">
                                            <div class="card-body">
                                                <h5 class="card-title">${service.name}</h5>
                                                <h6 class="card-subtitle mb-2 text-muted">${service.category}</h6>
                                                <p class="card-text">${service.description}</p>
                                                <ul class="list-group list-group-flush mb-3">
                                                    <c:forEach var="feature" items="${service.features}">
                                                        <li class="list-group-item border-0 ps-0 py-1">
                                                            <i class="bi bi-check text-success me-2"></i>${feature}
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="fs-4 fw-bold text-primary">$${service.price}</span>
                                                    <a href="${pageContext.request.contextPath}/booking/create-booking?photographerId=${photographer.photographerId}&serviceId=${service.serviceId}"
                                                       class="btn btn-primary">Book Now</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle me-2"></i>This photographer hasn't added any services yet.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Reviews Section -->
                <div class="profile-content">
                    <h3 class="mb-4">Client Reviews</h3>
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="review" items="${reviews}">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-2">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= review.rating}">
                                                        <i class="bi bi-star-fill text-warning"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bi bi-star text-warning"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <span class="ms-2 text-muted">
                                                <fmt:formatDate value="${review.reviewDate}" pattern="MMMM d, yyyy" />
                                            </span>
                                        </div>
                                        <h5 class="card-title">Client Review</h5>
                                        <p class="card-text">${review.comment}</p>
                                        <c:if test="${review.hasResponse}">
                                            <div class="border-top pt-3 mt-3">
                                                <h6 class="text-primary">Photographer's Response:</h6>
                                                <p class="mb-0">${review.responseText}</p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle me-2"></i>This photographer hasn't received any reviews yet.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="col-md-4">
                <!-- Contact Information -->
                <div class="profile-content">
                    <h3 class="mb-4">Contact Information</h3>
                    <ul class="list-unstyled">
                        <c:if test="${not empty photographer.email}">
                            <li class="mb-3">
                                <i class="bi bi-envelope me-2 text-primary"></i>
                                <a href="mailto:${photographer.email}">${photographer.email}</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty photographer.contactPhone}">
                            <li class="mb-3">
                                <i class="bi bi-telephone me-2 text-primary"></i>
                                <a href="tel:${photographer.contactPhone}">${photographer.contactPhone}</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty photographer.websiteUrl}">
                            <li class="mb-3">
                                <i class="bi bi-globe me-2 text-primary"></i>
                                <a href="${photographer.websiteUrl}" target="_blank">${photographer.websiteUrl}</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty photographer.location}">
                            <li>
                                <i class="bi bi-geo-alt me-2 text-primary"></i>${photographer.location}
                            </li>
                        </c:if>
                    </ul>
                </div>

                <!-- Photographer Details -->
                <div class="profile-content">
                    <h3 class="mb-4">Details</h3>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item border-0 ps-0">
                            <strong>Base Price:</strong> $${photographer.basePrice}/hour
                        </li>
                        <c:if test="${photographer.yearsOfExperience > 0}">
                            <li class="list-group-item border-0 ps-0">
                                <strong>Experience:</strong> ${photographer.yearsOfExperience} years
                            </li>
                        </c:if>
                        <c:if test="${not empty photographer.specialties}">
                            <li class="list-group-item border-0 ps-0">
                                <strong>Specialties:</strong> ${fn:join(photographer.specialties, ', ')}
                            </li>
                        </c:if>
                    </ul>
                </div>

                <!-- Call to Action -->
                <div class="profile-content text-center">
                    <h3 class="mb-3">Ready to Book?</h3>
                    <p>Contact this photographer to check availability for your event.</p>
                    <a href="${pageContext.request.contextPath}/booking/create?photographerId=${photographer.photographerId}"
                       class="btn btn-primary btn-lg">Book Now</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>