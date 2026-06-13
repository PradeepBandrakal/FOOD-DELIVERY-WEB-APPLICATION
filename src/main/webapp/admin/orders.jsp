<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.foodapp.model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Orders | Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<% request.setAttribute("currentPage", "orders"); %>

<div class="admin-layout">
    <jsp:include page="components/sidebar.jsp" />

    <main class="admin-main">

        <div class="admin-header">
            <div>
                <h1 class="admin-title">Orders</h1>
                <p class="admin-subtitle">View and manage all customer orders</p>
            </div>
        </div>

        <!-- ALERTS -->
        <% if ("updated".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success">✅ Order status updated successfully!</div>
        <% } %>

        <!-- SEARCH -->
        <div class="search-bar-wrap">
            <input type="text" id="searchInput"
                   class="search-input"
                   placeholder="🔍 Search by customer name, status..."
                   onkeyup="filterTable()">
        </div>

        <!-- TABLE -->
        <div class="table-wrapper">
            <table class="admin-table" id="ordersTable">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Payment</th>
                        <th>Address</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Update</th>
                    </tr>
                </thead>
                <tbody>
                <%
                ArrayList<Order> orderList =
                    (ArrayList<Order>) request.getAttribute("orderList");
                for (Order order : orderList) {
                    String status = order.getStatus();
                %>
                    <tr>
                        <td><strong>#<%= order.getOrderId() %></strong></td>
                        <td>
                            <div class="customer-info">
                                <span class="customer-name"><%= order.getCustomerName() %></span>
                                <span class="customer-email"><%= order.getCustomerEmail() %></span>
                            </div>
                        </td>
                        <td><strong>₹<%= String.format("%.2f", order.getTotalAmount()) %></strong></td>
                        <td><%= order.getPaymentMethod() %></td>
                        <td class="addr-cell"><%= order.getDeliveryAddress() %></td>
                        <td class="date-cell"><%= order.getOrderDate() %></td>
                        <td>
                            <span class="badge
                                <%
                                if ("Delivered".equals(status))       out.print("badge-active");
                                else if ("Pending".equals(status))    out.print("badge-pending");
                                else if ("Cancelled".equals(status))  out.print("badge-inactive");
                                else                                  out.print("badge-transit");
                                %>">
                                <%= status %>
                            </span>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/orders"
                                  method="post"
                                  class="status-form">
                                <input type="hidden" name="orderId"
                                       value="<%= order.getOrderId() %>">
                                <select name="status" class="status-select"
                                        onchange="this.form.submit()">
                                    <option value="Pending"             <%= "Pending".equals(status)              ? "selected" : "" %>>Pending</option>
                                    <option value="Confirmed"           <%= "Confirmed".equals(status)            ? "selected" : "" %>>Confirmed</option>
                                    <option value="Preparing"           <%= "Preparing".equals(status)            ? "selected" : "" %>>Preparing</option>
                                    <option value="Out for Delivery"    <%= "Out for Delivery".equals(status)     ? "selected" : "" %>>Out for Delivery</option>
                                    <option value="Delivered"           <%= "Delivered".equals(status)            ? "selected" : "" %>>Delivered</option>
                                    <option value="Cancelled"           <%= "Cancelled".equals(status)            ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </form>
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
    const rows  = document.querySelectorAll('#ordersTable tbody tr');
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(input) ? '' : 'none';
    });
}
</script>
</body>
</html>
