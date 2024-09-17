<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Invoice Details</h1>
        <c:if test="${not empty invoice}">
            <p><strong>Order ID:</strong> ${invoice.order_id}</p>
            <p><strong>Item:</strong> ${invoice.grocery.groceryName}</p>
            <p><strong>User:</strong> ${invoice.users.user_Name}</p>
            <p><strong>Total Amount:</strong> ${invoice.totalAmount}</p>
            <p><strong>Status:</strong> ${invoice.orderStatus}</p>
            <p><strong>Order Date:</strong> ${invoice.order_date}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
    </div>
</body>
</html>
