<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style type="text/css">
/* General Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, sans-serif;
}

/* Login Section */
.login {
	display: flex;
	justify-content: center;
	align-items: center;
	height: calc(100vh - 60px); /* Adjusting for header height */
	padding: 20px;
	background: #f4f4f4;
}

.container-fluid {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

.row {
	display: flex;
	justify-content: center; /* Center content horizontally */
	align-items: center; /* Center content vertically */
	width: 100%;
}

.col-md-6, .col-lg-6, .col-xl-4 {
	flex: 1;
	padding: 15px;
}

.img-fluid {
	max-width: 100%;
	height: auto;
}

.login-form {
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	max-width: 100%;
	margin: auto;
	width: 100%;
	max-width: 400px; /* Limit the width of the login form */
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.login-form h1 {
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
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 1em;
	color: #333;
}

button {
	width: 100%;
	padding: 10px;
	background: rgba(56, 51, 37, 0.8); /* Updated color */
	color: #fff;
	border: none;
	border-radius: 4px;
	font-size: 1em;
	cursor: pointer;
}

button:hover {
	background: rgba(56, 51, 37, 1);
	/* Slightly less transparent on hover */
}

.links {
	text-align: center;
	margin-top: 20px;
}

.links a {
	display: block;
	color: #007BFF;
	text-decoration: none;
	margin-bottom: 10px;
}

.links a:hover {
	text-decoration: underline;
}

.error-message {
	color: #d9534f;
	font-weight: bold;
	margin-bottom: 15px;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.login {
		flex-direction: column;
		padding: 10px;
	}
	.row {
		flex-direction: column;
	}
}

/* Adjust image to match card size */
.image-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
}

.image-container img {
	max-width: 100%;
	max-height: 100%;
	object-fit: cover;
	border-radius: 8px;
}
</style>
</head>
<body>
	<!-- Header Section -->
	<jsp:include page="/header.jsp"></jsp:include>

	<!-- Login Section -->
	<section class="login">
		<div class="container-fluid h-custom">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<!-- Left side: Image -->
				<div class="col-md-6 col-lg-6 col-xl-4 image-container">
					<img
						src="https://hdwallpaperim.com/wp-content/uploads/2017/08/31/155931-food.jpg"
						alt="Login Image" class="img-fluid">
				</div>
				<!-- Right side: Login card -->
				<div class="col-md-6 col-lg-6 col-xl-4">
					<div class="login-form">
						<h1>Login to Your Account</h1>
						<form action="${pageContext.request.contextPath}/users/login"
							method="post">
							<div class="form-group">
								<label for="userEmail">Email</label> <input type="text"
									id="userEmail" name="userEmail" required>
							</div>
							<div class="form-group">
								<label for="userPassword">Password</label> <input
									type="password" id="userPassword" name="userPassword" required>
							</div>
							<button type="submit">Login</button>
							<p class="error-message">${error}</p>
						</form>
						<div class="links">
							<a href="${pageContext.request.contextPath}/users/register">Create
								an Account</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
