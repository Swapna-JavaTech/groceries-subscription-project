<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Grocery</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
}

.hero {
	background-color: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h2 {
	color: #343a40;
}

.form-group label {
	font-weight: bold;
	color: #495057;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #004085;
}

.btn-secondary {
	background-color: #6c757d;
	border-color: #6c757d;
}

.btn-secondary:hover {
	background-color: #5a6268;
	border-color: #545b62;
}

.alert-info {
	background-color: #d1ecf1;
	border-color: #bee5eb;
	color: #0c5460;
}

img {
	max-width: 100px;
	height: auto;
	border-radius: 4px;
}
</style>
</head>
<body>
	<!-- Header Section -->
	<jsp:include page="/sellerHeader.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<div class="container hero">
		<h2 class="my-4">Update Grocery Item</h2>

		<form action="${pageContext.request.contextPath}/groceries/edit"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${grocery.grocery_id}">
			<div class="form-group">
				<label for="groceryName">Grocery Name:</label> <input type="text"
					class="form-control" id="groceryName" name="groceryName"
					value="${grocery.groceryName}" required>
			</div>
			<div class="form-group">
				<label for="description">Description:</label>
				<textarea class="form-control" id="description" name="description"
					rows="4" required>${grocery.description}</textarea>
			</div>
			<div class="form-group">
				<label for="grocery_price">Price:</label> <input type="text"
					class="form-control" id="grocery_price" name="grocery_price"
					value="${grocery.grocery_price}" required>
			</div>
			<div class="form-group">
				<label for="in_stock">In Stock:</label> <input type="number"
					class="form-control" id="in_stock" name="in_stock"
					value="${grocery.in_stock}" required>
			</div>
			<div class="form-group">
				<label for="category_id">Category:</label> <select
					class="form-control" id="category_id" name="category_id" required>
					<c:forEach items="${categories}" var="category">
						<option value="${category.category_id}"
							<c:if test="${category.category_id == grocery.category.category_id}">selected</c:if>>${category.category_name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="imageURL">Image:</label> <input type="file"
					class="form-control-file" id="imageURL" name="imageURL">
				<c:if test="${not empty grocery.imageURL}">
					<p>
						Current Image: <img
							src="${pageContext.request.contextPath}/uploaded/${grocery.imageURL}"
							alt="Grocery Image">
					</p>
				</c:if>
			</div>
			<button type="submit" class="btn btn-primary">Update Grocery</button>
		</form>

		<c:if test="${not empty message}">
			<div class="alert alert-info mt-3">${message}</div>
		</c:if>

		<a href="${pageContext.request.contextPath}/groceries/list"
			class="btn btn-secondary mt-3">Back to Grocery List</a>
	</div>

	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<br>
	<br>
</body>
</html>
