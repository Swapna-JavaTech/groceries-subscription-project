<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style type="text/css">
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Background and Body Styles */
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://th.bing.com/th/id/OIP.gpMaiVmWM9SYVqjLnOpBFgHaD-?rs=1&pid=ImgDetMain');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center center;
        }

        /* Sign-Up Section */
        .signup {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 60px); /* Adjust for header height */
            padding: 20px;
            background: rgba(255, 255, 255, 0.8); /* Slightly transparent background for the section */
        }

        .signup-form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
        }

        .signup-form h1 {
            margin-bottom: 20px;
            font-size: 1.5em;
            color: #333;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
            font-size: 0.9em; /* Adjust font size for labels */
        }

        input[type="text"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.9em;
            color: #333;
        }

        button {
            width: 100%;
            padding: 10px;
            background: rgba(56, 51, 37, 0.8); /* Updated rgba color */
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1em;
            cursor: pointer;
        }

        button:hover {
            background: rgba(56, 51, 37, 1); /* Less transparent on hover */
        }

        .links {
            text-align: center;
            margin-top: 15px;
        }

        .links a {
            color: #007BFF;
            text-decoration: none;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            font-size: 0.8em;
            margin-top: 5px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .signup {
                padding: 10px;
            }

            .signup-form {
                padding: 15px;
            }

            .signup-form h1 {
                font-size: 1.2em;
            }

            label {
                font-size: 0.8em; /* Smaller font size for labels on mobile */
            }
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <jsp:include page="/header.jsp"></jsp:include>
    <br><br><br>

    <!-- Sign-Up Section -->
    <section class="signup">
        <div class="signup-form">
            <h1>Create an Account</h1>
            <form id="signupForm" action="${pageContext.request.contextPath}/users/signup" method="post">
                <div class="form-group">
                    <label for="user_Name">User Name</label>
                    <input type="text" id="user_Name" name="user_Name" required>
                    <div id="user_NameError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="userMobileNumber">Mobile</label>
                    <input type="text" id="userMobileNumber" name="userMobileNumber" required>
                    <div id="userMobileNumberError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="userEmail">Email Address</label>
                    <input type="email" id="userEmail" name="userEmail" required>
                    <div id="userEmailError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="userRole">User Role</label>
                    <select id="userRole" name="userRole" required>
                        <option value="">Select Role</option>
                        <option value="Customer">Customer</option>
                        <option value="Seller">Seller</option>
                    </select>
                    <div id="userRoleError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="userPassword">Password</label>
                    <input type="password" id="userPassword" name="userPassword" required>
                    <div id="userPasswordError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                    <div id="confirmPasswordError" class="error-message"></div>
                </div>

                <button type="submit">Sign Up</button>
            </form>

            <div class="links">
                <p>Already have an account? <a href="${pageContext.request.contextPath}/users/login">Login here</a></p>
            </div>
        </div>
    </section>

    <!-- Footer Section -->
    <jsp:include page="/footer.jsp"></jsp:include>

    <!-- JavaScript for Validation -->
    <script>
        function validateField(id, value, regex, errorMsg) {
            let errorElement = document.getElementById(id + 'Error');
            if (!value) {
                errorElement.textContent = "This field is required";
                return false;
            } else if (regex && !regex.test(value)) {
                errorElement.textContent = errorMsg;
                return false;
            } else {
                errorElement.textContent = "";
                return true;
            }
        }

        function validatePassword(password) {
            return {
                lengthValid: password.length >= 8,
                containsDigit: /[0-9]/.test(password),
                containsUpper: /[A-Z]/.test(password),
                containsLower: /[a-z]/.test(password),
                containsSpecial: /[@$!%*?&]/.test(password) // Special character requirement
            };
        }

        document.getElementById('user_Name').addEventListener('input', function() {
            let value = this.value.trim();
            validateField('user_Name', value, /^[A-Za-z]+$/, "User Name must contain only letters and no digits");
        });

        document.getElementById('userMobileNumber').addEventListener('input', function() {
            let value = this.value.trim();
            validateField('userMobileNumber', value, /^[6-9][0-9]{9}$/, "Mobile number must start with 6, 7, 8, or 9 and be exactly 10 digits long");
        });

        document.getElementById('userEmail').addEventListener('input', function() {
            let value = this.value.trim();
            validateField('userEmail', value, /^[^\s@]+@[^\s@]+\.[^\s@]+$/, "Enter a valid email address");
        });

        document.getElementById('userRole').addEventListener('change', function() {
            let value = this.value.trim();
            validateField('userRole', value, null, "Please select your role");
        });

        document.getElementById('userPassword').addEventListener('input', function() {
            let value = this.value;
            let validation = validatePassword(value);
            let errorElement = document.getElementById('userPasswordError');

            if (!value) {
                errorElement.textContent = "Please enter a password";
            } else if (!validation.lengthValid) {
                errorElement.textContent = "Password must be at least 8 characters long";
            } else if (!validation.containsDigit) {
                errorElement.textContent = "Password must include at least one digit";
            } else if (!validation.containsUpper) {
                errorElement.textContent = "Password must include at least one uppercase letter";
            } else if (!validation.containsLower) {
                errorElement.textContent = "Password must include at least one lowercase letter";
            } else if (!validation.containsSpecial) {
                errorElement.textContent = "Password must include at least one special character";
            } else {
                errorElement.textContent = "";
            }
        });

        document.getElementById('confirmPassword').addEventListener('input', function() {
            let value = this.value;
            let password = document.getElementById('userPassword').value;
            let errorElement = document.getElementById('confirmPasswordError');

            if (value !== password) {
                errorElement.textContent = "Passwords do not match";
            } else {
                errorElement.textContent = "";
            }
        });

        document.getElementById('signupForm').addEventListener('submit', function(event) {
            let isValid = true;

            let name = document.getElementById('user_Name').value.trim();
            let mobile = document.getElementById('userMobileNumber').value.trim();
            let email = document.getElementById('userEmail').value.trim();
            let role = document.getElementById('userRole').value.trim();
            let password = document.getElementById('userPassword').value;
            let confirmPassword = document.getElementById('confirmPassword').value;

            if (!validateField('user_Name', name, /^[A-Za-z]+$/, "User Name must contain only letters and no digits")) isValid = false;
            if (!validateField('userMobileNumber', mobile, /^[6-9][0-9]{9}$/, "Mobile number must start with 6, 7, 8, or 9 and be exactly 10 digits long")) isValid = false;
            if (!validateField('userEmail', email, /^[^\s@]+@[^\s@]+\.[^\s@]+$/, "Enter a valid email address")) isValid = false;
            if (!validateField('userRole', role, null, "Please select your role")) isValid = false;

            let passwordValidation = validatePassword(password);
            let passwordError = document.getElementById('userPasswordError');

            if (!password) {
                passwordError.textContent = "Please enter a password";
                isValid = false;
            } else if (!passwordValidation.lengthValid) {
                passwordError.textContent = "Password must be at least 8 characters long";
                isValid = false;
            } else if (!passwordValidation.containsDigit) {
                passwordError.textContent = "Password must include at least one digit";
                isValid = false;
            } else if (!passwordValidation.containsUpper) {
                passwordError.textContent = "Password must include at least one uppercase letter";
                isValid = false;
            } else if (!passwordValidation.containsLower) {
                passwordError.textContent = "Password must include at least one lowercase letter";
                isValid = false;
            } else if (!passwordValidation.containsSpecial) {
                passwordError.textContent = "Password must include at least one special character";
                isValid = false;
            } else {
                passwordError.textContent = "";
            }

            if (confirmPassword !== password) {
                document.getElementById('confirmPasswordError').textContent = "Passwords do not match";
                isValid = false;
            } else {
                document.getElementById('confirmPasswordError').textContent = "";
            }

            if (!isValid) {
                event.preventDefault(); // Prevent form submission if validation fails
            }
        });
    </script>
</body>
</html>
