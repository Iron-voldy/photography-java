<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Footer -->
<footer class="footer bg-dark text-light mt-5 py-5">
    <div class="container">
        <div class="row">
            <!-- Logo and About -->
            <div class="col-lg-4 mb-4 mb-lg-0">
                <div class="d-flex align-items-center mb-3">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="SnapEvent" width="40" height="40" class="me-2">
                    <h5 class="m-0">SnapEvent</h5>
                </div>
                <p class="text-light-emphasis">
                    Capturing your special moments with professional photography services.
                    Whether it's a wedding, corporate event, or casual photoshoot, we connect
                    you with the perfect photographer for your occasion.
                </p>
                <div class="social-icons">
                    <a href="#" class="text-light me-3"><i class="bi bi-facebook fs-5"></i></a>
                    <a href="#" class="text-light me-3"><i class="bi bi-instagram fs-5"></i></a>
                    <a href="#" class="text-light me-3"><i class="bi bi-twitter fs-5"></i></a>
                    <a href="#" class="text-light"><i class="bi bi-linkedin fs-5"></i></a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                <h5 class="text-uppercase mb-4">Quick Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/" class="text-light-emphasis text-decoration-none">Home</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/about.jsp" class="text-light-emphasis text-decoration-none">About Us</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services.jsp" class="text-light-emphasis text-decoration-none">Services</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/gallery/gallery_list.jsp" class="text-light-emphasis text-decoration-none">Galleries</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/contact.jsp" class="text-light-emphasis text-decoration-none">Contact</a></li>
                </ul>
            </div>

            <!-- Services -->
            <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                <h5 class="text-uppercase mb-4">Services</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/wedding.jsp" class="text-light-emphasis text-decoration-none">Wedding Photography</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/corporate.jsp" class="text-light-emphasis text-decoration-none">Corporate Events</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/portrait.jsp" class="text-light-emphasis text-decoration-none">Portrait Sessions</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/family.jsp" class="text-light-emphasis text-decoration-none">Family Photography</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/services/special.jsp" class="text-light-emphasis text-decoration-none">Special Occasions</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="col-lg-4">
                <h5 class="text-uppercase mb-4">Contact Us</h5>
                <ul class="list-unstyled">
                    <li class="mb-3">
                        <i class="bi bi-geo-alt-fill text-primary me-2"></i>
                        123 Photography Lane, Creative City, PC 12345
                    </li>
                    <li class="mb-3">
                        <i class="bi bi-telephone-fill text-primary me-2"></i>
                        +1 (555) 123-4567
                    </li>
                    <li class="mb-3">
                        <i class="bi bi-envelope-fill text-primary me-2"></i>
                        info@snapevent.com
                    </li>
                    <li class="mb-3">
                        <i class="bi bi-clock-fill text-primary me-2"></i>
                        Monday - Friday: 9:00 AM - 6:00 PM
                    </li>
                </ul>

                <!-- Newsletter Signup -->
                <div class="mt-4">
                    <h6>Subscribe to our newsletter</h6>
                    <form class="d-flex">
                        <input type="email" class="form-control form-control-sm me-2" placeholder="Your email">
                        <button type="submit" class="btn btn-outline-light btn-sm">Subscribe</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Copyright -->
        <div class="row mt-4 pt-4 border-top border-secondary">
            <div class="col-md-6 text-center text-md-start">
                <p class="small text-light-emphasis">© 2023 SnapEvent. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <ul class="list-inline small mb-0">
                    <li class="list-inline-item"><a href="${pageContext.request.contextPath}/privacy.jsp" class="text-light-emphasis text-decoration-none">Privacy Policy</a></li>
                    <li class="list-inline-item"><span class="text-muted mx-2">|</span></li>
                    <li class="list-inline-item"><a href="${pageContext.request.contextPath}/terms.jsp" class="text-light-emphasis text-decoration-none">Terms of Service</a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<!-- Toast container for notifications -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <i class="bi bi-info-circle-fill me-2"></i>
            <strong class="me-auto">Notification</strong>
            <small>Just now</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <!-- Message will be inserted here -->
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>