<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.foodapp.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Restaurants | Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<% request.setAttribute("currentPage", "restaurants"); %>

<div class="admin-layout">
    <jsp:include page="components/sidebar.jsp" />

    <main class="admin-main">

        <div class="admin-header">
            <div>
                <h1 class="admin-title">Restaurants</h1>
                <p class="admin-subtitle">Manage all restaurants on the platform</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/restaurants?action=add"
               class="btn-primary">+ Add Restaurant</a>
        </div>

        <!-- ALERTS -->
        <% if ("added".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">✅ Restaurant added successfully!</div>
        <% } else if ("updated".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">✅ Restaurant updated successfully!</div>
        <% } else if ("deleted".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">🗑️ Restaurant deleted successfully!</div>
        <% } %>

        <!-- SEARCH BAR -->
        <div class="search-bar-wrap">
            <input type="text" id="searchInput"
                   class="search-input"
                   placeholder="🔍 Search restaurants..."
                   onkeyup="filterTable()">
        </div>

        <!-- TABLE -->
        <div class="table-wrapper">
            <table class="admin-table" id="restaurantTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Cuisine</th>
                        <th>Rating</th>
                        <th>Delivery Time</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                ArrayList<Restaurant> restaurantList =
                    (ArrayList<Restaurant>) request.getAttribute("restaurantList");
                int i = 1;
                for (Restaurant r : restaurantList) {
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td>
                            <img src="${pageContext.request.contextPath}/<%= r.getImagePath() %>"
                                 alt="Restaurant"
                                 class="table-img"
                                 onerror="this.src='${pageContext.request.contextPath}/images/restaurants/default.jpg'">
                        </td>
                        <td><strong><%= r.getName() %></strong></td>
                        <td><%= r.getCuisineType() %></td>
                        <td>⭐ <%= r.getRating() %></td>
                        <td>🚚 <%= r.getDeliveryTime() %></td>
                        <td>
                            <span class="badge <%= r.isActive() ? "badge-active" : "badge-inactive" %>">
                                <%= r.isActive() ? "Active" : "Inactive" %>
                            </span>
                        </td>
                        <td class="action-btns">
                            <a href="${pageContext.request.contextPath}/admin/restaurants?action=edit&id=<%= r.getRestaurantId() %>"
                               class="btn-edit">✏️ Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/restaurants?action=delete&id=<%= r.getRestaurantId() %>"
                               class="btn-delete"
                               onclick="return confirm('Delete <%= r.getName() %>?')">🗑️ Delete</a>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

    </main>
</div>

<script>
function filterTable() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const rows  = document.querySelectorAll('#restaurantTable tbody tr');
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(input) ? '' : 'none';
    });
}
</script>
</body>
</html>
