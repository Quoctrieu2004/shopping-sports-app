<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .search-header{background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);color:#fff;padding:3rem 0;margin-bottom:2rem}
        .search-stats{background:#f8f9fa;border-radius:10px;padding:1.5rem;margin-bottom:2rem}
        .product-card{transition:transform .2s,box-shadow .2s;height:100%}
        .product-card:hover{transform:translateY(-5px);box-shadow:0 10px 25px rgba(0,0,0,.15)}
        .product-image{aspect-ratio:1/1;object-fit:cover}
        .no-results{text-align:center;padding:3rem;color:#6c757d}
        .search-suggestions{background:#e9ecef;border-radius:10px;padding:1.5rem;margin-top:2rem}
        .suggestion-tag{display:inline-block;background:#007bff;color:#fff;padding:.5rem 1rem;border-radius:20px;margin:.25rem;text-decoration:none}
        .suggestion-tag:hover{background:#0056b3;color:#fff}
    </style>
    </head>
<body>
    <jsp:include page="../inc/navbar.jsp"/>
    <div class="search-header">
        <div class="container">
            <div class="row justify-content-center text-center">
                <div class="col-lg-8">
                    <h1 class="display-4 mb-3"><i class="fas fa-search me-3"></i>Kết Quả Tìm Kiếm</h1>
                    <p class="lead">Tìm thấy sản phẩm phù hợp với yêu cầu của bạn</p>
                    <form action="search" method="GET" class="mt-4">
                        <div class="input-group input-group-lg">
                            <input type="search" name="q" class="form-control" placeholder="Tìm kiếm sản phẩm..." value="${searchQuery}" required>
                            <button class="btn btn-light" type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="search-stats">
            <div class="row align-items-center">
                <div class="col-md-6"><h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Tìm kiếm: <strong>"${searchQuery}"</strong></h5></div>
                <div class="col-md-6 text-md-end"><span class="badge bg-primary fs-6"><i class="fas fa-box me-1"></i>${resultCount} sản phẩm tìm thấy</span></div>
            </div>
        </div>
        <c:choose>
            <c:when test="${not empty searchResults}">
                <div class="row">
                    <c:forEach var="product" items="${searchResults}">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="card product-card h-100 shadow-sm">
                                <img src="assets/images/${product.image}" class="card-img-top product-image" alt="${product.name}"/>
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${product.name}</h5>
                                    <p class="card-text text-primary fw-bold fs-5">${product.price} VND</p>
                                    <div class="mt-auto">
                                        <a href="home?id_category=${product.id_category}" class="btn btn-outline-secondary w-100"><i class="fas fa-tags me-1"></i>Xem danh mục</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <h3>Không tìm thấy sản phẩm</h3>
                    <p class="text-muted">Không có sản phẩm nào khớp với từ khóa "<strong>${searchQuery}</strong>"</p>
                    <div class="search-suggestions">
                        <h5><i class="fas fa-lightbulb me-2"></i>Gợi ý tìm kiếm:</h5>
                        <div class="mt-3">
                            <a href="search?q=iphone" class="suggestion-tag">iPhone</a>
                            <a href="search?q=giay" class="suggestion-tag">Giày</a>
                            <a href="search?q=ao" class="suggestion-tag">Áo</a>
                            <a href="search?q=tui" class="suggestion-tag">Túi</a>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="home" class="btn btn-primary me-2"><i class="fas fa-home me-1"></i>Về trang chủ</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <jsp:include page="../inc/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


