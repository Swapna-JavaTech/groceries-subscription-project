<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Grocery Item</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
body {
	background-color:;
}

.container {
	margin-top: 2rem;
}

.card {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-header {
	background-color: #6c757d;
	color: #fff;
	font-size: 1.25rem;
}

.btn-submit {
	background-color: #28a745;
	border-color: #28a745;
}

.btn-submit:hover {
	background-color: #218838;
	border-color: #1e7e34;
}

.invalid-feedback {
	display: none;
}

.is-invalid ~ .invalid-feedback {
	display: block;
}
</style>
</head>
<body>

	<!-- Header Section -->
	<jsp:include page="/sellerHeader.jsp"></jsp:include>
	<br>
	<br>
	<br>

	<div class="container mt-4">
		<div class="card">
			<div class="card-header">Add Grocery Item</div>
			<c:if test="${not empty message}">
				<div class="alert alert-info mt-3">${message}</div>
			</c:if>

			<div class="card-body">
				<form action="${pageContext.request.contextPath}/groceries/add"
					method="post" enctype="multipart/form-data" id="groceryForm">
					<div class="form-group">
						<label for="groceryName">Grocery Name:</label> <input type="text"
							id="groceryName" name="groceryName" class="form-control"
							placeholder="Grocery Name" required />
						<div class="invalid-feedback">Name must be between 3 and 50
							characters and contain no numbers.</div>
					</div>
					<div class="form-group">
						<label for="description">Description:</label>
						<textarea id="description" name="description" class="form-control"
							placeholder="Description"></textarea>
					</div>
					<div class="form-group">
						<label for="grocery_price">Price:</label> <input type="number"
							id="grocery_price" name="grocery_price" class="form-control"
							placeholder="Price" step="0.01" required />
						<div class="invalid-feedback">Price must be a positive
							number.</div>
					</div>
					<div class="form-group">
						<label for="in_stock">In Stock:</label> <input type="number"
							id="in_stock" name="in_stock" class="form-control"
							placeholder="In Stock" required />
						<div class="invalid-feedback">Stock quantity must be a
							positive integer.</div>
					</div>
					<div class="form-group">
						<label for="imageURL">Image:</label> <input type="file"
							id="imageURL" name="imageURL" class="form-control-file" required />
					</div>
					<div class="form-group">
						<label for="category_id">Category:</label> <select
							id="category_id" name="category_id" class="form-control" required>
							<option value="" disabled selected>Select a category</option>
							<c:forEach var="category" items="${categories}">
								<option value="${category.category_id}">${category.category_name}</option>
							</c:forEach>
						</select>
					</div>
					<button type="submit" class="btn btn-secondary">Add
						Grocery</button>
				</form>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK3F8AyI6G2Njt5iZ8F4r5+I5U6Y5+F5u6j3Pq5FvWwZ4kB"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UOa0XWkDXhiyx5ZqC6Ww8i1Zz7E7p5X5M6eD4zP2A8iJ+P1L7Zn6j5aOzFj5K5I"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-tsQW6o6HtPj9f5d5i4W09E8B4m2pKsk5TrwPqGJ79fAaD/7kV4Rj2M7VbI7Z5O8w"
		crossorigin="anonymous"></script>
	<script>
        document.addEventListener('DOMContentLoaded', function () {
            var form = document.getElementById('groceryForm');
            var groceryName = document.getElementById('groceryName');
            var groceryPrice = document.getElementById('grocery_price');
            var inStock = document.getElementById('in_stock');
            
            function validateGroceryName() {
                var name = groceryName.value;
                var regex = /^[a-zA-Z\s]+$/; // Only letters and spaces allowed
                if (name.length < 3 || name.length > 50 || !regex.test(name)) {
                    groceryName.classList.add('is-invalid');
                } else {
                    groceryName.classList.remove('is-invalid');
                }
            }

            function validateGroceryPrice() {
                if (groceryPrice.value <= 0) {
                    groceryPrice.classList.add('is-invalid');
                } else {
                    groceryPrice.classList.remove('is-invalid');
                }
            }

            function validateInStock() {
                if (inStock.value <= 0) {
                    inStock.classList.add('is-invalid');
                } else {
                    inStock.classList.remove('is-invalid');
                }
            }

            groceryName.addEventListener('input', validateGroceryName);
            groceryPrice.addEventListener('input', validateGroceryPrice);
            inStock.addEventListener('input', validateInStock);
        });
    </script>
</body>
</html>
