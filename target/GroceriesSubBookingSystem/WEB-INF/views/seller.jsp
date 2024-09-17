<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" import="com.crimsonlogic.groceriessubbookingsystem.entity.Users"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome | Seller</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Main Section */
        main {
            margin-top: 60px; /* Adjust for header height */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 120px); /* Adjust for header and footer height */
            padding: 20px;
            background: #f4f4f4;
            text-align: center;
            background-image: url('https://img.freepik.com/free-photo/cooking-elements-kitchen_1112-124.jpg?t=st=1714893575~exp=1714897175~hmac=ec15a875589ff75026c6b2ebc467332a2cdf300523d2ce2403cc43943a106856&w=740');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .welcome-message {
            max-width: 600px;
            margin-bottom: 20px;
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 8px;
        }

        .welcome-message h2 {
            font-size: 2em;
            color: #333;
            margin-bottom: 10px;
        }

        .welcome-message p {
            font-size: 1.1em;
            color: #555;
            line-height: 1.5;
        }

        .cta-buttons {
            margin-top: 20px;
        }

        .cta-buttons a {
    display: inline-block;
    margin: 0 10px;
    padding: 10px 20px;
    text-decoration: none;
    color: #fff; /* White text color */
    background: rgba(56, 51, 37, 0.8); /* Dark brown with 80% opacity */
    border-radius: 5px;
    font-size: 1.1em;
    transition: background 0.3s ease, transform 0.3s ease;
}

.cta-buttons a:hover {
    background: rgba(56, 51, 37, 1); /* Dark brown with full opacity */
    transform: scale(1.05);
}

    </style>
</head>
<body>
    <!-- Header Section -->
<jsp:include page="/sellerHeader.jsp"></jsp:include>
    <!-- Main Section -->
    <main class="main">
        <div class="welcome-message">
            <h2>Welcome to the Seller Page!</h2>
        </div>
        <div class="cta-buttons">
        <%
                        Users user = (Users) request.getSession().getAttribute("user");
                    %>
            <a href="${pageContext.request.contextPath}/users/profile?user_id=<%= user.getUser_id() %>">Update Profile</a>
            <a href="${pageContext.request.contextPath}/groceries/add">Add Item</a>
        </div>
    </main>

    <!-- Footer Section -->
    <jsp:include page="/footer.jsp"></jsp:include>
     <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
