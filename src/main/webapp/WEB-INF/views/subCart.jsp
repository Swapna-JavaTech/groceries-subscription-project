<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"
	import="com.crimsonlogic.groceriessubbookingsystem.entity.Subscription"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Subscription Cart</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
.subscription-table th, .subscription-table td {
	vertical-align: middle;
}

.subscription-table img {
	width: 100px; /* Adjust width */
	height: auto;
}

.btn-back {
	margin-top: 20px;
}

.total-amount {
	font-weight: bold;
	font-size: 1.2em;
}

.frequency-display {
	font-style: italic;
}

.quantity-buttons {
	display: flex;
	align-items: center;
}

.quantity-buttons button {
	width: 30px; /* Reduced button width */
	height: 30px; /* Reduced button height */
	font-size: 1.2rem; /* Reduced font size */
	line-height: 1;
	border: none;
	background-color: rgba(220, 53, 69, 0.8); /* Danger color (red) */
	color: white;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}

.quantity-buttons button:hover {
	background-color: rgba(220, 53, 69, 1); /* Darker red on hover */
}

.quantity-buttons span {
	display: inline-block;
	width: 30px; /* Match width to button size */
	height: 30px; /* Match height to button size */
	line-height: 30px;
	text-align: center;
	font-size: 1.2rem; /* Match font size to button */
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	background-color: #fff;
}

.btn-primary {
	background-color: rgba(56, 51, 37, 0.8); /* Custom color */
	border-color: rgba(56, 51, 37, 0.8); /* Match border color */
}

.btn-primary:hover {
	background-color: rgba(56, 51, 37, 1); /* Darker color on hover */
	border-color: rgba(56, 51, 37, 1); /* Match border color on hover */
}

.btn-light {
	background-color: rgba(56, 51, 37, 0.8); /* Custom color */
	border-color: rgba(56, 51, 37, 0.8); /* Match border color */
}

.btn-light:hover {
	background-color: rgba(56, 51, 37, 1); /* Darker color on hover */
	border-color: rgba(56, 51, 37, 1); /* Match border color on hover */
}

.text-center {
	color: #CD5C5C; /* Match the icon color */
}
</style>
</head>
<body>
	<!-- Header Section -->
	<jsp:include page="/customerHeader.jsp"></jsp:include>
	<br>
	<br>
	<br>
	<div class="container mt-5">
		<h2 class="mb-4 text-center">Subscription Cart</h2>
		<c:choose>
			<c:when test="${empty subCart}">
				<p class="text-center">No subscriptions in the cart</p>
			</c:when>
			<c:otherwise>
				<table class="table table-bordered subscription-table">
					<thead class="btn-secondary">
						<tr>
							<th>Item</th>
							<th>Image</th>
							<th>Price</th>
							<th>Frequency</th>
							<th>Start Date</th>
							<th>Quantity</th>
							<th>Total</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="subscription" items="${subCart}"
							varStatus="status">
							<tr>
								<td>${subscription.groceries.groceryName}</td>
								<td><img
									src="${pageContext.request.contextPath}/uploaded/${subscription.groceries.imageURL}"
									alt="Image of ${subscription.groceries.groceryName}"></td>
								<td>$${subscription.groceries.grocery_price}</td>
								<td class="frequency-display">${subscription.frequency}</td>
								<td><fmt:formatDate value="${subscription.startedAt}"
										pattern="yyyy-MM-dd" /></td>
								<td>
									<div class="quantity-buttons">
										<form
											action="${pageContext.request.contextPath}/subscription/reducequantity"
											method="post" style="display: inline;">
											<input type="hidden" name="index" value="${status.index}">
											<button type="submit" class="btn btn-light btn-sm">
												<i class="fas fa-minus"></i>
											</button>
										</form>
										<span>${subscription.quantity}</span>
										<form
											action="${pageContext.request.contextPath}/subscription/addquantity"
											method="post" style="display: inline;">
											<input type="hidden" name="index" value="${status.index}">
											<button type="submit" class="btn btn-light btn-sm">
												<i class="fas fa-plus"></i>
											</button>
										</form>
									</div>
								</td>
								<td>$${subscription.amount}</td>
								<td>
									<form
										action="${pageContext.request.contextPath}/subscription/subremove"
										method="post" style="display: inline;">
										<input type="hidden" name="index" value="${status.index}">
										<button type="submit" class="btn btn-danger btn-sm">Remove</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="text-right total-amount">Total Amount:
					$${subTotalAmount}</div>
				<div class="text-center mt-3">
					<a
						href="${pageContext.request.contextPath}/subscription/subcheckout"
						class="btn btn-primary">Proceed to Payment</a>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="text-center btn-back">
			<a href="${pageContext.request.contextPath}/groceries/list"
				class="btn btn-secondary">Add More Items</a>
		</div>
	</div>

	<!-- Insufficient Balance Modal -->
	<div class="modal fade" id="insufficientBalanceModal" tabindex="-1"
		role="dialog" aria-labelledby="insufficientBalanceModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="insufficientBalanceModalLabel">Insufficient
						Balance</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Your wallet balance is insufficient to
					complete this transaction. Please recharge your wallet.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<a href="${pageContext.request.contextPath}/wallets/wallet"
						class="btn btn-primary">Recharge Wallet</a>
				</div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		$(document)
				.ready(
						function() {
							<c:if test="${not empty message && message == 'Insufficient wallet balance. Please recharge your wallet.'}">
							$('#insufficientBalanceModal').modal('show');
							</c:if>
						});
	</script>
</body>
</html>
