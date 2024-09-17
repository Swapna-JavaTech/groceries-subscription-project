<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"
	import="com.crimsonlogic.groceriessubbookingsystem.entity.Users"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>User Wallet</title>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	padding-top: 20px;
	background-color: #f8f9fa;
}

.container {
	max-width: 900px;
}

.wallet-info {
	margin-bottom: 30px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #ffffff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.wallet-info p {
	margin-bottom: 10px;
}

.wallet-info .btn-add-money {
	background-color: rgba(56, 51, 37, 0.8);
	color: white;
	border: none;
}

.wallet-info .btn-add-money:hover {
	background-color: rgba(56, 51, 37, 1);
	color: #f8f9fa;
}

.btn-secondary {
	background-color: #6c757d;
	border: none;
}

.btn-secondary:hover {
	background-color: #5a6268;
}

table {
	margin-top: 20px;
}

.table th {
	background-color: rgba(56, 51, 37, 0.8);
	color: white;
}

.table td {
	vertical-align: middle;
}

.card-header {
	background-color: rgba(56, 51, 37, 0.8);
	color: white;
	font-weight: bold;
	text-align: center;
}

.card-body {
	padding: 20px;
}

.toggle-btn {
	margin-bottom: 20px;
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
	<!-- Header Section -->
	<jsp:include page="/customerHeader.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<div class="container">
		<h2 class="mb-4 text-center">Wallet Information</h2>
		<div class="wallet-info card p-4 mb-4">
			<div class="card-header">Wallet Details</div>
			<div class="card-body">
				<p>
					<strong>User ID:</strong> ${wallet.user.user_Name}
				</p>
				<p>
					<strong>Wallet Balance:</strong> $ ${wallet.balance}
				</p>

				<form action="${pageContext.request.contextPath}/wallets/recharge"
					method="post">
					<%
					Users user = (Users) request.getSession().getAttribute("user");
					%>
					<input type="hidden" name="user_id" value="<%=user.getUser_id()%>">
					<div class="form-group">
						<label for="amount">Amount to Recharge:</label> <input
							type="number" class="form-control" name="amount" required />
					</div>
					<button type="submit" class="btn btn-add-money">Add Money</button>
				</form>
			</div>
		</div>

		<h3 class="text-center mb-3">Transaction History</h3>
		<button class="btn btn-secondary toggle-btn"
			onclick="toggleTransactionHistory()">Transaction History</button>
		<div id="transactionHistory" style="display: none;">
			<table class="table table-bordered table-striped">
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

	<br>
	<br>
	<br>
	<jsp:include page="/footer.jsp"></jsp:include>
	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
