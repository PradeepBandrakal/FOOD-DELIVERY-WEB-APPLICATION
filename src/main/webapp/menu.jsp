
<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>

<%@ page import="com.foodapp.model.User" %>
<%@ page import="com.foodapp.model.MenuItem" %>

<%@ page import="com.foodapp.dao.MenuDAO" %>

<%

User user = (User) session.getAttribute("loggedInUser");

if(user == null){

    response.sendRedirect("login.jsp");
    return;
}

int restaurantId =
Integer.parseInt(
request.getParameter("restaurantId"));

MenuDAO menuDAO = new MenuDAO();

ArrayList<MenuItem> menuList =
menuDAO.getMenuByRestaurant(restaurantId);

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Restaurant Menu</title>

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
href="css/menu.css">

<link rel="stylesheet"
href="css/responsive.css">

</head>

<body>

<!-- NAVBAR -->

<jsp:include page="components/navbar.jsp" />

<!-- MENU PAGE -->

<div class="menu-page">

    <!-- HEADER -->

    <div class="menu-header">

        <h1>
            Explore Delicious Foods 🍴
        </h1>

        <p>
            Choose your favorite dishes and enjoy fast delivery
        </p>

    </div>

    <!-- MENU GRID -->

    <div class="menu-grid">

    <%

    for(MenuItem item : menuList){

    %>

    <!-- MENU CARD -->

    <div class="menu-card"

         data-name="<%= item.getItemName().toLowerCase() %>"

         data-description="<%= item.getDescription().toLowerCase() %>">

        <!-- IMAGE -->

        <img src="<%= request.getContextPath() %>/<%= item.getImagePath() %>"
             alt="Food Image">

        <!-- CONTENT -->

        <div class="menu-content">

            <!-- ITEM NAME -->

            <h2 class="item-name">

                <%= item.getItemName() %>

            </h2>

            <!-- DESCRIPTION -->

            <p class="item-description">

                <%= item.getDescription() %>

            </p>

            <!-- FOOTER -->

            <div class="menu-footer">

                <!-- PRICE -->

                <div class="item-price">

                    ₹ <%= item.getPrice() %>

                </div>

                <!-- ADD TO CART -->

                <form action="cart"
                      method="post">

                    <input type="hidden"
                           name="itemId"
                           value="<%= item.getItemId() %>">

                    <button type="submit"
                            class="add-btn">

                        Add +

                    </button>

                </form>

            </div>

        </div>

    </div>

    <%

    }

    %>

    </div>

</div>

<!-- JS -->

<script src="js/menu.js"></script>

</body>

</html>
