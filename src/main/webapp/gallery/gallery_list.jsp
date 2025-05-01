<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo Galleries - SnapEvent</title>

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

        .page-header {
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

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .gallery-card {
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            border: none;
        }

        .gallery-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .gallery-header {
            position: relative;
            height: 200px;
        }

        .gallery-cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .gallery-info {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 1rem;
            background: linear-gradient(0deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0) 100%);
            color: white;
        }

        .gallery-body {
            padding: 1.5rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .gallery-title {
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }

        .gallery-subtitle {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .gallery-description {
            color: var(--text-color);
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            flex-grow: 1;
        }

        .gallery-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
        }

        .gallery-meta {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .gallery-status {
            display: inline-block;
            padding: 0.3rem 0.6rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .status-draft {
            background-color: rgba(108, 117, 125, 0.1);
            color: #6c757d;
        }

        .status-published {
            background-color: rgba(25, 135, 84, 0.1);
            color: #198754;
        }

        .status-private {
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
        }

        .filter-bar {
            background-color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--card-shadow);
        }

        .filter-bar .form-control,
        .filter-bar .form-select {
            border-radius: 10px;
            border: 1px solid var(--border-color);
        }

        .filter-bar .form-control:focus,
        .filter-bar .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

        .filter-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }

        .view-toggle {
            display: inline-flex;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            overflow: hidden;
        }

        .view-toggle button {
            padding: 0.5rem 1rem;
            background-color: white;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .view-toggle button.active {
            background-color: var(--primary-color);
            color: white;
        }

        .view-toggle button:first-child {
            border-right: 1px solid var(--border-color);
        }

        .gallery-list-view {
            display: none;
        }

        .gallery-list-view.active {
            display: block;
        }

        .gallery-list-item {
            display: flex;
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .gallery-list-item:hover {
            transform: translateX(5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .gallery-list-image {
            width: 180px;
            min-width: 180px;
            height: 180px;
            object-fit: cover;
        }

        .gallery-list-content {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .gallery-list-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            background-color: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
        }

        .empty-state-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .pagination-custom {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
        }

        .pagination-custom .page-link {
            border-radius: 10px;
            margin: 0 0.2rem;
            border: 1px solid var(--border-color);
            color: var(--text-color);
            transition: all 0.3s ease;
        }

        .pagination-custom .page-link:hover {
            background-color: var(--light-bg);
            color: var(--primary-color);
        }

        .pagination-custom .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        @media (max-width: 768px) {
            .gallery-list-image {
                width: 120px;
                min-width: 120px;
                height: 120px;
            }

            .gallery-list-content {
                padding: 1rem;
            }

            .gallery-list-item .gallery-title {
                font-size: 1.1rem;
            }

            .filter-bar {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="container">
                <h1 class="page-title">Photo Galleries</h1>

                <c:choose>
                    <c:when test="${param.userOnly == 'true' && sessionScope.userType == 'photographer'}">
                        <p class="mb-0 lead">Manage and organize your photography portfolios.</p>
                    </c:when>
                    <c:when test="${param.userOnly == 'true' && sessionScope.userType == 'client'}">
                        <p class="mb-0 lead">View your event photography galleries.</p>
                    </c:when>
                    <c:otherwise>
                        <p class="mb-0 lead">Explore beautiful photography from our talented photographers.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Include Messages -->
        <jsp:include page="/includes/messages.jsp" />

        <!-- Filter Bar -->
        <div class="filter-bar">
            <div class="row align-items-end">
                <div class="col-md-3 mb-3 mb-md-0">
                    <label for="searchGallery" class="filter-label">Search</label>
                    <input type="text" class="form-control" id="searchGallery" placeholder="Search galleries...">
                </div>

                <div class="col-md-3 mb-3 mb-md-0">
                    <label for="categoryFilter" class="filter-label">Category</label>
                    <select class="form-select" id="categoryFilter">
                        <option value="">All Categories</option>
                        <option value="WEDDING">Wedding</option>
                        <option value="PORTRAIT">Portrait</option>
                        <option value="EVENT">Event</option>
                        <option value="CORPORATE">Corporate</option>
                        <option value="LANDSCAPE">Landscape</option>
                        <option value="PRODUCT">Product</option>
                        <option value="OTHER">Other</option>
                    </select>
                </div>

                <div class="col-md-2 mb-3 mb-md-0">
                    <label for="sortGalleries" class="filter-label">Sort By</label>
                    <select class="form-select" id="sortGalleries">
                        <option value="date-desc">Newest First</option>
                        <option value="date-asc">Oldest First</option>
                        <option value="name-asc">Name A-Z</option>
                        <option value="name-desc">Name Z-A</option>
                    </select>
                </div>

                <div class="col-md-2 mb-3 mb-md-0">
                    <label class="filter-label d-block">View</label>
                    <div class="view-toggle">
                        <button type="button" id="gridViewBtn" class="active"><i class="bi bi-grid"></i></button>
                        <button type="button" id="listViewBtn"><i class="bi bi-list"></i></button>
                    </div>
                </div>

                <div class="col-md-2 text-md-end mb-3 mb-md-0">
                    <c:if test="${sessionScope.userType == 'photographer'}">
                        <a href="${pageContext.request.contextPath}/gallery/upload_form.jsp" class="btn btn-primary-custom">
                            <i class="bi bi-plus-circle me-2"></i>Create Gallery
                        </a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Gallery Grid View -->
        <div class="gallery-list-view active" id="gridView">
            <div class="gallery-grid">
                <!-- Gallery 1 -->
                <div class="gallery-card">
                    <div class="gallery-header">
                        <img src="https://images.unsplash.com/photo-1511285560929-80b456f7a771?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3538&q=80" alt="Smith Wedding" class="gallery-cover">
                        <div class="gallery-info">
                            <span class="gallery-status status-published">Published</span>
                        </div>
                    </div>
                    <div class="gallery-body">
                        <h5 class="gallery-title">Smith Wedding</h5>
                        <div class="gallery-subtitle">Wedding Photography</div>
                        <p class="gallery-description">Beautiful wedding ceremony at Park Plaza Hotel with elegant decorations and joyful moments.</p>
                        <div class="gallery-footer">
                            <div class="gallery-meta">
                                <i class="bi bi-images me-1"></i> 95 photos
                            </div>
                            <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g001" class="btn btn-sm btn-outline-custom">View Gallery</a>
                        </div>
                    </div>
                </div>

                <!-- Gallery 2 -->
                <div class="gallery-card">
                    <div class="gallery-header">
                        <img src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Johnson Corporate Event" class="gallery-cover">
                        <div class="gallery-info">
                            <span class="gallery-status status-published">Published</span>
                        </div>
                    </div>
                    <div class="gallery-body">
                        <h5 class="gallery-title">Johnson Corporate Event</h5>
                        <div class="gallery-subtitle">Corporate Photography</div>
                        <p class="gallery-description">Annual meeting photography capturing professional presentations and networking moments.</p>
                        <div class="gallery-footer">
                            <div class="gallery-meta">
                                <i class="bi bi-images me-1"></i> 94 photos
                            </div>
                            <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g002" class="btn btn-sm btn-outline-custom">View Gallery</a>
                        </div>
                    </div>
                </div>

                <!-- Gallery 3 -->
                <div class="gallery-card">
                    <div class="gallery-header">
                        <img src="https://images.unsplash.com/photo-1470770841072-f978cf4d019e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Nature Portfolio" class="gallery-cover">
                        <div class="gallery-info">
                            <span class="gallery-status status-published">Published</span>
                        </div>
                    </div>
                    <div class="gallery-body">
                        <h5 class="gallery-title">Nature Portfolio</h5>
                        <div class="gallery-subtitle">Landscape Photography</div>
                        <p class="gallery-description">A collection of breathtaking landscape photographs showcasing the beauty of nature.</p>
                        <div class="gallery-footer">
                            <div class="gallery-meta">
                                <i class="bi bi-images me-1"></i> 52 photos
                            </div>
                            <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g003" class="btn btn-sm btn-outline-custom">View Gallery</a>
                        </div>
                    </div>
                </div>

                <!-- Gallery 4 -->
                <div class="gallery-card">
                    <div class="gallery-header">
                        <img src="https://images.unsplash.com/photo-1581291518857-4e27b48ff24e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80" alt="City Landscapes" class="gallery-cover">
                        <div class="gallery-info">
                            <span class="gallery-status status-draft">Draft</span>
                        </div>
                    </div>
                    <div class="gallery-body">
                        <h5 class="gallery-title">City Landscapes</h5>
                        <div class="gallery-subtitle">Urban Photography</div>
                        <p class="gallery-description">Urban architecture and city scenes capturing the essence of modern metropolises.</p>
                        <div class="gallery-footer">
                            <div class="gallery-meta">
                                <i class="bi bi-images me-1"></i> 38 photos
                            </div>
                            <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g004" class="btn btn-sm btn-outline-custom">View Gallery</a>
                        </div>
                    </div>
                </div>

                <!-- Gallery 5 -->
                <div class="gallery-card">
                    <div class="gallery-header">
                        <img src="https://images.unsplash.com/photo-1566275529824-cca6d008f3da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80" alt="Family Portraits" class="gallery-cover">
                        <div class="gallery-info">
                            <span class="gallery-status status-private">Private</span>
                        </div>
                    </div>
                    <div class="gallery-body">
                        <h5 class="gallery-title">Family Portraits</h5>
                        <div class="gallery-subtitle">Portrait Photography</div>
                        <p class="gallery-description">Beautiful family portrait session at the park capturing genuine emotions and connections.</p>
                        <div class="gallery-footer">
                            <div class="gallery-meta">
                                <i class="bi bi-images me-1"></i> 65 photos
                            </div>
                            <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g005" class="btn btn-sm btn-outline-custom">View Gallery</a>
                        </div>
                    </div>
                </div>

                <!-- Gallery 6 -->
                <div class="gallery-card">
                    <div class="gallery-header">
                        <img src="https://images.unsplash.com/photo-1577401239170-897942555fb3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80" alt="Product Showcase" class="gallery-cover">
                        <div class="gallery-info">
                            <span class="gallery-status status-published">Published</span>
                        </div>
                    </div>
                    <div class="gallery-body">
                        <h5 class="gallery-title">Product Showcase</h5>
                        <div class="gallery-subtitle">Product Photography</div>
                        <p class="gallery-description">Professional product photography for a fashion brand showcasing their latest collection.</p>
                        <div class="gallery-footer">
                            <div class="gallery-meta">
                                <i class="bi bi-images me-1"></i> 42 photos
                            </div>
                            <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g006" class="btn btn-sm btn-outline-custom">View Gallery</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Gallery List View -->
        <div class="gallery-list-view" id="listView">
            <!-- Gallery 1 -->
            <div class="gallery-list-item">
                <img src="https://images.unsplash.com/photo-1511285560929-80b456f7a771?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3538&q=80" alt="Smith Wedding" class="gallery-list-image">
                <div class="gallery-list-content">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="gallery-title">Smith Wedding</h5>
                            <div class="gallery-subtitle">Wedding Photography</div>
                        </div>
                        <span class="gallery-status status-published">Published</span>
                    </div>
                    <p class="gallery-description">Beautiful wedding ceremony at Park Plaza Hotel with elegant decorations and joyful moments.</p>
                    <div class="gallery-list-footer">
                        <div class="d-flex align-items-center">
                            <span class="gallery-meta me-3">
                                <i class="bi bi-images me-1"></i> 95 photos
                            </span>
                            <span class="gallery-meta">
                                <i class="bi bi-calendar3 me-1"></i> Dec 16, 2023
                            </span>
                        </div>
                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g001" class="btn btn-sm btn-outline-custom">View Gallery</a>
                    </div>
                </div>
            </div>

            <!-- Gallery 2 -->
            <div class="gallery-list-item">
                <img src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Johnson Corporate Event" class="gallery-list-image">
                <div class="gallery-list-content">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="gallery-title">Johnson Corporate Event</h5>
                            <div class="gallery-subtitle">Corporate Photography</div>
                        </div>
                        <span class="gallery-status status-published">Published</span>
                    </div>
                    <p class="gallery-description">Annual meeting photography capturing professional presentations and networking moments.</p>
                    <div class="gallery-list-footer">
                        <div class="d-flex align-items-center">
                            <span class="gallery-meta me-3">
                                <i class="bi bi-images me-1"></i> 94 photos
                                                            </span>
                                                            <span class="gallery-meta">
                                                                <i class="bi bi-calendar3 me-1"></i> Nov 5, 2023
                                                            </span>
                                                        </div>
                                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g002" class="btn btn-sm btn-outline-custom">View Gallery</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Gallery 3 -->
                                            <div class="gallery-list-item">
                                                <img src="https://images.unsplash.com/photo-1470770841072-f978cf4d019e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80" alt="Nature Portfolio" class="gallery-list-image">
                                                <div class="gallery-list-content">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <h5 class="gallery-title">Nature Portfolio</h5>
                                                            <div class="gallery-subtitle">Landscape Photography</div>
                                                        </div>
                                                        <span class="gallery-status status-published">Published</span>
                                                    </div>
                                                    <p class="gallery-description">A collection of breathtaking landscape photographs showcasing the beauty of nature.</p>
                                                    <div class="gallery-list-footer">
                                                        <div class="d-flex align-items-center">
                                                            <span class="gallery-meta me-3">
                                                                <i class="bi bi-images me-1"></i> 52 photos
                                                            </span>
                                                            <span class="gallery-meta">
                                                                <i class="bi bi-calendar3 me-1"></i> Sep 15, 2023
                                                            </span>
                                                        </div>
                                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g003" class="btn btn-sm btn-outline-custom">View Gallery</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Gallery 4 -->
                                            <div class="gallery-list-item">
                                                <img src="https://images.unsplash.com/photo-1581291518857-4e27b48ff24e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80" alt="City Landscapes" class="gallery-list-image">
                                                <div class="gallery-list-content">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <h5 class="gallery-title">City Landscapes</h5>
                                                            <div class="gallery-subtitle">Urban Photography</div>
                                                        </div>
                                                        <span class="gallery-status status-draft">Draft</span>
                                                    </div>
                                                    <p class="gallery-description">Urban architecture and city scenes capturing the essence of modern metropolises.</p>
                                                    <div class="gallery-list-footer">
                                                        <div class="d-flex align-items-center">
                                                            <span class="gallery-meta me-3">
                                                                <i class="bi bi-images me-1"></i> 38 photos
                                                            </span>
                                                            <span class="gallery-meta">
                                                                <i class="bi bi-calendar3 me-1"></i> Aug 20, 2023
                                                            </span>
                                                        </div>
                                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g004" class="btn btn-sm btn-outline-custom">View Gallery</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Gallery 5 -->
                                            <div class="gallery-list-item">
                                                <img src="https://images.unsplash.com/photo-1566275529824-cca6d008f3da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80" alt="Family Portraits" class="gallery-list-image">
                                                <div class="gallery-list-content">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <h5 class="gallery-title">Family Portraits</h5>
                                                            <div class="gallery-subtitle">Portrait Photography</div>
                                                        </div>
                                                        <span class="gallery-status status-private">Private</span>
                                                    </div>
                                                    <p class="gallery-description">Beautiful family portrait session at the park capturing genuine emotions and connections.</p>
                                                    <div class="gallery-list-footer">
                                                        <div class="d-flex align-items-center">
                                                            <span class="gallery-meta me-3">
                                                                <i class="bi bi-images me-1"></i> 65 photos
                                                            </span>
                                                            <span class="gallery-meta">
                                                                <i class="bi bi-calendar3 me-1"></i> Jul 30, 2023
                                                            </span>
                                                        </div>
                                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g005" class="btn btn-sm btn-outline-custom">View Gallery</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Gallery 6 -->
                                            <div class="gallery-list-item">
                                                <img src="https://images.unsplash.com/photo-1577401239170-897942555fb3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80" alt="Product Showcase" class="gallery-list-image">
                                                <div class="gallery-list-content">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <h5 class="gallery-title">Product Showcase</h5>
                                                            <div class="gallery-subtitle">Product Photography</div>
                                                        </div>
                                                        <span class="gallery-status status-published">Published</span>
                                                    </div>
                                                    <p class="gallery-description">Professional product photography for a fashion brand showcasing their latest collection.</p>
                                                    <div class="gallery-list-footer">
                                                        <div class="d-flex align-items-center">
                                                            <span class="gallery-meta me-3">
                                                                <i class="bi bi-images me-1"></i> 42 photos
                                                            </span>
                                                            <span class="gallery-meta">
                                                                <i class="bi bi-calendar3 me-1"></i> Jul 12, 2023
                                                            </span>
                                                        </div>
                                                        <a href="${pageContext.request.contextPath}/gallery/gallery_details.jsp?id=g006" class="btn btn-sm btn-outline-custom">View Gallery</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Empty State (hidden when there are galleries) -->
                                        <div class="empty-state" style="display: none;">
                                            <i class="bi bi-images empty-state-icon"></i>
                                            <h4>No Galleries Found</h4>
                                            <p class="text-muted">There are no galleries matching your search criteria.</p>

                                            <c:if test="${sessionScope.userType == 'photographer'}">
                                                <div class="mt-4">
                                                    <a href="${pageContext.request.contextPath}/gallery/upload_form.jsp" class="btn btn-primary-custom">
                                                        <i class="bi bi-plus-circle me-2"></i>Create Your First Gallery
                                                    </a>
                                                </div>
                                            </c:if>
                                        </div>

                                        <!-- Pagination -->
                                        <nav aria-label="Gallery pagination" class="pagination-custom">
                                            <ul class="pagination">
                                                <li class="page-item disabled">
                                                    <a class="page-link" href="#" aria-label="Previous">
                                                        <i class="bi bi-chevron-left"></i>
                                                    </a>
                                                </li>
                                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                <li class="page-item">
                                                    <a class="page-link" href="#" aria-label="Next">
                                                        <i class="bi bi-chevron-right"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>

                                    <!-- Include Footer -->
                                    <jsp:include page="/includes/footer.jsp" />

                                    <!-- Bootstrap Bundle with Popper -->
                                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                                    <script>
                                        document.addEventListener('DOMContentLoaded', function() {
                                            // View Toggle
                                            const gridViewBtn = document.getElementById('gridViewBtn');
                                            const listViewBtn = document.getElementById('listViewBtn');
                                            const gridView = document.getElementById('gridView');
                                            const listView = document.getElementById('listView');

                                            gridViewBtn.addEventListener('click', function() {
                                                gridViewBtn.classList.add('active');
                                                listViewBtn.classList.remove('active');
                                                gridView.classList.add('active');
                                                listView.classList.remove('active');

                                                // Save preference in localStorage
                                                localStorage.setItem('galleryViewPreference', 'grid');
                                            });

                                            listViewBtn.addEventListener('click', function() {
                                                listViewBtn.classList.add('active');
                                                gridViewBtn.classList.remove('active');
                                                listView.classList.add('active');
                                                gridView.classList.remove('active');

                                                // Save preference in localStorage
                                                localStorage.setItem('galleryViewPreference', 'list');
                                            });

                                            // Check if user has a saved preference
                                            const viewPreference = localStorage.getItem('galleryViewPreference');
                                            if (viewPreference === 'list') {
                                                listViewBtn.click();
                                            }

                                            // Handle Search
                                            const searchInput = document.getElementById('searchGallery');
                                            const categoryFilter = document.getElementById('categoryFilter');
                                            const sortFilter = document.getElementById('sortGalleries');

                                            function filterGalleries() {
                                                const searchTerm = searchInput.value.toLowerCase();
                                                const categoryValue = categoryFilter.value;
                                                const sortValue = sortFilter.value;

                                                // Get all gallery cards and list items
                                                const galleryCards = document.querySelectorAll('.gallery-card');
                                                const galleryListItems = document.querySelectorAll('.gallery-list-item');

                                                // Arrays to track visible galleries for each view
                                                let visibleGridGalleries = 0;
                                                let visibleListGalleries = 0;

                                                // Filter function for both views
                                                function isGalleryVisible(galleryTitle, gallerySubtitle) {
                                                    // Search term filter
                                                    const titleMatches = galleryTitle.toLowerCase().includes(searchTerm);
                                                    const subtitleMatches = gallerySubtitle.toLowerCase().includes(searchTerm);
                                                    const searchMatches = titleMatches || subtitleMatches;

                                                    // Category filter
                                                    const categoryMatches = categoryValue === '' ||
                                                        gallerySubtitle.toUpperCase().includes(categoryValue);

                                                    return searchMatches && categoryMatches;
                                                }

                                                // Filter grid view galleries
                                                galleryCards.forEach(function(card) {
                                                    const galleryTitle = card.querySelector('.gallery-title').textContent;
                                                    const gallerySubtitle = card.querySelector('.gallery-subtitle').textContent;

                                                    if (isGalleryVisible(galleryTitle, gallerySubtitle)) {
                                                        card.style.display = 'flex';
                                                        visibleGridGalleries++;
                                                    } else {
                                                        card.style.display = 'none';
                                                    }
                                                });

                                                // Filter list view galleries
                                                galleryListItems.forEach(function(item) {
                                                    const galleryTitle = item.querySelector('.gallery-title').textContent;
                                                    const gallerySubtitle = item.querySelector('.gallery-subtitle').textContent;

                                                    if (isGalleryVisible(galleryTitle, gallerySubtitle)) {
                                                        item.style.display = 'flex';
                                                        visibleListGalleries++;
                                                    } else {
                                                        item.style.display = 'none';
                                                    }
                                                });

                                                // Show/hide empty state
                                                const emptyState = document.querySelector('.empty-state');
                                                if (visibleGridGalleries === 0 && visibleListGalleries === 0) {
                                                    emptyState.style.display = 'block';
                                                    document.querySelector('.pagination-custom').style.display = 'none';
                                                } else {
                                                    emptyState.style.display = 'none';
                                                    document.querySelector('.pagination-custom').style.display = 'flex';
                                                }

                                                // Sort galleries
                                                sortGalleries(sortValue);
                                            }

                                            // Sort function for galleries
                                            function sortGalleries(sortValue) {
                                                const gridParent = document.querySelector('.gallery-grid');
                                                const listParent = document.querySelector('#listView');

                                                // Sort cards in grid view
                                                const gridCards = Array.from(document.querySelectorAll('.gallery-card'));
                                                // Sort list items in list view
                                                const listItems = Array.from(document.querySelectorAll('.gallery-list-item'));

                                                function getSortComparator(sortVal) {
                                                    return function(a, b) {
                                                        const titleA = a.querySelector('.gallery-title').textContent;
                                                        const titleB = b.querySelector('.gallery-title').textContent;

                                                        // Get dates (this is a simplified example - in real app would use actual date objects)
                                                        // For demo, assuming dates are in the format "MMM DD, YYYY" in the gallery-meta
                                                        const dateTextA = a.querySelector('.gallery-meta:last-child') ?
                                                            a.querySelector('.gallery-meta:last-child').textContent : "";
                                                        const dateTextB = b.querySelector('.gallery-meta:last-child') ?
                                                            b.querySelector('.gallery-meta:last-child').textContent : "";

                                                        switch(sortVal) {
                                                            case 'name-asc':
                                                                return titleA.localeCompare(titleB);
                                                            case 'name-desc':
                                                                return titleB.localeCompare(titleA);
                                                            case 'date-asc':
                                                                // Simple string comparison for demo
                                                                return dateTextA.localeCompare(dateTextB);
                                                            case 'date-desc':
                                                            default:
                                                                // Simple string comparison for demo
                                                                return dateTextB.localeCompare(dateTextA);
                                                        }
                                                    };
                                                }

                                                // Apply sorting
                                                const sortComparator = getSortComparator(sortValue);

                                                // Sort and reattach grid cards
                                                gridCards
                                                    .filter(card => card.style.display !== 'none')
                                                    .sort(sortComparator)
                                                    .forEach(card => gridParent.appendChild(card));

                                                // Sort and reattach list items
                                                listItems
                                                    .filter(item => item.style.display !== 'none')
                                                    .sort(sortComparator)
                                                    .forEach(item => listParent.appendChild(item));
                                            }

                                            // Add event listeners for search and filter changes
                                            searchInput.addEventListener('input', filterGalleries);
                                            categoryFilter.addEventListener('change', filterGalleries);
                                            sortFilter.addEventListener('change', filterGalleries);

                                            // Initial filtering to set up proper state
                                            filterGalleries();
                                        });
                                    </script>
                                </body>
                                </html>