<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="admin-sidebar">

    <div class="sidebar-brand">
        <span class="brand-icon">🍔</span>
        <span class="brand-text">Foodie Admin</span>
    </div>

    <ul class="sidebar-nav">

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}">
                <span class="nav-icon">📊</span>
                <span>Dashboard</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/restaurants"
               class="nav-link ${currentPage == 'restaurants' ? 'active' : ''}">
                <span class="nav-icon">🏪</span>
                <span>Restaurants</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/menu-items"
               class="nav-link ${currentPage == 'menu' ? 'active' : ''}">
                <span class="nav-icon">🍽️</span>
                <span>Menu Items</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/orders"
               class="nav-link ${currentPage == 'orders' ? 'active' : ''}">
                <span class="nav-icon">🛒</span>
                <span>Orders</span>
            </a>
        </li>

    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout"
           class="logout-btn">
            <span>🚪</span> Logout
        </a>
    </div>

</nav>
