<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Invoice Details</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-3">
		<h2 class="mb-4">Invoice Details</h2>
		<c:if test="${not empty order}">
			<p>
				<strong>Order ID:</strong> ${order.order_id}
			</p>
			<p>
				<strong>Item:</strong> ${order.grocery.groceryName}
			</p>
			<p>
				<strong>User:</strong> ${order.users.user_Name}
			</p>
			<p>
				<strong>Total Amount:</strong> ${order.totalAmount}
			</p>
			<p>
				<strong>Status:</strong> ${order.orderStatus}
			</p>
			<p>
				<strong>Order Date:</strong> ${order.order_date}
			</p>
		</c:if>
		<c:if test="${not empty message}">
			<div class="alert alert-danger">${message}</div>
		</c:if>
	</div>
</body>
</html>
