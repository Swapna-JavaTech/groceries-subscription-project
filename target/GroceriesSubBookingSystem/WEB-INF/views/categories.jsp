<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Categories</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
        }
        .table-wrapper {
            width: 80%; /* Set the desired width of the table wrapper */
        }
        .table {
            background-color: #fff;
            border-radius: 0.25rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 0 auto; /* Center the table */
        }
        .table thead th {
            background-color: #007bff;
            color: #fff;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
            padding: 0.5rem; /* Adjust padding as needed */
        }
        .btn-add {
            margin-top: 1rem;
            background-color: #28a745;
            color: #fff;
        }
        .btn-add:hover {
            background-color: #218838;
            color: #fff;
        }
    </style>
</head>
<body>
<jsp:include page="/sellerHeader.jsp"></jsp:include>
<br><br><br>

    <div class="container">
        <div class="table-wrapper">
            <h1 class="mb-4">List of Categories</h1>

            <table class="table table-bordered table-striped table-hover table-sm">
                <thead>
                    <tr>
                        <th>Category Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categories}" var="category">
                        <tr>
                            <td>${category.category_name}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="${pageContext.request.contextPath}/categories/add" class="btn btn-add">Add New Category</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK3F8AyI6G2Njt5iZ8F4r5+I5U6Y5+F5u6j3Pq5FvWwZ4kB"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UOa0XWkDXhiyx5ZqC6Ww8i1Zz7E7p5X5M6eD4zP2A8iJ+P1L7Zn6j5aOzFj5K5I"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-tsQW6o6HtPj9f5d5i4W09E8B4m2pKsk5TrwPqGJ79fAaD/7kV4Rj2M7VbI7Z5O8w"
        crossorigin="anonymous"></script>
        
        <br><br><br>
<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
