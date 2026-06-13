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

double grandTotal = 0;

double deliveryFee = 40;

double platformFee = 10;

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>My Cart</title>

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet"
href="css/global.css">

<link rel="stylesheet"
href="css/navbar.css">

<link rel="stylesheet"
href="css/cart.css?v=2">

<link rel="stylesheet"
href="css/responsive.css">

</head>

<body>

<jsp:include page="components/navbar.jsp" />

<%

if(cartList != null && !cartList.isEmpty()){

%>

<!-- CART PAGE -->

<div class="cart-page">

    <!-- LEFT -->

    <div class="cart-left">

        <!-- RESTAURANT INFO -->

        <div class="restaurant-info">

            <h1>

                Your Cart 🍔

            </h1>

            <p>

                Review your order before checkout

            </p>

        </div>

        <!-- ITEMS -->

        <div class="cart-items">

        <%

        for(CartItem cartItem : cartList){

            grandTotal +=
            cartItem.getTotalPrice();

        %>

        <!-- ITEM -->

        <div class="cart-item">

            <!-- IMAGE -->

            <div class="item-image-section">

                <img src="<%= request.getContextPath() %>/<%= cartItem.getMenuItem().getImagePath() %>">

            </div>

            <!-- DETAILS -->

            <div class="item-details">

                <h2>

                    <%= cartItem.getMenuItem().getItemName() %>

                </h2>

                <p>

                    Hot & freshly prepared 🔥

                </p>

                <div class="item-price">

                    ₹ <%= cartItem.getMenuItem().getPrice() %>

                </div>

            </div>

            <!-- RIGHT -->

            <div class="item-actions">

                <!-- QUANTITY -->

                <form action="update-cart"
                      method="post"
                      class="quantity-box">

                    <input type="hidden"
                           name="itemId"
                           value="<%= cartItem.getMenuItem().getItemId() %>">

                    <button type="submit"
                            name="action"
                            value="decrease">

                        -

                    </button>

                    <span>

                        <%= cartItem.getQuantity() %>

                    </span>

                    <button type="submit"
                            name="action"
                            value="increase">

                        +

                    </button>

                </form>

                <!-- TOTAL -->

                <div class="item-total">

                    ₹ <%= cartItem.getTotalPrice() %>

                </div>

            </div>

        </div>

        <%

        }

        %>

        </div>

    </div>

    <!-- RIGHT -->

    <div class="cart-right">

        <div class="bill-card">

            <h2>

                Bill Details

            </h2>

            <div class="bill-row">

                <span>Item Total</span>

                <span>₹ <%= grandTotal %></span>

            </div>

            <div class="bill-row">

                <span>Delivery Fee</span>

                <span>₹ <%= deliveryFee %></span>

            </div>

            <div class="bill-row">

                <span>Platform Fee</span>

                <span>₹ <%= platformFee %></span>

            </div>

            <!-- TOTAL -->

            <div class="bill-total">

                <span>Grand Total</span>

                <span>

                    ₹ <%= grandTotal + deliveryFee + platformFee %>

                </span>

            </div>

            <!-- ETA -->

            <div class="delivery-info">

                🚀 Delivery in 25 - 30 mins

            </div>

            <!-- CHECKOUT -->

            <a href="checkout.jsp">

                <button class="checkout-btn">

                    Proceed To Checkout

                </button>

            </a>

        </div>

    </div>

</div>

<%

} else {

%>

<!-- EMPTY CART -->

<div class="empty-cart-page">

    <div class="empty-cart-card">

        <img src="https://cdn-icons-png.flaticon.com/512/2038/2038854.png">

        <h1>

            Your Cart is Empty

        </h1>

        <p>

            Looks like you haven’t added
            anything delicious yet.

        </p>

        <a href="home.jsp">

            <button>

                Explore Food

            </button>

        </a>

    </div>

</div>

<%

}

%>

</body>

</html>