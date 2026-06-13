package com.foodapp.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.foodapp.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get item ID
        int itemId =
                Integer.parseInt(
                        request.getParameter("itemId"));

        // Get action
        String action =
                request.getParameter("action");

        // Session
        HttpSession session =
                request.getSession();

        // Get cart
        ArrayList<CartItem> cartList =
                (ArrayList<CartItem>)
                session.getAttribute("cart");

        if(cartList != null){

            for(int i = 0; i < cartList.size(); i++){

                CartItem cartItem = cartList.get(i);

                if(cartItem.getMenuItem().getItemId()
                        == itemId){

                    // Increase quantity
                    if(action.equals("increase")){

                        cartItem.setQuantity(
                                cartItem.getQuantity() + 1);
                    }

                    // Decrease quantity
                    else if(action.equals("decrease")){

                        cartItem.setQuantity(
                                cartItem.getQuantity() - 1);

                        // Remove item if quantity becomes 0
                        if(cartItem.getQuantity() <= 0){

                            cartList.remove(i);
                        }
                    }

                    break;
                }
            }
        }

        // Save updated cart
        session.setAttribute("cart", cartList);

        // Redirect back
        response.sendRedirect("cart.jsp");
    }
}