<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Management - SnapEvent</title>

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

        .service-management-container {
            padding: 20px;
        }

        .section-header {
            background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .content-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
        }

        .card-header-custom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }

        .card-title-custom {
            font-weight: 600;
            color: #4361ee;
            margin-bottom: 0;
        }

        .service-card {
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            position: relative;
        }

        .service-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .service-actions {
            position: absolute;
            top: 15px;
            right: 15px;
            display: flex;
            gap: 5px;
        }

        .service-price {
            font-size: 1.5rem;
            font-weight: 600;
            color: #4361ee;
            margin-bottom: 10px;
        }

        .service-description {
            color: #6c757d;
            margin-bottom: 15px;
        }

        .service-detail {
            margin-bottom: 5px;
        }

        .service-status {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .badge-custom {
            font-size: 0.8rem;
            padding: 5px 10px;
            border-radius: 20px;
        }

        .addon-card {
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .addon-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .addon-name {
            font-weight: 500;
        }

        .addon-price {
            color: #4361ee;
            font-weight: 600;
        }

        .nav-link.active {
            background-color: #4361ee;
            color: white !important;
            border-radius: 0.25rem;
        }

        .btn-primary-custom {
            background-color: #4361ee;
            border-color: #4361ee;
        }

        .btn-primary-custom:hover {
            background-color: #3a56d4;
            border-color: #3a56d4;
        }

        .btn-outline-custom {
            color: #4361ee;
            border-color: #4361ee;
        }

        .btn-outline-custom:hover {
            background-color: #4361ee;
            color: white;
        }

        /* Package Features List */
        .package-features {
            margin-top: 15px;
            margin-bottom: 20px;
        }

        .package-features ul {
            padding-left: 20px;
            list-style-type: none;
        }

        .package-features ul li {
            position: relative;
            padding-left: 25px;
            margin-bottom: 8px;
        }

        .package-features ul li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #4361ee;
            font-weight: bold;
        }

        /* Modal styles */
        .modal-style .modal-header {
            background-color: #4361ee;
            color: white;
        }

        .modal-style .modal-header .btn-close {
            color: white;
            opacity: 1;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <!-- Include Sidebar with "services" as active page -->
            <c:set var="activePage" value="services" scope="request"/>
            <jsp:include page="/includes/sidebar.jsp" />

            <!-- Main Content Area -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="service-management-container">
                    <!-- Include Messages for notifications -->
                    <jsp:include page="/includes/messages.jsp" />

                    <!-- Section Header -->
                    <div class="section-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h1 class="h3 mb-0">Service Management</h1>
                                <p class="mb-0">Create and manage your photography service packages</p>
                            </div>
                            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                                <i class="bi bi-plus-circle me-2"></i>Add New Package
                            </button>
                        </div>
                    </div>

                    <!-- Main Content Section -->
                    <div class="row g-4">
                        <!-- Service Packages Column -->
                        <div class="col-lg-8">
                            <div class="content-card">
                                <div class="card-header-custom">
                                    <h5 class="card-title-custom">
                                        <i class="bi bi-camera me-2"></i>Your Service Packages
                                    </h5>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                            <i class="bi bi-funnel me-1"></i>Filter
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="filterDropdown">
                                            <li><a class="dropdown-item" href="#">All Packages</a></li>
                                            <li><a class="dropdown-item" href="#">Active Packages</a></li>
                                            <li><a class="dropdown-item" href="#">Inactive Packages</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="#">Wedding</a></li>
                                            <li><a class="dropdown-item" href="#">Portrait</a></li>
                                            <li><a class="dropdown-item" href="#">Event</a></li>
                                            <li><a class="dropdown-item" href="#">Corporate</a></li>
                                        </ul>
                                    </div>
                                </div>

                                <!-- Package List -->
                                <div class="service-list">
                                    <!-- Silver Wedding Package -->
                                    <div class="service-card">
                                        <div class="service-actions">
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editServiceModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteServiceModal">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                        <h5>Silver Wedding Package</h5>
                                        <div class="service-price">$1,800</div>
                                        <div class="badge bg-success badge-custom">Active</div>
                                        <p class="service-description">Basic wedding coverage with essential services for couples on a budget.</p>
                                        <div class="service-detail"><i class="bi bi-tag me-2"></i><strong>Category:</strong> Wedding</div>
                                        <div class="service-detail"><i class="bi bi-clock me-2"></i><strong>Duration:</strong> 6 hours</div>
                                        <div class="service-detail"><i class="bi bi-camera me-2"></i><strong>Photographers:</strong> 2</div>
                                        <div class="service-detail"><i class="bi bi-image me-2"></i><strong>Deliverables:</strong> 100+ edited digital images</div>
                                        <div class="service-detail"><i class="bi bi-calendar-check me-2"></i><strong>Bookings:</strong> 12 times booked</div>

                                        <div class="package-features">
                                            <h6>Package Includes:</h6>
                                            <ul>
                                                <li>6 hours of coverage</li>
                                                <li>Two photographers</li>
                                                <li>Online gallery with digital downloads</li>
                                                <li>Engagement session (1 hour)</li>
                                                <li>100+ edited digital images</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Gold Wedding Package -->
                                    <div class="service-card">
                                        <div class="service-actions">
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editServiceModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteServiceModal">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                        <h5>Gold Wedding Package</h5>
                                        <div class="service-price">$2,800</div>
                                        <div class="badge bg-success badge-custom">Active</div>
                                        <p class="service-description">Comprehensive wedding coverage with premium features for a complete experience.</p>
                                        <div class="service-detail"><i class="bi bi-tag me-2"></i><strong>Category:</strong> Wedding</div>
                                        <div class="service-detail"><i class="bi bi-clock me-2"></i><strong>Duration:</strong> 10 hours</div>
                                        <div class="service-detail"><i class="bi bi-camera me-2"></i><strong>Photographers:</strong> 2</div>
                                        <div class="service-detail"><i class="bi bi-image me-2"></i><strong>Deliverables:</strong> 300+ edited digital images, Wedding album</div>
                                        <div class="service-detail"><i class="bi bi-calendar-check me-2"></i><strong>Bookings:</strong> 8 times booked</div>

                                        <div class="package-features">
                                            <h6>Package Includes:</h6>
                                            <ul>
                                                <li>10 hours of coverage</li>
                                                <li>Two photographers</li>
                                                <li>Online gallery with digital downloads</li>
                                                <li>Engagement session (2 hours)</li>
                                                <li>300+ edited digital images</li>
                                                <li>Wedding album (10x10, 30 pages)</li>
                                                <li>Two parent albums (8x8, 20 pages)</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Portrait Session Package -->
                                    <div class="service-card">
                                        <div class="service-actions">
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editServiceModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteServiceModal">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                        <h5>Portrait Session</h5>
                                        <div class="service-price">$350</div>
                                        <div class="badge bg-success badge-custom">Active</div>
                                        <p class="service-description">Professional portrait photography session at a location of your choice.</p>
                                        <div class="service-detail"><i class="bi bi-tag me-2"></i><strong>Category:</strong> Portrait</div>
                                        <div class="service-detail"><i class="bi bi-clock me-2"></i><strong>Duration:</strong> 1 hour</div>
                                        <div class="service-detail"><i class="bi bi-camera me-2"></i><strong>Photographers:</strong> 1</div>
                                        <div class="service-detail"><i class="bi bi-image me-2"></i><strong>Deliverables:</strong> 25+ edited digital images</div>
                                        <div class="service-detail"><i class="bi bi-calendar-check me-2"></i><strong>Bookings:</strong> 17 times booked</div>

                                        <div class="package-features">
                                            <h6>Package Includes:</h6>
                                            <ul>
                                                <li>1-hour session at location of your choice</li>
                                                <li>Online gallery with digital downloads</li>
                                                <li>25+ edited digital images</li>
                                                <li>Print release</li>
                                                <li>One outfit change</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Corporate Event Package -->
                                    <div class="service-card">
                                        <div class="service-actions">
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editServiceModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteServiceModal">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                        <h5>Corporate Event Coverage</h5>
                                        <div class="service-price">$800</div>
                                        <div class="badge bg-secondary badge-custom">Inactive</div>
                                        <p class="service-description">Professional photography coverage for corporate events, conferences, and meetings.</p>
                                        <div class="service-detail"><i class="bi bi-tag me-2"></i><strong>Category:</strong> Corporate</div>
                                        <div class="service-detail"><i class="bi bi-clock me-2"></i><strong>Duration:</strong> 4 hours</div>
                                        <div class="service-detail"><i class="bi bi-camera me-2"></i><strong>Photographers:</strong> 1</div>
                                        <div class="service-detail"><i class="bi bi-image me-2"></i><strong>Deliverables:</strong> 100+ edited digital images</div>
                                        <div class="service-detail"><i class="bi bi-calendar-check me-2"></i><strong>Bookings:</strong> 5 times booked</div>

                                        <div class="package-features">
                                            <h6>Package Includes:</h6>
                                            <ul>
                                                <li>4 hours of coverage</li>
                                                <li>Online gallery with digital downloads</li>
                                                <li>100+ edited digital images</li>
                                                <li>Corporate usage rights</li>
                                                <li>Quick turnaround (3 business days)</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Add-ons & Info Column -->
                        <div class="col-lg-4">
                            <!-- Service Add-ons Card -->
                            <div class="content-card mb-4">
                                <div class="card-header-custom">
                                    <h5 class="card-title-custom">
                                        <i class="bi bi-plus-circle me-2"></i>Service Add-ons
                                    </h5>
                                    <button class="btn btn-sm btn-outline-custom" data-bs-toggle="modal" data-bs-target="#addAddonModal">
                                        <i class="bi bi-plus-lg me-1"></i>Add
                                    </button>
                                </div>
                                <div>
                                    <!-- Add-on 1 -->
                                    <div class="addon-card">
                                        <div>
                                            <div class="addon-name">Extra Coverage Hour</div>
                                            <div class="text-muted small">Additional hour of photography coverage</div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="addon-price me-3">$250</div>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="addon1Dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bi bi-three-dots-vertical"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="addon1Dropdown">
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editAddonModal"><i class="bi bi-pencil me-2"></i>Edit</a></li>
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#deleteAddonModal"><i class="bi bi-trash me-2"></i>Delete</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Add-on 2 -->
                                    <div class="addon-card">
                                        <div>
                                            <div class="addon-name">Second Photographer</div>
                                            <div class="text-muted small">Additional photographer for 6 hours</div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="addon-price me-3">$400</div>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="addon2Dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bi bi-three-dots-vertical"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="addon2Dropdown">
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editAddonModal"><i class="bi bi-pencil me-2"></i>Edit</a></li>
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#deleteAddonModal"><i class="bi bi-trash me-2"></i>Delete</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Add-on 3 -->
                                    <div class="addon-card">
                                        <div>
                                            <div class="addon-name">Engagement Session</div>
                                            <div class="text-muted small">1-hour pre-wedding photo session</div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="addon-price me-3">$350</div>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="addon3Dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bi bi-three-dots-vertical"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="addon3Dropdown">
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editAddonModal"><i class="bi bi-pencil me-2"></i>Edit</a></li>
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#deleteAddonModal"><i class="bi bi-trash me-2"></i>Delete</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Add-on 4 -->
                                    <div class="addon-card">
                                        <div>
                                            <div class="addon-name">Wedding Album</div>
                                            <div class="text-muted small">10x10, 30 pages, premium quality</div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="addon-price me-3">$600</div>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="addon4Dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bi bi-three-dots-vertical"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="addon4Dropdown">
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editAddonModal"><i class="bi bi-pencil me-2"></i>Edit</a></li>
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#deleteAddonModal"><i class="bi bi-trash me-2"></i>Delete</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Add-on 5 -->
                                    <div class="addon-card">
                                        <div>
                                            <div class="addon-name">Express Editing</div>
                                            <div class="text-muted small">3-day rush turnaround</div>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="addon-price me-3">$200</div>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="addon5Dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bi bi-three-dots-vertical"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="addon5Dropdown">
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editAddonModal"><i class="bi bi-pencil me-2"></i>Edit</a></li>
                                                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#deleteAddonModal"><i class="bi bi-trash me-2"></i>Delete</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Stats & Tips Card -->
                            <div class="content-card mb-4">
                                <div class="card-header-custom">
                                    <h5 class="card-title-custom">
                                        <i class="bi bi-graph-up me-2"></i>Service Stats
                                    </h5>
                                </div>
                                <div>
                                    <div class="mb-3">
                                        <h6>Most Popular Package</h6>
                                        <p class="mb-1">Portrait Session</p>
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-primary" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mt-2">
                                            <small>17 bookings</small>
                                            <small>75% of total</small>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <h6>Most Profitable Package</h6>
                                        <p class="mb-1">Gold Wedding Package</p>
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 60%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mt-2">
                                            <small>$22,400 revenue</small>
                                            <small>60% of total</small>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <h6>Top Add-on</h6>
                                        <p class="mb-1">Extra Coverage Hour</p>
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-info" role="progressbar" style="width: 45%;" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mt-2">
                                            <small>14 purchases</small>
                                            <small>45% of orders</small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tips Card -->
                            <div class="content-card">
                                <div class="card-header-custom">
                                    <h5 class="card-title-custom">
                                        <i class="bi bi-lightbulb me-2"></i>Tips for Effective Packages
                                    </h5>
                                </div>
                                <div>
                                    <ul class="mb-0">
                                        <li class="mb-2">Create packages at 3 different price points (good, better, best)</li>
                                        <li class="mb-2">Make your offerings clear and easy to understand</li>
                                        <li class="mb-2">Highlight what makes your packages unique</li>
                                        <li class="mb-2">Offer add-ons to make packages customizable</li>
                                        <li class="mb-2">Update prices seasonally for peak demand periods</li>
                                        <li>Include sample photos with each package description</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Add Service Modal -->
    <div class="modal fade modal-style" id="addServiceModal" tabindex="-1" aria-labelledby="addServiceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addServiceModalLabel">Add New Service Package</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addServiceForm" action="${pageContext.request.contextPath}/photographer/add-service" method="post">
                        <div class="row g-3">
                            <!-- Basic Information -->
                            <div class="col-md-8">
                                <label for="packageName" class="form-label">Package Name</label>
                                <input type="text" class="form-control" id="packageName" name="packageName" required>
                            </div>

                            <div class="col-md-4">
                                <label for="packageCategory" class="form-label">Category</label>
                                <select class="form-select" id="packageCategory" name="packageCategory" required>
                                    <option value="" selected disabled>Select category</option>
                                    <option value="WEDDING">Wedding</option>
                                    <option value="PORTRAIT">Portrait</option>
                                    <option value="EVENT">Event</option>
                                    <option value="CORPORATE">Corporate</option>
                                    <option value="FAMILY">Family</option>
                                    <option value="PRODUCT">Product</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </div>

                            <div class="col-md-12">
                                <label for="packageDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="packageDescription" name="packageDescription" rows="3" required></textarea>
                            </div>

                            <!-- Pricing & Duration -->
                            <div class="col-md-4">
                                <label for="packagePrice" class="form-label">Price ($)</label>
                                <input type="number" class="form-control" id="packagePrice" name="packagePrice" step="0.01" min="0" required>
                            </div>

                            <div class="col-md-4">
                                <label for="packageDuration" class="form-label">Duration (hours)</label>
                                <input type="number" class="form-control" id="packageDuration" name="packageDuration" min="1" required>
                            </div>

                            <div class="col-md-4">
                                <label for="packagePhotographers" class="form-label">Number of Photographers</label>
                                <input type="number" class="form-control" id="packagePhotographers" name="packagePhotographers" min="1" max="5" value="1" required>
                            </div>

                            <!-- Features Section -->
                            <div class="col-md-12">
                                <label class="form-label">Package Features</label>
                                <div class="form-text mb-2">Enter each feature on a new line</div>
                                <textarea class="form-control" id="packageFeatures" name="packageFeatures" rows="5" placeholder="e.g.
Online gallery with digital downloads
100+ edited digital images
Print release"></textarea>
                            </div>

                            <!-- Deliverables -->
                            <div class="col-md-12">
                                <label for="packageDeliverables" class="form-label">Deliverables</label>
                                <input type="text" class="form-control" id="packageDeliverables" name="packageDeliverables" placeholder="e.g. 100+ edited images, 1 album">
                            </div>

                            <!-- Status -->
                            <div class="col-md-12">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="packageActive" name="packageActive" checked>
                                    <label class="form-check-label" for="packageActive">Package Active</label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="addServiceForm" class="btn btn-primary-custom">Add Package</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Service Modal -->
    <div class="modal fade modal-style" id="editServiceModal" tabindex="-1" aria-labelledby="editServiceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editServiceModalLabel">Edit Service Package</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editServiceForm" action="${pageContext.request.contextPath}/photographer/update-service" method="post">
                        <input type="hidden" name="packageId" value="s001">
                        <div class="row g-3">
                            <!-- Basic Information -->
                            <div class="col-md-8">
                                <label for="editPackageName" class="form-label">Package Name</label>
                                <input type="text" class="form-control" id="editPackageName" name="packageName" value="Silver Wedding Package" required>
                            </div>

                            <div class="col-md-4">
                                <label for="editPackageCategory" class="form-label">Category</label>
                                <select class="form-select" id="editPackageCategory" name="packageCategory" required>
                                    <option value="" disabled>Select category</option>
                                    <option value="WEDDING" selected>Wedding</option>
                                    <option value="PORTRAIT">Portrait</option>
                                    <option value="EVENT">Event</option>
                                    <option value="CORPORATE">Corporate</option>
                                    <option value="FAMILY">Family</option>
                                    <option value="PRODUCT">Product</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </div>

                            <div class="col-md-12">
                                <label for="editPackageDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="editPackageDescription" name="packageDescription" rows="3" required>Basic wedding coverage with essential services for couples on a budget.</textarea>
                            </div>

                            <!-- Pricing & Duration -->
                            <div class="col-md-4">
                                <label for="editPackagePrice" class="form-label">Price ($)</label>
                                <input type="number" class="form-control" id="editPackagePrice" name="packagePrice" step="0.01" min="0" value="1800" required>
                            </div>

                            <div class="col-md-4">
                                <label for="editPackageDuration" class="form-label">Duration (hours)</label>
                                <input type="number" class="form-control" id="editPackageDuration" name="packageDuration" min="1" value="6" required>
                            </div>

                            <div class="col-md-4">
                                <label for="editPackagePhotographers" class="form-label">Number of Photographers</label>
                                <input type="number" class="form-control" id="editPackagePhotographers" name="packagePhotographers" min="1" max="5" value="2" required>
                            </div>

                            <!-- Features Section -->
                            <div class="col-md-12">
                                <label class="form-label">Package Features</label>
                                <div class="form-text mb-2">Enter each feature on a new line</div>
                                <textarea class="form-control" id="editPackageFeatures" name="packageFeatures" rows="5">6 hours of coverage
Two photographers
Online gallery with digital downloads
Engagement session (1 hour)
100+ edited digital images</textarea>
                            </div>

                            <!-- Deliverables -->
                            <div class="col-md-12">
                                <label for="editPackageDeliverables" class="form-label">Deliverables</label>
                                <input type="text" class="form-control" id="editPackageDeliverables" name="packageDeliverables" value="100+ edited digital images" placeholder="e.g. 100+ edited images, 1 album">
                            </div>

                            <!-- Status -->
                            <div class="col-md-12">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="editPackageActive" name="packageActive" checked>
                                    <label class="form-check-label" for="editPackageActive">Package Active</label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="editServiceForm" class="btn btn-primary-custom">Update Package</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Service Modal -->
    <div class="modal fade modal-style" id="deleteServiceModal" tabindex="-1" aria-labelledby="deleteServiceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteServiceModalLabel">Delete Service Package</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the <strong>Silver Wedding Package</strong>?</p>
                    <p class="text-danger">This action cannot be undone. This will permanently delete this package and remove it from client booking options.</p>

                    <div class="alert alert-warning">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <strong>Warning:</strong> This package has been booked 12 times. Deleting it will not affect existing bookings, but it will no longer be available for new bookings.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="${pageContext.request.contextPath}/photographer/delete-service" method="post">
                        <input type="hidden" name="packageId" value="s001">
                        <button type="submit" class="btn btn-danger">Delete Package</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Add-on Modal -->
    <div class="modal fade modal-style" id="addAddonModal" tabindex="-1" aria-labelledby="addAddonModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addAddonModalLabel">Add New Add-on</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addAddonForm" action="${pageContext.request.contextPath}/photographer/add-addon" method="post">
                        <div class="mb-3">
                            <label for="addonName" class="form-label">Add-on Name</label>
                            <input type="text" class="form-control" id="addonName" name="addonName" required>
                        </div>
                        <div class="mb-3">
                            <label for="addonDescription" class="form-label">Description</label>
                            <input type="text" class="form-control" id="addonDescription" name="addonDescription" required>
                        </div>
                        <div class="mb-3">
                            <label for="addonPrice" class="form-label">Price ($)</label>
                            <input type="number" class="form-control" id="addonPrice" name="addonPrice" step="0.01" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label for="addonApplicablePackages" class="form-label">Applicable To</label>
                            <select class="form-select" id="addonApplicablePackages" name="addonApplicablePackages" multiple>
                                <option value="all" selected>All Packages</option>
                                <option value="s001">Silver Wedding Package</option>
                                <option value="s002">Gold Wedding Package</option>
                                <option value="s003">Portrait Session</option>
                                <option value="s004">Corporate Event Coverage</option>
                            </select>
                            <div class="form-text">Hold Ctrl/Cmd to select multiple packages</div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="addAddonForm" class="btn btn-primary-custom">Add Add-on</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Add-on Modal -->
    <div class="modal fade modal-style" id="editAddonModal" tabindex="-1" aria-labelledby="editAddonModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAddonModalLabel">Edit Add-on</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editAddonForm" action="${pageContext.request.contextPath}/photographer/update-addon" method="post">
                        <input type="hidden" name="addonId" value="a001">
                        <div class="mb-3">
                            <label for="editAddonName" class="form-label">Add-on Name</label>
                            <input type="text" class="form-control" id="editAddonName" name="addonName" value="Extra Coverage Hour" required>
                        </div>
                        <div class="mb-3">
                            <label for="editAddonDescription" class="form-label">Description</label>
                            <input type="text" class="form-control" id="editAddonDescription" name="addonDescription" value="Additional hour of photography coverage" required>
                        </div>
                        <div class="mb-3">
                            <label for="editAddonPrice" class="form-label">Price ($)</label>
                            <input type="number" class="form-control" id="editAddonPrice" name="addonPrice" step="0.01" min="0" value="250" required>
                        </div>
                        <div class="mb-3">
                            <label for="editAddonApplicablePackages" class="form-label">Applicable To</label>
                            <select class="form-select" id="editAddonApplicablePackages" name="addonApplicablePackages" multiple>
                                <option value="all" selected>All Packages</option>
                                <option value="s001">Silver Wedding Package</option>
                                <option value="s002">Gold Wedding Package</option>
                                <option value="s003">Portrait Session</option>
                                <option value="s004">Corporate Event Coverage</option>
                            </select>
                            <div class="form-text">Hold Ctrl/Cmd to select multiple packages</div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="editAddonForm" class="btn btn-primary-custom">Update Add-on</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Add-on Modal -->
    <div class="modal fade modal-style" id="deleteAddonModal" tabindex="-1" aria-labelledby="deleteAddonModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteAddonModalLabel">Delete Add-on</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the <strong>Extra Coverage Hour</strong> add-on?</p>
                    <p class="text-danger">This action cannot be undone. Deleting this add-on will remove it from all packages.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="${pageContext.request.contextPath}/photographer/delete-addon" method="post">
                        <input type="hidden" name="addonId" value="a001">
                        <button type="submit" class="btn btn-danger">Delete Add-on</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>