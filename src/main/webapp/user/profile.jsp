<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - SnapEvent</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f4f6f9;
        }
        .profile-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 50px;
        }
        .profile-avatar {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #007bff;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="profile-container">
                    <div class="text-center mb-4">
                        <img src="${pageContext.request.contextPath}/assets/images/default-avatar.jpg"
                             alt="Profile Avatar" class="profile-avatar mb-3">
                        <h2>${sessionScope.user.fullName}</h2>
                        <p class="text-muted">@${sessionScope.user.username}</p>
                        <span class="badge
                            ${sessionScope.userType == 'client' ? 'bg-primary' :
                              (sessionScope.userType == 'photographer' ? 'bg-success' : 'bg-danger')}">
                            ${sessionScope.userType == 'client' ? 'Client' :
                              (sessionScope.userType == 'photographer' ? 'Photographer' : 'Administrator')}
                        </span>
                    </div>

                    <!-- Include Messages -->
                    <jsp:include page="/includes/messages.jsp" />

                    <form action="${pageContext.request.contextPath}/update-profile" method="post">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName"
                                       value="${sessionScope.user.fullName}" required maxlength="100">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${sessionScope.user.email}" required maxlength="100">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">
                                Current Password
                                <small class="text-muted">(required to change password)</small>
                            </label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword"
                                       placeholder="Enter current password">
                                <button class="btn btn-outline-secondary toggle-password" type="button"
                                        data-target="currentPassword">
                                    <i class="bi bi-eye-slash"></i>
                                </button>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="newPassword" class="form-label">
                                    New Password
                                    <small class="text-muted">(optional)</small>
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword"
                                           placeholder="Enter new password" minlength="8" maxlength="20"
                                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                           title="Must contain at least one number, one uppercase, one lowercase letter, one special character, and be 8-20 characters long">
                                    <button class="btn btn-outline-secondary toggle-password" type="button"
                                            data-target="newPassword">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                                <small class="form-text text-muted">
                                    8-20 characters, with uppercase, lowercase, number, and special character
                                </small>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="confirmPassword" class="form-label">
                                    Confirm New Password
                                    <small class="text-muted">(optional)</small>
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword"
                                           name="confirmPassword" placeholder="Confirm new password">
                                    <button class="btn btn-outline-secondary toggle-password" type="button"
                                            data-target="confirmPassword">
                                        <i class="bi bi-eye-slash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-between mt-4">
                            <a href="${pageContext.request.contextPath}/user/delete-account"
                               class="btn btn-outline-danger">
                                <i class="bi bi-trash me-2"></i>Delete Account
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save me-2"></i>Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Password toggle visibility
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

        // Client-side password match validation
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');

        function validatePassword() {
            if (newPassword.value && newPassword.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match');
            } else {
                confirmPassword.setCustomValidity('');
            }
        }

        newPassword.addEventListener('input', validatePassword);
        confirmPassword.addEventListener('input', validatePassword);
    </script>
</body>
</html>