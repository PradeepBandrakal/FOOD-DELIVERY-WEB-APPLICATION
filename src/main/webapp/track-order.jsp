<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="com.foodapp.dao.OrderDAO" %>
<%@ page import="com.foodapp.model.Order" %>

<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.Duration" %>
<%@ page import="java.time.LocalDateTime" %>

<%

int orderId =
Integer.parseInt(
request.getParameter("orderId"));

OrderDAO orderDAO =
new OrderDAO();

Order order =
orderDAO.getOrderById(orderId);

/* AUTO STATUS CALCULATION */

Timestamp orderTime =
order.getOrderDate();

LocalDateTime orderDateTime =
orderTime.toLocalDateTime();

LocalDateTime currentTime =
LocalDateTime.now();

long minutesPassed =
Duration.between(
        orderDateTime,
        currentTime).toMinutes();

String status = "Pending";

if(minutesPassed >= 1){

    status = "Preparing";
}

if(minutesPassed >= 2){

    status = "Out for Delivery";
}

if(minutesPassed >= 3){

    status = "Delivered";
}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Track Order</title>

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{

    margin: 0;

    padding: 0;

    box-sizing: border-box;

    font-family: 'Poppins', sans-serif;
}

body{

    background-color: #f8f8f8;
}

/* CONTAINER */

.track-container{

    width: 60%;

    margin: 60px auto;

    background-color: white;

    padding: 45px;

    border-radius: 24px;

    box-shadow:
    0 4px 18px rgba(0,0,0,0.08);
}

/* TITLE */

.track-title{

    font-size: 42px;

    font-weight: 700;

    color: #282c3f;

    margin-bottom: 10px;
}

/* SUBTITLE */

.track-subtitle{

    color: #686b78;

    margin-bottom: 40px;

    font-size: 18px;
}

.track-subtitle strong{

    color: #fc8019;
}

/* TIMELINE */

.timeline{

    position: relative;

    margin-left: 20px;
}

.timeline::before{

    content: "";

    position: absolute;

    left: 14px;

    top: 0;

    width: 4px;

    height: 100%;

    background-color: #ddd;
}

/* STEP */

.step{

    position: relative;

    padding-left: 55px;

    margin-bottom: 50px;
}

/* CIRCLE */

.circle{

    position: absolute;

    left: 0;

    top: 0;

    width: 32px;

    height: 32px;

    border-radius: 50%;

    background-color: #ddd;

    transition: 0.3s ease;
}

/* ACTIVE STEP */

.active .circle{

    background-color: #48c479;

    box-shadow:
    0 0 12px rgba(72,196,121,0.5);
}

/* TITLES */

.step-title{

    font-size: 24px;

    font-weight: 600;

    color: #282c3f;
}

/* DESCRIPTION */

.step-desc{

    margin-top: 6px;

    color: #686b78;

    font-size: 16px;
}

/* BUTTON */

.home-btn{

    margin-top: 20px;

    display: inline-block;

    padding: 14px 28px;

    background-color: #fc8019;

    color: white;

    text-decoration: none;

    border-radius: 14px;

    font-weight: 600;

    transition: 0.3s ease;
}

.home-btn:hover{

    background-color: #e46f10;
}

</style>

</head>

<body>

<div class="track-container">

    <h1 class="track-title">

        Track Your Order

    </h1>

    <p class="track-subtitle">

        Current Status:
        <strong><%= status %></strong>

    </p>

    <!-- TIMELINE -->

    <div class="timeline">

        <!-- STEP 1 -->

        <div class="step active">

            <div class="circle"></div>

            <div class="step-title">

                Order Confirmed

            </div>

            <div class="step-desc">

                Restaurant accepted your order

            </div>

        </div>

        <!-- STEP 2 -->

        <div class="step
        <%= status.equalsIgnoreCase("Preparing")
        || status.equalsIgnoreCase("Out for Delivery")
        || status.equalsIgnoreCase("Delivered")
        ? "active" : "" %>">

            <div class="circle"></div>

            <div class="step-title">

                Preparing Food

            </div>

            <div class="step-desc">

                Chef is preparing your meal

            </div>

        </div>

        <!-- STEP 3 -->

        <div class="step
        <%= status.equalsIgnoreCase("Out for Delivery")
        || status.equalsIgnoreCase("Delivered")
        ? "active" : "" %>">

            <div class="circle"></div>

            <div class="step-title">

                Out for Delivery

            </div>

            <div class="step-desc">

                Delivery partner is on the way

            </div>

        </div>

        <!-- STEP 4 -->

        <div class="step
        <%= status.equalsIgnoreCase("Delivered")
        ? "active" : "" %>">

            <div class="circle"></div>

            <div class="step-title">

                Delivered

            </div>

            <div class="step-desc">

                Enjoy your food 🍔

            </div>

        </div>

    </div>

    <!-- BUTTON -->

    <a href="orders.jsp"
       class="home-btn">

        Back To Orders

    </a>

</div>

</body>

</html>