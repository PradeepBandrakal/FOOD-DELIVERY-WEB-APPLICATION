
<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="com.foodapp.model.CartItem" %>
<%@ page import="com.foodapp.model.User" %>

<%

User user =
(User) session.getAttribute("loggedInUser");

if(user == null){

    response.sendRedirect("login.jsp");
    return;
}

ArrayList<CartItem> cartList =
(ArrayList<CartItem>)
session.getAttribute("cart");

// GRAND TOTAL

double grandTotal = 0;

if(cartList != null){

    for(CartItem cartItem : cartList){

        grandTotal +=
        cartItem.getTotalPrice();
    }
}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Checkout</title>

<!-- GOOGLE FONT -->

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<!-- CSS FILES -->

<link rel="stylesheet"
href="css/global.css">

<link rel="stylesheet"
href="css/navbar.css">

<link rel="stylesheet"
href="css/checkout.css">

<link rel="stylesheet"
href="css/responsive.css">

</head>

<body>

<!-- NAVBAR -->

<jsp:include page="components/navbar.jsp" />

<!-- CHECKOUT PAGE -->

<div class="checkout-page">

    <!-- LEFT FORM SECTION -->

    <div class="checkout-form-section">

        <h1 class="checkout-title">

            Checkout

        </h1>
        
        
<%

String errorMessage =
(String) request.getAttribute("errorMessage");

if(errorMessage != null){

%>

<div class="error-box">

    <%= errorMessage %>

</div>

<%

}

%>

        

        <!-- FORM -->

        <form action="place-order"
              method="post">

            <!-- ADDRESS -->

            <label class="checkout-label">

                Delivery Address

            </label>

            <textarea name="address"
                      required
                      class="checkout-textarea"
                      placeholder="Enter your delivery address">

            </textarea>

            <!-- PAYMENT -->

            <label class="checkout-label">

                Payment Method

            </label>

            <select name="paymentMethod"
                    class="checkout-select">

                <option value="COD">

                    Cash On Delivery

                </option>

            </select>

            <!-- BUTTON -->

            <button type="submit"
                    class="place-order-btn">

                Place Order

            </button>

        </form>

    </div>

    <!-- RIGHT SUMMARY SECTION -->

    <div class="checkout-summary">

        <h2 class="summary-title">

            Bill Summary

        </h2>

        <div class="summary-row">

            <span>Item Total</span>

            <span>₹ <%= grandTotal %></span>

        </div>

        <div class="summary-row">

            <span>Delivery Fee</span>

            <span>₹ 40</span>

        </div>

        <div class="summary-row">

            <span>Platform Fee</span>

            <span>₹ 10</span>

        </div>

        <!-- GRAND TOTAL -->

        <div class="checkout-total">

            <span>Grand Total</span>

            <span>₹ <%= grandTotal + 50 %></span>

        </div>

    </div>

</div>

</body>

</html>
