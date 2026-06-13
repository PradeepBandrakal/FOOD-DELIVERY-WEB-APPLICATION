
<%@ page import="com.foodapp.model.User" %>

<%

User user =
(User) session.getAttribute("loggedInUser");

String userName = "";

if(user != null){

    userName = user.getName();
}

%>

<nav class="navbar">

    <!-- LEFT SECTION -->

    <div class="nav-left">

        <a href="home.jsp"
           class="logo">

            Foodie

        </a>

    </div>

    <!-- CENTER SECTION -->

    <div class="nav-center">

        <div class="search-box">

            <span class="search-icon">

                🔍

            </span>

            <input type="text"
                   id="searchInput"
                   placeholder="Search for restaurants and food">

        </div>

    </div>

    <!-- RIGHT SECTION -->

    <div class="nav-right">

        <!-- HOME -->

        <a href="home.jsp"
           class="nav-link">

            Home

        </a>

        <!-- ORDERS -->

        <a href="orders.jsp"
           class="nav-link">

            Orders

        </a>

        <!-- CART -->

        <a href="cart.jsp"
           class="nav-link">

            Cart

        </a>

        <!-- USER PROFILE -->

        <div class="user-profile">

            <div class="user-avatar">

                <%= userName.substring(0,1).toUpperCase() %>

            </div>

            <span class="user-name">

                <%= userName %>

            </span>

        </div>

        <!-- LOGOUT -->

        <a href="logout"
           class="logout-btn">

            Logout

        </a>

    </div>

</nav>

<!-- SEARCH SCRIPT -->

<script>

document.addEventListener("DOMContentLoaded", function(){

    const searchInput =
    document.getElementById("searchInput");

    if(searchInput){

        searchInput.addEventListener("keyup", function(){

            let filter =
            searchInput.value.toLowerCase();

            // RESTAURANT CARDS

            const restaurantCards =
            document.querySelectorAll(".card");

            restaurantCards.forEach(function(card){

                let text =
                card.innerText.toLowerCase();

                if(text.includes(filter)){

                    card.style.display = "block";

                } else {

                    card.style.display = "none";
                }
            });

            // MENU CARDS

            const menuCards =
            document.querySelectorAll(".menu-card");

            menuCards.forEach(function(card){

                let itemName =
                card.dataset.name;

                let itemDescription =
                card.dataset.description;

                if(itemName.includes(filter)
                || itemDescription.includes(filter)){

                    card.style.display = "flex";

                } else {

                    card.style.display = "none";
                }
            });

        });
    }

});

</script>
