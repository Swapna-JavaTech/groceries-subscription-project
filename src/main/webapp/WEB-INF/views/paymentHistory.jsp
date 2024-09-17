<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment History</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #e9ecef;
	margin: 0;
	padding: 0;
}

.hero {
	width: 90%;
	max-width: 1200px;
	margin: 40px auto;
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	color: #343a40;
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 12px 15px;
	text-align: left;
	border-bottom: 1px solid #dee2e6;
}

th {
	background-color: #f8f9fa;
	color: #495057;
	font-weight: bold;
}

tr:nth-child(even) {
	background-color: #f8f9fa;
}

tr:hover {
	background-color: #e2e6ea;
}

.message {
	text-align: center;
	color: #dc3545;
	margin-bottom: 20px;
}

.message p {
	margin: 0;
	padding: 10px;
	border-radius: 4px;
	background-color: #f8d7da;
	color: #721c24;
}

.btn-container {
	text-align: center;
	margin-top: 20px;
}
</style>
</head>
<body>
<!-- Header Section -->
	<jsp:include page="/customerHeader.jsp"></jsp:include>
	<br><br>
	<div class="container hero">
		<h1>Payment History</h1>
		<div class="message">
			<c:if test="${not empty message}">
				<p>${message}</p>
			</c:if>
		</div>
		<table>
			<thead>
				<tr>
					<th>Payment ID</th>
					<th>User</th>
					<th>Amount</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="payment" items="${paymentHistory}">
					<tr>
						<td>${payment.payment_id}</td>
						<td>${payment.user.user_Name}</td>
						<td>${payment.amount}</td>
						<td>${payment.payment_date}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="btn-container">
			<a href="${pageContext.request.contextPath}/groceries/list"
				class="btn btn-secondary">Continue Shopping</a>
		</div>
	</div>
	
	<br>
	<br>
	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
