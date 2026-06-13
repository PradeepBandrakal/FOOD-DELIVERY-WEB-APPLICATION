package com.foodapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import com.foodapp.model.Order;
import com.foodapp.model.OrderItemDetails;
import com.foodapp.util.DBConnection;

public class OrderDAO {

    // FETCH ORDERS BY USER ID

    public ArrayList<Order> getOrdersByUserId(int userId){

        ArrayList<Order> orderList =
                new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM orders "
                    + "WHERE user_id=? "
                    + "ORDER BY order_date DESC";

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, userId);

            ResultSet resultSet =
                    preparedStatement.executeQuery();

            while(resultSet.next()){

                Order order =
                        new Order();

                order.setOrderId(
                        resultSet.getInt("order_id"));

                order.setUserId(
                        resultSet.getInt("user_id"));

                order.setTotalAmount(
                        resultSet.getDouble("total_amount"));

                order.setStatus(
                        resultSet.getString("status"));

                order.setPaymentMethod(
                        resultSet.getString("payment_method"));

                order.setDeliveryAddress(
                        resultSet.getString("delivery_address"));

                order.setOrderDate(
                        resultSet.getTimestamp("order_date"));

                // ADD TO LIST

                orderList.add(order);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return orderList;
    }
    
 // FETCH SINGLE ORDER BY ID

    public Order getOrderById(int orderId){

        Order order = null;

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM orders "
                  + "WHERE order_id=?";

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, orderId);

            ResultSet resultSet =
                    preparedStatement.executeQuery();

            if(resultSet.next()){

                order = new Order();

                order.setOrderId(
                        resultSet.getInt("order_id"));

                order.setUserId(
                        resultSet.getInt("user_id"));

                order.setTotalAmount(
                        resultSet.getDouble("total_amount"));

                order.setStatus(
                        resultSet.getString("status"));

                order.setPaymentMethod(
                        resultSet.getString("payment_method"));

                order.setDeliveryAddress(
                        resultSet.getString("delivery_address"));

                order.setOrderDate(
                        resultSet.getTimestamp("order_date"));
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return order;
    }

    // FETCH ORDER ITEMS BY ORDER ID

    public ArrayList<OrderItemDetails>
    getOrderItemsByOrderId(int orderId){

        ArrayList<OrderItemDetails> itemList =
                new ArrayList<>();

        try {

            Connection connection =
                    DBConnection.getConnection();

            String query =
                    "SELECT oi.*, m.item_name, m.image_path "
                  + "FROM order_items oi "
                  + "JOIN menu_items m "
                  + "ON oi.item_id = m.item_id "
                  + "WHERE oi.order_id=?";

            PreparedStatement preparedStatement =
                    connection.prepareStatement(query);

            preparedStatement.setInt(1, orderId);

            ResultSet resultSet =
                    preparedStatement.executeQuery();

            while(resultSet.next()){

                OrderItemDetails item =
                        new OrderItemDetails();

                item.setItemName(
                        resultSet.getString("item_name"));

                item.setQuantity(
                        resultSet.getInt("quantity"));

                item.setPrice(
                        resultSet.getDouble("price"));

                item.setSubtotal(
                        resultSet.getDouble("subtotal"));

                item.setImagePath(
                        resultSet.getString("image_path"));

                // ADD ITEM TO LIST

                itemList.add(item);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return itemList;
    }
}