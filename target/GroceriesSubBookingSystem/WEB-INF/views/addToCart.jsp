<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" import="com.crimsonlogic.groceriessubbookingsystem.entity.Order" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .cart-table th, .cart-table td {
            vertical-align: middle;
        }
        .cart-table img {
            width: 100px; /* Increased width */
            height: auto;
        }
        .btn-back {
            margin-top: 20px;
        }
        .total-amount {
            font-weight: bold;
            font-size: 1.2em;
        }
        .quantity-buttons {
            display: flex;
            align-items: center;
        }
        .quantity-buttons form {
            margin: 0 5px;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <jsp:include page="/customerHeader.jsp"></jsp:include>
    <br><br><br>
    <div class="container mt-5">
        <h2 class="mb-4 text-center">Shopping Cart</h2>
        <c:choose>
            <c:when test="${empty cart}">
                <p class="text-center">No items in the cart</p>
            </c:when>
            <c:otherwise>
                    <table class="table table-bordered cart-table">
                        <thead class="thead-light">
                            <tr>
                                <th>Item</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Date</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${cart}" varStatus="status">
                                <tr>
                                    <td>${order.grocery.groceryName}</td>
                                    <td><img src="${pageContext.request.contextPath}/uploaded/${order.grocery.imageURL}" alt="Image of ${order.grocery.groceryName}"></td>
                                    <td>$${order.grocery.grocery_price}</td>
                                    <td>${order.order_date}</td>
                                    <td>
                                        <div class="quantity-buttons">
                                            <form action="${pageContext.request.contextPath}/orders/reduceQuantity" method="post" style="display:inline;">
                                                <input type="hidden" name="index" value="${status.index}">
                                                <button type="submit" class="btn btn-light btn-sm"><i class="fas fa-minus"></i></button>
                                            </form>
                                            ${order.quantity}
                                            <form action="${pageContext.request.contextPath}/orders/addQuantity" method="post" style="display:inline;">
                                                <input type="hidden" name="index" value="${status.index}">
                                                <button type="submit" class="btn btn-light btn-sm"><i class="fas fa-plus"></i></button>
                                            </form>
                                        </div>
                                    </td>
                                    <td>$${order.totalAmount}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/orders/remove" method="post" style="display:inline;">
                                            <input type="hidden" name="index" value="${status.index}">
                                            <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="text-right total-amount">
                        Total Amount: $${totalAmount}
                    </div>
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/orders/checkout" class="btn btn-primary">Card</a>
                        <a href="${pageContext.request.contextPath}/orders/walletcheckout" class="btn btn-primary">wallet</a>
                    </div>
            </c:otherwise>
        </c:choose>
        <div class="text-center btn-back">
            <a href="${pageContext.request.contextPath}/groceries/list" class="btn btn-secondary">Add More Items</a>
        </div>
    </div>
    
    
    <!-- Insufficient Balance Modal -->
    <div class="modal fade" id="insufficientBalanceModal" tabindex="-1" role="dialog" aria-labelledby="insufficientBalanceModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="insufficientBalanceModalLabel">Insufficient Balance</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    Your wallet balance is insufficient to complete this transaction. Please recharge your wallet.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <a href="${pageContext.request.contextPath}/wallets/wallet" class="btn btn-primary">Recharge Wallet</a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
       <script>
        $(document).ready(function() {
            <c:if test="${not empty message && message == 'Insufficient wallet balance. Please recharge your wallet.'}">
                $('#insufficientBalanceModal').modal('show');
            </c:if>
        });
    </script>
</body>
</html>
