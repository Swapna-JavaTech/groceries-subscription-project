<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Subscription Success</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	padding-top: 20px;
	background-color: #f8f9fa;
}

.container {
	max-width: 600px;
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.btn-custom {
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-4">Subscription Successful!</h2>
		<p>Your subscription has been successfully processed.</p>
		<p>Thank you for subscribing to our service.</p>
		<div class="btn-custom">
			<a href="${pageContext.request.contextPath}/groceries/list"
				class="btn btn-primary">Continue Shopping</a> <a
				href="${pageContext.request.contextPath}/subscription/subscriptionlist"
				class="btn btn-secondary">View My Subscriptions</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
