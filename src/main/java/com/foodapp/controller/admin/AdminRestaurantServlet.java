package com.foodapp.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import com.foodapp.dao.RestaurantDAO;
import com.foodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/admin/restaurants")
@MultipartConfig(maxFileSize = 2 * 1024 * 1024) // 2MB limit
public class AdminRestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Upload folder relative to webapp
    private static final String UPLOAD_DIR = "images/restaurants";

    // ─── GET: List + Edit form ────────────────────────
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        RestaurantDAO restaurantDAO = new RestaurantDAO();

        if ("edit".equals(action)) {

            // Load restaurant for edit form
            int restaurantId = Integer.parseInt(
                    request.getParameter("id"));

            Restaurant restaurant =
                    restaurantDAO.getRestaurantById(restaurantId);

            request.setAttribute("restaurant", restaurant);

            request.getRequestDispatcher(
                    "/admin/edit-restaurant.jsp")
                    .forward(request, response);

        } else if ("delete".equals(action)) {

            // Delete restaurant
            int restaurantId = Integer.parseInt(
                    request.getParameter("id"));

            restaurantDAO.deleteRestaurant(restaurantId);

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/restaurants?success=deleted");

        } else {

            // List all restaurants
            ArrayList<Restaurant> restaurantList =
                    restaurantDAO.getAllRestaurantsForAdmin();

            request.setAttribute("restaurantList", restaurantList);

            request.getRequestDispatcher(
                    "/admin/restaurants.jsp")
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
        String action            = request.getParameter("action");
        String restaurantId      = request.getParameter("restaurantId");
        String name              = request.getParameter("name");
        String cuisineType       = request.getParameter("cuisineType");
        String address           = request.getParameter("address");
        String rating            = request.getParameter("rating");
        String deliveryTime      = request.getParameter("deliveryTime");
        String isActive          = request.getParameter("isActive");
        String existingImagePath = request.getParameter("existingImagePath");
        String imagePath         = null;

        try {

            // Handle file upload
            Part filePart = request.getPart("restaurantImage");
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

                    } else {
                        request.setAttribute("errorMessage",
                                "Only JPG, PNG, WEBP images allowed!");
                    }
                }
            }

            // Use existing image if none uploaded
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = existingImagePath;
            }

            // Fallback default image
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = "images/restaurants/default.jpg";
            }

            RestaurantDAO restaurantDAO = new RestaurantDAO();

            if ("add".equals(action)) {

                // ── Add new restaurant ────────────────
                Restaurant restaurant = new Restaurant();

                restaurant.setName(name);
                restaurant.setCuisineType(cuisineType);
                restaurant.setAddress(address);
                restaurant.setRating(Double.parseDouble(rating));
                restaurant.setDeliveryTime(deliveryTime);
                restaurant.setImagePath(imagePath);
                restaurant.setActive("true".equals(isActive));

                restaurantDAO.addRestaurant(restaurant);

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/restaurants?success=added");

            } else if ("update".equals(action)) {

                // ── Update existing restaurant ────────
                Restaurant restaurant = new Restaurant();

                restaurant.setRestaurantId(Integer.parseInt(restaurantId));
                restaurant.setName(name);
                restaurant.setCuisineType(cuisineType);
                restaurant.setAddress(address);
                restaurant.setRating(Double.parseDouble(rating));
                restaurant.setDeliveryTime(deliveryTime);
                restaurant.setImagePath(imagePath);
                restaurant.setActive("true".equals(isActive));

                restaurantDAO.updateRestaurant(restaurant);

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/restaurants?success=updated");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/restaurants?error=upload_failed");
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
