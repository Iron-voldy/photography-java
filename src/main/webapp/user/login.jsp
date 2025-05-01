<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SnapEvent Photography</title>

    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background: linear-gradient(135deg, rgba(37, 117, 252, 0.8) 0%, rgba(106, 17, 203, 0.8) 100%);
            font-family: 'Montserrat', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            color: #333;
        }

        .login-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header img {
            max-width: 100px;
            margin-bottom: 15px;
        }

        .form-control, .btn {
            height: 50px;
        }

        .btn-primary {
            background-color: #2575fc;
            border-color: #2575fc;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #1a5aec;
            border-color: #1a5aec;
        }

        .social-login .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 10px 0;
        }

        .social-login .btn i {
            margin-right: 10px;
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 20px 0;
        }

        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #ddd;
        }

        .divider span {
            padding: 0 10px;
            color: #999;
        }

        .toggle-password {
            background: transparent;
            border: none;
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 10;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-header">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="SnapEvent Logo">
                <h2 class="mb-3">Welcome Back</h2>
                <p class="text-muted">Login to your SnapEvent account</p>
            </div>

            <!-- Include message display -->
            <jsp:include page="/includes/messages.jsp" />

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" id="username" name="username"
                               value="${not empty param.username ? param.username : ''}"
                               required minlength="3" maxlength="20"
                               placeholder="Enter your username">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <div class="position-relative">
                        <input type="password" class="form-control" id="password" name="password"
                               required minlength="8" maxlength="20"
                               placeholder="Enter your password">
                        <button type="button" class="toggle-password" id="togglePassword">
                            <i class="bi bi-eye-slash text-muted"></i>
                        </button>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <a href="${pageContext.request.contextPath}/forgot-password"
                           class="small text-muted text-decoration-none">Forgot Password?</a>
                    </div>
                </div>

                <div class="d-grid gap-2 mb-3">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>

                <div class="divider">
                    <span>or continue with</span>
                </div>

                <div class="social-login">
                    <div class="row g-2">
                        <div class="col-6">
                            <a href="#" class="btn btn-outline-danger w-100">
                                <i class="bi bi-google"></i> Google
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="#" class="btn btn-outline-primary w-100">
                                <i class="bi bi-facebook"></i> Facebook
                            </a>
                        </div>
                    </div>
                </div>
            </form>

            <div class="text-center mt-4">
                <p class="small">
                    Don't have an account?
                    <a href="${pageContext.request.contextPath}/user/register.jsp" class="text-primary">Sign up here</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

    <script>
        // Password visibility toggle
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordField = document.getElementById('password');
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
    </script>
</body>
</html>