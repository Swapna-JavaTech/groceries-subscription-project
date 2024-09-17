<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .message {
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
 <jsp:include page="/customerHeader.jsp"></jsp:include>
    <br><br>
    <div class="container">
        <h1>Payment History</h1>
        <div class="message">
            <c:if test="${not empty message}">
                <p>${message}</p>
            </c:if>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>User</th>
                    <th>Amount</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="payment" items="${paymentHistory}">
                    <tr>
                        <td>${payment.payment_id}</td>
                        <td>${payment.user.user_Name}</td>
                        <td>${payment.amount}</td>
                        <td>${payment.payment_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <br><br>
    
 <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>