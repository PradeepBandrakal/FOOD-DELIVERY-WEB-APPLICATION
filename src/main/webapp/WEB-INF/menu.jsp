<%@ page language="java" contentType="text/html; charset=UTF-8"
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

<style>

body{
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
}

.container{
    width: 90%;
    margin: 30px auto;

    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.card{
    background-color: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
}

.card img{
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.card-content{
    padding: 15px;
}

.price{
    color: green;
    font-size: 20px;
    font-weight: bold;
}

button{
    width: 100%;
    padding: 10px;
    background-color: orange;
    border: none;
    color: white;
    font-size: 16px;
    cursor: pointer;
}

</style>

</head>
<body>

<h1 style="text-align:center;">
    Welcome, <%= user.getName() %>
</h1>

<div class="container">

<%

for(MenuItem item : menuList){

%>

<div class="card">

    <img src="<%= item.getImagePath() %>">

    <div class="card-content">

        <h2>
            <%= item.getItemName() %>
        </h2>

        <p>
            <%= item.getDescription() %>
        </p>

        <p class="price">
            ₹ <%= item.getPrice() %>
        </p>

        <button>
            Add To Cart
        </button>

    </div>

</div>

<%

}

%>

</div>

</body>
</html>