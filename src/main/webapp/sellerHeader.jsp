<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Courier Booking System</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
/* Header */
header {
	background: rgba(56, 51, 37, 0.8);
	color: #fff;
	padding: 15px 0;
	position: fixed;
	width: 100%;
	top: 0;
	left: 0;
	z-index: 1000;
}

header .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

header .logo {
	font-size: 2em; /* Increased size for the logo */
	font-weight: bold;
}

header nav ul {
	list-style: none;
	display: flex;
	margin: 0;
}

header nav ul li {
	margin-left: 20px;
}

header nav ul li a {
	color: #fff;
	text-decoration: none;
	padding: 10px 15px; /* Increased padding for better click area */
	font-size: 1.2em; /* Increased font size for navigation links */
	border-radius: 5px;
}

header nav ul li a:hover {
	background: #dd4545;
}
</style>
</head>
<body>
	<!-- Header -->
	<header>
	<div class="container">
		<div class="logo">Grocery Store</div>
		<nav>
		<ul>
			<li><a href="${pageContext.request.contextPath}/home.jsp"><strong>Home</strong></a></li>
			<li><a href="${pageContext.request.contextPath}/groceries/add"><strong>Item</strong></a></li>
			<li><a href="${pageContext.request.contextPath}/groceries/list"><strong>Menu</strong></a></li>
			<li><a
				href="${pageContext.request.contextPath}/subscription/allsubscriptions"><strong>Subscriptions</strong></a></li>
			<li><a
				href="${pageContext.request.contextPath}/orders/viewOrders"><strong>Orders</strong></a></li>
			<li><a href="${pageContext.request.contextPath}/categories/add"><strong>Categories</strong></a></li>

			<li><a href="${pageContext.request.contextPath}/home.jsp"><strong>Logout</strong></a></li>
		</ul>
		</nav>
	</div>
	</header>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>
</html>
