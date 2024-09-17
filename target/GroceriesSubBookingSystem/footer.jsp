<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<style>
/* Features Section */
.features {
    padding: 60px 20px;
    background: #f9f9f9;
}

.features h2 {
    text-align: center;
    margin-bottom: 40px;
}

.feature-cards {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
}

.feature-card {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    padding: 20px;
    width: 22%;
    text-align: center;
    margin-bottom: 20px;
}

.feature-card img {
    max-width: 50px;
    margin-bottom: 10px;
}

.feature-card h3 {
    margin: 10px 0;
    font-size: 1.2em;
}

.feature-card p {
    color: #666;
}

/* Footer */
footer {
    background: rgba(56, 51, 37, 0.8);
    color: #fff;
    padding: 40px 20px;
}

footer .container {
    max-width: 1200px;
    margin: 0 auto;
}

.footer-top {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    margin-bottom: 20px;
}

.footer-top div {
    flex: 1;
    margin: 10px;
}

.footer-top h3 {
    margin-bottom: 15px;
    font-size: 1.2em;
}

.footer-top ul {
    list-style: none;
}

.footer-top ul li {
    margin-bottom: 10px;
}

.footer-top ul li a {
    color: #fff;
    text-decoration: none;
}

.footer-top ul li a:hover {
    text-decoration: underline;
}

.footer-contact p,
.footer-social a {
    margin: 5px 0;
}

.footer-social a {
    color: #fff;
    text-decoration: none;
    margin-right: 10px;
}

.footer-social a:hover {
    text-decoration: underline;
}

.footer-newsletter form {
    display: flex;
    justify-content: center;
    margin-top: 10px;
}

.footer-newsletter input {
    padding: 10px;
    border-radius: 5px;
    border: none;
    width: 250px;
    margin-right: 10px;
}

.footer-newsletter button {
    padding: 10px 20px;
    border-radius: 5px;
    border: none;
    background: #007BFF;
    color: #fff;
    font-weight: bold;
    cursor: pointer;
}

.footer-bottom {
    text-align: center;
    padding-top: 20px;
    border-top: 1px solid #444;
}

.footer-bottom p {
    margin: 10px 0;
}
 
</style>
</head>
<body>
	    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-top">
                <div class="footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/services.jsp">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact Us</a></li>
                    </ul>
                </div>
                <div class="footer-contact">
                    <h3>Contact Us</h3>
                    <p>Phone: 789054321</p>
                    <p>Email:mounika@gmail.com</p>
                    <p>Address: Bengaluru</p>
                </div>
                <div class="footer-social">
                    <h3>Follow Us</h3>
                    <a href="#">Facebook</a>
                    <a href="#">Twitter</a>
                    <a href="#">Instagram</a>
                </div>
                <div class="footer-newsletter">
                    <h3>Newsletter</h3>
                    <p>Subscribe to our newsletter for updates and offers.</p>
                    <p>for maintaining and managing the couriers</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 [Your Courier Service Name]. All rights reserved.</p>
            </div>
        </div>
    </footer>
<!-- Footer -->
</body>
</html>