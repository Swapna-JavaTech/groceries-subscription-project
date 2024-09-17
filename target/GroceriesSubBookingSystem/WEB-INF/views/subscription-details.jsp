<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" import="com.crimsonlogic.groceriessubbookingsystem.entity.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grocery Subscription</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card {
            width: 22rem; /* Increased width */
            padding: 15px; /* Increased padding */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: auto;
        }
        .card-img-top {
            height: 180px; /* Increased height */
            object-fit: cover;
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff;
        }
        .card-text {
            font-size: 1rem;
            color: #6c757d;
        }
        .price {
            font-weight: bold;
            color: #28a745;
        }
        .stock {
            color: #dc3545;
        }
        .category {
            font-style: italic;
            color: #17a2b8;
        }
        .frequency-options {
            display: none;
            margin-top: 10px;
        }
         .quantity-display {
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <jsp:include page="/customerHeader.jsp"></jsp:include>
    <br><br><br>
    <div class="container mt-5">
        <h1 class="mb-4 text-center">Grocery</h1>
        <div class="card">
            <img src="${pageContext.request.contextPath}/uploaded/${grocery.imageURL}" class="card-img-top" alt="Image of ${grocery.groceryName}">
            <div class="card-body">
                <h5 class="card-title">${grocery.groceryName}</h5>
                <p class="card-text">${grocery.description}</p>
                <p class="card-text price">Price: $${grocery.grocery_price}</p>
                <p class="card-text stock">In Stock: ${grocery.in_stock}</p>
                <p class="card-text category">Category: ${grocery.category.category_name}</p>
                
                <form id="orderForm" action="${pageContext.request.contextPath}/subscription/submit" method="post">
                    <input type="hidden" name="grocery_id" value="${grocery.grocery_id}">
                    <%
                        Users user = (Users) request.getSession().getAttribute("user");
                    %>
                    <input type="hidden" name="user_id" value="<%= user.getUser_id() %>">
                    
                    <div class="form-group">
                        <label for="frequency">Frequency:</label>
                        <select id="frequency" name="frequency" class="form-control" onchange="updateFrequencyOptions()">
                            <option value="daily">Daily</option>
                            <option value="weekly">Weekly</option>
                            <option value="monthly">Monthly</option>
                        </select>
                    </div>

                    <div id="dailyOptions" class="frequency-options">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" class="form-control">
                    </div>
                    
                    <div id="weeklyOptions" class="frequency-options">
                        <label for="weekDay">Select Day:</label>
                        <select id="weekDay" name="weekDay" class="form-control">
                            <option value="sunday">Sunday</option>
                            <option value="monday">Monday</option>
                            <option value="tuesday">Tuesday</option>
                            <option value="wednesday">Wednesday</option>
                            <option value="thursday">Thursday</option>
                            <option value="friday">Friday</option>
                            <option value="saturday">Saturday</option>
                        </select>
                    </div>

                    <div id="monthlyOptions" class="frequency-options">
                        <label for="dayOfMonth">Day of Month:</label>
                        <input type="number" id="dayOfMonth" name="dayOfMonth" class="form-control" min="1" max="31">
                    </div>
                    
                    <p class="quantity-display">Quantity: 1</p>
                    <input type="hidden" name="quantity" value="1">

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function updateFrequencyOptions() {
            const frequency = document.getElementById('frequency').value;
            document.getElementById('dailyOptions').style.display = frequency === 'daily' ? 'block' : 'none';
            document.getElementById('weeklyOptions').style.display = frequency === 'weekly' ? 'block' : 'none';
            document.getElementById('monthlyOptions').style.display = frequency === 'monthly' ? 'block' : 'none';
        }

        function setMinDate() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').setAttribute('min', today);
        }

        document.addEventListener('DOMContentLoaded', function() {
            updateFrequencyOptions();
            setMinDate();
        });
    </script>
    <br>
     <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>