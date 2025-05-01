<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Error Messages -->
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        <strong>Error:</strong> ${errorMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="errorMessage" scope="session" />
</c:if>

<!-- Success Messages -->
<c:if test="${not empty successMessage}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>
        <strong>Success:</strong> ${successMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="successMessage" scope="session" />
</c:if>

<!-- Info Messages -->
<c:if test="${not empty infoMessage}">
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <i class="bi bi-info-circle-fill me-2"></i>
        <strong>Information:</strong> ${infoMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="infoMessage" scope="session" />
</c:if>

<!-- Warning Messages -->
<c:if test="${not empty warningMessage}">
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-circle-fill me-2"></i>
        <strong>Warning:</strong> ${warningMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="warningMessage" scope="session" />
</c:if>

<!-- Custom Messages -->
<c:if test="${not empty customMessage}">
    <div class="alert alert-${customMessageType} alert-dismissible fade show" role="alert">
        <c:choose>
            <c:when test="${customMessageType eq 'success'}">
                <i class="bi bi-check-circle-fill me-2"></i>
            </c:when>
            <c:when test="${customMessageType eq 'danger'}">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
            </c:when>
            <c:when test="${customMessageType eq 'warning'}">
                <i class="bi bi-exclamation-circle-fill me-2"></i>
            </c:when>
            <c:when test="${customMessageType eq 'info'}">
                <i class="bi bi-info-circle-fill me-2"></i>
            </c:when>
        </c:choose>
        ${customMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="customMessage" scope="session" />
    <c:remove var="customMessageType" scope="session" />
</c:if>

<!-- Toast Container for JS-based notifications -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1050">
    <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <i id="toastIcon" class="bi me-2"></i>
            <strong class="me-auto" id="toastTitle">Notification</strong>
            <small id="toastTime">Just now</small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toastMessage">
            <!-- Dynamic message will be inserted here via JavaScript -->
        </div>
    </div>
</div>

<script>
// JavaScript function to show toast notifications
function showToast(message, type = 'info', title = 'Notification') {
    const toast = document.getElementById('liveToast');
    const toastMessage = document.getElementById('toastMessage');
    const toastTitle = document.getElementById('toastTitle');
    const toastIcon = document.getElementById('toastIcon');
    const toastTime = document.getElementById('toastTime');

    // Set toast content
    toastMessage.textContent = message;
    toastTitle.textContent = title;
    toastTime.textContent = 'Just now';

    // Set toast appearance based on type
    toast.classList.remove('bg-success', 'bg-danger', 'bg-warning', 'bg-info');
    toastIcon.classList.remove('bi-check-circle-fill', 'bi-exclamation-triangle-fill',
                              'bi-exclamation-circle-fill', 'bi-info-circle-fill');

    switch(type) {
        case 'success':
            toastIcon.classList.add('bi-check-circle-fill');
            toastIcon.style.color = '#198754';
            break;
        case 'danger':
        case 'error':
            toastIcon.classList.add('bi-exclamation-triangle-fill');
            toastIcon.style.color = '#dc3545';
            break;
        case 'warning':
            toastIcon.classList.add('bi-exclamation-circle-fill');
            toastIcon.style.color = '#ffc107';
            break;
        case 'info':
        default:
            toastIcon.classList.add('bi-info-circle-fill');
            toastIcon.style.color = '#0dcaf0';
            break;
    }

    // Show the toast
    const bsToast = new bootstrap.Toast(toast);
    bsToast.show();
}
</script>