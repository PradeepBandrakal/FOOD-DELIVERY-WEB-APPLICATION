package com.foodapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import com.foodapp.model.Restaurant;
import com.foodapp.util.DBConnection;

public class RestaurantDAO {

    // ─── HELPER: Map ResultSet row to Restaurant ─────
    private Restaurant mapRow(ResultSet rs)
            throws SQLException {

        Restaurant r = new Restaurant();

        r.setRestaurantId(rs.getInt("restaurant_id"));
        r.setName(rs.getString("name"));
        r.setCuisineType(rs.getString("cuisine_type"));
        r.setDeliveryTime(rs.getString("delivery_time"));
        r.setAddress(rs.getString("address"));
        r.setRating(rs.getDouble("rating"));
        r.setActive(rs.getBoolean("is_active"));
        r.setImagePath(rs.getString("image_path"));

        return r;
    }

    // ─── FETCH ALL ACTIVE RESTAURANTS (Customer) ────
    public ArrayList<Restaurant> getAllRestaurants() {

        ArrayList<Restaurant> restaurantList =
                new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM restaurants "
                    + "WHERE is_active = true "
                    + "ORDER BY name ASC";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                restaurantList.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }

    // ─── FETCH ALL RESTAURANTS (Admin — incl inactive)
    public ArrayList<Restaurant> getAllRestaurantsForAdmin() {

        ArrayList<Restaurant> restaurantList =
                new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM restaurants "
                    + "ORDER BY restaurant_id DESC";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                restaurantList.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }

    // ─── FETCH SINGLE RESTAURANT BY ID ───────────────
    public Restaurant getRestaurantById(int restaurantId) {

        Restaurant restaurant = null;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM restaurants "
                    + "WHERE restaurant_id = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                restaurant = mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    // ─── ADD RESTAURANT ──────────────────────────────
    public boolean addRestaurant(Restaurant restaurant) {

        boolean success = false;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "INSERT INTO restaurants "
                    + "(name, cuisine_type, address, "
                    + "rating, delivery_time, "
                    + "image_path, is_active) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setString(3, restaurant.getAddress());
            ps.setDouble(4, restaurant.getRating());
            ps.setString(5, restaurant.getDeliveryTime());
            ps.setString(6, restaurant.getImagePath());
            ps.setBoolean(7, restaurant.isActive());

            int rows = ps.executeUpdate();

            success = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // ─── UPDATE RESTAURANT ───────────────────────────
    public boolean updateRestaurant(Restaurant restaurant) {

        boolean success = false;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "UPDATE restaurants SET "
                    + "name = ?, "
                    + "cuisine_type = ?, "
                    + "address = ?, "
                    + "rating = ?, "
                    + "delivery_time = ?, "
                    + "image_path = ?, "
                    + "is_active = ? "
                    + "WHERE restaurant_id = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setString(3, restaurant.getAddress());
            ps.setDouble(4, restaurant.getRating());
            ps.setString(5, restaurant.getDeliveryTime());
            ps.setString(6, restaurant.getImagePath());
            ps.setBoolean(7, restaurant.isActive());
            ps.setInt(8, restaurant.getRestaurantId());

            int rows = ps.executeUpdate();

            success = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    // ─── DELETE RESTAURANT ───────────────────────────
    public boolean deleteRestaurant(int restaurantId) {

        boolean success = false;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "DELETE FROM restaurants "
                    + "WHERE restaurant_id = ?";

            PreparedStatement ps =
                    connection.prepareStatement(query);

            ps.setInt(1, restaurantId);

            int rows = ps.executeUpdate();

            success = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }
}