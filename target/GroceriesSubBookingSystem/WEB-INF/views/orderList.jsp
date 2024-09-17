<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
        <h1 class="mb-4">Order List</h1>
        <c:if test="${not empty orders}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Item</th>
                        <th>User</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Order Date</th>
                        <th>Action</th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td><a href="${pageContext.request.contextPath}/orders/invoice?orderId=${order.order_id}">${order.order_id}</a></td>
                            <td>${order.grocery.groceryName}</td>
                            <td>${order.users.user_Name}</td>
                            <td>${order.totalAmount}</td>
                            <td>${order.orderStatus}</td>
                            <td>${order.order_date}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/orders/updateStatus" method="post" class="form-inline">
                                    <input type="hidden" name="order_id" value="${order.order_id}">
                                    <select name="orderStatus" class="form-control mr-2">
                                    <c:choose>
                                            <c:when test="${sessionScope.userRole eq 'Seller'}">
                                        <option value="Pending" ${order.orderStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                                        <option value="Processed" ${order.orderStatus == 'Processed' ? 'selected' : ''}>Processed</option>
                                        <option value="Shipped" ${order.orderStatus == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                        <option value="Delivered" ${order.orderStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                        </c:when>
                                        <c:otherwise>
                                        <option value="Cancelled" ${order.orderStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                        </c:otherwise></c:choose>
                                    </select>
                                    <button type="submit" class="btn btn-primary">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty orders}">
            <p>No orders found.</p>
        </c:if>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <br><br><br><br>
     <jsp:include page="/footer.jsp"></jsp:include>
     
     <c:if test="${updateSuccess}">
        <script>
            alert('Order status updated successfully');
        </script>
    </c:if>
</body>
</html>
