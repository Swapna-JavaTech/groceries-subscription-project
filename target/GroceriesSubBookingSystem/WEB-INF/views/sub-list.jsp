<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false" import="com.crimsonlogic.groceriessubbookingsystem.entity.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Subscriptions</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="my-4">All Subscriptions</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Item</th>
                    <th>Frequency</th>
                    <th>Amount</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Start Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="subscription" items="${subscriptions}">
                    <tr data-id="${subscription.subscription_id}">
                        <td><c:out value="${subscription.user.user_Name}" /></td>
                        <td><c:out value="${subscription.groceries.groceryName}" /></td>
                        <td><c:out value="${subscription.frequency}" /></td>
                        <td><c:out value="${subscription.amount}" /></td>
                        <td><c:out value="${subscription.quantity}" /></td>
                        <td><c:out value="${subscription.subStatus}" /></td>
                        <td><c:out value="${subscription.startedAt}" /></td>
                        <td>
                            <button class="btn btn-primary btn-sm update-status-btn" data-id="${subscription.subscription_id}">Update Status</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Modal for updating status -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateStatusModalLabel">Update Subscription Status</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="updateStatusForm">
                        <input type="hidden" id="eventId" name="eventId">
                        <div class="form-group">
                            <label for="status">New Status:</label>
                            <select class="form-control" id="status" name="status" required>
                                <option value="">-- Select Status --</option>
                                <option value="Processed">Processed</option>
                                <option value="Pending">Pending</option>
                                <option value="Shipped">Shipped</option>
                                <option value="Delivered">Delivered</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Update Status</button>
                    </form>
                    <div id="message" class="mt-3"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Attach click event to all update status buttons
            $('.update-status-btn').click(function() {
                var subscriptionId = $(this).data('id');
                $('#eventId').val(subscriptionId);
                $('#updateStatusModal').modal('show');
            });

            // Handle form submission
            $('#updateStatusForm').submit(function(e) {
                e.preventDefault();
                var formData = $(this).serialize();
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/subscription/update-status',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        if (response.success) {
                            $('#message').html('<div class="alert alert-success">Status updated successfully!</div>');
                            // Update the status in the table
                            $('tr[data-id="' + $('#eventId').val() + '"] td').eq(5).text($('#status').val());
                        } else {
                            $('#message').html('<div class="alert alert-danger">Failed to update status: ' + response.message + '</div>');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error: ', status, error);
                        $('#message').html('<div class="alert alert-danger">An error occurred while updating the status.</div>');
                    }
                });
            });
        });
    </script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
