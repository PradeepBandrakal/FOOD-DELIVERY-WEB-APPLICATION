<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Foodie</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<% request.setAttribute("currentPage", "dashboard"); %>

<div class="admin-layout">

    <!-- SIDEBAR -->
    <jsp:include page="components/sidebar.jsp" />

    <!-- MAIN CONTENT -->
    <main class="admin-main">

        <!-- HEADER -->
        <div class="admin-header">
            <div>
                <h1 class="admin-title">Dashboard</h1>
                <p class="admin-subtitle">Welcome back, <strong>${adminName}</strong> 👋</p>
            </div>
            <div class="header-date" id="adminDate"></div>
        </div>

        <!-- STAT CARDS ROW 1 -->
        <div class="stats-grid">

            <div class="stat-card stat-blue">
                <div class="stat-icon">🛒</div>
                <div class="stat-info">
                    <div class="stat-value">${totalOrders}</div>
                    <div class="stat-label">Total Orders</div>
                </div>
            </div>

            <div class="stat-card stat-green">
                <div class="stat-icon">💰</div>
                <div class="stat-info">
                    <div class="stat-value">₹${String.format("%.0f", totalRevenue)}</div>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>

            <div class="stat-card stat-orange">
                <div class="stat-icon">👤</div>
                <div class="stat-info">
                    <div class="stat-value">${totalUsers}</div>
                    <div class="stat-label">Registered Users</div>
                </div>
            </div>

            <div class="stat-card stat-purple">
                <div class="stat-icon">🏪</div>
                <div class="stat-info">
                    <div class="stat-value">${totalRestaurants}</div>
                    <div class="stat-label">Restaurants</div>
                </div>
            </div>

        </div>

        <!-- STAT CARDS ROW 2 -->
        <div class="stats-grid">

            <div class="stat-card stat-teal">
                <div class="stat-icon">📅</div>
                <div class="stat-info">
                    <div class="stat-value">${todayOrders}</div>
                    <div class="stat-label">Today's Orders</div>
                </div>
            </div>

            <div class="stat-card stat-indigo">
                <div class="stat-icon">💵</div>
                <div class="stat-info">
                    <div class="stat-value">₹${String.format("%.0f", todayRevenue)}</div>
                    <div class="stat-label">Today's Revenue</div>
                </div>
            </div>

            <div class="stat-card stat-red">
                <div class="stat-icon">⏳</div>
                <div class="stat-info">
                    <div class="stat-value">${pendingOrders}</div>
                    <div class="stat-label">Pending Orders</div>
                </div>
            </div>

            <div class="stat-card stat-pink">
                <div class="stat-icon">🍽️</div>
                <div class="stat-info">
                    <div class="stat-value">${totalMenuItems}</div>
                    <div class="stat-label">Menu Items</div>
                </div>
            </div>

        </div>

        <!-- QUICK ACTIONS -->
        <div class="quick-actions">
            <h2 class="section-heading">Quick Actions</h2>
            <div class="action-cards">

                <a href="${pageContext.request.contextPath}/admin/restaurants?action=add"
                   class="action-card">
                    <span class="action-icon">➕</span>
                    <span>Add Restaurant</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/menu-items?action=add"
                   class="action-card">
                    <span class="action-icon">🍕</span>
                    <span>Add Menu Item</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/orders"
                   class="action-card">
                    <span class="action-icon">📦</span>
                    <span>View Orders</span>
                </a>

                <a href="${pageContext.request.contextPath}/home.jsp"
                   class="action-card" target="_blank">
                    <span class="action-icon">🌐</span>
                    <span>View Site</span>
                </a>

            </div>
        </div>

    </main>

</div>

<script>
    // Live date display
    const dateEl = document.getElementById('adminDate');
    const now = new Date();
    dateEl.textContent = now.toLocaleDateString('en-IN', {
        weekday: 'long', year: 'numeric',
        month: 'long', day: 'numeric'
    });
</script>

</body>
</html>
