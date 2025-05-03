<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.photobooking.model.photographer.PhotographerManager" %>
<%@ page import="com.photobooking.model.photographer.Photographer" %>
<%@ page import="com.photobooking.model.photographer.PhotographerServiceManager" %>
<%@ page import="com.photobooking.model.photographer.PhotographerService" %>
<%@ page import="java.util.List" %>

<%
    String photographerId = request.getParameter("photographerId");
    String serviceId = request.getParameter("packageId");

    PhotographerManager photographerManager = new PhotographerManager();
    PhotographerServiceManager serviceManager = new PhotographerServiceManager();

    Photographer photographer = null;
    List<Photographer> allPhotographers = photographerManager.getAllPhotographers();
    List<PhotographerService> services = null;
    PhotographerService selectedService = null;

    if (photographerId != null) {
        photographer = photographerManager.getPhotographerById(photographerId);
        if (photographer != null) {
            services = serviceManager.getActiveServicesByPhotographer(photographerId);
        }
    }

    if (serviceId != null && services != null) {
        for (PhotographerService service : services) {
            if (service.getServiceId().equals(serviceId)) {
                selectedService = service;
                break;
            }
        }
    }

    request.setAttribute("allPhotographers", allPhotographers);
    request.setAttribute("selectedPhotographer", photographer);
    request.setAttribute("services", services);
    request.setAttribute("selectedService", selectedService);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Photography Session - SnapEvent</title>

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

        <div class="row">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Book Photography Session</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/booking/create" method="post">
                            <!-- Photographer Selection -->
                            <div class="mb-3">
                                <label for="photographerId" class="form-label">Select Photographer</label>
                                <select class="form-select" id="photographerId" name="photographerId" required>
                                    <option value="" disabled ${empty selectedPhotographer ? 'selected' : ''}>
                                        Select a photographer...
                                    </option>
                                    <c:forEach var="photo" items="${allPhotographers}">
                                        <option value="${photo.photographerId}"
                                            ${selectedPhotographer != null && photo.photographerId == selectedPhotographer.photographerId ? 'selected' : ''}>
                                            ${photo.businessName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Package Selection -->
                            <div class="mb-3">
                                <label for="packageId" class="form-label">Select Package</label>
                                <select class="form-select" id="packageId" name="packageId" required>
                                    <option value="" disabled ${empty selectedService ? 'selected' : ''}>
                                        Select a package...
                                    </option>
                                    <c:forEach var="service" items="${services}">
                                        <option value="${service.serviceId}"
                                            ${selectedService != null && service.serviceId == selectedService.serviceId ? 'selected' : ''}>
                                            ${service.name} - $${service.price}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Event Details -->
                            <div class="mb-3">
                                <label for="eventDate" class="form-label">Event Date</label>
                                <input type="date" class="form-control" id="eventDate" name="eventDate" required min="<%= java.time.LocalDate.now().plusDays(1) %>">
                            </div>

                            <div class="mb-3">
                                <label for="startTime" class="form-label">Start Time</label>
                                <input type="time" class="form-control" id="startTime" name="startTime" required>
                            </div>

                            <div class="mb-3">
                                <label for="eventLocation" class="form-label">Event Location</label>
                                <input type="text" class="form-control" id="eventLocation" name="eventLocation" required>
                            </div>

                            <div class="mb-3">
                                <label for="eventType" class="form-label">Event Type</label>
                                <select class="form-select" id="eventType" name="eventType" required>
                                    <option value="" selected disabled>Select event type</option>
                                    <option value="WEDDING">Wedding</option>
                                    <option value="CORPORATE">Corporate Event</option>
                                    <option value="PORTRAIT">Portrait Session</option>
                                    <option value="EVENT">General Event</option>
                                    <option value="FAMILY">Family Session</option>
                                    <option value="PRODUCT">Product Photography</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="eventNotes" class="form-label">Special Requirements/Notes</label>
                                <textarea class="form-control" id="eventNotes" name="eventNotes" rows="3"></textarea>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Book Session</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <c:if test="${not empty selectedPhotographer}">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="card-title">Photographer Details</h5>
                        </div>
                        <div class="card-body">
                            <h6 class="card-title">${selectedPhotographer.businessName}</h6>
                            <p class="card-text">${selectedPhotographer.location}</p>
                            <p class="card-text">Rating: ${selectedPhotographer.rating} ⭐</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty selectedService}">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">Package Details</h5>
                        </div>
                        <div class="card-body">
                            <h6 class="card-title">${selectedService.name}</h6>
                            <p class="card-text">${selectedService.description}</p>
                            <p class="card-text">
                                <strong>Price:</strong> $${selectedService.price}<br>
                                <strong>Duration:</strong> ${selectedService.durationHours} hours<br>
                                <strong>Deliverables:</strong> ${selectedService.deliverables}
                            </p>
                            <h6>Package Includes:</h6>
                            <ul>
                                <c:forEach var="feature" items="${selectedService.features}">
                                    <li>${feature}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Update packages when photographer is selected
        document.getElementById('photographerId').addEventListener('change', function() {
            const params = new URLSearchParams(window.location.search);
            params.set('photographerId', this.value);
            window.location.search = params.toString();
        });
    </script>
</body>
</html>