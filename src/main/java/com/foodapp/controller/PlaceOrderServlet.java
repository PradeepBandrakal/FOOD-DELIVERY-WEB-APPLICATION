package com.foodapp.controller;




import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import com.foodapp.model.CartItem;
import com.foodapp.model.User;
import com.foodapp.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Session
        HttpSession session =
                request.getSession();

        // Logged in user
        User user =
                (User) session.getAttribute("loggedInUser");

        // Cart
        ArrayList<CartItem> cartList =
                (ArrayList<CartItem>)
                session.getAttribute("cart");

        // Form data
        String address =
                request.getParameter("address");

        String paymentMethod =
                request.getParameter("paymentMethod");
        
        
     // BACKEND VALIDATION

     if(address == null || address.trim().isEmpty()){

         request.setAttribute(
                 "errorMessage",
                 "Delivery address is required!");

         request.getRequestDispatcher(
                 "checkout.jsp")
                 .forward(request, response);

         return;
     }
    


        // Calculate total
        double grandTotal = 0;

        for(CartItem cartItem : cartList){

            grandTotal += cartItem.getTotalPrice();
        }

        try {

            Connection connection =
                    DBConnection.getConnection();

            // INSERT INTO ORDERS
            String orderQuery =
                    "INSERT INTO orders "
                    + "(user_id, total_amount, "
                    + "payment_method, delivery_address) "
                    + "VALUES (?, ?, ?, ?)";

            PreparedStatement orderStatement =
                    connection.prepareStatement(
                            orderQuery,
                            PreparedStatement.RETURN_GENERATED_KEYS);

            orderStatement.setInt(
                    1,
                    user.getUserId());

            orderStatement.setDouble(
                    2,
                    grandTotal);

            orderStatement.setString(
                    3,
                    paymentMethod);

            orderStatement.setString(
                    4,
                    address);

            // Execute order insert
            orderStatement.executeUpdate();

            // Get generated order ID
            ResultSet generatedKeys =
                    orderStatement.getGeneratedKeys();

            int orderId = 0;

            if(generatedKeys.next()){

                orderId = generatedKeys.getInt(1);
            }

            // INSERT ORDER ITEMS
            String itemQuery =
                    "INSERT INTO order_items "
                    + "(order_id, item_id, quantity, "
                    + "price, subtotal) "
                    + "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement itemStatement =
                    connection.prepareStatement(itemQuery);

            for(CartItem cartItem : cartList){

                itemStatement.setInt(
                        1,
                        orderId);

                itemStatement.setInt(
                        2,
                        cartItem.getMenuItem().getItemId());

                itemStatement.setInt(
                        3,
                        cartItem.getQuantity());

                itemStatement.setDouble(
                        4,
                        cartItem.getMenuItem().getPrice());

                itemStatement.setDouble(
                        5,
                        cartItem.getTotalPrice());

                itemStatement.executeUpdate();
            }

            // Clear cart
            session.removeAttribute("cart");

            // Redirect success page
            response.sendRedirect("order-success.jsp");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }
}