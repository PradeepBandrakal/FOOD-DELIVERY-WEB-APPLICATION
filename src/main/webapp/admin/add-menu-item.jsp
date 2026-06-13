<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.foodapp.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Menu Item | Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<% request.setAttribute("currentPage", "menu"); %>

<div class="admin-layout">
    <jsp:include page="components/sidebar.jsp" />

    <main class="admin-main">

        <div class="admin-header">
            <div>
                <h1 class="admin-title">Add Menu Item</h1>
                <p class="admin-subtitle">Add a new food item to a restaurant</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/menu-items"
               class="btn-secondary">← Back to List</a>
        </div>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/admin/menu-items"
                  method="post"
                  enctype="multipart/form-data">

                <input type="hidden" name="action" value="add">

                <div class="form-grid">

                    <!-- RESTAURANT -->
                    <div class="form-group form-full">
                        <label class="form-label">Restaurant *</label>
                        <select name="restaurantId" class="form-input" required>
                            <option value="">-- Select Restaurant --</option>
                            <%
                            ArrayList<Restaurant> restaurantList =
                                (ArrayList<Restaurant>) request.getAttribute("restaurantList");
                            for (Restaurant r : restaurantList) {
                            %>
                                <option value="<%= r.getRestaurantId() %>">
                                    <%= r.getName() %>
                                </option>
                            <% } %>
                        </select>
                    </div>

                    <!-- ITEM NAME -->
                    <div class="form-group">
                        <label class="form-label">Item Name *</label>
                        <input type="text" name="itemName"
                               class="form-input"
                               placeholder="e.g. Margherita Pizza"
                               required>
                    </div>

                    <!-- PRICE -->
                    <div class="form-group">
                        <label class="form-label">Price (₹) *</label>
                        <input type="number" name="price"
                               class="form-input"
                               min="1" step="0.01"
                               placeholder="e.g. 249"
                               required>
                    </div>

                    <!-- DESCRIPTION -->
                    <div class="form-group form-full">
                        <label class="form-label">Description *</label>
                        <textarea name="description"
                                  class="form-input"
                                  rows="3"
                                  placeholder="Short description of the dish..."
                                  required></textarea>
                    </div>

                    <!-- IMAGE -->
                    <div class="form-group form-full">
                        <label class="form-label">Food Image</label>
                        <div class="upload-area"
                             onclick="document.getElementById('imageFile').click()">
                            <div class="upload-placeholder" id="uploadPlaceholder">
                                <span class="upload-icon">🍕</span>
                                <p>Click to upload food image</p>
                                <span class="upload-hint">JPG, PNG, WEBP — Max 2MB</span>
                            </div>
                            <img id="imagePreview" class="image-preview" style="display:none;" alt="Preview">
                        </div>
                        <input type="file" name="imageFile" id="imageFile"
                               accept=".jpg,.jpeg,.png,.webp"
                               style="display:none;"
                               onchange="previewImage(this)">
                    </div>

                    <!-- AVAILABILITY -->
                    <div class="form-group">
                        <label class="form-label">Availability</label>
                        <select name="isAvailable" class="form-input">
                            <option value="true">Available</option>
                            <option value="false">Unavailable</option>
                        </select>
                    </div>

                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        ➕ Add Menu Item
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/menu-items"
                       class="btn-secondary">Cancel</a>
                </div>

            </form>
        </div>

    </main>
</div>

<script>
function previewImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('imagePreview').src = e.target.result;
            document.getElementById('imagePreview').style.display = 'block';
            document.getElementById('uploadPlaceholder').style.display = 'none';
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>
