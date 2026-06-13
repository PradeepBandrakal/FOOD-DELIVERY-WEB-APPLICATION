<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodapp.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Restaurant | Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<% request.setAttribute("currentPage", "restaurants");
   Restaurant r = (Restaurant) request.getAttribute("restaurant"); %>

<div class="admin-layout">
    <jsp:include page="components/sidebar.jsp" />

    <main class="admin-main">

        <div class="admin-header">
            <div>
                <h1 class="admin-title">Edit Restaurant</h1>
                <p class="admin-subtitle">Update restaurant details</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/restaurants"
               class="btn-secondary">← Back to List</a>
        </div>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/admin/restaurants"
                  method="post"
                  enctype="multipart/form-data">

                <input type="hidden" name="action" value="update">
                <input type="hidden" name="restaurantId" value="<%= r.getRestaurantId() %>">
                <input type="hidden" name="existingImagePath" value="<%= r.getImagePath() %>">

                <div class="form-grid">

                    <div class="form-group">
                        <label class="form-label">Restaurant Name *</label>
                        <input type="text" name="name"
                               class="form-input"
                               value="<%= r.getName() %>" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Cuisine Type *</label>
                        <input type="text" name="cuisineType"
                               class="form-input"
                               value="<%= r.getCuisineType() %>" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Rating *</label>
                        <input type="number" name="rating"
                               class="form-input"
                               min="1.0" max="5.0" step="0.1"
                               value="<%= r.getRating() %>" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Delivery Time *</label>
                        <input type="text" name="deliveryTime"
                               class="form-input"
                               value="<%= r.getDeliveryTime() %>" required>
                    </div>

                    <div class="form-group form-full">
                        <label class="form-label">Address *</label>
                        <input type="text" name="address"
                               class="form-input"
                               value="<%= r.getAddress() %>" required>
                    </div>

                    <!-- IMAGE UPLOAD -->
                    <div class="form-group form-full">
                        <label class="form-label">Restaurant Image</label>
                        <p class="form-hint">Current image shown below. Upload a new one to replace it.</p>
                        <div class="current-image-wrap">
                            <img src="${pageContext.request.contextPath}/<%= r.getImagePath() %>"
                                 alt="Current Image"
                                 class="current-image"
                                 id="imagePreview"
                                 onerror="this.src='${pageContext.request.contextPath}/images/restaurants/default.jpg'">
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
                        <label class="form-label">Status</label>
                        <select name="isActive" class="form-input">
                            <option value="true" <%= r.isActive() ? "selected" : "" %>>Active</option>
                            <option value="false" <%= !r.isActive() ? "selected" : "" %>>Inactive</option>
                        </select>
                    </div>

                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        💾 Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/restaurants"
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
