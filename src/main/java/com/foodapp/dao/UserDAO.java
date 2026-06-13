package com.foodapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import com.foodapp.model.User;
import com.foodapp.util.DBConnection;

public class UserDAO {

    // INSERT USER METHOD
    public boolean registerUser(User user) {

        boolean isRegistered = false;

        try {

            // Get database connection
            Connection connection = DBConnection.getConnection();

            // SQL INSERT QUERY
            String query = "INSERT INTO users "
                    + "(name, email, phone, address, password, role) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            // Create PreparedStatement
            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            // Set values
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setString(4, user.getAddress());
            preparedStatement.setString(5, user.getPassword());
            preparedStatement.setString(6, user.getRole());

            // Execute query
            int rowsInserted = preparedStatement.executeUpdate();

            // Check insertion success
            if (rowsInserted > 0) {

                isRegistered = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return isRegistered;
    }
 // LOGIN USER METHOD
    public User loginUser(String email, String password) {

        User user = null;

        try {

            // Get database connection
            Connection connection = DBConnection.getConnection();

            // SQL SELECT QUERY
            String query =
                    "SELECT * FROM users WHERE email=? AND password=?";

            // Create PreparedStatement
            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            // Set values
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            // Execute query
            ResultSet resultSet = preparedStatement.executeQuery();

            // Check user exists
            if (resultSet.next()) {

                user = new User();

                user.setUserId(resultSet.getInt("user_id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setAddress(resultSet.getString("address"));
                user.setRole(resultSet.getString("role"));
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return user;
    }
    
}