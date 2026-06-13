package com.foodapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import com.foodapp.model.MenuItem;
import com.foodapp.util.DBConnection;

public class MenuDAO {

    // ─── HELPER: Map ResultSet row to MenuItem ───────
    private MenuItem mapRow(ResultSet rs)
            throws SQLException {

        MenuItem item = new MenuItem();

        item.setItemId(rs.getInt("item_id"));
        item.setRestaurantId(rs.getInt("restaurant_id"));
        item.setItemName(rs.getString("item_name"));
        item.setDescription(rs.getString("description"));
        item.setPrice(rs.getDouble("price"));
        item.setAvailable(rs.getBoolean("is_available"));
        item.setImagePath(rs.getString("image_path"));

        return item;
    }

    // ─── FETCH MENU BY RESTAURANT (Customer) ─────────
    public ArrayList<MenuItem> getMenuByRestaurant(
            int restaurantId) {

        ArrayList<MenuItem> menuList = new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM menu_items "
                    + "WHERE restaurant_id = ? "
                    + "AND is_available = true";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }

    // ─── FETCH ALL MENU ITEMS (Admin) ─────────────────
    public ArrayList<MenuItem> getAllMenuItemsForAdmin() {

        ArrayList<MenuItem> menuList = new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT m.*, r.name AS restaurant_name "
                    + "FROM menu_items m "
                    + "JOIN restaurants r "
                    + "ON m.restaurant_id = r.restaurant_id "
                    + "ORDER BY m.item_id DESC";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }

    // ─── FETCH MENU BY RESTAURANT (Admin — all items) ─
    public ArrayList<MenuItem> getMenuByRestaurantForAdmin(
            int restaurantId) {

        ArrayList<MenuItem> menuList = new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM menu_items "
                    + "WHERE restaurant_id = ? "
                    + "ORDER BY item_id DESC";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }

    // ─── FETCH MENU ITEM BY NAME ──────────────────────
    public MenuItem getMenuItemByName(String itemName) {

        MenuItem menuItem = null;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM menu_items "
                    + "WHERE item_name = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setString(1, itemName);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                menuItem = mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuItem;
    }

    // ─── FETCH SINGLE MENU ITEM BY ID ────────────────
    public MenuItem getMenuItemById(int itemId) {

        MenuItem menuItem = null;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM menu_items "
                    + "WHERE item_id = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, itemId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                menuItem = mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuItem;
    }

    // ─── ADD MENU ITEM ────────────────────────────────
    public boolean addMenuItem(MenuItem item) {

        boolean success = false;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "INSERT INTO menu_items "
                    + "(restaurant_id, item_name, "
                    + "description, price, "
                    + "image_path, is_available) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, item.getRestaurantId());
            ps.setString(2, item.getItemName());
            ps.setString(3, item.getDescription());
            ps.setDouble(4, item.getPrice());
            ps.setString(5, item.getImagePath());
            ps.setBoolean(6, item.isAvailable());

            int rows = ps.executeUpdate();

            success = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // ─── UPDATE MENU ITEM ─────────────────────────────
    public boolean updateMenuItem(MenuItem item) {

        boolean success = false;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "UPDATE menu_items SET "
                    + "restaurant_id = ?, "
                    + "item_name = ?, "
                    + "description = ?, "
                    + "price = ?, "
                    + "image_path = ?, "
                    + "is_available = ? "
                    + "WHERE item_id = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, item.getRestaurantId());
            ps.setString(2, item.getItemName());
            ps.setString(3, item.getDescription());
            ps.setDouble(4, item.getPrice());
            ps.setString(5, item.getImagePath());
            ps.setBoolean(6, item.isAvailable());
            ps.setInt(7, item.getItemId());

            int rows = ps.executeUpdate();

            success = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // ─── DELETE MENU ITEM ─────────────────────────────
    public boolean deleteMenuItem(int itemId) {

        boolean success = false;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "DELETE FROM menu_items "
                    + "WHERE item_id = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, itemId);

            int rows = ps.executeUpdate();

            success = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }
}