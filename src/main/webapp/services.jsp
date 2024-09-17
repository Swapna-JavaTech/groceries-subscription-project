<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Grocery Services</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link href="styles.css" rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
}

.jumbotron {
	background-color: rgba(248, 249, 250, 0.8);
	/* Slightly transparent background */
	padding: 2rem 1rem;
}

.card {
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>

	<br>
	<br>
	<br>

	<div class="container mt-5">
		<div class="jumbotron text-center">
			<h1>Our Grocery Services</h1>
			<p>Explore the variety of services we offer to make your grocery
				shopping easier!</p>
		</div>

		<div class="row">
			<div class="col-md-4">
				<div class="card">
					<img
						src="https://www.nation.com/nation/wp-content/uploads/2019/05/seniors-grocery-delivery-service-1024x683.jpg"
						class="card-img-top" alt="Delivery Service">
					<div class="card-body">
						<h5 class="card-title">Delivery Service</h5>
						<p class="card-text">Get your groceries delivered to your
							doorstep quickly and safely.</p>
						<a href="${pageContext.request.contextPath}/users/login"
							class="btn btn-secondary">Know More</a>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<img
						src="https://th.bing.com/th/id/OIP.hHYfsdbKikgRpJ4FeABrlwHaEH?pid=ImgDet&w=474&h=263&rs=1"
						class="card-img-top" alt="Pickup Service">
					<div class="card-body">
						<h5 class="card-title">Pickup Service</h5>
						<p class="card-text">Order online and pick up your groceries
							at your convenience.</p>
						<a href="${pageContext.request.contextPath}/users/login"
							class="btn btn-secondary">Know More</a>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card">
					<img
						src="https://th.bing.com/th/id/OIP.fiyEw6LveOPlKYoR3MjVKAHaE7?rs=1&pid=ImgDetMain"
						class="card-img-top" alt="Subscription Service">
					<div class="card-body">
						<h5 class="card-title">Subscription Service</h5>
						<p class="card-text">Subscribe to our service and get regular
							deliveries of your favorite items.</p>
						<a href="${pageContext.request.contextPath}/users/login"
							class="btn btn-secondary">Know More</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
