<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment Confirmation</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
body {
	background-color: #f8f9fa;
	padding-top: 20px;
}

.confirmation-container {
	max-width: 600px;
	margin: 0 auto;
	text-align: center;
	padding: 30px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.alert {
	font-size: 1.25em;
	margin-bottom: 1.5em;
}

.btn-primary {
	background-color: rgba(56, 51, 37, 0.8);
	border: none;
}

.btn-primary:hover {
	background-color: rgba(56, 51, 37, 1);
}
</style>
</head>
<body>
	<!-- Header Section -->
	<jsp:include page="/customerHeader.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="confirmation-container">
			<h2 class="mb-4">Payment Confirmation</h2>
			<div class="alert alert-success">${message}</div>
			<p>Your order has been successfully processed.</p>
			<p>Thank you for choosing our service.</p>
			<div class="text-center">
				<a href="${pageContext.request.contextPath}/orders/viewOrders"
					class="btn btn-primary">View Orders</a> <a
					href="${pageContext.request.contextPath}/groceries/list"
					class="btn btn-primary">Continue Shopping</a>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
