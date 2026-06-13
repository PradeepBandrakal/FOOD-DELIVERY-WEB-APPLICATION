package com.foodapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.foodapp.util.DBConnection;

public class AdminDAO {

    // ─── TOTAL USERS ────────────────────────────────
    public int getTotalUsers() {

        int count = 0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COUNT(*) FROM users "
                    + "WHERE role = 'customer'";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // ─── TOTAL RESTAURANTS ──────────────────────────
    public int getTotalRestaurants() {

        int count = 0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COUNT(*) FROM restaurants";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // ─── TOTAL ORDERS ────────────────────────────────
    public int getTotalOrders() {

        int count = 0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COUNT(*) FROM orders";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // ─── TOTAL REVENUE ───────────────────────────────
    public double getTotalRevenue() {

        double revenue = 0.0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COALESCE(SUM(total_amount), 0) "
                    + "FROM orders";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                revenue = rs.getDouble(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return revenue;
    }

    // ─── TODAY'S ORDERS ──────────────────────────────
    public int getTodayOrders() {

        int count = 0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COUNT(*) FROM orders "
                    + "WHERE DATE(order_date) = CURDATE()";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // ─── TODAY'S REVENUE ─────────────────────────────
    public double getTodayRevenue() {

        double revenue = 0.0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COALESCE(SUM(total_amount), 0) "
                    + "FROM orders "
                    + "WHERE DATE(order_date) = CURDATE()";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                revenue = rs.getDouble(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return revenue;
    }

    // ─── PENDING ORDERS ──────────────────────────────
    public int getPendingOrders() {

        int count = 0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COUNT(*) FROM orders "
                    + "WHERE status = 'Pending'";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // ─── TOTAL MENU ITEMS ────────────────────────────
    public int getTotalMenuItems() {

        int count = 0;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT COUNT(*) FROM menu_items";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
}
