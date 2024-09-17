<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Groceries List</title>
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"> <!-- Your custom styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> <!-- Font Awesome -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            transition: transform 0.2s;
            width: 18rem; /* Adjust the width as needed */
            height: auto; /* Let the height adjust automatically */
            padding: 5px; /* Reduce padding */
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card-img-top {
            height: 150px; /* Keep the image height */
            object-fit: cover;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: bold;
        }
        .card-text {
            font-size: 1rem;
        }
        .price {
            font-weight: bold;
            color: #28a745;
        }
        .stock {
            color: #dc3545;
        }
        .btn-container {
            margin-top: 0.5rem; /* Reduce margin */
            display: flex;
            justify-content: space-between;
        }
        .icon-btn {
            font-size: 2.5rem;
            color: #007bff;
        }
        .icon-btn:hover {
            color: #0056b3;
        }
        .search-wrapper {
            display: flex;
            max-width: 400px;
            margin: 0 auto;
        }
        .search-wrapper input {
            flex: 1;
        }
        .search-wrapper .fa-search {
            display: flex;
            align-items: center;
            padding: 0 10px;
            color: #6c757d; /* Gray color for the icon */
        }
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
    <br><br><br>

    <div class="container mt-5">
        <h1 class="mb-4 text-center">Groceries List</h1>
        
        <!-- Search Bar with Icon Next to Input -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="search-wrapper">
                    <input type="text" id="search" class="form-control" placeholder="Search by name or category">
                    <i class="fas fa-search"></i>
                </div>
            </div>
        </div>

        <div class="row" id="groceryList">
            <%-- Assuming 'groceries' is a List<Groceries> object passed to the JSP --%>
            <c:forEach var="grocery" items="${groceries}">
                <div class="col-md-4 mb-4 grocery-item" data-name="${grocery.groceryName}" data-category="${grocery.category.category_name}">
                    <div class="card shadow-sm">
                        <img src="${pageContext.request.contextPath}/uploaded/${grocery.imageURL}" class="card-img-top" alt="Image of ${grocery.groceryName}">
                        <div class="card-body">
                            <h5 class="card-title">${grocery.groceryName}</h5>
                            <p class="card-text">${grocery.description}</p>
                            <p class="card-text price">Price: $${grocery.grocery_price}</p>
                            <c:choose>
                                <c:when test="${sessionScope.userRole eq 'Seller'}">
                                    <p class="card-text stock">In Stock: ${grocery.in_stock}</p>
                                </c:when>
                            </c:choose>
                            <p class="category">Category: ${grocery.category.category_name}</p>
                            <div class="btn-container">
                                <a href="${pageContext.request.contextPath}/orders/order?groceryId=${grocery.grocery_id}" class="icon-btn"><i class="fas fa-shopping-cart"></i></a>
                                <a href="${pageContext.request.contextPath}/subscription/sub?groceryId=${grocery.grocery_id}" class="icon-btn"><i class="fas fa-bell"></i></a>
                                <c:choose>
                                    <c:when test="${sessionScope.userRole eq 'Seller'}">
                                        <a href="${pageContext.request.contextPath}/groceries/edit/${grocery.grocery_id}" class="icon-btn"><i class="fas fa-edit"></i></a>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- JavaScript for Search -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('search');
            const groceryItems = document.querySelectorAll('.grocery-item');

            function filterItems() {
                const searchTerm = searchInput.value.toLowerCase();

                groceryItems.forEach(item => {
                    const name = item.getAttribute('data-name').toLowerCase();
                    const category = item.getAttribute('data-category').toLowerCase();

                    const matchesSearch = name.includes(searchTerm) || category.includes(searchTerm);

                    if (matchesSearch) {
                        item.style.display = '';
                    } else {
                        item.style.display = 'none';
                    }
                });
            }

            searchInput.addEventListener('input', filterItems);
        });
    </script>

<br><br><br><br><br><br><br>
    <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>


