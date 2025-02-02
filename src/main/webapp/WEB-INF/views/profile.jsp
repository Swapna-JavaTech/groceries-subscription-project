<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update User Details</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
body {
	background-image:
		url('https://t3.ftcdn.net/jpg/03/07/15/28/360_F_307152868_ncMILWfZIhGoAEK8QsFDsScGiRaQMsL0.jpg');
	/* Background image URL */
	background-repeat: no-repeat;
	background-position: center center; /* Center the image */
	background-size: cover; /* Cover the entire viewport */
	background-attachment: fixed; /* Fix the background image */
	color: #483D8B;
}

.card {
	border-radius: 15px;
	background: rgba(255, 255, 255, 0.9);
	/* Slightly transparent background */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	/* Add shadow for better depth effect */
}

.card-body {
	padding: 2rem;
}

.btn-update {
	background-color: #4a4a4a; /* Dark grey color */
	border-color: #4a4a4a;
}

.btn-update:hover {
	background-color: #333; /* Even darker grey on hover */
	border-color: #333;
}

.error-message {
	color: red;
	font-size: 0.9em;
	margin-top: 0.5rem;
}

.form-control:focus {
	border-color: #4a4a4a;
	box-shadow: none;
}

.container {
	margin-top: 5rem;
}

.header-logo {
	max-width: 150px;
}
</style>
</head>
<body>
	<!-- Conditionally Render Header -->
	<c:choose>
		<c:when test="${sessionScope.userRole eq 'Seller'}">
			<!-- Seller Header -->
			<jsp:include page="/sellerHeader.jsp"></jsp:include>
		</c:when>
		<c:otherwise>
			<!-- Customer Header -->
			<jsp:include page="/customerHeader.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>
	<br>
	<br>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-8 col-lg-6">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title mb-4 text-center">Update User Details</h1>

						<p class="text-center text-success">${message}</p>

						<form action="${pageContext.request.contextPath}/users/profile"
							method="post" id="userForm">
							<input type="hidden" name="user_id" value="${user.user_id}">

							<div class="form-group">
								<label for="user_Name">Name:</label> <input type="text"
									id="user_Name" name="user_Name" value="${user.user_Name}"
									class="form-control" required>
								<div id="user_NameError" class="error-message"></div>
							</div>

							<div class="form-group">
								<label for="userRole">Role:</label> <input type="text"
									id="userRole" value="${user.userRole}" class="form-control"
									name="userRole" readonly>
							</div>

							<div class="form-group">
								<label for="userEmail">Email:</label> <input type="email"
									id="userEmail" name="userEmail" value="${user.userEmail}"
									class="form-control">
								<div id="userEmailError" class="error-message"></div>
							</div>

							<div class="form-group">
								<label for="userMobileNumber">Mobile Number:</label> <input
									type="tel" id="userMobileNumber" name="userMobileNumber"
									value="${user.userMobileNumber}" class="form-control" required>
								<div id="userMobileNumberError" class="error-message"></div>
							</div>


							<button type="submit" class="btn btn-update btn-secondary">Update</button>
						</form>

						<br> <a
							href="${pageContext.request.contextPath}/users/forgot-password"
							class="btn btn-secondary btn-block">Forgot Password?</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<br>
	<jsp:include page="/footer.jsp"></jsp:include>

	<script>
		function validateField(id, value, regex, minLength, maxLength, errorMsg) {
			let errorElement = document.getElementById(id + 'Error');
			if (!value) {
				errorElement.textContent = "This field is required";
				return false;
			} else if (minLength && value.length < minLength) {
				errorElement.textContent = `Must be at least ${minLength} characters long`;
				return false;
			} else if (maxLength && value.length > maxLength) {
				errorElement.textContent = `Must be less than ${maxLength} characters long`;
				return false;
			} else if (regex && !regex.test(value)) {
				errorElement.textContent = errorMsg;
				return false;
			} else {
				errorElement.textContent = "";
				return true;
			}
		}

		document
				.getElementById('user_Name')
				.addEventListener(
						'input',
						function() {
							let value = this.value.trim();
							validateField(
									'user_Name',
									value,
									/^[A-Za-z\s]+$/,
									3,
									50,
									"Name must contain only letters and spaces and be between 3 and 50 characters long");
						});

		document.getElementById('userEmail').addEventListener(
				'input',
				function() {
					let value = this.value.trim();
					validateField('userEmail', value,
							/^[^\s@]+@[^\s@]+\.[^\s@]+$/, null, null,
							"Enter a valid email address");
				});

		document
				.getElementById('userMobileNumber')
				.addEventListener(
						'input',
						function() {
							let value = this.value.trim();
							validateField('userMobileNumber', value,
									/^[6-9][0-9]{9}$/, null, null,
									"Mobile number must start with 6, 7, 8, or 9 and be exactly 10 digits long");
						});

		document
				.getElementById('userForm')
				.addEventListener(
						'submit',
						function(event) {
							let isValid = true;

							let name = document.getElementById('user_Name').value
									.trim();
							let email = document.getElementById('userEmail').value
									.trim();
							let mobile = document
									.getElementById('userMobileNumber').value
									.trim();

							if (!validateField(
									'user_Name',
									name,
									/^[A-Za-z\s]+$/,
									3,
									50,
									"Name must contain only letters and spaces and be between 3 and 50 characters long"))
								isValid = false;
							if (!validateField('userEmail', email,
									/^[^\s@]+@[^\s@]+\.[^\s@]+$/, null, null,
									"Enter a valid email address"))
								isValid = false;
							if (!validateField('userMobileNumber', mobile,
									/^[6-9][0-9]{9}$/, null, null,
									"Mobile number must start with 6, 7, 8, or 9 and be exactly 10 digits long"))
								isValid = false;

							if (!isValid) {
								event.preventDefault(); // Prevent form submission if validation fails
							}
						});
	</script>
</body>
</html>
