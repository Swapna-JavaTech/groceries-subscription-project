<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Custom CSS -->
<style>
.container {
	max-width: 500px;
	margin-top: 50px;
}

.form-container {
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.alert {
	margin-top: 20px;
}

.btn-custom {
	background-color: rgba(56, 51, 37, 0.8); /* Custom button color */
	color: #fff; /* Text color for the button */
	border: none; /* Remove default border */
}

.btn-custom:hover {
	background-color: rgba(56, 51, 37, 1); /* Less transparent on hover */
	color: #fff; /* Ensure text color remains white on hover */
}
</style>
</head>
<body>
	<div class="container">
		<div class="form-container bg-light">
			<h2 class="text-center">Forgot Password</h2>
			<form
				action="${pageContext.request.contextPath}/users/forgot-password"
				method="post">
				<div class="form-group">
					<label for="email">Email Address:</label> <input type="email"
						id="email" name="email" class="form-control" required />
				</div>
				<button type="submit" class="btn btn-custom btn-block">Submit</button>
			</form>

			<c:if test="${not empty message}">
				<div class="alert alert-success" role="alert">${message}</div>
			</c:if>

			<c:if test="${not empty error}">
				<div class="alert alert-danger" role="alert">${error}</div>
			</c:if>

			<c:if test="${not empty resetPasswordUrl}">
				<p>
					you can visit the reset password URL: <a href="${resetPasswordUrl}"
						class="btn btn-link">${resetPasswordUrl}</a>
				</p>
			</c:if>
		</div>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
