<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Us</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="styles.css">
<style>
/* General Reset */
/* General Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, sans-serif;
}

/* Contact Section */
.contact {
	background: #f9f9f9;
	padding: 60px 20px;
	margin-top: 60px; /* Offset for fixed header */
}

.contact .container {
	max-width: 1200px;
	margin: 0 auto;
}

.contact h1 {
	text-align: center;
	margin-bottom: 40px;
	font-size: 2.5em;
	color: #333;
}

.contact-info {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-between;
}

.contact-details, .contact-message {
	flex: 1;
	background: #fff;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.contact-details h2, .contact-message h2 {
	margin-bottom: 20px;
	font-size: 2em;
	color: #007BFF;
}

.contact-details p {
	margin-bottom: 10px;
	color: #666;
}

.contact-message p {
	margin-bottom: 20px;
	color: #666;
}

.contact-map {
	margin-top: 40px;
	text-align: center;
}

.contact-map h2 {
	margin-bottom: 20px;
	font-size: 2em;
	color: #007BFF;
}

.contact-map iframe {
	border: 0;
	border-radius: 8px;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.contact-info {
		flex-direction: column;
	}
	.contact-details, .contact-message {
		width: 100%;
	}
}
</style>
</head>
<body>
	<!-- Customer Header -->
	<jsp:include page="/header.jsp"></jsp:include>

	<!-- Contact Section -->
	<section id="contact" class="contact">
		<div class="container">
			<h1>Contact Us</h1>
			<div class="contact-info">
				<div class="contact-details">
					<h2>Our Office</h2>
					<p>
						<i class="fas fa-map-marker-alt"></i> 1-127, Rhb Coloy,
						mahadevapura, Bengaluru, Karnataka
					</p>
					<p>
						<i class="fas fa-phone"></i> +91 7890976512
					</p>
					<p>
						<i class="fas fa-envelope"></i>GroceryStore@gmail.com
					</p>
				</div>
				<div class="contact-message">
					<h2>We're Here to Help!</h2>
					<p>At Courier Management System, your satisfaction is our
						priority. If you have any questions, concerns, or feedback, please
						don’t hesitate to reach out to us. Our dedicated team is here to
						provide you with the support you need.</p>
					<p>We value your input and are always looking to improve our
						services. Whether you have a query about our services or need
						assistance with a delivery issue, we're here to assist you.</p>
					<p>Thank you for choosing Courier Management System. We look
						forward to hearing from you and helping you with any needs you
						might have.</p>
				</div>
			</div>
			<div class="contact-map">
				<h2>Our Location</h2>
				<!-- You can embed a Google Map here -->
				<iframe
					src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d122396.97306068787!2d77.64508258029291!3d12.987812321828004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bae14bb4dc3bbf7%3A0x1d8e8c03e56b0cb7!2sMahadevapura%2C%20Bengaluru%2C%20Karnataka%2C%20India!5e0!3m2!1sen!2sin!4v1694536489562!5m2!1sen!2sin"
					width="100%" height="400" style="border: 0;" allowfullscreen=""
					loading="lazy"></iframe>
			</div>
		</div>
	</section>

	<!-- Footer Section -->
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
