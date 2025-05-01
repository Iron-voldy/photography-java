/**
 * Main JavaScript file for SnapEvent Photography System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap components
    initializeBootstrapComponents();

    // Initialize any custom components
    initializeCustomComponents();

    // Setup YouTube video handling
    setupYouTubeHandling();
});

/**
 * Initialize Bootstrap components
 */
function initializeBootstrapComponents() {
    // Initialize dropdowns
    var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
    dropdownElementList.forEach(function(dropdownToggleEl) {
        new bootstrap.Dropdown(dropdownToggleEl);
    });

    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.forEach(function(tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Initialize popovers
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    popoverTriggerList.forEach(function(popoverTriggerEl) {
        new bootstrap.Popover(popoverTriggerEl);
    });

    // Initialize toasts
    var toastElList = [].slice.call(document.querySelectorAll('.toast'));
    toastElList.forEach(function(toastEl) {
        new bootstrap.Toast(toastEl);
    });

    // Ensure dropdowns work on mobile
    document.addEventListener('click', function(e) {
        // Fix for iOS touch events
        if (e.target.classList.contains('dropdown-toggle') ||
            e.target.closest('.dropdown-toggle')) {
            e.preventDefault();
            var dropdown = e.target.closest('.dropdown');
            if (dropdown) {
                var dropdownToggle = dropdown.querySelector('.dropdown-toggle');
                var bsDropdown = bootstrap.Dropdown.getInstance(dropdownToggle);
                if (!bsDropdown) {
                    bsDropdown = new bootstrap.Dropdown(dropdownToggle);
                }
                bsDropdown.toggle();
            }
        }
    });
}

/**
 * Initialize custom components and event listeners
 */
function initializeCustomComponents() {
    // Toggle password visibility for password fields
    document.querySelectorAll('.toggle-password').forEach(function(button) {
        button.addEventListener('click', function() {
            const targetId = this.getAttribute('data-target') || this.previousElementSibling.id;
            const passwordField = document.getElementById(targetId);
            const icon = this.querySelector('i');

            if (passwordField) {
                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    if (icon) {
                        icon.classList.remove('bi-eye-slash');
                        icon.classList.add('bi-eye');
                    }
                } else {
                    passwordField.type = 'password';
                    if (icon) {
                        icon.classList.remove('bi-eye');
                        icon.classList.add('bi-eye-slash');
                    }
                }
            }
        });
    });

    // Enable form validation styles
    document.querySelectorAll('form').forEach(function(form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });
}

/**
 * Setup YouTube video handling to avoid tracking prevention issues
 */
function setupYouTubeHandling() {
    // Reset video modals on close
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('hidden.bs.modal', function() {
            const iframe = this.querySelector('iframe');
            if (iframe) {
                // Get video ID from the iframe src
                const videoIdMatch = iframe.src.match(/embed\/([^?]+)/);
                if (videoIdMatch && videoIdMatch[1]) {
                    const videoId = videoIdMatch[1];
                    const container = iframe.parentNode;

                    // Replace iframe with thumbnail and play button
                    container.innerHTML = `
                        <img src="https://img.youtube.com/vi/${videoId}/maxresdefault.jpg" alt="Video Thumbnail">
                        <div class="play-button" onclick="loadYoutubeVideo(this, '${videoId}')"></div>
                    `;
                }
            }
        });
    });

    // Global function to load YouTube videos
    window.loadYoutubeVideo = function(element, videoId) {
        const container = element.parentNode;
        const iframe = document.createElement('iframe');

        iframe.setAttribute('width', '100%');
        iframe.setAttribute('height', '100%');
        iframe.setAttribute('frameborder', '0');
        iframe.setAttribute('allowfullscreen', '1');
        iframe.setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture');

        // Use privacy-enhanced mode URL
        iframe.setAttribute('src', `https://www.youtube-nocookie.com/embed/${videoId}?autoplay=1&rel=0`);

        // Replace the container content with iframe
        container.innerHTML = '';
        container.appendChild(iframe);
    };
}

/**
 * Show a toast notification
 * @param {string} message - The message to display
 * @param {string} type - The type of toast (success, danger, warning, info)
 * @param {string} title - Optional title for the toast
 */
function showToast(message, type = 'info', title = 'Notification') {
    const toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) return;

    const toast = document.getElementById('liveToast');
    if (!toast) return;

    const toastBody = toast.querySelector('.toast-body');
    const toastTitle = toast.querySelector('.me-auto');
    const toastIcon = toast.querySelector('.bi');

    // Set toast content
    if (toastBody) toastBody.textContent = message;
    if (toastTitle) toastTitle.textContent = title;

    // Set toast type
    toast.className = 'toast';
    toastIcon.className = 'bi';

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