<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --accent-color: #f093fb;
            --success-color: #4facfe;
            --warning-color: #f093fb;
            --danger-color: #ff6b6b;
            --light-bg: #f8f9fa;
            --dark-text: #2c3e50;
            --border-radius: 16px;
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .cart-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin: 2rem 0;
        }

        .cart-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .cart-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
        }

        .cart-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0.5rem 0 0 0;
        }

        .cart-actions {
            background: var(--light-bg);
            padding: 1.5rem 2rem;
            border-bottom: 1px solid #e9ecef;
        }

        .cart-actions a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            margin-right: 1rem;
        }

        .cart-actions a:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .cart-actions .empty-cart {
            color: var(--danger-color);
        }

        .cart-actions .empty-cart:hover {
            background: var(--danger-color);
            color: white;
        }

        .product-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            margin-bottom: 1.5rem;
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid #e9ecef;
        }

        .product-info h5 {
            color: var(--dark-text);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .product-price {
            color: var(--success-color);
            font-size: 1.2rem;
            font-weight: 700;
        }

        .size-selector {
            display: flex;
            gap: 0.5rem;
            margin: 0.5rem 0;
        }

        .size-option {
            padding: 0.4rem 0.9rem;
            border: 2px solid #e9ecef;
            border-radius: 20px;
            background: white;
            color: var(--dark-text);
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.95rem;
            font-weight: 600;
            min-width: 40px;
            text-align: center;
        }

        .size-option:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

        .size-option.selected {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quantity-input {
            width: 60px;
            text-align: center;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.5rem;
            font-weight: 600;
        }

        .quantity-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-update {
            background: var(--success-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-update:hover {
            background: #3a9bfe;
            transform: translateY(-2px);
        }

        .btn-remove {
            background: var(--danger-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-remove:hover {
            background: #ff5252;
            transform: translateY(-2px);
        }

        .payment-card {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .payment-header {
            padding: 2rem 2rem 1rem 2rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        .payment-header h5 {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }

        .bank-icons {
            padding: 1rem 2rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        .bank-icons p {
            font-size: 0.9rem;
            opacity: 0.8;
            margin-bottom: 1rem;
        }

        .bank-icon {
            width: 45px;
            height: 45px;
            margin-right: 1rem;
            transition: transform 0.3s ease;
        }

        .bank-icon:hover {
            transform: scale(1.1);
        }

        .payment-form {
            padding: 2rem;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            color: white;
            padding: 1rem;
            font-size: 1rem;
        }

        /* Address fields use light background + dark text to avoid white-on-white in native selects */
        .address-field {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            color: #2c3e50;
        }
        .address-field::placeholder { color: #6b7280; }
        /* Ensure options in dropdown are readable */
        .address-field option {
            color: #1f2937 !important; /* dark text */
            background-color: #ffffff !important;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
            color: white;
        }

        /* Override focus for address fields so text doesn't turn white */
        .address-field:focus {
            background: #ffffff;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
            color: #1f2937;
        }

        .form-label {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .cost-summary {
            padding: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }

        .cost-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.5rem 0;
        }

        .cost-row.total {
            border-top: 2px solid rgba(255, 255, 255, 0.3);
            padding-top: 1rem;
            margin-top: 1rem;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .checkout-btn {
            background: linear-gradient(135deg, var(--accent-color), var(--warning-color));
            color: white;
            border: none;
            padding: 1.2rem 2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .checkout-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(240, 147, 251, 0.4);
        }

        .empty-cart-message {
            text-align: center;
            padding: 4rem 2rem;
            color: #6c757d;
        }

        .empty-cart-message i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1rem;
        }

        .empty-cart-message h4 {
            color: var(--dark-text);
            margin-bottom: 1rem;
        }

        .empty-cart-message a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .empty-cart-message a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .cart-header h1 {
                font-size: 2rem;
            }
            
            .product-card {
                margin-bottom: 1rem;
            }
            
            .product-image {
                width: 60px;
                height: 60px;
            }
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="cart-container">
        <!-- Cart Header -->
        <div class="cart-header">
            <h1><i class="fas fa-shopping-cart me-3"></i>Shopping Cart</h1>
            <p>Manage your items and complete your purchase</p>
        </div>

        <!-- Cart Actions -->
        <div class="cart-actions">
            <a href="home" class="continue-shopping">
                <i class="fas fa-arrow-left me-2"></i>Continue Shopping
            </a>
            <a href="cart?action=clear" class="empty-cart">
                <i class="fas fa-trash me-2"></i>Empty Cart
            </a>
        </div>

        <div class="row g-0">
            
            <!-- Left side - Product list -->
            <div class="col-lg-8">
                <div class="p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h4 class="mb-1" style="color: var(--dark-text);">
                                <i class="fas fa-box me-2"></i>Your Items
                            </h4>
                            <c:choose>
                                <c:when test="${not empty sessionScope.cart and sessionScope.cart.size() > 0}">
                                    <p class="mb-0 text-muted">You have ${sessionScope.cart.size()} items in your cart</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="mb-0 text-muted">Your cart is empty</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty sessionScope.cart and sessionScope.cart.size() > 0}">
                            <c:forEach var="cartItem" items="${sessionScope.cart}">
                                <c:set var="productId" value="${cartItem.key}" />
                                <c:set var="quantity" value="${cartItem.value}" />
                                
                                <!-- Tìm sản phẩm trong danh sách đã chuẩn bị -->
                                <c:set var="product" value="${null}" />
                                <c:forEach var="cartProduct" items="${requestScope.cartProducts}">
                                    <c:if test="${cartProduct.id == productId}">
                                        <c:set var="product" value="${cartProduct}" />
                                    </c:if>
                                </c:forEach>
                                
                                <c:choose>
                                    <c:when test="${not empty product}">
                                        <div class="product-card">
                                            <div class="card-body p-4">
                                                <div class="row align-items-center">
                                                    <div class="col-md-2">
                                                        <c:choose>
                                                            <c:when test="${not empty product.image and product.image ne ''}">
                                                                <img src="assets/images/${product.image}" class="product-image" 
                                                                     alt="${product.name}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img1.webp"
                                                                     class="product-image" alt="${product.name}">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <div class="product-info">
                                                            <h5>${product.name}</h5>
                                                            
                                                            <!-- Dynamic Size Selector based on Product Category -->
                                                            <c:choose>
                                                                <c:when test="${product.id_category == 1}">
                                                                    <!-- Áo thể thao - S, M, L, XL -->
                                                                    <div class="size-selector">
                                                                        <span class="size-option selected" data-size="S">S</span>
                                                                        <span class="size-option" data-size="M">M</span>
                                                                        <span class="size-option" data-size="L">L</span>
                                                                        <span class="size-option" data-size="XL">XL</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${product.id_category == 2}">
                                                                    <!-- Giày thể thao - 39, 40, 41, 42, 43, 44 -->
                                                                    <div class="size-selector">
                                                                        <span class="size-option selected" data-size="39">39</span>
                                                                        <span class="size-option" data-size="40">40</span>
                                                                        <span class="size-option" data-size="41">41</span>
                                                                        <span class="size-option" data-size="42">42</span>
                                                                        <span class="size-option" data-size="43">43</span>
                                                                        <span class="size-option" data-size="44">44</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${product.id_category == 3}">
                                                                    <!-- Kính bơi/thể thao - Free size -->
                                                                    <div class="size-selector">
                                                                        <span class="size-option selected" data-size="Free">Free Size</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${product.id_category == 4}">
                                                                    <!-- Mũ/Nón - Chỉ S, M, L (bỏ Free Size) -->
                                                                    <div class="size-selector">
                                                                        <span class="size-option selected" data-size="S">S</span>
                                                                        <span class="size-option" data-size="M">M</span>
                                                                        <span class="size-option" data-size="L">L</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${product.id_category == 5}">
                                                                    <!-- Phụ kiện - Check if it's pants first -->
                                                                    <c:choose>
                                                                        <c:when test="${fn:containsIgnoreCase(product.name, 'quần') or fn:containsIgnoreCase(product.name, 'pants') or fn:containsIgnoreCase(product.name, 'sweatpants') or fn:containsIgnoreCase(product.name, 'cargo') or fn:containsIgnoreCase(product.name, 'jogger') or fn:containsIgnoreCase(product.name, 'short')}">
                                                                            <!-- Quần trong phụ kiện - S, M, L, XL -->
                                                                            <div class="size-selector">
                                                                                <span class="size-option selected" data-size="S">S</span>
                                                                                <span class="size-option" data-size="M">M</span>
                                                                                <span class="size-option" data-size="L">L</span>
                                                                                <span class="size-option" data-size="XL">XL</span>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <!-- Phụ kiện khác - Free size -->
                                                                            <div class="size-selector">
                                                                                <span class="size-option selected" data-size="Free">Free Size</span>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:when test="${product.id_category == 6}">
                                                                    <!-- Quần thể thao - S, M, L, XL -->
                                                                    <div class="size-selector">
                                                                        <span class="size-option selected" data-size="S">S</span>
                                                                        <span class="size-option" data-size="M">M</span>
                                                                        <span class="size-option" data-size="L">L</span>
                                                                        <span class="size-option" data-size="XL">XL</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${product.id_category == 8}">
                                                                    <!-- Quần sweatpants/Quần khác - S, M, L, XL -->
                                                                    <div class="size-selector">
                                                                        <span class="size-option selected" data-size="S">S</span>
                                                                        <span class="size-option" data-size="M">M</span>
                                                                        <span class="size-option" data-size="L">L</span>
                                                                        <span class="size-option" data-size="XL">XL</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${product.id_category == 7}">
                                                                    <!-- Túi/Balo  -->
                                                                    <div class="size-selector">
                                                                        <span class="size-option selected" data-size="X">X</span>
                                                                        <span class="size-option" data-size="M">M</span>
                                                                        <span class="size-option" data-size="L">L</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <!-- Default - Check if product name contains "quần", "pants", "túi", or "bag" -->
                                                                    <c:choose>
                                                                        <c:when test="${fn:containsIgnoreCase(product.name, 'quần') or fn:containsIgnoreCase(product.name, 'pants') or fn:containsIgnoreCase(product.name, 'sweatpants') or fn:containsIgnoreCase(product.name, 'cargo') or fn:containsIgnoreCase(product.name, 'jogger')}">
                                                                            <!-- Quần - S, M, L, XL -->
                                                                            <div class="size-selector">
                                                                                <span class="size-option selected" data-size="S">S</span>
                                                                                <span class="size-option" data-size="M">M</span>
                                                                                <span class="size-option" data-size="L">L</span>
                                                                                <span class="size-option" data-size="XL">XL</span>
                                                                            </div>
                                                                        </c:when>
                                                                                                                                                                                                                         <c:when test="${fn:containsIgnoreCase(product.name, 'túi') or fn:containsIgnoreCase(product.name, 'bag') or fn:containsIgnoreCase(product.name, 'balo') or fn:containsIgnoreCase(product.name, 'chéo')}">
                                                                            <!-- Túi -->
                                                                            <div class="size-selector">
                                                                                <span class="size-option selected" data-size="S">S</span>
                                                                                <span class="size-option" data-size="M">M</span>
                                                                                <span class="size-option" data-size="L">L</span>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <!-- Default - Free size -->
                                                                            <div class="size-selector">
                                                                                <span class="size-option selected" data-size="Free">Free Size</span>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-md-2 text-center">
                                                        <div class="product-price">$${product.price}</div>
                                                    </div>
                                                    
                                                    <div class="col-md-4">
                                                        <form action="cart" method="post">
                                                            <input type="hidden" name="id_product" value="${product.id}" />
                                                            <div class="quantity-controls">
                                                                <input type="number" name="quantity" value="${quantity}" min="1" 
                                                                       class="quantity-input" />
                                                                <button type="submit" name="action" value="update" class="btn btn-update">
                                                                    <i class="fas fa-sync-alt me-1"></i>Update
                                                                </button>
                                                                <button type="submit" name="action" value="remove" class="btn btn-remove">
                                                                    <i class="fas fa-trash me-1"></i>Remove
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Fallback nếu không tìm thấy sản phẩm -->
                                        <div class="product-card">
                                            <div class="card-body p-4">
                                                <div class="row align-items-center">
                                                    <div class="col-md-2">
                                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img1.webp"
                                                             class="product-image" alt="Shopping item">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <h5>Product ID: ${productId}</h5>
                                                        <p class="small mb-0 text-muted">Quantity: ${quantity}</p>
                                                    </div>
                                                    <div class="col-md-2 text-center">
                                                        <div class="product-price">$900</div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <a href="cart?action=remove&id_product=${productId}" class="btn btn-remove">
                                                            <i class="fas fa-trash me-1"></i>Remove
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-cart-message">
                                <i class="fas fa-shopping-cart"></i>
                                <h4>Your cart is empty</h4>
                                <p>Looks like you haven't added any items to your cart yet.</p>
                                <a href="home" class="btn btn-primary">
                                    <i class="fas fa-shopping-bag me-2"></i>Start Shopping
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Right side - Payment form -->
            <div class="col-lg-4">
                <div class="payment-card h-100">
                    
                    <!-- Payment Header -->
                    <div class="payment-header">
                        <h5><i class="fas fa-credit-card me-2"></i>Thông tin thanh toán</h5>
                    </div>

                    <!-- Bank Icons -->
                    <div class="bank-icons">
                        <p>Phương thức hỗ trợ</p>
                        <a href="#" class="text-white me-2">
                            <img src="./assets/icon/mastercard.png" alt="Mastercard" class="bank-icon" />
                        </a>
                        <a href="#" class="text-white me-2">
                            <img src="./assets/icon/vietcombank.png" alt="Vietcombank" class="bank-icon" />
                        </a>
                        <a href="#" class="text-white me-2">
                            <img src="./assets/icon/vietinbank.png" alt="Vietinbank" class="bank-icon" />
                        </a>
                        <a href="#" class="text-white">
                            <img src="./assets/icon/donga.png" alt="DongA Bank" class="bank-icon" />
                        </a>
                    </div>

                    <!-- Address & Payment Form -->
                    <div class="payment-form">
                        <form id="checkoutForm" action="#" method="post">
                            <div class="mb-3">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" id="fullName" name="fullName" class="form-control address-field" placeholder="Nhập họ và tên" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="tel" id="phone" name="phone" class="form-control address-field" placeholder="Nhập số điện thoại" />
                            </div>

                            <div class="row mb-3">
                                <div class="col-12">
                                    <label class="form-label">Tỉnh/Thành phố</label>
                                    <select id="provinceSelect" class="form-control address-field">
                                        <option value="">Chọn tỉnh/thành phố</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-6 mb-3 mb-sm-0">
                                    <label class="form-label">Quận/Huyện</label>
                                    <select id="districtSelect" class="form-control address-field" disabled>
                                        <option value="">Chọn quận/huyện</option>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Xã/Phường</label>
                                    <select id="wardSelect" class="form-control address-field" disabled>
                                        <option value="">Chọn xã/phường</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Địa chỉ chi tiết</label>
                                <textarea id="addressDetail" class="form-control address-field" rows="3" placeholder="Nhập địa chỉ cụ thể (số nhà, đường, thôn/xóm, ...)"></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label d-block">Phương thức thanh toán</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="payOnline" value="online" checked>
                                    <label class="form-check-label" for="payOnline">Thanh toán online</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="payCod" value="cod">
                                    <label class="form-check-label" for="payCod">Thanh toán khi nhận hàng</label>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Cost Summary -->
                    <div class="cost-summary">
                        <c:set var="total" value="${requestScope.subtotal}" />
                        <c:set var="vat" value="${requestScope.vat}" />
                        <c:set var="grand" value="${requestScope.total}" />

                        <div class="cost-row">
                            <span>Subtotal</span>
                            <span>$<fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                        </div>

                        <div class="cost-row">
                            <span>VAT (10%)</span>
                            <span>$<fmt:formatNumber value="${vat}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                        </div>

                        <div class="cost-row total">
                            <span>Tổng cộng (đã bao gồm thuế)</span>
                            <span>$<fmt:formatNumber value="${grand}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                        </div>

                        <button type="button" id="checkoutBtn" class="checkout-btn">
                            <i class="fas fa-lock me-2"></i>
                            Đặt hàng ngay - $<fmt:formatNumber value="${grand}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                        </button>
                    </div>

                </div>
            </div>

        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Success Modal -->
<div class="modal fade" id="orderSuccessModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-check-circle me-2"></i>Đặt hàng thành công</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Cảm ơn bạn! Đơn hàng của bạn đã được ghi nhận (demo).
            </div>
            <div class="modal-footer">
                <a href="home" class="btn btn-primary">Tiếp tục mua sắm</a>
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
    </div>
<script>
    // Size selector functionality + Address/Shipping UI
    document.addEventListener('DOMContentLoaded', function() {
        // ----- Size selection -----
        const sizeOptions = document.querySelectorAll('.size-option');
        sizeOptions.forEach(option => {
            option.addEventListener('click', function() {
                const parentCard = this.closest('.product-card');
                parentCard.querySelectorAll('.size-option').forEach(opt => opt.classList.remove('selected'));
                this.classList.add('selected');
                console.log('Selected size:', this.dataset.size);
            });
        });

        // ----- Address selectors -----
        // Lấy toàn bộ danh sách Tỉnh/Quận/Xã từ API công khai của Việt Nam
        // https://provinces.open-api.vn
        let provincesData = [];

        const provinceSelect = document.getElementById('provinceSelect');
        const districtSelect = document.getElementById('districtSelect');
        const wardSelect = document.getElementById('wardSelect');

        function populateProvinces() {
            if (!provinceSelect) return;
            clearSelect(provinceSelect, 'Chọn tỉnh/thành phố');
            provincesData.forEach(p => {
                const opt = document.createElement('option');
                opt.value = p.code; // dùng code để tìm chính xác
                opt.textContent = p.name;
                provinceSelect.appendChild(opt);
            });
        }

        function clearSelect(select, placeholder, disable = false) {
            if (!select) return;
            select.innerHTML = '';
            const opt = document.createElement('option');
            opt.value = ''; opt.textContent = placeholder;
            select.appendChild(opt);
            select.disabled = disable;
        }

        function populateDistricts(provinceCode) {
            clearSelect(districtSelect, 'Chọn quận/huyện', !provinceCode);
            clearSelect(wardSelect, 'Chọn xã/phường', true);
            if (!provinceCode) return;
            const p = provincesData.find(x => String(x.code) === String(provinceCode));
            if (!p) return;
            (p.districts || []).forEach(d => {
                const opt = document.createElement('option');
                opt.value = d.code; // dùng code
                opt.textContent = d.name;
                districtSelect.appendChild(opt);
            });
            districtSelect.disabled = false;
        }

        function populateWards(provinceCode, districtCode) {
            clearSelect(wardSelect, 'Chọn xã/phường', !districtCode);
            if (!provinceCode || !districtCode) return;
            const p = provincesData.find(x => String(x.code) === String(provinceCode));
            if (!p) return;
            const d = (p.districts || []).find(x => String(x.code) === String(districtCode));
            if (!d) return;
            (d.wards || []).forEach(w => {
                const opt = document.createElement('option');
                opt.value = w.code; // code của phường/xã
                opt.textContent = w.name;
                wardSelect.appendChild(opt);
            });
            wardSelect.disabled = false;
        }

        // Tải dữ liệu tỉnh/thành từ API rồi populate
        fetch('https://provinces.open-api.vn/api/?depth=3')
            .then(r => r.json())
            .then(data => { provincesData = data || []; populateProvinces(); })
            .catch(() => { provincesData = []; });

        provinceSelect && provinceSelect.addEventListener('change', function() {
            populateDistricts(this.value);
        });
        districtSelect && districtSelect.addEventListener('change', function() {
            populateWards(provinceSelect.value, this.value);
        });
        // Totals are rendered server-side now; no JS total calculation required
        function updateTotals() {}

        // ----- Checkout success modal (no validation, demo) -----
        const checkoutBtn = document.getElementById('checkoutBtn');
        const successModalEl = document.getElementById('orderSuccessModal');
        const successModal = successModalEl ? new bootstrap.Modal(successModalEl) : null;
        checkoutBtn && checkoutBtn.addEventListener('click', function() {
            if (successModal) successModal.show();
            else alert('Đặt hàng thành công! (demo)');
        });
    });
</script>

</body>
</html>









