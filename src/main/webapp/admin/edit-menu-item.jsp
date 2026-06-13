<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.foodapp.model.MenuItem, com.foodapp.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Menu Item | Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<%
request.setAttribute("currentPage", "menu");
MenuItem item = (MenuItem) request.getAttribute("menuItem");
ArrayList<Restaurant> restaurantList =
    (ArrayList<Restaurant>) request.getAttribute("restaurantList");
%>

<div class="admin-layout">
    <jsp:include page="components/sidebar.jsp" />

    <main class="admin-main">

        <div class="admin-header">
            <div>
                <h1 class="admin-title">Edit Menu Item</h1>
                <p class="admin-subtitle">Update food item details</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/menu-items"
               class="btn-secondary">← Back to List</a>
        </div>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/admin/menu-items"
                  method="post"
                  enctype="multipart/form-data">

                <input type="hidden" name="action" value="update">
                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                <input type="hidden" name="existingImagePath" value="<%= item.getImagePath() %>">

                <div class="form-grid">

                    <div class="form-group form-full">
                        <label class="form-label">Restaurant *</label>
                        <select name="restaurantId" class="form-input" required>
                            <% for (Restaurant r : restaurantList) { %>
                                <option value="<%= r.getRestaurantId() %>"
                                    <%= r.getRestaurantId() == item.getRestaurantId() ? "selected" : "" %>>
                                    <%= r.getName() %>
                                </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Item Name *</label>
                        <input type="text" name="itemName"
                               class="form-input"
                               value="<%= item.getItemName() %>" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Price (₹) *</label>
                        <input type="number" name="price"
                               class="form-input"
                               min="1" step="0.01"
                               value="<%= item.getPrice() %>" required>
                    </div>

                    <div class="form-group form-full">
                        <label class="form-label">Description *</label>
                        <textarea name="description"
                                  class="form-input"
                                  rows="3"
                                  required><%= item.getDescription() %></textarea>
                    </div>

                    <!-- IMAGE -->
                    <div class="form-group form-full">
                        <label class="form-label">Food Image</label>
                        <p class="form-hint">Current image shown below. Upload new to replace.</p>
                        <div class="current-image-wrap">
                            <img id="imagePreview"
                                 src="${pageContext.request.contextPath}/<%= item.getImagePath() %>"
                                 alt="Current"
                                 class="current-image"
                                 onerror="this.src='${pageContext.request.contextPath}/images/menu/default.jpg'">
                        </div>
                        <div class="upload-area" style="margin-top:12px;"
                             onclick="document.getElementById('imageFile').click()">
                            <div class="upload-placeholder">
                                <span class="upload-icon">📁</span>
                                <p>Click to upload new image</p>
                                <span class="upload-hint">JPG, PNG, WEBP — Max 2MB</span>
                            </div>
                        </div>
                        <input type="file" name="imageFile" id="imageFile"
                               accept=".jpg,.jpeg,.png,.webp"
                               style="display:none;"
                               onchange="previewImage(this)">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Availability</label>
                        <select name="isAvailable" class="form-input">
                            <option value="true" <%= item.isAvailable() ? "selected" : "" %>>Available</option>
                            <option value="false" <%= !item.isAvailable() ? "selected" : "" %>>Unavailable</option>
                        </select>
                    </div>

                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        💾 Save Changes
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
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>
