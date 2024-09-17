<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Customer</title>
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
            background-image: url('https://img.freepik.com/premium-photo/baking-ingredients-white-background_978921-226.jpg');
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
            color: #fff;
            background: #00008B;
            border-radius: 5px;
            font-size: 1.1em;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .cta-buttons a:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <jsp:include page="/customerHeader.jsp"></jsp:include>

    <!-- Main Section -->
    <main class="main">
        <div class="welcome-message">
            <h2>Welcome to the Grocery Store!</h2>
            <p>We're glad to have you here. Explore the Subscriptions below to get started:</p>
        </div>
        <div class="cta-buttons">
            <a href="${pageContext.request.contextPath}/users/profile?user_id=${user.user_id}">Update Profile</a>
            <a href="<%= request.getContextPath() %>/list">Track Courier</a>
        </div>
    </main>

    <!-- Footer Section -->
    <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
