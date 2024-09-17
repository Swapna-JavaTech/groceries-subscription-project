<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false" import="com.crimsonlogic.groceriessubbookingsystem.entity.Users" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subscription Calendar</title>
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.min.js'></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <style>
        #calendar {
            width: 80%;
            max-width: 800px;
            margin: 0 auto;
            height: 500px;
        }
        .daily-event { background-color: #84e430 !important; border-color: #84e430 !important; }
        .weekly-event { background-color: #94daee !important; border-color: #94daee !important; }
        .monthly-event { background-color: #f7b7a3 !important; border-color: #f7b7a3 !important; }
        .fc-event { border-radius: 0 !important; }
        .cancelled-event { background-color: #d3d3d3 !important; border-color: #d3d3d3 !important; text-decoration: line-through; opacity: 0.6; }
    </style>
</head>
<body>
    <div id='calendar'></div>
    
    <!-- Modal for displaying and updating status -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateStatusModalLabel">Subscription Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p><strong>Item:</strong> <span id="eventTitle"></span></p>
                    <p><strong>Frequency:</strong> <span id="frequency"></span></p>
                    <p><strong>Amount:</strong> <span id="amount"></span></p>
                    <p><strong>Quantity:</strong> <span id="quantity"></span></p>
                    <p><strong>Status:</strong> <span id="status"></span></p>
                    <hr>
                    <div class="form-group">
                        <label for="updateStatus">Update Status:</label>
                        <select class="form-control" id="updateStatus" name="updateStatus">
                            <option value="">-- Select Status --</option>
                            <option value="Cancelled">Cancelled</option>
                            <option value="NotDelivered">Not Delivered</option>
                        </select>
                    </div>
                    <button id="updateStatusButton" class="btn btn-primary">Update Status</button>
                    <button id="downloadButton" class="btn btn-secondary mt-3">Download PDF</button>
                    <div id="message" class="mt-3"></div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                events: {
                    url: '${pageContext.request.contextPath}/subscription/api/subscriptions',
                    method: 'GET',
                    failure: function(response) {
                        console.error('Error fetching events:', response);
                        alert('Failed to fetch events.');
                    }
                },
                eventClassNames: function(arg) {
                    var frequency = arg.event.extendedProps.frequency;
                    var status = arg.event.extendedProps.status;
                    
                    var baseClass = '';
                    switch (frequency) {
                        case 'daily':
                            baseClass = 'daily-event';
                            break;
                        case 'weekly':
                            baseClass = 'weekly-event';
                            break;
                        case 'monthly':
                            baseClass = 'monthly-event';
                            break;
                    }
                    
                    if (status === 'Cancelled') {
                        return [baseClass, 'cancelled-event'];
                    }
                    
                    return [baseClass];
                },
                eventClick: function(info) {
                    document.getElementById('eventTitle').innerText = info.event.title;
                    document.getElementById('frequency').innerText = info.event.extendedProps.frequency;
                    document.getElementById('amount').innerText = info.event.extendedProps.amount;
                    document.getElementById('quantity').innerText = info.event.extendedProps.quantity;
                    document.getElementById('status').innerText = info.event.extendedProps.status;
                    
                    document.getElementById('updateStatus').value = ''; // Reset the status dropdown
                    document.getElementById('updateStatusButton').dataset.eventId = info.event.id; // Store event ID for update
                    document.getElementById('downloadButton').dataset.eventId = info.event.id; // Store event ID for download
                    $('#updateStatusModal').modal('show');
                },
                locale: 'en',
                contentHeight: 'auto'
            });

            calendar.render();

            // Handle status update
            document.getElementById('updateStatusButton').addEventListener('click', function() {
                var newStatus = document.getElementById('updateStatus').value;
                var eventId = this.dataset.eventId;

                if (!newStatus) {
                    alert('Please select a status.');
                    return;
                }

                var xhr = new XMLHttpRequest();
                xhr.open('POST', '${pageContext.request.contextPath}/subscription/update-status', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                xhr.onload = function() {
                    if (xhr.status >= 200 && xhr.status < 300) {
                        var response = JSON.parse(xhr.responseText);
                        var messageElement = document.getElementById('message');
                        if (response.success) {
                            messageElement.innerHTML = '<div class="alert alert-success">Status updated successfully!</div>';
                            $('#updateStatusModal').modal('hide');
                            calendar.refetchEvents();
                        } else {
                            messageElement.innerHTML = '<div class="alert alert-danger">Failed to update status: ' + response.message + '</div>';
                        }
                    } else {
                        var messageElement = document.getElementById('message');
                        messageElement.innerHTML = '<div class="alert alert-danger">An unexpected error occurred.</div>';
                    }
                };

                xhr.send('eventId=' + encodeURIComponent(eventId) + '&status=' + encodeURIComponent(newStatus));
            });

            // Handle PDF download
            document.getElementById('downloadButton').addEventListener('click', function() {
                var eventId = this.dataset.eventId;
                window.location.href = '${pageContext.request.contextPath}/api/subscription/download-pdf?id=' + encodeURIComponent(eventId);
            });
        });
    </script>
</body>
</html>
