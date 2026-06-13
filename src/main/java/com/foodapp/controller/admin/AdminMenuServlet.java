package com.foodapp.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import com.foodapp.dao.MenuDAO;
import com.foodapp.dao.RestaurantDAO;
import com.foodapp.model.MenuItem;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/admin/menu-items")
@MultipartConfig(maxFileSize = 2 * 1024 * 1024) // 2MB limit
public class AdminMenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Upload folder relative to webapp
    private static final String UPLOAD_DIR = "images/menu";

    // ─── GET: List + Edit form ────────────────────────
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        MenuDAO menuDAO = new MenuDAO();
        RestaurantDAO restaurantDAO = new RestaurantDAO();

        if ("edit".equals(action)) {

            // Load item for edit form
            int itemId = Integer.parseInt(
                    request.getParameter("id"));

            MenuItem item = menuDAO.getMenuItemById(itemId);

            // Load restaurant list for dropdown
            ArrayList<Restaurant> restaurantList =
                    restaurantDAO.getAllRestaurantsForAdmin();

            request.setAttribute("menuItem", item);
            request.setAttribute("restaurantList", restaurantList);

            request.getRequestDispatcher(
                    "/admin/edit-menu-item.jsp")
                    .forward(request, response);

        } else if ("delete".equals(action)) {

            // Delete menu item
            int itemId = Integer.parseInt(
                    request.getParameter("id"));

            menuDAO.deleteMenuItem(itemId);

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/menu-items?success=deleted");

        } else {

            // List all menu items + restaurant list
            ArrayList<MenuItem> menuList =
                    menuDAO.getAllMenuItemsForAdmin();

            ArrayList<Restaurant> restaurantList =
                    restaurantDAO.getAllRestaurantsForAdmin();

            request.setAttribute("menuList", menuList);
            request.setAttribute("restaurantList", restaurantList);

            request.getRequestDispatcher(
                    "/admin/menu-items.jsp")
                    .forward(request, response);
        }
    }

    // ─── POST: Add or Update ──────────────────────────
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Determine upload path on server
        String uploadPath = getServletContext()
                .getRealPath("") + File.separator + UPLOAD_DIR;

        // Create upload directory if not exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Read form fields
        String action           = request.getParameter("action");
        String itemId           = request.getParameter("itemId");
        String restaurantId     = request.getParameter("restaurantId");
        String itemName         = request.getParameter("itemName");
        String description      = request.getParameter("description");
        String price            = request.getParameter("price");
        String isAvailable      = request.getParameter("isAvailable");
        String existingImagePath = request.getParameter("existingImagePath");
        String imagePath        = null;

        try {

            // Handle file upload
            Part filePart = request.getPart("itemImage");
            if (filePart != null && filePart.getSize() > 0) {

                String fileName = getFileName(filePart);

                if (fileName != null && !fileName.trim().isEmpty()) {
                    String lower = fileName.toLowerCase();

                    if (lower.endsWith(".jpg") ||
                        lower.endsWith(".jpeg") ||
                        lower.endsWith(".png") ||
                        lower.endsWith(".webp")) {

                        String uniqueName = System.currentTimeMillis() + "_" + fileName;
                        filePart.write(uploadPath + File.separator + uniqueName);
                        imagePath = UPLOAD_DIR + "/" + uniqueName;
                    }
                }
            }

            // Use existing image if none uploaded
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = existingImagePath;
            }

            // Fallback default image
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = "images/menu/default.jpg";
            }

            MenuDAO menuDAO = new MenuDAO();

            if ("add".equals(action)) {

                // ── Add new menu item ─────────────────
                MenuItem menuItem = new MenuItem();

                menuItem.setRestaurantId(Integer.parseInt(restaurantId));
                menuItem.setItemName(itemName);
                menuItem.setDescription(description);
                menuItem.setPrice(Double.parseDouble(price));
                menuItem.setImagePath(imagePath);
                menuItem.setAvailable("true".equals(isAvailable));

                menuDAO.addMenuItem(menuItem);

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/menu-items?success=added");

            } else if ("update".equals(action)) {

                // ── Update existing menu item ─────────
                MenuItem menuItem = new MenuItem();

                menuItem.setItemId(Integer.parseInt(itemId));
                menuItem.setRestaurantId(Integer.parseInt(restaurantId));
                menuItem.setItemName(itemName);
                menuItem.setDescription(description);
                menuItem.setPrice(Double.parseDouble(price));
                menuItem.setImagePath(imagePath);
                menuItem.setAvailable("true".equals(isAvailable));

                menuDAO.updateMenuItem(menuItem);

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/menu-items?success=updated");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/menu-items?error=upload_failed");
        }
    }

    // Helper: extract filename from Part header
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) return null;
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1)
                            .trim()
                            .replace("\"", "");
            }
        }
        return null;
    }
}
