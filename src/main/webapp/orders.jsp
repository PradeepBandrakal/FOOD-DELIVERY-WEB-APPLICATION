<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%@ page import="com.foodapp.model.User" %>
<%@ page import="com.foodapp.model.Order" %>
<%@ page import="com.foodapp.model.OrderItemDetails" %>

<%@ page import="com.foodapp.dao.OrderDAO" %>

<%

User user =
(User) session.getAttribute("loggedInUser");

if(user == null){

    response.sendRedirect("login.jsp");
    return;
}

// FETCH ORDERS

OrderDAO orderDAO =
new OrderDAO();

ArrayList<Order> orderList =
orderDAO.getOrdersByUserId(
        user.getUserId());

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>My Orders</title>

<!-- GOOGLE FONT -->

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<!-- CSS -->

<link rel="stylesheet"
href="css/global.css">

<link rel="stylesheet"
href="css/navbar.css">

<link rel="stylesheet"
href="css/orders.css">

<link rel="stylesheet"
href="css/responsive.css">

</head>

<body>

<!-- NAVBAR -->

<jsp:include page="components/navbar.jsp" />

<!-- PAGE -->

<div class="orders-page">

    <!-- TITLE -->

    <h1 class="orders-title">

        My Orders

    </h1>

    <%

    if(orderList.size() > 0){

    %>

    <!-- ORDER LIST -->

    <div class="orders-list">

    <%

    for(Order order : orderList){

        ArrayList<OrderItemDetails> itemList =
        orderDAO.getOrderItemsByOrderId(
                order.getOrderId());

    %>

    <!-- ORDER CARD -->

    <div class="order-card">

        <!-- TOP -->

        <div class="order-top">

            <div class="order-id">

                Order #<%= order.getOrderId() %>

            </div>

            <div class="order-status">

                <%

java.sql.Timestamp orderTime =
order.getOrderDate();

java.time.LocalDateTime orderDateTime =
orderTime.toLocalDateTime();

java.time.LocalDateTime currentTime =
java.time.LocalDateTime.now();

long minutesPassed =
java.time.Duration.between(
        orderDateTime,
        currentTime).toMinutes();

String dynamicStatus = "Pending";

if(minutesPassed >= 1){

    dynamicStatus = "Preparing";
}

if(minutesPassed >= 2){

    dynamicStatus = "Out for Delivery";
}

if(minutesPassed >= 3){

    dynamicStatus = "Delivered";
}

%>

<%= dynamicStatus %>

            </div>

        </div>

        <!-- ORDER ITEMS -->

        <div class="items-section">

            <h3 class="section-title">

                Ordered Items

            </h3>

            <%

            for(OrderItemDetails item : itemList){

            %>

            <!-- ITEM -->

            <div class="order-item">

                <!-- LEFT -->

                <div class="item-left">

                    <img src="<%= request.getContextPath() %>/<%= item.getImagePath() %>"
                         class="item-image">

                    <div>

                        <div class="item-name">

                            <%= item.getItemName() %>

                        </div>

                        <div class="item-qty">

                            Quantity:
                            <%= item.getQuantity() %>

                        </div>

                    </div>

                </div>

                <!-- PRICE -->

                <div class="item-price">

                    ₹ <%= item.getSubtotal() %>

                </div>

            </div>

            <%

            }

            %>

        </div>

        <!-- BILL SECTION -->

        <div class="bill-section">

            <div class="bill-row">

                <span>Payment Method</span>

                <span><%= order.getPaymentMethod() %></span>

            </div>

            <div class="bill-row">

                <span>Delivery Address</span>

                <span><%= order.getDeliveryAddress() %></span>

            </div>

            <div class="bill-row total-row">

                <span>Grand Total</span>

                <span>₹ <%= order.getTotalAmount() %></span>

            </div>

        </div>

        <!-- ACTION BUTTONS -->

        <div class="order-actions">

            <a href="reorder?orderId=<%= order.getOrderId() %>">

                <button class="action-btn reorder-btn">

                    Reorder

                </button>

            </a>

            <a href="track-order.jsp?orderId=<%= order.getOrderId() %>">

    <button class="action-btn track-btn">

        Track Order

    </button>

</a>

        </div>

    </div>

    <%

    }

    %>

    </div>

    <%

    } else {

    %>

    <!-- EMPTY STATE -->

    <div class="empty-orders">

        <h2>

            No Orders Yet 🍔

        </h2>

        <p>

            Start exploring delicious food now!

        </p>

    </div>

    <%

    }

    %>

</div>

</body>

</html>