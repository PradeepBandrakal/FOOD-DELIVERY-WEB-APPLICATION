<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.foodapp.model.MenuItem, com.foodapp.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu Items | Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<% request.setAttribute("currentPage", "menu"); %>

<div class="admin-layout">
    <jsp:include page="components/sidebar.jsp" />

    <main class="admin-main">

        <div class="admin-header">
            <div>
                <h1 class="admin-title">Menu Items</h1>
                <p class="admin-subtitle">Manage all food items across restaurants</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/menu-items?action=add"
               class="btn-primary">+ Add Menu Item</a>
        </div>

        <!-- ALERTS -->
        <% if ("added".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">✅ Menu item added successfully!</div>
        <% } else if ("updated".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">✅ Menu item updated successfully!</div>
        <% } else if ("deleted".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">🗑️ Menu item deleted successfully!</div>
        <% } %>

        <!-- SEARCH -->
        <div class="search-bar-wrap">
            <input type="text" id="searchInput"
                   class="search-input"
                   placeholder="🔍 Search menu items..."
                   onkeyup="filterTable()">
        </div>

        <!-- TABLE -->
        <div class="table-wrapper">
            <table class="admin-table" id="menuTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Item Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                ArrayList<MenuItem> menuList =
                    (ArrayList<MenuItem>) request.getAttribute("menuList");
                int i = 1;
                for (MenuItem item : menuList) {
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td>
                            <img src="${pageContext.request.contextPath}/<%= item.getImagePath() %>"
                                 alt="Food"
                                 class="table-img"
                                 onerror="this.src='${pageContext.request.contextPath}/images/menu/default.jpg'">
                        </td>
                        <td><strong><%= item.getItemName() %></strong></td>
                        <td class="desc-cell"><%= item.getDescription() %></td>
                        <td>₹<%= item.getPrice() %></td>
                        <td>
                            <span class="badge <%= item.isAvailable() ? "badge-active" : "badge-inactive" %>">
                                <%= item.isAvailable() ? "Available" : "Unavailable" %>
                            </span>
                        </td>
                        <td class="action-btns">
                            <a href="${pageContext.request.contextPath}/admin/menu-items?action=edit&id=<%= item.getItemId() %>"
                               class="btn-edit">✏️ Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/menu-items?action=delete&id=<%= item.getItemId() %>"
                               class="btn-delete"
                               onclick="return confirm('Delete <%= item.getItemName() %>?')">🗑️ Delete</a>
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
    const rows  = document.querySelectorAll('#menuTable tbody tr');
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(input) ? '' : 'none';
    });
}
</script>
</body>
</html>
