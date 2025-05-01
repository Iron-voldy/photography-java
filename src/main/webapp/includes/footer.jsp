<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Footer -->
<footer class="bg-dark text-white py-5 mt-5">
    <div class="container">
        <div class="row g-4">
            <!-- Company Info -->
            <div class="col-lg-4">
                <h5 class="mb-4"><i class="bi bi-camera me-2"></i>SnapEvent</h5>
                <p class="mb-3">Professional photography services for all your special moments. We connect clients with talented photographers for weddings, events, portraits, and more.</p>
                <div class="d-flex gap-3 social-icons">
                    <a href="#" class="text-white"><i class="bi bi-facebook fs-5"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-instagram fs-5"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-twitter fs-5"></i></a>
                    <a href="#" class="text-white"><i class="bi bi-linkedin fs-5"></i></a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-lg-2 col-md-4">
                <h6 class="mb-3">Quick Links</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-white-50 hover-white">Home</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/photographer/photographer_list.jsp" class="text-decoration-none text-white-50 hover-white">Photographers</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/gallery/gallery_list.jsp" class="text-decoration-none text-white-50 hover-white">Galleries</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/about.jsp" class="text-decoration-none text-white-50 hover-white">About Us</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/contact.jsp" class="text-decoration-none text-white-50 hover-white">Contact</a></li>
                </ul>
            </div>

            <!-- Services -->
            <div class="col-lg-2 col-md-4">
                <h6 class="mb-3">Services</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/wedding.jsp" class="text-decoration-none text-white-50 hover-white">Wedding Photography</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/portrait.jsp" class="text-decoration-none text-white-50 hover-white">Portrait Sessions</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/event.jsp" class="text-decoration-none text-white-50 hover-white">Event Coverage</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/corporate.jsp" class="text-decoration-none text-white-50 hover-white">Corporate Photography</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/family.jsp" class="text-decoration-none text-white-50 hover-white">Family Sessions</a></li>
                </ul>
            </div>

            <!-- Support -->
            <div class="col-lg-2 col-md-4">
                <h6 class="mb-3">Support</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/help/faq.jsp" class="text-decoration-none text-white-50 hover-white">FAQ</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/help/pricing.jsp" class="text-decoration-none text-white-50 hover-white">Pricing</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/help/terms.jsp" class="text-decoration-none text-white-50 hover-white">Terms of Service</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/help/privacy.jsp" class="text-decoration-none text-white-50 hover-white">Privacy Policy</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/help/contact.jsp" class="text-decoration-none text-white-50 hover-white">Contact Support</a></li>
                </ul>
            </div>

            <!-- Contact -->
            <div class="col-lg-2 col-md-4">
                <h6 class="mb-3">Contact Us</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="bi bi-geo-alt me-2"></i>123 Photography St, City</li>
                    <li class="mb-2"><i class="bi bi-telephone me-2"></i>(123) 456-7890</li>
                    <li class="mb-2"><i class="bi bi-envelope me-2"></i>info@snapevent.com</li>
                </ul>
            </div>
        </div>

        <hr class="my-4 bg-light">

        <!-- Copyright -->
        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0">&copy; 2025 SnapEvent. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <p class="mb-0">Designed and developed by <a href="#" class="text-white">Your Team Name</a></p>
            </div>
        </div>
    </div>
</footer>

<!-- Custom CSS for hover effects -->
<style>
    .hover-white:hover {
        color: white !important;
        transition: color 0.3s ease;
    }

    .social-icons a {
        transition: transform 0.3s ease;
        display: inline-block;
    }

    .social-icons a:hover {
        transform: translateY(-3px);
    }
</style>