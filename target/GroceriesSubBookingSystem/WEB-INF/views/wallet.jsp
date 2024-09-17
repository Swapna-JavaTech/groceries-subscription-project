<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" import="com.crimsonlogic.groceriessubbookingsystem.entity.Users"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Wallet</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 20px;
        }
        .container {
            max-width: 800px;
        }
        .wallet-info {
            margin-bottom: 30px;
        }
        table {
            margin-top: 20px;
        }
    </style>
    <script>
        function toggleTransactionHistory() {
            var x = document.getElementById("transactionHistory");
            if (x.style.display === "none") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2 class="mb-4">Wallet Information</h2>
        <div class="wallet-info card p-3 mb-4">
            <p><strong>User ID:</strong> ${wallet.user.user_id}</p>
            <p><strong>Wallet Balance:</strong> $ ${wallet.balance}</p>

            <form action="${pageContext.request.contextPath}/wallets/recharge" method="post">
                <%
                    Users user = (Users) request.getSession().getAttribute("user");
                %>
                <input type="hidden" name="user_id" value="<%= user.getUser_id() %>">
                <div class="form-group">
                    <label for="amount">Amount to Recharge:</label>
                    <input type="number" class="form-control" name="amount" required />
                </div>
                <button type="submit" class="btn btn-primary">Add Money</button>
            </form>
        </div>

        <h3>Transaction History</h3>
        <button class="btn btn-secondary" onclick="toggleTransactionHistory()">Toggle Transaction History</button>
        <div id="transactionHistory" style="display:none;">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Transaction ID</th>
                        <th>Amount</th>
                        <th>Type</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="transaction" items="${transactions}">
                        <tr>
                            <td>${transaction.transactionId}</td>
                            <td>$${transaction.amount}</td>
                            <td>${transaction.transactionType}</td>
                            <td>${transaction.transactionDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
