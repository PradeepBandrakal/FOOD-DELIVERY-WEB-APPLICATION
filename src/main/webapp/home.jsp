
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="com.foodapp.model.User" %>
<%@ page import="com.foodapp.model.Restaurant" %>
<%@ page import="com.foodapp.dao.RestaurantDAO" %>

<%

// Session validation
User user = (User) session.getAttribute("loggedInUser");

if(user == null){

    response.sendRedirect("login.jsp");
    return;
}

// Fetch restaurants
RestaurantDAO restaurantDAO = new RestaurantDAO();

ArrayList<Restaurant> restaurantList =
        restaurantDAO.getAllRestaurants();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Foodie | Home</title>

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
href="css/home.css">

<link rel="stylesheet"
href="css/card.css">

<link rel="stylesheet"
href="css/responsive.css">

</head>

<body>

<!-- NAVBAR -->

<jsp:include page="components/navbar.jsp" />

<!-- HERO SECTION -->

<section class="hero-section">

    <div class="hero-overlay">

        <div class="hero-content">

            <h1>
                Delicious Food Delivered To Your Doorstep
            </h1>

            <p>
                Order from your favorite restaurants anytime
            </p>

            <a href="#restaurants">

                <button class="hero-btn">
                    Explore Restaurants
                </button>

            </a>

        </div>

    </div>

</section>

<!-- HOME PAGE -->

<div class="home-section">

    <!-- RESTAURANT SECTION -->
<section class="restaurant-section"
         id="restaurants">
        <h1 class="section-title">
            Top Restaurants Near You
        </h1>

        <!-- RESTAURANT GRID -->

        <div class="restaurant-grid">

        <%

        for(Restaurant restaurant : restaurantList){

        %>

        <!-- RESTAURANT CARD -->

        <a href="menu.jsp?restaurantId=<%= restaurant.getRestaurantId() %>">

           

<div class="restaurant-card"
     data-name="<%= restaurant.getName().toLowerCase() %>">



    <!-- IMAGE SECTION -->

    <div class="restaurant-image">

        <img src="<%= restaurant.getImagePath() %>"
             alt="Restaurant Image">

        <!-- OVERLAY -->

        <div class="image-overlay"></div>

        <!-- DELIVERY BADGE -->

        <div class="delivery-badge">

            🚚 <%= restaurant.getDeliveryTime() %>

        </div>

        <!-- RATING -->

        <div class="rating-badge">

            ⭐ <%= restaurant.getRating() %>

        </div>

    </div>

    <!-- CONTENT -->

    <div class="restaurant-content">

        <!-- NAME -->

        <h2 class="restaurant-name">

            <%= restaurant.getName() %>

        </h2>

        <!-- CUISINE -->

        <p class="restaurant-cuisine">

            🍽️
            <%= restaurant.getCuisineType() %>

        </p>

        <!-- ADDRESS -->

        <p class="restaurant-address">

            📍
            <%= restaurant.getAddress() %>

        </p>

        <!-- FOOTER -->

        <div class="card-footer">

            <span>
                Fast Delivery
            </span>

            <div class="view-menu-btn">

                View Menu

            </div>

        </div>

    </div>

</div>



        </a>

        <%

        }

        %>

        </div>

    </section>

</div>

<script src="js/home.js"></script>


</body>
</html>

