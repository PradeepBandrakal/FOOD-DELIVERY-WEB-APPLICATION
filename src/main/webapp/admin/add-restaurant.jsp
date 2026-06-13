<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Restaurant | Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body class="admin-body">

<% request.setAttribute("currentPage", "restaurants"); %>

<div class="admin-layout">
    <jsp:include page="components/sidebar.jsp" />

    <main class="admin-main">

        <div class="admin-header">
            <div>
                <h1 class="admin-title">Add Restaurant</h1>
                <p class="admin-subtitle">Add a new restaurant to the platform</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/restaurants"
               class="btn-secondary">← Back to List</a>
        </div>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/admin/restaurants"
                  method="post"
                  enctype="multipart/form-data"
                  id="addRestaurantForm">

                <input type="hidden" name="action" value="add">

                <div class="form-grid">

                    <!-- NAME -->
                    <div class="form-group">
                        <label class="form-label">Restaurant Name *</label>
                        <input type="text" name="name"
                               class="form-input"
                               placeholder="e.g. Pizza Palace"
                               required>
                    </div>

                    <!-- CUISINE TYPE -->
                    <div class="form-group">
                        <label class="form-label">Cuisine Type *</label>
                        <input type="text" name="cuisineType"
                               class="form-input"
                               placeholder="e.g. Italian, Indian, Chinese"
                               required>
                    </div>

                    <!-- RATING -->
                    <div class="form-group">
                        <label class="form-label">Rating (1.0 - 5.0) *</label>
                        <input type="number" name="rating"
                               class="form-input"
                               min="1.0" max="5.0" step="0.1"
                               placeholder="e.g. 4.5"
                               required>
                    </div>

                    <!-- DELIVERY TIME -->
                    <div class="form-group">
                        <label class="form-label">Delivery Time *</label>
                        <input type="text" name="deliveryTime"
                               class="form-input"
                               placeholder="e.g. 30-45 mins"
                               required>
                    </div>

                    <!-- ADDRESS -->
                    <div class="form-group form-full">
                        <label class="form-label">Address *</label>
                        <input type="text" name="address"
                               class="form-input"
                               placeholder="Full address"
                               required>
                    </div>

                    <!-- IMAGE UPLOAD -->
                    <div class="form-group form-full">
                        <label class="form-label">Restaurant Image</label>
                        <div class="upload-area" id="uploadArea"
                             onclick="document.getElementById('imageFile').click()">
                            <div class="upload-placeholder" id="uploadPlaceholder">
                                <span class="upload-icon">📁</span>
                                <p>Click to upload image</p>
                                <span class="upload-hint">JPG, PNG, WEBP — Max 2MB</span>
                            </div>
                            <img id="imagePreview" class="image-preview" style="display:none;" alt="Preview">
                        </div>
                        <input type="file" name="imageFile" id="imageFile"
                               accept=".jpg,.jpeg,.png,.webp"
                               style="display:none;"
                               onchange="previewImage(this)">
                    </div>

                    <!-- STATUS -->
                    <div class="form-group">
                        <label class="form-label">Status</label>
                        <select name="isActive" class="form-input">
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>

                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        ➕ Add Restaurant
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
            document.getElementById('imagePreview').style.display = 'block';
            document.getElementById('uploadPlaceholder').style.display = 'none';
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>
