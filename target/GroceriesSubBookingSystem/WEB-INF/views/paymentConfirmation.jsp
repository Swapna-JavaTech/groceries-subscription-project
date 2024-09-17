<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
  <!-- Header Section -->
    <jsp:include page="/customerHeader.jsp"></jsp:include>
    <br><br><br>
    <div class="container mt-5">
        <h2 class="mb-4 text-center">Payment Confirmation</h2>
        <div class="alert alert-success">
            ${message}
        </div>
        
        <p>Your order has been successfully processed.</p>
        <p>Thank you for choosing to our service.</p>
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/orders/viewOrders" class="btn btn-primary">View Orders</a>
            <a href="${pageContext.request.contextPath}/groceries/list" class="btn btn-primary">Continue Shopping</a>
        </div>
    </div>
    <br><br><br><br>
       <!-- Footer Section -->
    <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
