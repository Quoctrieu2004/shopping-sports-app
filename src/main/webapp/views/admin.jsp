<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - Shopping Sports</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: #333;
                min-height: 100vh;
            }
            
            .header {
                background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
                color: white;
                padding: 1rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }
            
            .header h1 {
                font-size: 1.8rem;
                font-weight: 600;
            }
            
            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }
            
            .logout-btn {
                background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
                color: white;
                border: none;
                padding: 0.7rem 1.5rem;
                border-radius: 25px;
                cursor: pointer;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            }
            
            .logout-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            }
            
            .container {
                display: flex;
                min-height: calc(100vh - 80px);
                padding: 2rem;
                gap: 2rem;
            }
            
            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: 0 8px 32px rgba(0,0,0,0.1);
                height: fit-content;
            }
            
            .sidebar h3 {
                margin-bottom: 2rem;
                text-align: center;
                color: #2c3e50;
                font-size: 1.5rem;
                border-bottom: 3px solid #3498db;
                padding-bottom: 1rem;
            }
            
            .sidebar a {
                display: flex;
                align-items: center;
                gap: 1rem;
                color: #2c3e50;
                text-decoration: none;
                padding: 1rem 1.5rem;
                margin: 0.5rem 0;
                border-radius: 15px;
                transition: all 0.3s ease;
                font-weight: 500;
                border: 2px solid transparent;
            }
            
            .sidebar a:hover {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
                color: white;
                transform: translateX(10px);
                box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
            }
            
            .sidebar a.active {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
                color: white;
                border-color: #2980b9;
                box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
            }
            
            .main-content {
                flex: 1;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            }
            
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }
            
            .stat-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 2rem;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 8px 32px rgba(102, 126, 234, 0.3);
                transition: transform 0.3s ease;
            }
            
            .stat-card:hover {
                transform: translateY(-5px);
            }
            
            .stat-card h3 {
                font-size: 2.5rem;
                margin-bottom: 0.5rem;
                font-weight: 700;
            }
            
            .stat-card p {
                font-size: 1.1rem;
                opacity: 0.9;
                font-weight: 500;
            }
            
            .content-section {
                background: white;
                padding: 2rem;
                border-radius: 20px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                border: 1px solid #e9ecef;
            }
            
            .content-section h2 {
                margin-bottom: 1.5rem;
                color: #2c3e50;
                border-bottom: 3px solid #3498db;
                padding-bottom: 1rem;
                font-size: 1.8rem;
                font-weight: 600;
            }
            
            .btn {
                padding: 0.8rem 1.5rem;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                margin: 0.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            
            .btn-primary {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
                color: white;
            }
            
            .btn-success {
                background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
                color: white;
            }
            
            .btn-danger {
                background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
                color: white;
            }
            
            .btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                color: white;
            }
            
            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            }
            
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1.5rem;
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            }
            
            th, td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #e9ecef;
            }
            
            th {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                font-weight: 600;
                color: #2c3e50;
                font-size: 1rem;
            }
            
            tr:hover {
                background: #f8f9fa;
            }
            
            .badge {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
            }
            
            .badge-admin {
                background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
                color: white;
            }
            
            .badge-user {
                background: linear-gradient(135deg, #95a5a6 0%, #7f8c8d 100%);
                color: white;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 600;
                color: #2c3e50;
            }
            
            .form-control {
                width: 100%;
                padding: 0.8rem 1rem;
                border: 2px solid #e9ecef;
                border-radius: 10px;
                font-size: 1rem;
                transition: border-color 0.3s ease;
            }
            
            .form-control:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            }
            
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }
            
            .hidden {
                display: none;
            }
            
            .alert {
                padding: 1rem 1.5rem;
                border-radius: 10px;
                margin-bottom: 1rem;
                border-left: 4px solid;
            }
            
            .alert-success {
                background: #d4edda;
                color: #155724;
                border-left-color: #28a745;
            }
            
            .alert-danger {
                background: #f8d7da;
                color: #721c24;
                border-left-color: #dc3545;
            }
            
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                backdrop-filter: blur(5px);
            }
            
            .modal-content {
                background-color: white;
                margin: 5% auto;
                padding: 2rem;
                border-radius: 20px;
                width: 80%;
                max-width: 600px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.3);
                position: relative;
            }
            
            .close {
                position: absolute;
                right: 1.5rem;
                top: 1.5rem;
                font-size: 2rem;
                cursor: pointer;
                color: #aaa;
            }
            
            .close:hover {
                color: #000;
            }
            
            .search-box {
                display: flex;
                gap: 1rem;
                margin-bottom: 1.5rem;
                align-items: center;
            }
            
            .search-input {
                flex: 1;
                padding: 0.8rem 1rem;
                border: 2px solid #e9ecef;
                border-radius: 25px;
                font-size: 1rem;
            }
            
            .search-input:focus {
                outline: none;
                border-color: #3498db;
            }
            
            /* Search and Sort Styles */
            .search-section {
                background: #f8f9fa;
                padding: 1rem;
                border-radius: 8px;
                margin-bottom: 1rem;
            }
            
            .sortable {
                cursor: pointer;
                user-select: none;
                position: relative;
            }
            
            .sortable:hover {
                background-color: #e9ecef;
            }
            
            .sortable i {
                margin-left: 5px;
                transition: transform 0.2s;
            }
            
            .sortable.asc i {
                transform: rotate(180deg);
            }
            
            .sortable.desc i {
                transform: rotate(0deg);
            }
            
            .table-responsive {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            
            .table th {
                background: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
                font-weight: 600;
            }
            
            .table tbody tr:hover {
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-shield-alt"></i> Admin Dashboard - Shopping Sports</h1>
            <div class="user-info">
                <span><i class="fas fa-user-circle"></i> Welcome, ${sessionScope.user.name}!</span>
                <a href="logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
                                </div>
                            </div>

        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <h3><i class="fas fa-cogs"></i> Admin Panel</h3>
                <a href="admin?section=dashboard" class="nav-link ${param.section == 'dashboard' || empty param.section ? 'active' : ''}">
                    <i class="fas fa-chart-line"></i> Dashboard
                </a>
                <a href="admin?section=users" class="nav-link ${param.section == 'users' ? 'active' : ''}">
                    <i class="fas fa-users"></i> Users Management
                </a>
                <a href="admin?section=products" class="nav-link ${param.section == 'products' ? 'active' : ''}">
                    <i class="fas fa-box"></i> Products Management
                </a>
                <a href="admin?section=add-product" class="nav-link ${param.section == 'add-product' ? 'active' : ''}">
                    <i class="fas fa-plus-circle"></i> Add Product
                </a>
                <a href="admin?section=categories" class="nav-link ${param.section == 'categories' ? 'active' : ''}">
                    <i class="fas fa-tags"></i> Categories
                </a>
                <a href="home" class="nav-link">
                    <i class="fas fa-home"></i> Back to Home
                </a>
                        </div>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Alert Messages -->
                <c:if test="${not empty sessionScope.adminMessage}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${sessionScope.adminMessage}
                    </div>
                    <% request.getSession().removeAttribute("adminMessage"); %>
                </c:if>
                
                <c:if test="${not empty sessionScope.adminError}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i> ${sessionScope.adminError}
                    </div>
                    <% request.getSession().removeAttribute("adminError"); %>
                </c:if>
                
                <!-- Dashboard Section -->
                <c:if test="${param.section == 'dashboard' || empty param.section}">
                    <div class="content-section">
                        <h2><i class="fas fa-chart-line"></i> Dashboard Overview</h2>
                    
                    <!-- Stats Cards -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <h3>${totalUsers}</h3>
                                <p><i class="fas fa-users"></i> Total Users</p>
                                </div>
                        <div class="stat-card">
                            <h3>${totalProducts}</h3>
                                <p><i class="fas fa-box"></i> Total Products</p>
                            </div>
                        <div class="stat-card">
                            <h3>${totalCategories}</h3>
                                <p><i class="fas fa-tags"></i> Categories</p>
                        </div>
                            </div>

                    <!-- Quick Actions -->
                    <div class="content-section">
                            <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
                            <a href="admin?section=users" class="btn btn-primary">
                                <i class="fas fa-users"></i> Manage Users
                            </a>
                            <a href="admin?section=products" class="btn btn-primary">
                                <i class="fas fa-box"></i> Manage Products
                            </a>
                            <a href="admin?section=add-product" class="btn btn-success">
                                <i class="fas fa-plus"></i> Add New Product
                            </a>
                        </div>
                    </div>
                </c:if>
                    
                <!-- Users Management Section -->
                <c:if test="${param.section == 'users'}">
                    <div class="content-section">
                        <h2><i class="fas fa-users"></i> Users Management</h2>
                    
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                                <c:choose>
                                    <c:when test="${not empty allUsers}">
                            <c:forEach var="user" items="${allUsers}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.name}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role eq 'admin'}">
                                                <span class="badge badge-admin">Admin</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-user">User</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                                    <button class="btn btn-warning" onclick="showEditUserForm(${user.id}, '${user.name}', '${user.email}', '${user.phone}', '${user.role}')">
                                                        <i class="fas fa-edit"></i> Edit
                                                    </button>
                                                    <form action="admin" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete user: ${user.name}?')">
                                                        <input type="hidden" name="action" value="deleteUser">
                                                        <input type="hidden" name="userId" value="${user.id}">
                                                        <button type="submit" class="btn btn-danger">
                                                            <i class="fas fa-trash"></i> Delete
                                                        </button>
                                                    </form>
                                    </td>
                                </tr>
                            </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" style="text-align: center; padding: 2rem; color: #6c757d;">
                                                <i class="fas fa-users"></i> No users found
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                        </tbody>
                    </table>
                    </div>
                </c:if>

                <!-- Products Management Section -->
                <c:if test="${param.section == 'products'}">
                    <div class="content-section">
                        <h2><i class="fas fa-box"></i> Products Management</h2>
                        
                        <!-- Search Bar -->
                        <div class="search-section mb-3">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <input type="text" id="productSearch" class="form-control" 
                                               placeholder="Search products by name, category, or price..." 
                                               onkeyup="filterProducts()">
                                        <button class="btn btn-outline-secondary" type="button" onclick="clearSearch()">
                                            <i class="fas fa-times"></i> Clear
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6 text-end">
                                    <span class="text-muted">Found: <span id="productCount">0</span> products</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table table-striped" id="productsTable">
                                <thead>
                                    <tr>
                                        <th class="sortable" onclick="sortTable(0, 'id')">
                                            ID <i class="fas fa-sort" id="sort-icon-id"></i>
                                        </th>
                                        <th>Image</th>
                                        <th class="sortable" onclick="sortTable(2, 'name')">
                                            Name <i class="fas fa-sort" id="sort-icon-name"></i>
                                        </th>
                                        <th class="sortable" onclick="sortTable(3, 'category')">
                                            Category <i class="fas fa-sort" id="sort-icon-category"></i>
                                        </th>
                                        <th class="sortable" onclick="sortTable(4, 'price')">
                                            Price <i class="fas fa-sort" id="sort-icon-price"></i>
                                        </th>
                                        <th class="sortable" onclick="sortTable(5, 'stock')">
                                            Stock <i class="fas fa-sort" id="sort-icon-stock"></i>
                                        </th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty allProducts}">
                                        <c:forEach var="product" items="${allProducts}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty product.image}">
                                                            <img src="assets/images/${product.image}" alt="${product.name}" 
                                                                 style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div style="width: 50px; height: 50px; background: #f8f9fa; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: #6c757d;">
                                                                <i class="fas fa-image"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${product.name}</td>
                                                <td>${product.categoryName}</td>
                                                <td>$${product.price}</td>
                                                <td>${product.quantity}</td>
                                                <td>
                                                    <button class="btn btn-warning" onclick="showEditProductForm(${product.id}, '${product.name}', ${product.id_category}, ${product.price}, ${product.quantity}, '${product.image}', ${product.status})">
                                                        <i class="fas fa-edit"></i> Edit
                                                    </button>
                                                    <form action="admin" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete product: ${product.name}?')">
                                                        <input type="hidden" name="action" value="deleteProduct">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <button type="submit" class="btn btn-danger">
                                                            <i class="fas fa-trash"></i> Delete
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" style="text-align: center; padding: 2rem; color: #6c757d;">
                                                <i class="fas fa-box-open"></i> No products found
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <!-- Add Product Section -->
                <c:if test="${param.section == 'add-product'}">
                    <div class="content-section">
                        <h2><i class="fas fa-plus-circle"></i> Add New Product</h2>
                        
                        <form action="admin" method="post">
                            <input type="hidden" name="action" value="addProduct">
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productName">Product Name *</label>
                                    <input type="text" id="productName" name="productName" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="productCategory">Category *</label>
                                    <select id="productCategory" name="productCategory" class="form-control" required>
                                        <option value="">Select Category</option>
                                        <c:forEach var="category" items="${allCategories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="productPrice">Price *</label>
                                    <input type="number" id="productPrice" name="productPrice" class="form-control" 
                                           step="0.01" min="0" required>
                                </div>
                                <div class="form-group">
                                    <label for="productQuantity">Quantity *</label>
                                    <input type="number" id="productQuantity" name="productQuantity" class="form-control" 
                                           min="0" required>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="productDescription">Description</label>
                                <textarea id="productDescription" name="productDescription" class="form-control" 
                                          rows="4" placeholder="Enter product description..."></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="productImage">Product Image</label>
                                <input type="text" id="productImage" name="productImage" class="form-control" 
                                       placeholder="Enter image filename (e.g., product1.png)">
                </div>
                            
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Add Product
                            </button>
                            <button type="reset" class="btn btn-warning">
                                <i class="fas fa-undo"></i> Reset
                            </button>
                        </form>
                    </div>
                </c:if>

                <!-- Categories Management Section -->
                <c:if test="${param.section == 'categories'}">
                    <div class="content-section">
                        <h2><i class="fas fa-tags"></i> Categories Management</h2>
                        <button class="btn btn-success" onclick="showAddCategoryModal()">
                            <i class="fas fa-plus"></i> Add New Category
                        </button>
                        
                        <div class="table-responsive">
                            <table class="table table-striped" id="categoriesTable">
                                <thead>
                                    <tr>
                                        <th class="sortable" onclick="sortCategoriesTable(0, 'id')">
                                            ID <i class="fas fa-sort" id="sort-icon-cat-id"></i>
                                        </th>
                                        <th class="sortable" onclick="sortCategoriesTable(1, 'name')">
                                            Name <i class="fas fa-sort" id="sort-icon-cat-name"></i>
                                        </th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty allCategories}">
                                            <c:forEach var="category" items="${allCategories}">
                                                <tr>
                                                    <td>${category.id}</td>
                                                    <td>${category.name}</td>
                                                    <td>
                                                        <button class="btn btn-warning" onclick="showEditCategoryForm(${category.id}, '${category.name}')">
                                                            <i class="fas fa-edit"></i> Edit
                                                        </button>
                                                        <form action="admin" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete category: ${category.name}?')">
                                                            <input type="hidden" name="action" value="deleteCategory">
                                                            <input type="hidden" name="categoryId" value="${category.id}">
                                                            <button type="submit" class="btn btn-danger">
                                                                <i class="fas fa-trash"></i> Delete
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3" style="text-align: center; padding: 2rem; color: #6c757d;">
                                                    <i class="fas fa-tags"></i> No categories found
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Edit Product Modal -->
        <div id="editProductModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeEditModal()">&times;</span>
                <h2><i class="fas fa-edit"></i> Edit Product</h2>
                
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="updateProduct">
                    <input type="hidden" id="editProductId" name="productId">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="editProductName">Product Name *</label>
                            <input type="text" id="editProductName" name="productName" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="editProductCategory">Category *</label>
                            <select id="editProductCategory" name="productCategory" class="form-control" required>
                                <option value="">Select Category</option>
                                <c:forEach var="category" items="${allCategories}">
                                    <option value="${category.id}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="editProductPrice">Price *</label>
                            <input type="number" id="editProductPrice" name="productPrice" class="form-control" 
                                   step="0.01" min="0" required>
                        </div>
                        <div class="form-group">
                            <label for="editProductQuantity">Quantity *</label>
                            <input type="number" id="editProductQuantity" name="productQuantity" class="form-control" 
                                   min="0" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="editProductImage">Product Image</label>
                        <input type="text" id="editProductImage" name="productImage" class="form-control" 
                               placeholder="Enter image filename (e.g., product1.png)">
                    </div>
                    
                    <div class="form-group">
                        <label for="editProductStatus">Status</label>
                        <select id="editProductStatus" name="productStatus" class="form-control">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Update Product
                    </button>
                    <button type="button" class="btn btn-warning" onclick="closeEditModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </form>
            </div>
        </div>

        <!-- Add Category Modal -->
        <div id="addCategoryModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeAddCategoryModal()">&times;</span>
                <h2><i class="fas fa-plus"></i> Add New Category</h2>
                
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="addCategory">
                    
                    <div class="form-group">
                        <label for="categoryName">Category Name *</label>
                        <input type="text" id="categoryName" name="categoryName" class="form-control" 
                               placeholder="Enter category name..." required>
                    </div>
                    
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Add Category
                    </button>
                    <button type="button" class="btn btn-warning" onclick="closeAddCategoryModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </form>
            </div>
        </div>

        <!-- Edit Category Modal -->
        <div id="editCategoryModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeEditCategoryModal()">&times;</span>
                <h2><i class="fas fa-edit"></i> Edit Category</h2>
                
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="updateCategory">
                    <input type="hidden" id="editCategoryId" name="categoryId">
                    
                    <div class="form-group">
                        <label for="editCategoryName">Category Name *</label>
                        <input type="text" id="editCategoryName" name="categoryName" class="form-control" 
                               placeholder="Enter category name..." required>
            </div>

                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Update Category
                    </button>
                    <button type="button" class="btn btn-warning" onclick="closeEditCategoryModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </form>
            </div>
        </div>

        <!-- Edit User Modal -->
        <div id="editUserModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeEditUserModal()">&times;</span>
                <h2><i class="fas fa-edit"></i> Edit User</h2>
                
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="updateUser">
                    <input type="hidden" id="editUserId" name="userId">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="editUserName">Name *</label>
                            <input type="text" id="editUserName" name="userName" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="editUserEmail">Email *</label>
                            <input type="email" id="editUserEmail" name="userEmail" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="editUserPhone">Phone *</label>
                            <input type="text" id="editUserPhone" name="userPhone" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="editUserRole">Role *</label>
                            <select id="editUserRole" name="userRole" class="form-control" required>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Update User
                    </button>
                    <button type="button" class="btn btn-warning" onclick="closeEditUserModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </form>
    </div>
