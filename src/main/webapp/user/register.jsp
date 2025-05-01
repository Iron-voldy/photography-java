<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SnapEvent</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f4f6f9;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .register-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 500px;
            width: 100%;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <h2 class="text-center mb-4">Create Your Account</h2>

            <!-- Include message display -->
            <jsp:include page="/includes/messages.jsp" />

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName"
                           value="${not empty param.fullName ? param.fullName : ''}"
                           required maxlength="100">
                </div>

                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username"
                           value="${not empty param.username ? param.username : ''}"
                           required minlength="3" maxlength="20"
                           pattern="[a-zA-Z0-9_]{3,20}"
                           title="3-20 alphanumeric characters or underscore">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email"
                           value="${not empty param.email ? param.email : ''}"
                           required maxlength="100">
                </div>

                <div class="mb-3">
                    <label for="userType" class="form-label">Account Type</label>
                    <select class="form-select" id="userType" name="userType" required>
                        <option value="">Select Account Type</option>
                        <option value="CLIENT" ${param.userType == 'CLIENT' ? 'selected' : ''}>
                            Client (Looking to Book Photographers)
                        </option>
                        <option value="PHOTOGRAPHER" ${param.userType == 'PHOTOGRAPHER' ? 'selected' : ''}>
                            Photographer (Offering Services)
                        </option>
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="password" name="password"
                                   required minlength="8" maxlength="20"
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
                                   title="Must contain at least one number, one uppercase, one lowercase letter, one special character, and be 8-20 characters long">
                            <button class="btn btn-outline-secondary toggle-password" type="button"
                                    data-target="password">
                                <i class="bi bi-eye-slash"></i>
                            </button>
                        </div>
                        <small class="form-text text-muted">
                            8-20 characters, with uppercase, lowercase, number, and special character
                        </small>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="confirmPassword"
                                   name="confirmPassword" required>
                            <button class="btn btn-outline-secondary toggle-password" type="button"
                                    data-target="confirmPassword">
                                <i class="bi bi-eye-slash"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="termsCheck" required>
                    <label class="form-check-label" for="termsCheck">
                        I agree to the <a href="${pageContext.request.contextPath}/terms.jsp" target="_blank">Terms of Service</a>
                        and <a href="${pageContext.request.contextPath}/privacy.jsp" target="_blank">Privacy Policy</a>
                    </label>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Create Account</button>
                </div>
            </form>

            <div class="text-center mt-3">
                <p class="small">Already have an account?
                    <a href="${pageContext.request.contextPath}/user/login.jsp">Login here</a>
                </p>
            </div>
        </div>
    </div>

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
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        function validatePassword() {
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match');
            } else {
                confirmPassword.setCustomValidity('');
            }
        }

        password.addEventListener('input', validatePassword);
        confirmPassword.addEventListener('input', validatePassword);
    </script>
</body>
</html>