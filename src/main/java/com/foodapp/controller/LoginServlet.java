package com.foodapp.controller;

import java.io.IOException;

import com.foodapp.dao.UserDAO;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // DAO object
        UserDAO userDAO = new UserDAO();

        // Validate user
        User user = userDAO.loginUser(email, password);

        // Check login success
        if (user != null) {

            // Create session
            HttpSession session = request.getSession();

            // Store user object in session
            session.setAttribute("loggedInUser", user);

            // Redirect based on role
            if (user.getRole().equals("admin")) {

                response.sendRedirect("admin/dashboard");

            } else {

                response.sendRedirect("home.jsp");
            }

        } else {

        	response.sendRedirect("login.jsp?error=invalid");
        }
    }
}