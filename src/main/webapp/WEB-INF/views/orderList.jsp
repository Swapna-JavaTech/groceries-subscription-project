<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order List</title>
<link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Font Awesome -->
<style>
.table-header {
    background-color: rgba(199, 204, 218, 0.8);
}

.btn-icon {
    background: transparent;
    border: none;
    color: rgba(56, 51, 37, 0.8); /* Custom color for the icon */
}

.btn-icon:hover {
    color: rgba(0, 0, 0, 0.8); /* Darker color on hover */
}

.btn-icon i {
    font-size: 1.25rem; /* Adjust the size of the icon */
}

/* Custom styles for the search bar */
.search-bar {
    margin-bottom: 20px;
}

.search-bar label {
    color: #007bff; /* Custom color for the label text */
    font-weight: bold; /* Optional: make the label text bold */
}

.search-bar input {
    border-radius: 0.25rem; /* Rounded corners */
    border: 1px solid #ced4da; /* Light gray border */
    padding: 10px 15px; /* Padding inside the search bar */
    font-size: 1rem; /* Adjust font size */
    color: #333; /* Custom text color */
    background-color: #f9f9f9; /* Light background color */
}

.search-bar input:focus {
    border-color: #80bdff; /* Blue border on focus */
    outline: none; /* Remove default outline */
    box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25); /* Blue shadow on focus */
    background-color: #fff; /* White background on focus */
    color: #000; /* Black text color on focus */
}
</style>
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
    <br>
    <br>
    <br>

    <div class="container mt-5">
        <h1 class="mb-4">Order List</h1>

        <!-- Search Bar -->
        <div class="form-group search-bar">
            <label for="searchInput">Search Orders</label>
            <input type="text" class="form-control" id="searchInput" placeholder="Search by item name, user name, date, or status">
        </div>

        <c:if test="${not empty orders}">
            <table class="table table-striped table-hover" id="orderTable">
                <thead class="table-header">
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
                            <td><a href="#" class="order-link" data-order-id="${order.order_id}">${order.order_id}</a></td>
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
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                    <button type="submit" class="btn btn-icon btn-sm">
                                        <i class="fas fa-edit"></i>
                                        <!-- Font Awesome Edit Icon -->
                                    </button>
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

    <!-- Modal -->
    <div class="modal fade" id="invoiceModal" tabindex="-1" aria-labelledby="invoiceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="invoiceModalLabel">Invoice Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Invoice details will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <br>
    <br>
    <br>
    <br>
    <jsp:include page="/footer.jsp"></jsp:include>

    <c:if test="${updateSuccess}">
        <script>
            alert('Order status updated successfully');
        </script>
    </c:if>

    <script>
        $(document).ready(function() {
            $('.order-link').on('click', function(e) {
                e.preventDefault();
                var orderId = $(this).data('order-id');
                $.ajax({
                    url : '${pageContext.request.contextPath}/orders/invoice',
                    type : 'GET',
                    data : {
                        orderId : orderId
                    },
                    success : function(data) {
                        $('#invoiceModal .modal-body').html(data);
                        $('#invoiceModal').modal('show');
                    }
                });
            });

            $('#searchInput').on('input', function() {
                var searchTerm = $(this).val().toLowerCase();
                $('#orderTable tbody tr').each(function() {
                    var row = $(this);
                    var itemName = row.find('td').eq(1).text().toLowerCase();
                    var userName = row.find('td').eq(2).text().toLowerCase();
                    var orderDate = row.find('td').eq(5).text().toLowerCase();
                    var status = row.find('td').eq(4).text().toLowerCase();
                    
                    var showRow = itemName.includes(searchTerm) || 
                                   userName.includes(searchTerm) || 
                                   orderDate.includes(searchTerm) || 
                                   status.includes(searchTerm);

                    row.toggle(showRow);
                });
            });
        });
    </script>
</body>
</html>
