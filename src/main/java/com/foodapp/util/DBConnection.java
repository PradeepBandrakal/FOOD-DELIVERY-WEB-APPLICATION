package com.foodapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Database URL — timezone & SSL params required for MySQL 8
    private static final String URL =
            "jdbc:mysql://localhost:3306/food_delivery_app"
            + "?useSSL=false"
            + "&serverTimezone=Asia/Kolkata"
            + "&allowPublicKeyRetrieval=true"
            + "&useUnicode=true"
            + "&characterEncoding=UTF-8";

    // MySQL username
    private static final String USERNAME = "root";

    // MySQL password
    private static final String PASSWORD = "Sanju@313";

    // Method to establish database connection
    public static Connection getConnection() {

        Connection connection = null;

        try {

            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create database connection
            connection = DriverManager.getConnection(
                    URL, USERNAME, PASSWORD);

            System.out.println("✅ Database Connected Successfully!");

        } catch (ClassNotFoundException e) {

            System.out.println("❌ MySQL Driver Not Found!");
            System.out.println("   Cause: " + e.getMessage());
            e.printStackTrace();

        } catch (SQLException e) {

            System.out.println("❌ Database Connection Failed!");
            System.out.println("   SQLState : " + e.getSQLState());
            System.out.println("   ErrorCode: " + e.getErrorCode());
            System.out.println("   Message  : " + e.getMessage());
            e.printStackTrace();
        }

        return connection;
    }
}