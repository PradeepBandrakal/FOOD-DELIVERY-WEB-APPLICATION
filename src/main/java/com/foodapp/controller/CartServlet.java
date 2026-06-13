package com.foodapp.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.foodapp.dao.MenuDAO;
import com.foodapp.model.CartItem;
import com.foodapp.model.MenuItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get item ID from request
        int itemId =
                Integer.parseInt(
                        request.getParameter("itemId"));

        // DAO object
        MenuDAO menuDAO = new MenuDAO();

        // Fetch menu item
        MenuItem menuItem =
                menuDAO.getMenuItemById(itemId);

        // Session object
        HttpSession session =
                request.getSession();

        // Get existing cart
        ArrayList<CartItem> cartList =
                (ArrayList<CartItem>)
                session.getAttribute("cart");

        // If cart doesn't exist
        if(cartList == null){

            cartList = new ArrayList<>();
        }

        // Check if item already exists
        boolean itemExists = false;

        for(CartItem cartItem : cartList){

            if(cartItem.getMenuItem().getItemId()
                    == itemId){

                // Increase quantity
                cartItem.setQuantity(
                        cartItem.getQuantity() + 1);

                itemExists = true;

                break;
            }
        }

        // If item not already in cart
        if(!itemExists){

            CartItem cartItem =
                    new CartItem(menuItem, 1);

            cartList.add(cartItem);
        }

        // Store cart back in session
        session.setAttribute("cart", cartList);

        // Redirect to cart page
        response.sendRedirect("cart.jsp");
    }
}