</div>

        <script>
            function showEditProductForm(id, name, categoryId, price, quantity, image, status) {
                document.getElementById('editProductId').value = id;
                document.getElementById('editProductName').value = name;
                document.getElementById('editProductCategory').value = categoryId;
                document.getElementById('editProductPrice').value = price;
                document.getElementById('editProductQuantity').value = quantity;
                document.getElementById('editProductImage').value = image;
                document.getElementById('editProductStatus').value = status ? '1' : '0';
                
                document.getElementById('editProductModal').style.display = 'block';
            }
            
            function closeEditModal() {
                document.getElementById('editProductModal').style.display = 'none';
            }
            
            function showEditUserForm(id, name, email, phone, role) {
                document.getElementById('editUserId').value = id;
                document.getElementById('editUserName').value = name;
                document.getElementById('editUserEmail').value = email;
                document.getElementById('editUserPhone').value = phone;
                document.getElementById('editUserRole').value = role;
                
                document.getElementById('editUserModal').style.display = 'block';
            }
            
            function closeEditUserModal() {
                document.getElementById('editUserModal').style.display = 'none';
            }
            
            // Close modal when clicking outside
            window.onclick = function(event) {
                const productModal = document.getElementById('editProductModal');
                const userModal = document.getElementById('editUserModal');
                if (event.target === productModal) {
                    productModal.style.display = 'none';
                }
                if (event.target === userModal) {
                    userModal.style.display = 'none';
                }
            }
            
            // Search and Sort Functions
            let currentSortColumn = -1;
            let currentSortDirection = 'asc';
            
            function filterProducts() {
                const searchTerm = document.getElementById('productSearch').value.toLowerCase();
                const table = document.getElementById('productsTable');
                const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
                let visibleCount = 0;
                
                for (let i = 0; i < rows.length; i++) {
                    const row = rows[i];
                    const cells = row.getElementsByTagName('td');
                    let shouldShow = false;
                    
                    // Check if any cell contains the search term
                    for (let j = 0; j < cells.length; j++) {
                        const cellText = cells[j].textContent.toLowerCase();
                        if (cellText.includes(searchTerm)) {
                            shouldShow = true;
                            break;
                        }
                    }
                    
                    if (shouldShow) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                }
                
                document.getElementById('productCount').textContent = visibleCount;
            }
            
            function clearSearch() {
                document.getElementById('productSearch').value = '';
                filterProducts();
            }
            
            function sortTable(columnIndex, columnType) {
                const table = document.getElementById('productsTable');
                const tbody = table.getElementsByTagName('tbody')[0];
                const rows = Array.from(tbody.getElementsByTagName('tr'));
                
                // Remove previous sort indicators
                const headers = table.getElementsByTagName('th');
                for (let i = 0; i < headers.length; i++) {
                    headers[i].classList.remove('asc', 'desc');
                }
                
                // Determine sort direction
                if (currentSortColumn === columnIndex) {
                    currentSortDirection = currentSortDirection === 'asc' ? 'desc' : 'asc';
                } else {
                    currentSortColumn = columnIndex;
                    currentSortDirection = 'asc';
                }
                
                // Add sort indicator
                headers[columnIndex].classList.add(currentSortDirection);
                
                // Sort rows
                rows.sort((a, b) => {
                    const aValue = getCellValue(a, columnIndex, columnType);
                    const bValue = getCellValue(b, columnIndex, columnType);
                    
                    if (currentSortDirection === 'asc') {
                        return aValue > bValue ? 1 : -1;
                    } else {
                        return aValue < bValue ? 1 : -1;
                    }
                });
                
                // Reorder rows in the table
                rows.forEach(row => tbody.appendChild(row));
            }
            
            function getCellValue(row, columnIndex, columnType) {
                const cell = row.getElementsByTagName('td')[columnIndex];
                let value = cell.textContent.trim();
                
                switch (columnType) {
                    case 'id':
                    case 'stock':
                        return parseInt(value) || 0;
                    case 'price':
                        return parseFloat(value.replace('$', '')) || 0;
                    case 'name':
                    case 'category':
                    default:
                        return value.toLowerCase();
                }
            }
            
            // Initialize product count on page load
            document.addEventListener('DOMContentLoaded', function() {
                if (document.getElementById('productCount')) {
                    const table = document.getElementById('productsTable');
                    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
                    let visibleCount = 0;
                    
                    for (let i = 0; i < rows.length; i++) {
                        if (rows[i].style.display !== 'none') {
                            visibleCount++;
                        }
                    }
                    
                    document.getElementById('productCount').textContent = visibleCount;
                }
            });
            
            // Categories Table Sorting
            function sortCategoriesTable(columnIndex, columnType) {
                const table = document.getElementById('categoriesTable');
                const tbody = table.getElementsByTagName('tbody')[0];
                const rows = Array.from(tbody.getElementsByTagName('tr'));
                
                // Remove previous sort indicators
                const headers = table.getElementsByTagName('th');
                for (let i = 0; i < headers.length; i++) {
                    headers[i].classList.remove('asc', 'desc');
                }
                
                // Determine sort direction
                if (currentSortColumn === columnIndex) {
                    currentSortDirection = currentSortDirection === 'asc' ? 'desc' : 'asc';
                } else {
                    currentSortColumn = columnIndex;
                    currentSortDirection = 'asc';
                }
                
                // Add sort indicator
                headers[columnIndex].classList.add(currentSortDirection);
                
                // Sort rows
                rows.sort((a, b) => {
                    const aValue = getCategoryCellValue(a, columnIndex, columnType);
                    const bValue = getCategoryCellValue(b, columnIndex, columnType);
                    
                    if (currentSortDirection === 'asc') {
                        return aValue > bValue ? 1 : -1;
                    } else {
                        return aValue < bValue ? 1 : -1;
                    }
                });
                
                // Reorder rows in the table
                rows.forEach(row => tbody.appendChild(row));
            }
            
            function getCategoryCellValue(row, columnIndex, columnType) {
                const cell = row.getElementsByTagName('td')[columnIndex];
                let value = cell.textContent.trim();
                
                switch (columnType) {
                    case 'id':
                        return parseInt(value) || 0;
                    case 'name':
                    default:
                        return value.toLowerCase();
                }
            }
            
            // Category Modal Functions
            function showAddCategoryModal() {
                document.getElementById('addCategoryModal').style.display = 'block';
            }
            
            function closeAddCategoryModal() {
                document.getElementById('addCategoryModal').style.display = 'none';
            }
            
            function showEditCategoryForm(id, name) {
                document.getElementById('editCategoryId').value = id;
                document.getElementById('editCategoryName').value = name;
                document.getElementById('editCategoryModal').style.display = 'block';
            }
            
            function closeEditCategoryModal() {
                document.getElementById('editCategoryModal').style.display = 'none';
            }
            
            // Update window.onclick to handle category modals
            window.onclick = function(event) {
                const productModal = document.getElementById('editProductModal');
                const userModal = document.getElementById('editUserModal');
                const addCategoryModal = document.getElementById('addCategoryModal');
                const editCategoryModal = document.getElementById('editCategoryModal');
                
                if (event.target === productModal) {
                    productModal.style.display = 'none';
                }
                if (event.target === userModal) {
                    userModal.style.display = 'none';
                }
                if (event.target === addCategoryModal) {
                    addCategoryModal.style.display = 'none';
                }
                if (event.target === editCategoryModal) {
                    editCategoryModal.style.display = 'none';
                }
            }
        </script>
    </body>
</html>
