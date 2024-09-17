<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"
	import="com.crimsonlogic.groceriessubbookingsystem.entity.Users"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Subscription Calendar</title>
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.min.js'></script>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<style>
#calendar {
	width: 80%;
	max-width: 800px;
	margin: 0 auto;
	height: 500px;
}

.daily-event {
	background-color: #84e430 !important;
	border-color: #84e430 !important;
}

.weekly-event {
	background-color: #94daee !important;
	border-color: #94daee !important;
}

.monthly-event {
	background-color: #f7b7a3 !important;
	border-color: #f7b7a3 !important;
}

.fc-event {
	border-radius: 0 !important;
}

.cancelled-event {
	background-color: #d3d3d3 !important;
	border-color: #d3d3d3 !important;
	text-decoration: line-through;
	opacity: 0.6;
}

.button-container {
	text-align: center;
	margin-top: 20px;
}

.legend {
	text-align: center;
	margin-bottom: 20px;
}

.legend div {
	display: inline-block;
	margin: 0 15px;
	text-align: left;
}

.legend .color-box {
	width: 20px;
	height: 20px;
	display: inline-block;
	margin-right: 10px;
	border-radius: 4px;
}
</style>
</head>
<body>
	<br>

	<!-- Legend for color coding -->
	<div class="legend">
		<div>
			<div class="color-box daily-event"></div>
			Daily
		</div>
		<div>
			<div class="color-box weekly-event"></div>
			Weekly
		</div>
		<div>
			<div class="color-box monthly-event"></div>
			Monthly
		</div>
		<div>
			<div class="color-box cancelled-event"></div>
			Cancelled
		</div>
	</div>

	<div id='calendar'></div>

	<!-- Modal for displaying and updating status -->
	<div class="modal fade" id="updateStatusModal" tabindex="-1"
		role="dialog" aria-labelledby="updateStatusModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateStatusModalLabel">Subscription
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>
						<strong>Item:</strong> <span id="eventTitle"></span>
					</p>
					<p>
						<strong>Frequency:</strong> <span id="frequency"></span>
					</p>
					<p>
						<strong>Amount:</strong> <span id="amount"></span>
					</p>
					<p>
						<strong>Quantity:</strong> <span id="quantity"></span>
					</p>
					<p>
						<strong>Status:</strong> <span id="status"></span>
					</p>
					<hr>
					<div class="form-group">
						<label for="updateStatus">Update Status:</label> <select
							class="form-control" id="updateStatus" name="updateStatus">
							<option value="">-- Select Status --</option>
							<option value="Cancelled">Cancelled</option>
							<option value="NotDelivered">Not Delivered</option>
						</select>
					</div>
					<button id="updateStatusButton" class="btn btn-primary">Update
						Status</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal for showing result messages -->
	<div class="modal fade" id="resultMessageModal" tabindex="-1"
		role="dialog" aria-labelledby="resultMessageModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="resultMessageModalLabel">Status
						Update</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="resultMessage" class="alert"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<br>
	<br>

	<div class="button-container">
		<a href="${pageContext.request.contextPath}/groceries/list"
			class="btn btn-secondary">Continue Shopping</a>
	</div>

	<script>
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							var calendarEl = document
									.getElementById('calendar');

							var calendar = new FullCalendar.Calendar(
									calendarEl,
									{
										initialView : 'dayGridMonth',
										events : {
											url : '${pageContext.request.contextPath}/subscription/api/subscriptions',
											method : 'GET',
											failure : function(response) {
												console
														.error(
																'Error fetching events:',
																response);
											}
										},
										eventClassNames : function(arg) {
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
												return [ baseClass,
														'cancelled-event' ];
											}

											return [ baseClass ];
										},
										eventClick : function(info) {
											document
													.getElementById('eventTitle').innerText = info.event.title;
											document
													.getElementById('frequency').innerText = info.event.extendedProps.frequency;
											document.getElementById('amount').innerText = info.event.extendedProps.amount;
											document.getElementById('quantity').innerText = info.event.extendedProps.quantity;
											document.getElementById('status').innerText = info.event.extendedProps.status;

											document
													.getElementById('updateStatus').value = ''; // Reset the status dropdown
											document
													.getElementById('updateStatusButton').dataset.eventId = info.event.id; // Store event ID for update
											$('#updateStatusModal').modal(
													'show');
										},
										locale : 'en',
										contentHeight : 'auto'
									});

							calendar.render();

							// Handle status update
							document
									.getElementById('updateStatusButton')
									.addEventListener(
											'click',
											function() {
												var newStatus = document
														.getElementById('updateStatus').value;
												var eventId = this.dataset.eventId;

												if (!newStatus) {
													showResultMessage(
															'Please select a status.',
															'danger');
													return;
												}

												var xhr = new XMLHttpRequest();
												xhr
														.open(
																'POST',
																'${pageContext.request.contextPath}/subscription/update-status',
																true);
												xhr
														.setRequestHeader(
																'Content-Type',
																'application/x-www-form-urlencoded');

												xhr.onload = function() {
													if (xhr.status >= 200
															&& xhr.status < 300) {
														var response = JSON
																.parse(xhr.responseText);
														var message = '';
														var alertType = 'success';

														if (response.success) {
															if (newStatus === 'Cancelled') {
																message = 'Your subscription has been cancelled and your amount has been credited to your account.';
															} else {
																message = 'Subscription status updated successfully.';
															}
														} else {
															message = 'Failed to update status: '
																	+ response.message;
															alertType = 'danger';
														}

														showResultMessage(
																message,
																alertType);
													} else {
														showResultMessage(
																'An error occurred while updating the status.',
																'danger');
													}
												};

												xhr
														.send('eventId='
																+ encodeURIComponent(eventId)
																+ '&status='
																+ encodeURIComponent(newStatus));
											});

							function showResultMessage(message, type) {
								var resultMessage = document
										.getElementById('resultMessage');
								resultMessage.innerHTML = message;
								resultMessage.className = 'alert alert-' + type;
								$('#resultMessageModal').modal('show');
							}
						});
	</script>
</body>
</html>
