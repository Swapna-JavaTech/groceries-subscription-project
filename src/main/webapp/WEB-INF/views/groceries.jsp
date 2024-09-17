<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Groceries List</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css">
<!-- Your custom styles -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Font Awesome -->
<style>
<
style>body {
	background-color: #f8f9fa;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 30px;
}

.card {
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border: none;
	border-radius: 15px;
	max-width: 300px; /* Reduce card width */
	margin: 0 auto; /* Center card */
}

.card:hover {
	transform: scale(1.05);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.card-img-top {
	height: 150px; /* Reduce height of image */
	object-fit: cover;
	border-top-left-radius: 15px;
	border-top-right-radius: 15px;
}

.card-body {
	padding: 1rem; /* Adjust padding for a smaller card */
}

.card-title {
	font-size: 1.25rem; /* Reduce card title size */
	font-weight: bold;
	margin-bottom: 0.5rem;
}

.card-text {
	font-size: 0.875rem; /* Reduce text size */
	color: #6c757d;
	margin-bottom: 0.5rem;
}

.price {
	font-weight: bold;
	color: #28a745;
}

.stock {
	color: #dc3545;
}

.btn-container {
	margin-top: 1rem;
	display: flex;
	justify-content: space-between;
}

.icon-btn {
	font-size: 2rem; /* Increase icon size */
	color: rgba(159, 57, 74, 0.804);
}

.icon-btn:hover {
	color: #0056b3;
}

.search-wrapper {
	display: flex;
	max-width: 500px;
	margin: 0 auto;
	border: 1px solid #ced4da;
	border-radius: 25px;
	overflow: hidden;
	background-color: #fff;
}

.search-wrapper input {
	flex: 1;
	border: none;
	padding: 0.75rem;
	border-radius: 25px 0 0 25px;
}

.search-wrapper .fa-search {
	display: flex;
	align-items: center;
	padding: 0 15px;
	background-color: #e9ecef;
	color: #6c757d;
	border-radius: 0 25px 25px 0;
}

.groceries-list-title {
	color: #343a40;
	font-weight: bold;
}

.no-items-message {
	display: none;
	color: #dc3545;
	font-size: 1.25rem;
	text-align: center;
	margin-top: 20px;
}
</style>

</style>
</head>
<body>

	<!-- Conditionally Render Header -->
	<c:choose>
		<c:when test="${sessionScope.userRole eq 'Seller'}">
			<!-- Seller Header -->
			<jsp:include page="/sellerHeader.jsp"></jsp:include>
		</c:when>
		<c:otherwise>
			<!-- Customer Header -->
			<jsp:include page="/customerHeader.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>
	<br>
	<br>
	<br>
	<div class="container">
		<h1 class="mb-4 text-center groceries-list-title">Groceries List</h1>

		<!-- Search Bar with Icon Next to Input -->
		<div class="row mb-4">
			<div class="col-md-12">
				<div class="search-wrapper">
					<input type="text" id="search" class="form-control"
						placeholder="Search by name or category"> <i
						class="fas fa-search"></i>
				</div>
			</div>
		</div>

		<!-- No items found message -->
		<div id="noItemsMessage" class="no-items-message">No items found
			for your search.</div>

		<div class="row" id="groceryList">
			<%-- Assuming 'groceries' is a List<Groceries> object passed to the JSP --%>
			<c:forEach var="grocery" items="${groceries}">
				<div class="col-md-4 mb-4 grocery-item"
					data-name="${grocery.groceryName}"
					data-category="${grocery.category.category_name}">
					<div class="card shadow-sm">
						<img
							src="${pageContext.request.contextPath}/uploaded/${grocery.imageURL}"
							class="card-img-top" alt="Image of ${grocery.groceryName}">
						<div class="card-body">
							<h5 class="card-title">${grocery.groceryName}</h5>
							<p class="card-text">${grocery.description}</p>
							<p class="card-text price">Price: $${grocery.grocery_price}</p>
							<c:choose>
								<c:when test="${sessionScope.userRole eq 'Seller'}">
									<p class="card-text stock">In Stock: ${grocery.in_stock}</p>
								</c:when>
							</c:choose>
							<p class="card-text">Category:
								${grocery.category.category_name}</p>
							<div class="btn-container">
							<c:choose>
                                            <c:when test="${sessionScope.userRole eq 'Customer'}">
								<a
									href="${pageContext.request.contextPath}/orders/order?groceryId=${grocery.grocery_id}"
									class="icon-btn" title="Order"><i
									class="fas fa-shopping-cart"></i></a> 
									<a
									href="${pageContext.request.contextPath}/subscription/sub?groceryId=${grocery.grocery_id}"
									class="icon-btn" title="Subscribe"><i class="fas fa-bell"></i></a>
									</c:when></c:choose>
								<c:choose>
									<c:when test="${sessionScope.userRole eq 'Seller'}">
										<a
											href="${pageContext.request.contextPath}/groceries/edit/${grocery.grocery_id}"
											class="icon-btn" title="Edit"><i class="fas fa-edit"></i></a>
									</c:when>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<!-- JavaScript for Search -->
	<script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('search');
            const groceryItems = document.querySelectorAll('.grocery-item');
            const noItemsMessage = document.getElementById('noItemsMessage');

            function filterItems() {
                const searchTerm = searchInput.value.toLowerCase();
                let anyItemsVisible = false;

                groceryItems.forEach(item => {
                    const name = item.getAttribute('data-name').toLowerCase();
                    const category = item.getAttribute('data-category').toLowerCase();

                    const matchesSearch = name.includes(searchTerm) || category.includes(searchTerm);

                    if (matchesSearch) {
                        item.style.display = '';
                        anyItemsVisible = true;
                    } else {
                        item.style.display = 'none';
                    }
                });

                // Display message if no items are visible
                if (anyItemsVisible) {
                    noItemsMessage.style.display = 'none';
                } else {
                    noItemsMessage.style.display = 'block';
                }
            }

            searchInput.addEventListener('input', filterItems);
        });
    </script>

	<br>
	<br>
	<br>
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
