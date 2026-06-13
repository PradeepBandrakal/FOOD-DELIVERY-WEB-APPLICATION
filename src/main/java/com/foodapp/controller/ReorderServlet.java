package com.foodapp.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.foodapp.dao.MenuDAO;
import com.foodapp.dao.OrderDAO;
import com.foodapp.model.CartItem;
import com.foodapp.model.MenuItem;
import com.foodapp.model.OrderItemDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reorder")
public class ReorderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int orderId =
                Integer.parseInt(
                        request.getParameter("orderId"));

        OrderDAO orderDAO =
                new OrderDAO();

        ArrayList<OrderItemDetails> itemList =
                orderDAO.getOrderItemsByOrderId(orderId);

        ArrayList<CartItem> cartList =
                new ArrayList<>();

        MenuDAO menuDAO =
                new MenuDAO();

        for(OrderItemDetails item : itemList){

            MenuItem menuItem =
                    menuDAO.getMenuItemByName(
                            item.getItemName());

            if(menuItem != null){

                CartItem cartItem =
                        new CartItem();

                cartItem.setMenuItem(menuItem);

                cartItem.setQuantity(
                        item.getQuantity());

                
                cartList.add(cartItem);
            }
        }

        HttpSession session =
                request.getSession();

        session.setAttribute("cart", cartList);

        response.sendRedirect("cart.jsp");
    }
}