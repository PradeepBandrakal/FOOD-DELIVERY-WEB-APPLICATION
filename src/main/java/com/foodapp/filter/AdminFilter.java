package com.foodapp.filter;

import java.io.IOException;

import com.foodapp.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Intercepts ALL requests to /admin/*
@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig)
            throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        // Cast to HTTP types
        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        // Get session (don't create new)
        HttpSession session =
                httpRequest.getSession(false);

        // Check if user is logged in
        boolean isLoggedIn = (session != null)
                && (session.getAttribute("loggedInUser") != null);

        if (isLoggedIn) {

            // Get logged-in user
            User user = (User) session
                    .getAttribute("loggedInUser");

            // Check if user has admin role
            if ("admin".equals(user.getRole())) {

                // Allow request to proceed
                chain.doFilter(request, response);

            } else {

                // Not admin — redirect to home
                httpResponse.sendRedirect(
                        httpRequest.getContextPath()
                        + "/home.jsp");
            }

        } else {

            // Not logged in — redirect to login
            httpResponse.sendRedirect(
                    httpRequest.getContextPath()
                    + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
