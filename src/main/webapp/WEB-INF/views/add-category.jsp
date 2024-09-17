<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Category</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style>
body {
    background-color: #f8f9fa;
}

.container {
    margin-top: 2rem;
}

.card {
    border-radius: 20px; /* Rounded boundaries */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-header {
    background-color: #6c757d; /* Header color */
    color: #fff;
    font-size: 1.25rem;
    text-align: center;
    border-top-left-radius: 20px; /* Rounded top corners */
    border-top-right-radius: 20px; /* Rounded top corners */
}

.card-body {
    padding: 2rem;
}

.btn-submit {
    background-color: rgba(56, 51, 37, 0.8); /* Button color */
    border-color: rgba(56, 51, 37, 0.8);
    color: #fff;
}

.btn-submit:hover {
    background-color: rgba(56, 51, 37, 1); /* Button hover color */
    border-color: #fff;
}

.btn-secondary {
    background-color: #6c757d; /* Secondary button color */
    border-color: #6c757d;
    color: #fff;
}

.btn-secondary:hover {
    background-color: #5a6268; /* Secondary button hover color */
    border-color: #545b62;
}

.image-container img {
    max-width: 100%;
    border-radius: 20px;
    object-fit: cover;
}
</style>
<script>
function validateCategoryName(input) {
    const regex = /\d/; // Regex to detect digits
    if (regex.test(input.value)) {
        alert("Category name should not contain digits.");
        input.value = ''; // Clear the input
    }
}
</script>
</head>
<body>

    <jsp:include page="/sellerHeader.jsp"></jsp:include>
    <br><br><br><br><br>

    <div class="container">
        <div class="row">
            <!-- Left side: Form -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">Add Category</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/categories/add" method="post">
                            <div class="form-group">
                                <label for="category_name">Category Name:</label>
                                <input type="text" id="category_name" name="category_name" class="form-control" placeholder="Enter category name" required oninput="validateCategoryName(this)" />
                            </div>
                            <button type="submit" class="btn btn-submit btn-block">Add Category</button>
                            <a href="${pageContext.request.contextPath}/categories/list" class="btn btn-secondary btn-block mt-2">View Categories</a>
                        </form>
                        <c:if test="${not empty message}">
                            <div class="alert alert-info mt-3">${message}</div>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- Right side: Image -->
            <div class="col-md-6 d-flex align-items-center justify-content-center">
                <div class="image-container">
                    <img src="https://gifdb.com/images/high/happy-snoopy-grocery-shopping-7r6y9eqq4mi5tgsp.gif" alt="Category Image">
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK3F8AyI6G2Njt5iZ8F4r5+I5U6Y5+F5u6j3Pq5FvWwZ4kB" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UOa0XWkDXhiyx5ZqC6Ww8i1Zz7E7p5X5M6E4zP2A8iJ+P1L7Zn6j5aOzFj5K5I" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-tsQW6o6HtPj9f5d5i4W09E8B4m2pKsk5TrwPqGJ79fAaD/7kV4Rj2M7VbI7Z5O8w" crossorigin="anonymous"></script>

    <br><br><br>
    <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
