<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Groceries Booking</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
    <style type="text/css">
body {
    font-family: Arial, sans-serif;
    background-image: url('https://ramandosgrill.com/wp-content/uploads/2019/05/ramandos_header-image-min.jpeg'); /* Replace with your image URL */
    background-size: cover;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center center;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
    height: 100vh; /* Full viewport height */
    display: flex;
    justify-content: center;
    align-items: center;
}

.jumbotron {
    background-color: rgba(248, 249, 250, 0.8); /* Slightly transparent background */
    padding: 2rem 1rem;
    text-align: center;
}

.card {
    margin-bottom: 20px;
}
    </style>
</head>
<body>
 <jsp:include page="/header.jsp"></jsp:include>

    <div class="container mt-5">
        <div class="jumbotron text-center">
            <h1>Welcome to Groceries Booking</h1>
            <p>Order your groceries online with ease!</p>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
