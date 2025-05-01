<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Photographers - SnapEvent</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }

        .page-header {
            background: linear-gradient(135deg, #4361ee 0%, #7209b7 100%);
            color: white;
            padding: 60px 0;
            text-align: center;
            margin-bottom: 40px;
            border-radius: 0 0 20px 20px;
        }

        .filter-section {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .photographer-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .photographer-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .photographer-thumbnail {
            height: 200px;
            object-fit: cover;
        }

        .photographer-card .card-body {
            padding: 20px;
        }

        .rating-stars {
            color: #ffc107;
        }

        .badge-specialty {
            background-color: #4361ee;
            color: white;
            font-weight: 500;
            margin-right: 5px;
            margin-bottom: 5px;
            font-size: 0.75rem;
        }

        .btn-book {
            background-color: #4361ee;
            border-color: #4361ee;
            padding: 8px 16px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .btn-book:hover {
            background-color: #3a56d4;
            border-color: #3a56d4;
            transform: translateY(-2px);
        }

        .pagination .page-link {
            color: #4361ee;
            border-radius: 5px;
            margin: 0 3px;
        }

        .pagination .page-item.active .page-link {
            background-color: #4361ee;
            border-color: #4361ee;
        }

        .location-badge {
            display: inline-block;
            background-color: #f8f9fa;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 0.8rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1 class="display-4 fw-bold">Find Your Perfect Photographer</h1>
            <p class="lead">Discover talented photographers for any event or occasion</p>
        </div>
    </section>

    <div class="container">
        <!-- Include Messages -->
        <jsp:include page="/includes/messages.jsp" />

        <!-- Filter Section -->
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/photographer/list" method="get" id="filterForm">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label for="search" class="form-label">Search</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control" id="search" name="search"
                                   placeholder="Photographer name, specialty..." value="${param.search}">
                        </div>
                    </div>

                    <div class="col-md-3">
                        <label for="specialty" class="form-label">Specialty</label>
                        <select class="form-select" id="specialty" name="specialty">
                            <option value="">All Specialties</option>
                            <c:forEach var="specialty" items="${specialties}">
                                <option value="${specialty}" ${param.specialty == specialty ? 'selected' : ''}>${specialty}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="location" class="form-label">Location</label>
                        <input type="text" class="form-control" id="location" name="location"
                               placeholder="City, state, etc." value="${param.location}">
                    </div>

                    <div class="col-md-3">
                        <label for="sortBy" class="form-label">Sort By</label>
                        <select class="form-select" id="sortBy" name="sortBy">
                            <option value="rating-desc" ${param.sortBy == 'rating-desc' || empty param.sortBy ? 'selected' : ''}>
                                Highest Rating
                            </option>
                            <option value="price-asc" ${param.sortBy == 'price-asc' ? 'selected' : ''}>
                                Price: Low to High
                            </option>
                            <option value="price-desc" ${param.sortBy == 'price-desc' ? 'selected' : ''}>
                                Price: High to Low
                            </option>
                            <option value="experience-desc" ${param.sortBy == 'experience-desc' ? 'selected' : ''}>
                                Most Experienced
                            </option>
                            <option value="name-asc" ${param.sortBy == 'name-asc' ? 'selected' : ''}>
                                Name: A to Z
                            </option>
                        </select>
                    </div>

                    <div class="col-12 d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/photographer/list"
                           class="btn btn-outline-secondary px-4">
                            <i class="bi bi-x-lg me-2"></i>Clear
                        </a>
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-filter me-2"></i>Apply Filters
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Photographers Grid -->
        <div class="row g-4 mb-4">
            <c:choose>
                <c:when test="${not empty photographers}">
                    <c:forEach var="photographer" items="${photographers}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card photographer-card">
                                <c:choose>
                                    <c:when test="${not empty photographer.portfolioImageUrls}">
                                        <img src="${photographer.portfolioImageUrls[0]}" class="card-img-top photographer-thumbnail" alt="${photographer.businessName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://images.unsplash.com/photo-1531891437562-4301cf35b7e4" class="card-img-top photographer-thumbnail" alt="${photographer.businessName}">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="card-title mb-0">${photographer.businessName}</h5>
                                        <c:choose>
                                            <c:when test="${photographer.isPhotographerAvailable}">
                                                <span class="badge bg-success">Available</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark">Limited</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <p class="location-badge">
                                        <i class="bi bi-geo-alt me-1"></i>${photographer.location}
                                    </p>
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="rating-stars me-2">
                                            <c:forEach begin="1" end="5" varStatus="star">
                                                <c:choose>
                                                    <c:when test="${star.index <= photographer.rating}">
                                                        <i class="bi bi-star-fill"></i>
                                                    </c:when>
                                                    <c:when test="${star.index > photographer.rating && star.index < photographer.rating + 1}">
                                                        <i class="bi bi-star-half"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bi bi-star"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <span>${photographer.rating} (${photographer.reviewCount} reviews)</span>
                                    </div>
                                    <div class="mb-3">
                                        <c:forEach var="specialty" items="${photographer.specialties}">
                                            <span class="badge badge-specialty">${specialty}</span>
                                        </c:forEach>
                                    </div>
                                    <p class="card-text text-muted small mb-3">
                                        ${fn:substring(photographer.biography, 0, 100)}...
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold text-primary">From $${photographer.basePrice}/hr</span>
                                        <a href="${pageContext.request.contextPath}/photographer/profile?id=${photographer.photographerId}"
                                           class="btn btn-outline-primary">View Profile</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Photographer 1 (Example data - will be replaced by actual database data) -->
                    <div class="col-md-6 col-lg-4">
                        <div class="card photographer-card">
                            <img src="https://images.unsplash.com/photo-1531891437562-4301cf35b7e4"
                                 class="card-img-top photographer-thumbnail" alt="John's Photography">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title mb-0">John's Photography</h5>
                                    <span class="badge bg-success">Available</span>
                                </div>
                                <p class="location-badge">
                                    <i class="bi bi-geo-alt me-1"></i>New York, NY
                                </p>
                                <div class="d-flex align-items-center mb-3">
                                    <div class="rating-stars me-2">
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-half"></i>
                                    </div>
                                    <span>4.7 (126 reviews)</span>
                                </div>
                                <div class="mb-3">
                                    <span class="badge badge-specialty">Wedding</span>
                                    <span class="badge badge-specialty">Portrait</span>
                                    <span class="badge badge-specialty">Event</span>
                                </div>
                                <p class="card-text text-muted small mb-3">
                                    Specializing in candid moments with a modern style. Over 10 years of experience capturing weddings and special events.
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-primary">From $250/hr</span>
                                    <a href="${pageContext.request.contextPath}/photographer/profile?id=p456"
                                       class="btn btn-outline-primary">View Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Photographer 2 (Example data) -->
                    <div class="col-md-6 col-lg-4">
                        <div class="card photographer-card">
                            <img src="https://images.unsplash.com/photo-1521038199265-bc482db0f923"
                                 class="card-img-top photographer-thumbnail" alt="Nature Shots">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title mb-0">Nature Shots</h5>
                                    <span class="badge bg-success">Available</span>
                                </div>
                                <p class="location-badge">
                                    <i class="bi bi-geo-alt me-1"></i>Seattle, WA
                                </p>
                                <div class="d-flex align-items-center mb-3">
                                    <div class="rating-stars me-2">
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star"></i>
                                    </div>
                                    <span>4.2 (52 reviews)</span>
                                </div>
                                <div class="mb-3">
                                    <span class="badge badge-specialty">Landscape</span>
                                    <span class="badge badge-specialty">Wildlife</span>
                                    <span class="badge badge-specialty">Family</span>
                                </div>
                                <p class="card-text text-muted small mb-3">
                                    Capturing the beauty of nature and families in natural settings. Specializing in outdoor photography with natural light.
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-primary">From $180/hr</span>
                                    <a href="${pageContext.request.contextPath}/photographer/profile?id=p222"
                                       class="btn btn-outline-primary">View Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Photographer 3 (Example data) -->
                    <div class="col-md-6 col-lg-4">
                        <div class="card photographer-card">
                            <img src="https://images.unsplash.com/photo-1595126739114-f9de2a949d93"
                                 class="card-img-top photographer-thumbnail" alt="Studio Perfect">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title mb-0">Studio Perfect</h5>
                                    <span class="badge bg-success">Available</span>
                                </div>
                                <p class="location-badge">
                                    <i class="bi bi-geo-alt me-1"></i>Los Angeles, CA
                                </p>
                                <div class="d-flex align-items-center mb-3">
                                    <div class="rating-stars me-2">
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                    </div>
                                    <span>5.0 (93 reviews)</span>
                                </div>
                                <div class="mb-3">
                                    <span class="badge badge-specialty">Portrait</span>
                                    <span class="badge badge-specialty">Corporate</span>
                                    <span class="badge badge-specialty">Product</span>
                                </div>
                                <p class="card-text text-muted small mb-3">
                                    Professional studio-based photography for corporate clients, products, and model portfolios. High-end retouching available.
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-primary">From $300/hr</span>
                                    <a href="${pageContext.request.contextPath}/photographer/profile?id=p789"
                                       class="btn btn-outline-primary">View Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Pagination -->
        <nav aria-label="Photographer search results pages">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/photographer/list?page=${currentPage - 1}&search=${param.search}&specialty=${param.specialty}&location=${param.location}&sortBy=${param.sortBy}">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${currentPage == i}">
                            <li class="page-item active">
                                <span class="page-link">${i}</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/photographer/list?page=${i}&search=${param.search}&specialty=${param.specialty}&location=${param.location}&sortBy=${param.sortBy}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/photographer/list?page=${currentPage + 1}&search=${param.search}&specialty=${param.specialty}&location=${param.location}&sortBy=${param.sortBy}">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>

        <!-- Photography Tips Section -->
        <div class="card mt-5 mb-5">
            <div class="card-body p-4">
                <h3 class="card-title">Finding the Right Photographer</h3>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <i class="bi bi-camera fs-2 text-primary"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5>Check Their Portfolio</h5>
                                <p class="text-muted">Look at their past work to make sure their style matches your vision.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <i class="bi bi-chat-left-quote fs-2 text-primary"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5>Read the Reviews</h5>
                                <p class="text-muted">Client reviews give insights into reliability, professionalism, and quality.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <i class="bi bi-calendar-check fs-2 text-primary"></i>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5>Book in Advance</h5>
                                <p class="text-muted">Secure your date with top photographers by booking early, especially for weddings.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Handle clear button
            document.querySelector('.btn-outline-secondary').addEventListener('click', function(e) {
                e.preventDefault();
                document.getElementById('search').value = '';
                document.getElementById('specialty').value = '';
                document.getElementById('location').value = '';
                document.getElementById('sortBy').value = 'rating-desc';

                // Submit the form with cleared values
                document.getElementById('filterForm').submit();
            });

            // Auto-submit form when sort option changes
            document.getElementById('sortBy').addEventListener('change', function() {
                document.getElementById('filterForm').submit();
            });
        });
    </script>
</body>
</html>