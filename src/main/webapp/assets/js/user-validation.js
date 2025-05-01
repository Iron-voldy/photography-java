// User Validation Utility Functions

document.addEventListener('DOMContentLoaded', function() {
    // Username validation
    const usernameInput = document.getElementById('username');
    if (usernameInput) {
        usernameInput.addEventListener('input', function() {
            validateUsername(this);
        });
    }

    // Email validation
    const emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('input', function() {
            validateEmail(this);
        });
    }

    // Password validation
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');

    if (passwordInput && confirmPasswordInput) {
        passwordInput.addEventListener('input', function() {
            validatePassword(this);
            validatePasswordMatch();
        });

        confirmPasswordInput.addEventListener('input', function() {
            validatePasswordMatch();
        });
    }

    // Full Name validation
    const fullNameInput = document.getElementById('fullName');
    if (fullNameInput) {
        fullNameInput.addEventListener('input', function() {
            validateFullName(this);
        });
    }
});

// Username validation function
function validateUsername(input) {
    const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
    const errorElement = input.nextElementSibling ||
        createErrorElement(input, 'Username validation error');

    if (!usernameRegex.test(input.value)) {
        input.classList.add('is-invalid');
        errorElement.textContent = 'Username must be 3-20 alphanumeric characters or underscore';
        errorElement.classList.add('invalid-feedback');
    } else {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
        if (errorElement) {
            errorElement.textContent = '';
        }
    }
}

// Email validation function
function validateEmail(input) {
    const emailRegex = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/;
    const errorElement = input.nextElementSibling ||
        createErrorElement(input, 'Email validation error');

    if (!emailRegex.test(input.value)) {
        input.classList.add('is-invalid');
        errorElement.textContent = 'Please enter a valid email address';
        errorElement.classList.add('invalid-feedback');
    } else {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
        if (errorElement) {
            errorElement.textContent = '';
        }
    }
}

// Password validation function
function validatePassword(input) {
    const passwordRegex = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\S+$).{8,20}$/;
    const errorElement = input.nextElementSibling ||
        createErrorElement(input, 'Password validation error');

    if (!passwordRegex.test(input.value)) {
        input.classList.add('is-invalid');
        errorElement.textContent = 'Password must be 8-20 characters with uppercase, lowercase, number, and special character';
        errorElement.classList.add('invalid-feedback');
    } else {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
        if (errorElement) {
            errorElement.textContent = '';
        }
    }
}

// Password match validation function
function validatePasswordMatch() {
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const errorElement = confirmPasswordInput.nextElementSibling ||
        createErrorElement(confirmPasswordInput, 'Password match validation error');

    if (passwordInput.value !== confirmPasswordInput.value) {
        confirmPasswordInput.classList.add('is-invalid');
        errorElement.textContent = 'Passwords do not match';
        errorElement.classList.add('invalid-feedback');
    } else {
        confirmPasswordInput.classList.remove('is-invalid');
        confirmPasswordInput.classList.add('is-valid');
        if (errorElement) {
            errorElement.textContent = '';
        }
    }
}

// Full Name validation function
function validateFullName(input) {
    const fullNameRegex = /^[A-Za-z\s'-]{2,50}$/;
    const errorElement = input.nextElementSibling ||
        createErrorElement(input, 'Full Name validation error');

    if (!fullNameRegex.test(input.value)) {
        input.classList.add('is-invalid');
        errorElement.textContent = 'Please enter a valid full name (2-50 characters)';
        errorElement.classList.add('invalid-feedback');
    } else {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
        if (errorElement) {
            errorElement.textContent = '';
        }
    }
}

// Helper function to create error element
function createErrorElement(input, defaultMessage) {
    const errorElement = document.createElement('div');
    errorElement.textContent = defaultMessage;
    input.parentNode.insertBefore(errorElement, input.nextSibling);
    return errorElement;
}

// Form validation before submission
function validateForm(event) {
    const inputs = event.target.querySelectorAll('input[required]');
    let isValid = true;

    inputs.forEach(input => {
        switch(input.type) {
            case 'text':
                if (input.id === 'username') validateUsername(input);
                if (input.id === 'fullName') validateFullName(input);
                break;
            case 'email':
                validateEmail(input);
                break;
            case 'password':
                if (input.id === 'password') validatePassword(input);
                break;
        }

        if (input.classList.contains('is-invalid')) {
            isValid = false;
        }
    });

    if (!isValid) {
        event.preventDefault();
        showFormValidationError();
    }
}

// Show form validation error
function showFormValidationError() {
    const errorToast = new bootstrap.Toast(document.getElementById('validationErrorToast'));
    errorToast.show();
}