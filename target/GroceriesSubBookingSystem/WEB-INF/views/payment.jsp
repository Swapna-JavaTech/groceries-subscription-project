<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .error {
            color: red;
            font-size: 0.875em;
            margin-top: 0.25em;
        }
    </style>
    <script>
        function validateCardNumber() {
            const cardNumber = document.getElementById('card_number').value;
            const regex = /^\d{16}$/; // 16 digits for card number
            const errorElement = document.getElementById('card_number_error');
            if (cardNumber && !regex.test(cardNumber)) {
                errorElement.textContent = 'Card Number must be exactly 16 digits.';
            } else {
                errorElement.textContent = '';
            }
        }

        function validateExpiryDate() {
            const expireDate = document.getElementById('expire_date').value;
            const regex = /^(0[1-9]|1[0-2])\/\d{2}$/; // MM/YY format
            const errorElement = document.getElementById('expire_date_error');
            if (expireDate && !regex.test(expireDate)) {
                errorElement.textContent = 'Expiry Date must be in MM/YY format.';
            } else {
                errorElement.textContent = '';
            }
        }

        function validateCVV() {
            const cvvNumber = document.getElementById('cvv_number').value;
            const regex = /^\d{3}$/; // 3 digits for CVV
            const errorElement = document.getElementById('cvv_number_error');
            if (cvvNumber && !regex.test(cvvNumber)) {
                errorElement.textContent = 'CVV must be exactly 3 digits.';
            } else {
                errorElement.textContent = '';
            }
        }

        function showPaymentDetails() {
            const paymentMode = document.getElementById('payment_mode').value;
            const paymentDetails = document.getElementById('paymentDetails');
            paymentDetails.style.display = paymentMode ? 'block' : 'none';
        }
    </script>
</head>
<body>
  <!-- Header Section -->
    <jsp:include page="/customerHeader.jsp"></jsp:include>
    <br><br><br>
    <div class="container mt-5">
        <h2 class="mb-4 text-center">Payment Page</h2>
        <form action="${pageContext.request.contextPath}/payment/complete" method="post">

			
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="text" id="amount" name="amount" class="form-control" value="${totalAmount}" readonly>
            </div>
            <div class="form-group">
                <label for="payment_mode">Payment Mode:</label>
                <select id="payment_mode" name="payment_mode" class="form-control" onchange="showPaymentDetails()" required>
                    <option value="">Select Payment Mode</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="Net Banking">Net Banking</option>
                </select>
            </div>
            <div id="paymentDetails" style="display:none;">
                <div class="form-group">
                    <label for="card_number">Card Number:</label>
                    <input type="text" id="card_number" name="card_number" class="form-control" onchange="validateCardNumber()" required>
                    <div id="card_number_error" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="expire_date">Expiry Date:</label>
                    <input type="text" id="expire_date" name="expire_date" class="form-control" onchange="validateExpiryDate()" required>
                    <div id="expire_date_error" class="error"></div>
                </div>
                <div class="form-group">
                    <label for="cvv_number">CVV:</label>
                    <input type="text" id="cvv_number" name="cvv_number" class="form-control" onchange="validateCVV()" required>
                    <div id="cvv_number_error" class="error"></div>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Complete Payment</button>
        </form>
    </div>
    <br><br><br>
       <!-- Footer Section -->
    <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
