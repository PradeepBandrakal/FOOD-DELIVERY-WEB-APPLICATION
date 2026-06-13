package com.foodapp.controller.admin;

import java.io.IOException;

import com.foodapp.dao.AdminDAO;
import com.foodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Verify admin session (filter already checked,
        // but good practice to confirm)
        HttpSession session = request.getSession(false);
        User admin = (User) session.getAttribute("loggedInUser");

        // Load dashboard stats
        AdminDAO adminDAO = new AdminDAO();

        request.setAttribute("totalUsers",
                adminDAO.getTotalUsers());

        request.setAttribute("totalRestaurants",
                adminDAO.getTotalRestaurants());

        request.setAttribute("totalOrders",
                adminDAO.getTotalOrders());

        request.setAttribute("totalRevenue",
                adminDAO.getTotalRevenue());

        request.setAttribute("todayOrders",
                adminDAO.getTodayOrders());

        request.setAttribute("todayRevenue",
                adminDAO.getTodayRevenue());

        request.setAttribute("pendingOrders",
                adminDAO.getPendingOrders());

        request.setAttribute("totalMenuItems",
                adminDAO.getTotalMenuItems());

        request.setAttribute("adminName",
                admin.getName());

        // Forward to dashboard JSP
        request.getRequestDispatcher(
                "/admin/dashboard.jsp")
                .forward(request, response);
    }
}
