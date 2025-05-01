<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - SnapEvent</title>

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
            --profile-border: 4px solid #fff;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f2f5;
            color: var(--text-color);
        }

        .profile-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            padding: 3rem 0;
            color: white;
            position: relative;
            overflow: hidden;
            border-radius: 0 0 20px 20px;
            box-shadow: var(--card-shadow);
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0) 60%);
            transform: rotate(30deg);
        }

        .profile-avatar-container {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .profile-avatar {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            border: var(--profile-border);
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
        }

        .upload-avatar {
            position: absolute;
            bottom: 0;
            right: 0;
            background-color: var(--primary-color);
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .upload-avatar:hover {
            background-color: var(--primary-hover);
            transform: scale(1.1);
        }

        .profile-name {
            font-weight: 600;
            font-size: 1.8rem;
            margin-bottom: 0.3rem;
        }

        .profile-username {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 1rem;
        }

        .profile-stats {
            margin-top: 1.5rem;
            display: flex;
            justify-content: center;
            gap: 2rem;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 600;
        }

        .stat-label {
            font-size: 0.85rem;
            opacity: 0.8;
        }

        .profile-card {
            background-color: white;
            border-radius: 15px;
            margin-top: -30px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: none;
            position: relative;
            z-index: 2;
        }

        .profile-nav {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .profile-nav-item {
            background-color: var(--light-bg);
            color: var(--text-color);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .profile-nav-item:hover, .profile-nav-item.active {
            background-color: var(--primary-color);
            color: white;
        }

        .profile-nav-item i {
            font-size: 1.2rem;
        }

        .section-title {
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 0.5rem;
            display: inline-block;
        }

        .form-floating > label {
            font-weight: 500;
            color: var(--text-muted);
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            background-color: white;
            font-size: 1rem;
            min-height: 3.5rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

        .form-floating > .form-control {
            padding-top: 1.625rem;
            padding-bottom: 0.625rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .btn-danger {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-danger:hover {
            background-color: #e02071;
            border-color: #e02071;
        }

        .btn-outline-secondary {
            border-color: var(--border-color);
            color: var(--text-muted);
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
        }

        .btn-outline-secondary:hover {
            background-color: var(--light-bg);
            color: var(--text-color);
        }

        /* Password strength meter */
        .password-strength-meter {
            height: 6px;
            background-color: #e0e0e0;
            border-radius: 3px;
            margin-top: 8px;
            display: flex;
            overflow: hidden;
        }

        .password-strength-meter div {
            height: 100%;
            width: 25%;
            transition: all 0.3s ease;
        }

        .strength-weak { background-color: #ff4757; }
        .strength-fair { background-color: #ffa502; }
        .strength-good { background-color: #2ed573; }
        .strength-strong { background-color: #1e90ff; }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            color: var(--text-muted);
            cursor: pointer;
            z-index: 10;
        }

        .toggle-password:hover {
            color: var(--primary-color);
        }

        .user-badge {
            display: inline-block;
            padding: 0.35em 0.8em;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .badge-client {
            background-color: var(--primary-color);
            color: white;
        }

        .badge-photographer {
            background-color: var(--secondary-color);
            color: white;
        }

        .badge-admin {
            background-color: var(--accent-color);
            color: white;
        }

        @media (max-width: 768px) {
            .profile-stats {
                gap: 1rem;
            }

            .profile-nav-item {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .profile-card {
                padding: 1.5rem;
            }
        }

        /* Animation classes */
        .fade-in {
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container fade-in">
        <!-- Profile Header -->
        <div class="profile-header text-center mb-4">
            <div class="container">
                <div class="profile-avatar-container mx-auto">
                    <img src="${pageContext.request.contextPath}/assets/images/default-avatar.jpg"
                         alt="Profile Avatar" class="profile-avatar">
                    <label for="avatarUpload" class="upload-avatar">
                        <i class="bi bi-camera"></i>
                        <input type="file" id="avatarUpload" hidden accept="image/*">
                    </label>
                </div>

                <h1 class="profile-name">${sessionScope.user.fullName}</h1>
                <p class="profile-username">@${sessionScope.user.username}</p>

                <span class="user-badge
                    ${sessionScope.userType == 'client' ? 'badge-client' :
                     (sessionScope.userType == 'photographer' ? 'badge-photographer' : 'badge-admin')}">
                    ${sessionScope.userType == 'client' ? 'Client' :
                     (sessionScope.userType == 'photographer' ? 'Photographer' : 'Administrator')}
                </span>

                <div class="profile-stats">
                    <div class="stat-item">
                        <div class="stat-value">
                            <c:choose>
                                <c:when test="${sessionScope.userType == 'client'}">5</c:when>
                                <c:when test="${sessionScope.userType == 'photographer'}">24</c:when>
                                <c:otherwise>42</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">
                            <c:choose>
                                <c:when test="${sessionScope.userType == 'client'}">Bookings</c:when>
                                <c:when test="${sessionScope.userType == 'photographer'}">Assignments</c:when>
                                <c:otherwise>Users</c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="stat-item">
                        <div class="stat-value">
                            <c:choose>
                                <c:when test="${sessionScope.userType == 'client'}">3</c:when>
                                <c:when test="${sessionScope.userType == 'photographer'}">8</c:when>
                                <c:otherwise>16</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">
                            <c:choose>
                                <c:when test="${sessionScope.userType == 'client'}">Galleries</c:when>
                                <c:when test="${sessionScope.userType == 'photographer'}">Portfolios</c:when>
                                <c:otherwise>Bookings</c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="stat-item">
                        <div class="stat-value">
                            <c:choose>
                                <c:when test="${sessionScope.userType == 'client'}">4.8</c:when>
                                <c:when test="${sessionScope.userType == 'photographer'}">4.9</c:when>
                                <c:otherwise>--</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="stat-label">Rating</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Content -->
        <div class="row">
            <div class="col-lg-10 col-xl-8 mx-auto">
                <div class="card profile-card">
                    <!-- Navigation Tabs -->
                    <div class="profile-nav">
                        <a href="#personal-info" class="profile-nav-item active" data-bs-toggle="tab">
                            <i class="bi bi-person"></i> Personal Info
                        </a>
                        <a href="#account-security" class="profile-nav-item" data-bs-toggle="tab">
                            <i class="bi bi-shield-lock"></i> Security
                        </a>
                        <a href="#preferences" class="profile-nav-item" data-bs-toggle="tab">
                            <i class="bi bi-gear"></i> Preferences
                        </a>
                    </div>

                    <!-- Include Messages -->
                    <jsp:include page="/includes/messages.jsp" />

                    <!-- Tab Content -->
                    <div class="tab-content">
                        <!-- Personal Information Tab -->
                        <div class="tab-pane fade show active" id="personal-info">
                            <h4 class="section-title">
                                <i class="bi bi-person-vcard me-2"></i> Personal Information
                            </h4>

                            <form action="${pageContext.request.contextPath}/update-profile" method="post">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="fullName" name="fullName"
                                                value="${sessionScope.user.fullName}" required>
                                            <label for="fullName">Full Name</label>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="email" class="form-control" id="email" name="email"
                                                value="${sessionScope.user.email}" required>
                                            <label for="email">Email Address</label>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="username" name="username"
                                                value="${sessionScope.user.username}" readonly>
                                            <label for="username">Username</label>
                                        </div>
                                        <div class="form-text">Username cannot be changed.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <select class="form-select" id="userType" disabled>
                                                <option value="CLIENT" ${sessionScope.userType == 'client' ? 'selected' : ''}>Client</option>
                                                <option value="PHOTOGRAPHER" ${sessionScope.userType == 'photographer' ? 'selected' : ''}>Photographer</option>
                                                <option value="ADMIN" ${sessionScope.userType == 'admin' ? 'selected' : ''}>Administrator</option>
                                            </select>
                                            <label for="userType">Account Type</label>
                                        </div>
                                        <div class="form-text">Contact support to change account type.</div>
                                    </div>

                                    <div class="col-12 mt-4">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-check-circle me-2"></i>Save Changes
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Account Security Tab -->
                        <div class="tab-pane fade" id="account-security">
                            <h4 class="section-title">
                                <i class="bi bi-shield-lock me-2"></i> Security Settings
                            </h4>

                            <form action="${pageContext.request.contextPath}/update-profile" method="post">
                                <div class="row g-4">
                                    <div class="col-md-12">
                                        <div class="form-floating position-relative">
                                            <input type="password" class="form-control" id="currentPassword"
                                                name="currentPassword" placeholder="Current Password">
                                            <label for="currentPassword">Current Password</label>
                                            <button type="button" class="toggle-password" data-target="currentPassword">
                                                <i class="bi bi-eye-slash"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-floating position-relative">
                                            <input type="password" class="form-control" id="newPassword"
                                                name="newPassword" placeholder="New Password">
                                            <label for="newPassword">New Password</label>
                                            <button type="button" class="toggle-password" data-target="newPassword">
                                                <i class="bi bi-eye-slash"></i>
                                            </button>
                                        </div>

                                        <div class="password-strength-meter mt-2">
                                            <div class="strength-weak"></div>
                                            <div class="strength-fair"></div>
                                            <div class="strength-good"></div>
                                            <div class="strength-strong"></div>
                                        </div>
                                        <div class="form-text">8+ characters with letters, numbers & symbols</div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-floating position-relative">
                                            <input type="password" class="form-control" id="confirmPassword"
                                                name="confirmPassword" placeholder="Confirm New Password">
                                            <label for="confirmPassword">Confirm New Password</label>
                                            <button type="button" class="toggle-password" data-target="confirmPassword">
                                                <i class="bi bi-eye-slash"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="col-12 mt-2">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-check-circle me-2"></i>Update Password
                                            </button>
                                            <a href="${pageContext.request.contextPath}/user/delete-account.jsp"
                                               class="btn btn-outline-danger">
                                                <i class="bi bi-trash me-2"></i>Delete Account
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Preferences Tab -->
                        <div class="tab-pane fade" id="preferences">
                            <h4 class="section-title">
                                <i class="bi bi-sliders me-2"></i> Account Preferences
                            </h4>

                            <form action="${pageContext.request.contextPath}/update-preferences" method="post">
                                <div class="row g-4">
                                    <div class="col-12">
                                        <h5 class="mb-3">Notification Settings</h5>

                                        <div class="form-check form-switch mb-3">
                                            <input class="form-check-input" type="checkbox" id="emailNotifications" checked>
                                            <label class="form-check-label" for="emailNotifications">
                                                Email Notifications
                                            </label>
                                            <div class="form-text">Receive booking confirmations, updates, and reminders</div>
                                        </div>

                                        <div class="form-check form-switch mb-3">
                                            <input class="form-check-input" type="checkbox" id="marketingEmails">
                                            <label class="form-check-label" for="marketingEmails">
                                                Marketing Emails
                                            </label>
                                            <div class="form-text">Receive promotional offers and newsletters</div>
                                        </div>
                                    </div>

                                    <div class="col-12 mt-4">
                                        <h5 class="mb-3">Privacy Settings</h5>

                                        <div class="form-check form-switch mb-3">
                                            <input class="form-check-input" type="checkbox" id="profileVisibility" checked>
                                            <label class="form-check-label" for="profileVisibility">
                                                Public Profile
                                            </label>
                                            <div class="form-text">Allow others to view your profile</div>
                                        </div>

                                        <c:if test="${sessionScope.userType == 'photographer'}">
                                            <div class="form-check form-switch mb-3">
                                                <input class="form-check-input" type="checkbox" id="showRatings" checked>
                                                <label class="form-check-label" for="showRatings">
                                                    Show Ratings
                                                </label>
                                                <div class="form-text">Display your review ratings on your profile</div>
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="col-12 mt-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-check-circle me-2"></i>Save Preferences
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Password visibility toggle
        document.querySelectorAll('.toggle-password').forEach(button => {
            button.addEventListener('click', function() {
                const targetId = this.getAttribute('data-target');
                const passwordField = document.getElementById(targetId);
                const icon = this.querySelector('i');

                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                } else {
                    passwordField.type = 'password';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                }
            });
        });

        // Password strength meter
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const strengthBars = document.querySelectorAll('.password-strength-meter div');

        if (newPassword) {
            newPassword.addEventListener('input', function() {
                const value = this.value;
                let strength = 0;

                // Reset all bars
                strengthBars.forEach(bar => {
                    bar.style.opacity = '0.2';
                });

                if (value.length >= 8) strength++;
                if (/[A-Z]/.test(value)) strength++;
                if (/[0-9]/.test(value)) strength++;
                if (/[^A-Za-z0-9]/.test(value)) strength++;

                // Update strength meter
                for (let i = 0; i < strength; i++) {
                    strengthBars[i].style.opacity = '1';
                }

                // Also validate password match
                validatePasswordMatch();
            });
        }

        // Password match validation
        function validatePasswordMatch() {
            if (newPassword && confirmPassword) {
                if (newPassword.value && newPassword.value !== confirmPassword.value) {
                    confirmPassword.setCustomValidity('Passwords do not match');
                    confirmPassword.classList.add('is-invalid');
                } else {
                    confirmPassword.setCustomValidity('');
                    confirmPassword.classList.remove('is-invalid');
                }
            }
        }

        if (confirmPassword) {
            confirmPassword.addEventListener('input', validatePasswordMatch);
        }

        // Tab navigation
        document.querySelectorAll('.profile-nav-item').forEach(tab => {
            tab.addEventListener('click', function(e) {
                e.preventDefault();

                // Remove active class from all tabs
                document.querySelectorAll('.profile-nav-item').forEach(t => {
                    t.classList.remove('active');
                });

                // Add active class to clicked tab
                this.classList.add('active');

                // Show corresponding tab content
                const tabId = this.getAttribute('href');
                document.querySelectorAll('.tab-pane').forEach(pane => {
                    pane.classList.remove('show', 'active');
                });
                document.querySelector(tabId).classList.add('show', 'active');
            });
        });

        // Avatar upload preview
        const avatarUpload = document.getElementById('avatarUpload');
        const profileAvatar = document.querySelector('.profile-avatar');

        if (avatarUpload && profileAvatar) {
            avatarUpload.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    const reader = new FileReader();

                    reader.onload = function(e) {
                        profileAvatar.src = e.target.result;

                        // Add animation effect
                        profileAvatar.classList.add('fade-in');
                        setTimeout(() => {
                            profileAvatar.classList.remove('fade-in');
                        }, 500);
                    }

                    reader.readAsDataURL(this.files[0]);
                }
            });
        }
    </script>
</body>
</html>