<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" import="com.crimsonlogic.groceriessubbookingsystem.entity.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Grocery</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card {
            width: 20rem; /* Increased width */
            padding: 10px; /* Reduce padding */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add shadow */
            margin: auto; /* Center the card */
        }
        .card-img-top {
            height: 150px; /* Increased height */
            object-fit: cover;
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff; /* Blue color */
        }
        .card-text {
            font-size: 1rem;
            color: #6c757d; /* Gray color */
        }
        .price {
            font-weight: bold;
            color: #28a745; /* Green color */
        }
        .stock {
            color: #dc3545; /* Red color */
        }
        .category {
            font-style: italic;
            color: #17a2b8; /* Teal color */
        }
        .quantity-control {
            display: flex;
            align-items: center;
        }
        .quantity-control button {
            width: 30px;
            height: 30px;
            font-size: 1.2rem;
            line-height: 1;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        .quantity-control input {
            width: 50px;
            text-align: center;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            margin: 0 5px;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <jsp:include page="/customerHeader.jsp"></jsp:include>
    <div class="container mt-5">
        <h1 class="mb-4 text-center">Grocery</h1>
        <div class="card">
            <img src="${pageContext.request.contextPath}/uploaded/${grocery.imageURL}" class="card-img-top" alt="Image of ${grocery.groceryName}">
            <div class="card-body">
                <h5 class="card-title">${grocery.groceryName}</h5>
                <p class="card-text">${grocery.description}</p>
                <p class="card-text price">Price: $${grocery.grocery_price}</p>
                <p class="card-text stock">In Stock: ${grocery.in_stock}</p>
                <p class="category">Category: ${grocery.category.category_name}</p>
                <form id="orderForm" action="${pageContext.request.contextPath}/orders/submit" method="post">
                    <input type="hidden" name="grocery_id" value="${grocery.grocery_id}">
                    <%
                        Users user = (Users) request.getSession().getAttribute("user");
                    %>
                    <input type="hidden" name="user_id" value="<%= user.getUser_id() %>">
                    <p class="quantity-display">Quantity: 1</p>
                    <input type="hidden" name="quantity" value="1">
                   
                    <button type="submit" class="btn btn-primary">Add to Cart</button>
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
