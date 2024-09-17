<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Subscription List</title>
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
        <h1 class="mb-4">Subscription List</h1>

        <!-- Search Bar -->
        <div class="form-group search-bar">
            <label for="searchInput">Search Subscriptions</label>
            <input type="text" class="form-control" id="searchInput" placeholder="Search by item name, user name, status, date, or frequency">
        </div>

        <c:if test="${not empty subscriptions}">
            <table class="table table-striped table-hover" id="subscriptionTable">
                <thead class="table-header">
                    <tr>
                        <th>User</th>
                        <th>Item</th>
                        <th>Frequency</th>
                        <th>Amount</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Start Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="subscription" items="${subscriptions}">
                        <tr>
                            <td><c:out value="${subscription.user.user_Name}" /></td>
                            <td><c:out value="${subscription.groceries.groceryName}" /></td>
                            <td><c:out value="${subscription.frequency}" /></td>
                            <td><c:out value="${subscription.amount}" /></td>
                            <td><c:out value="${subscription.quantity}" /></td>
                            <td><c:out value="${subscription.subStatus}" /></td>
                            <td><c:out value="${subscription.startedAt}" /></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/subscription/updateStatus" method="post" class="form-inline">
                                    <input type="hidden" name="subscriptionId" value="${subscription.subscription_id}"> 
                                    <select name="subStatus" class="form-control mr-2">
                                        <option value="Processed" ${subscription.subStatus == 'Processed' ? 'selected' : ''}>Processed</option>
                                        <option value="Pending" ${subscription.subStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                                        <option value="Shipped" ${subscription.subStatus == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                        <option value="Delivered" ${subscription.subStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                    </select>
                                    <button type="submit" class="btn btn-icon btn-sm">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty subscriptions}">
            <p>No subscriptions found.</p>
        </c:if>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#searchInput').on('input', function() {
                var searchTerm = $(this).val().toLowerCase();
                $('#subscriptionTable tbody tr').each(function() {
                    var row = $(this);
                    var userName = row.find('td').eq(0).text().toLowerCase();
                    var itemName = row.find('td').eq(1).text().toLowerCase();
                    var frequency = row.find('td').eq(2).text().toLowerCase();
                    var status = row.find('td').eq(5).text().toLowerCase();
                    var startDate = row.find('td').eq(6).text().toLowerCase();

                    var showRow = userName.includes(searchTerm) || 
                                   itemName.includes(searchTerm) || 
                                   frequency.includes(searchTerm) || 
                                   status.includes(searchTerm) || 
                                   startDate.includes(searchTerm);

                    row.toggle(showRow);
                });
            });
        });
    </script>

    <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
