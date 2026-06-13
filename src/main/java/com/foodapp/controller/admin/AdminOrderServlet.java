package com.foodapp.controller.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.foodapp.model.Order;
import com.foodapp.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ─── GET: List all orders ─────────────────────────
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Order> orderList = getAllOrders();

        request.setAttribute("orderList", orderList);

        request.getRequestDispatcher(
                "/admin/orders.jsp")
                .forward(request, response);
    }

    // ─── POST: Update order status ────────────────────
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(
                request.getParameter("orderId"));

        String newStatus =
                request.getParameter("status");

        updateOrderStatus(orderId, newStatus);

        response.sendRedirect(
                request.getContextPath()
                + "/admin/orders?success=updated");
    }

    // ─── FETCH ALL ORDERS (with user info) ───────────
    private ArrayList<Order> getAllOrders() {

        ArrayList<Order> orderList = new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT o.*, u.name AS user_name, "
                    + "u.email AS user_email "
                    + "FROM orders o "
                    + "JOIN users u ON o.user_id = u.user_id "
                    + "ORDER BY o.order_date DESC";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setStatus(
                        rs.getString("status"));

                order.setPaymentMethod(
                        rs.getString("payment_method"));

                order.setDeliveryAddress(
                        rs.getString("delivery_address"));

                order.setOrderDate(
                        rs.getTimestamp("order_date"));

                // Extra fields stored as request attrs
                // We'll store on the order object via
                // the existing model (add to request map)
                order.setCustomerName(
                        rs.getString("user_name"));

                order.setCustomerEmail(
                        rs.getString("user_email"));

                orderList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    // ─── UPDATE ORDER STATUS ──────────────────────────
    private void updateOrderStatus(int orderId,
                                   String status) {

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "UPDATE orders SET status = ? "
                    + "WHERE order_id = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setString(1, status);
            ps.setInt(2, orderId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
