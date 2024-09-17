<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Grocery</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .form-group img {
            max-width: 200px;
        }
    </style>
</head>
<body>
<jsp:include page="/sellerHeader.jsp"></jsp:include>
<br><br><br>
    <div class="container">
        <h2 class="my-4">Update Grocery Item</h2>

        <form action="${pageContext.request.contextPath}/groceries/edit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${grocery.grocery_id}">
            <div class="form-group">
                <label for="groceryName">Grocery Name:</label>
                <input type="text" class="form-control" id="groceryName" name="groceryName" value="${grocery.groceryName}" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" id="description" name="description" rows="4" required>${grocery.description}</textarea>
            </div>
            <div class="form-group">
                <label for="grocery_price">Price:</label>
                <input type="text" class="form-control" id="grocery_price" name="grocery_price" value="${grocery.grocery_price}" required>
            </div>
            <div class="form-group">
                <label for="in_stock">In Stock:</label>
                <input type="number" class="form-control" id="in_stock" name="in_stock" value="${grocery.in_stock}" required>
            </div>
            <div class="form-group">
                <label for="category_id">Category:</label>
                <select class="form-control" id="category_id" name="category_id" required>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.category_id}" <c:if test="${category.category_id == grocery.category.category_id}">selected</c:if>>${category.category_name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="imageURL">Image:</label>
                <input type="file" class="form-control-file" id="imageURL" name="imageURL">
                <c:if test="${not empty grocery.imageURL}">
                    <p>Current Image: <img src="${pageContext.request.contextPath}/uploaded/${grocery.imageURL}" alt="Grocery Image"></p>
                </c:if>
            </div>
            <button type="submit" class="btn btn-primary">Update Grocery</button>
        </form>

        <c:if test="${not empty message}">
            <div class="alert alert-info mt-3">${message}</div>
        </c:if>

        <a href="${pageContext.request.contextPath}/groceries/list" class="btn btn-secondary mt-3">Back to Grocery List</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <br><br>
    <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
