<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - Chi Tiết Sản Phẩm | Gia Dụng Store</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }

        /* Custom Navbar */
        .navbar-custom {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
        }

        /* Breadcrumb styling */
        .breadcrumb-item a {
            color: #64748b;
            text-decoration: none;
            transition: color 0.2s;
        }

        .breadcrumb-item a:hover {
            color: #0d6efd;
        }

        /* Product Image Box */
        .product-media-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 400px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
        }

        .product-media-card img {
            max-height: 380px;
            width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .product-media-card:hover img {
            transform: scale(1.03);
        }

        /* Pricing Card/Text */
        .price-tag {
            color: #dc3545;
            font-size: 2.25rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        /* Quantity Counter */
        .quantity-btn {
            border: 1px solid #cbd5e1;
            background: #ffffff;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s;
        }

        .quantity-btn:hover {
            background-color: #e2e8f0;
        }

        .quantity-input {
            width: 60px;
            border-top: 1px solid #cbd5e1;
            border-bottom: 1px solid #cbd5e1;
            border-left: none;
            border-right: none;
            text-align: center;
            font-weight: 600;
        }

        /* Buttons */
        .btn-action-cart {
            border-radius: 12px;
            font-weight: 600;
            padding: 0.8rem 1.5rem;
            transition: all 0.2s;
        }

        .btn-action-buy {
            background: linear-gradient(135deg, #dc3545 0%, #bb2d3b 100%);
            border: none;
            border-radius: 12px;
            font-weight: 600;
            padding: 0.8rem 1.5rem;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.25);
            transition: all 0.2s;
        }

        .btn-action-buy:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(220, 53, 69, 0.35);
        }

        /* Trust Badges Box */
        .trust-feature {
            border: 1px solid #e2e8f0;
            background-color: #ffffff;
            border-radius: 16px;
            padding: 1rem;
        }
    </style>
</head>
<body>

<!-- 🌐 NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-custom sticky-top py-2 shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary fs-4 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-shop fs-3"></i> Gia Dụng Store
        </a>

        <div class="d-flex align-items-center gap-2">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="dropdown me-1">
                        <button class="btn btn-light rounded-pill dropdown-toggle d-flex align-items-center gap-2 px-3 border" type="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle text-primary"></i>
                            <span class="fw-semibold small">${sessionScope.user.username}</span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 rounded-3 mt-2">
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/order-history"><i class="bi bi-receipt me-2"></i> Lịch sử đơn hàng</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                        </ul>
                    </div>

                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-primary position-relative rounded-pill px-3">
                        <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary rounded-pill px-3 me-2">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary rounded-pill px-3">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<!-- 📍 BREADCRUMB & MAIN CONTAINER -->
<div class="container my-4" style="max-width: 1100px;">

    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb mb-0 small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="bi bi-house"></i> Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home#productList">${product.category != null ? product.category.categoryName : 'Đồ gia dụng'}</a></li>
            <li class="breadcrumb-item active text-truncate" style="max-width: 250px;" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <div class="row g-4">

        <!-- 🖼️ CỘT TRÁI: HÌNH ẢNH SẢN PHẨM & VIDEO REVIEW -->
        <div class="col-lg-5">
            <!-- Frame Ảnh Chính -->
            <div class="product-media-card">
                <c:choose>
                    <c:when test="${not empty product.thumbnailUrl && product.thumbnailUrl.startsWith('http')}">
                        <img src="${product.thumbnailUrl}" alt="${product.productName}" onerror="this.src='https://via.placeholder.com/400?text=No+Image';">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/uploads/${not empty product.thumbnailUrl ? product.thumbnailUrl : 'default.jpg'}" alt="${product.productName}" onerror="this.src='https://via.placeholder.com/400?text=No+Image';">
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Video Review Embed (Nếu có) -->
            <c:if test="${not empty product.videoUrl}">
                <div class="mt-4 bg-white p-3 border rounded-4 shadow-sm">
                    <h6 class="fw-bold text-dark mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-youtube text-danger fs-5"></i> Video Đánh Giá Sản Phẩm
                    </h6>
                    <div class="ratio ratio-16x9 rounded-3 overflow-hidden">
                        <iframe src="${product.videoUrl}" allowfullscreen title="Video Review"></iframe>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- 📝 CỘT PHẢI: THÔNG TIN CHI TIẾT & HÀNH ĐỘNG MUA -->
        <div class="col-lg-7">
            <div class="bg-white p-4 p-md-5 rounded-4 border shadow-sm">

                <!-- Category Badge -->
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill fw-semibold mb-2">
                    <i class="bi bi-tag-fill me-1"></i> ${product.category != null ? product.category.categoryName : 'Đồ gia dụng'}
                </span>

                <!-- Tên Sản Phẩm -->
                <h2 class="fw-bold text-dark my-2 leading-snug">${product.productName}</h2>

                <!-- Tình trạng kho -->
                <div class="d-flex align-items-center gap-2 my-3">
                    <span class="small text-muted">Tình trạng:</span>
                    <c:choose>
                        <c:when test="${product.stockQuantity > 0}">
                            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2.5 py-1">
                                <i class="bi bi-check-circle-fill me-1"></i> Còn hàng (${product.stockQuantity} sản phẩm)
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-2.5 py-1">
                                <i class="bi bi-x-circle-fill me-1"></i> Tạm hết hàng
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Giá Sản Phẩm -->
                <div class="p-3 bg-light rounded-3 my-3">
                    <small class="text-muted d-block mb-1">Giá bán ưu đãi:</small>
                    <div class="price-tag">
                        <fmt:formatNumber value="${product.price}" pattern="#,##0"/> <span class="fs-4">VNĐ</span>
                    </div>
                </div>

                <!-- Mô tả ngắn / chi tiết -->
                <div class="my-4">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-card-text me-1 text-primary"></i> Mô tả sản phẩm:</h6>
                    <p class="text-secondary small leading-relaxed mb-0" style="white-space: pre-line;">${not empty product.description ? product.description : 'Chưa có mô tả chi tiết cho sản phẩm này.'}</p>
                </div>

                <hr class="my-4 opacity-25">

                <!-- 🛒 FORM THÊM MUA SẮM (Giữ nguyên Name & Action Logic) -->
                <form id="productForm" method="post" class="mt-4">
                    <input type="hidden" name="productId" value="${product.productID}">
                    <input type="hidden" name="id" value="${product.productID}">

                    <!-- Bộ chọn số lượng -->
                    <div class="mb-4">
                        <label class="form-label small fw-semibold text-secondary">Số lượng mua:</label>
                        <div class="d-flex align-items-center">
                            <div class="d-flex rounded-3 overflow-hidden me-3">
                                <button type="button" class="quantity-btn rounded-start-3" onclick="decreaseQty()"><i class="bi bi-dash"></i></button>
                                <input type="number" id="quantityInput" name="quantity" class="form-control quantity-input" value="1" min="1" max="${product.stockQuantity}">
                                <button type="button" class="quantity-btn rounded-end-3" onclick="increaseQty()"><i class="bi bi-plus"></i></button>
                            </div>
                            <span class="small text-muted">Tối đa: ${product.stockQuantity}</span>
                        </div>
                    </div>

                    <!-- Hàng Nút Bấm -->
                    <div class="row g-2">
                        <div class="col-sm-6">
                            <button type="submit"
                                    formaction="${pageContext.request.contextPath}/cart/add"
                                    class="btn btn-outline-primary btn-action-cart w-100 fs-6 d-flex align-items-center justify-content-center gap-2"
                                    ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                                <i class="bi bi-cart-plus fs-5"></i> Thêm vào giỏ
                            </button>
                        </div>
                        <div class="col-sm-6">
                            <button type="submit"
                                    formaction="${pageContext.request.contextPath}/buy-now"
                                    class="btn btn-danger btn-action-buy text-white w-100 fs-6 d-flex align-items-center justify-content-center gap-2"
                                    ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                                <i class="bi bi-lightning-charge-fill"></i> Mua ngay
                            </button>
                        </div>
                    </div>
                </form>

                <!-- 🛡️ TÍNH NĂNG CAM KẾT (Trust Badges) -->
                <div class="row g-2 mt-4 pt-3 border-top">
                    <div class="col-6">
                        <div class="trust-feature d-flex align-items-center gap-2">
                            <i class="bi bi-truck text-primary fs-4"></i>
                            <div>
                                <strong class="d-block small text-dark">Giao hàng nhanh</strong>
                                <span class="text-muted" style="font-size: 0.75rem;">Toàn quốc từ 2 - 4 ngày</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="trust-feature d-flex align-items-center gap-2">
                            <i class="bi bi-shield-check text-success fs-4"></i>
                            <div>
                                <strong class="d-block small text-dark">Bảo hành 100%</strong>
                                <span class="text-muted" style="font-size: 0.75rem;">Chính hãng 12 tháng</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>

<!-- 🦶 FOOTER -->
<footer class="bg-white border-top py-4 mt-5">
    <div class="container text-center text-muted small">
        <p class="mb-1">&copy; 2026 Cửa Hàng Gia Dụng. Tất cả quyền được bảo lưu.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Logic tăng / giảm số lượng linh hoạt
    const qtyInput = document.getElementById('quantityInput');
    const maxQty = parseInt("${product.stockQuantity}") || 1;

    function increaseQty() {
        let current = parseInt(qtyInput.value) || 1;
        if (current < maxQty) {
            qtyInput.value = current + 1;
        }
    }

    function decreaseQty() {
        let current = parseInt(qtyInput.value) || 1;
        if (current > 1) {
            qtyInput.value = current - 1;
        }
    }
</script>
</body>
</html>