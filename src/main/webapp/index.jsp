<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Taglib chuẩn dành cho Tomcat 10 (Jakarta EE) --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ | Cửa Hàng Gia Dụng Chính Hãng</title>

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

        /* Navbar Custom */
        .navbar-custom {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
        }

        .search-input {
            border-radius: 20px 0 0 20px;
            border-right: none;
        }

        .search-btn {
            border-radius: 0 20px 20px 0;
        }

        /* Hero Banner Gradient */
        .hero-banner {
            background: linear-gradient(135deg, #0d6efd 0%, #0d47a1 100%);
            border-radius: 24px;
            color: #ffffff;
            position: relative;
            overflow: hidden;
        }

        .hero-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            pointer-events: none;
        }

        /* Product Card Styling */
        .product-card {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: #ffffff;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08);
            border-color: #bfdbfe;
        }

        .product-img-wrapper {
            position: relative;
            height: 220px;
            background-color: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            padding: 1rem;
        }

        .product-img-wrapper img {
            max-height: 100%;
            width: auto;
            object-fit: contain;
            transition: transform 0.4s ease;
        }

        .product-card:hover .product-img-wrapper img {
            transform: scale(1.08);
        }

        /* Video Badge Glassmorphism */
        .badge-video {
            background: rgba(220, 38, 38, 0.88);
            backdrop-filter: blur(4px);
            border-radius: 20px;
            padding: 5px 10px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* Custom Button */
        .btn-custom-primary {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            color: #ffffff;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .btn-custom-primary:hover {
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.25);
            opacity: 0.95;
        }

        .nav-btn-icon {
            border-radius: 10px;
            font-weight: 500;
            padding: 0.4rem 0.8rem;
        }
    </style>
</head>
<body>

<!-- 🌐 HEADER / NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-custom sticky-top py-2 shadow-sm">
    <div class="container">
        <!-- Logo Brand -->
        <a class="navbar-brand fw-bold text-primary fs-4 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-shop fs-3"></i> Cửa Hàng Gia Dụng
        </a>

        <!-- Toggle Mobile -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse mt-2 mt-lg-0" id="navbarContent">

            <!-- Ô Tìm Kiếm Sản Phẩm (Tích hợp gợi ý) -->
            <form class="d-flex mx-auto my-2 my-lg-0 position-relative" style="max-width: 400px; width: 100%;" action="${pageContext.request.contextPath}/home" method="GET">
                <div class="input-group">
                    <input type="text" id="searchQuery" name="query" class="form-control search-input bg-light border-end-0 ps-3" placeholder="Tìm kiếm đồ gia dụng..." autocomplete="off" value="${param.query}">
                    <button class="btn btn-primary search-btn px-3" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
                <!-- Khung hiển thị danh sách gợi ý -->
                <ul id="suggestionBox" class="list-group position-absolute w-100 shadow-sm" style="top: 100%; z-index: 1000; display: none;"></ul>
            </form>

            <!-- Menu Điều Hướng & Tài Khoản -->
            <div class="d-flex align-items-center gap-2 flex-wrap justify-content-end">
                <c:choose>
                    <%-- Trường hợp: Đã đăng nhập --%>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="me-2 text-end d-none d-xl-block">
                            <span class="text-muted small d-block">Xin chào,</span>
                            <strong class="text-dark">${sessionScope.user.username}</strong>
                        </div>

                        <!-- Giỏ hàng -->
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-primary btn-sm nav-btn-icon d-flex align-items-center gap-1">
                            <i class="bi bi-cart3 fs-6"></i>
                            <span>Giỏ hàng</span>
                        </a>

                        <!-- Lịch sử đơn hàng -->
                        <a href="${pageContext.request.contextPath}/order-history" class="btn btn-outline-secondary btn-sm nav-btn-icon d-flex align-items-center gap-1">
                            <i class="bi bi-clock-history fs-6"></i>
                            <span>Lịch sử</span>
                        </a>

                        <!-- Quản trị Admin/Staff -->
                        <c:if test="${sessionScope.user.role == 'Manager' || sessionScope.user.role == 'Staff'}">
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-warning btn-sm nav-btn-icon fw-semibold d-flex align-items-center gap-1">
                                <i class="bi bi-speedometer2"></i>
                                <span>Quản trị</span>
                            </a>
                        </c:if>

                        <!-- Đăng xuất -->
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm nav-btn-icon" title="Đăng xuất">
                            <i class="bi bi-box-arrow-right"></i>
                        </a>
                    </c:when>

                    <%-- Trường hợp: Chưa đăng nhập --%>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary btn-sm nav-btn-icon px-3">
                            <i class="bi bi-person me-1"></i> Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm nav-btn-icon px-3">
                            Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</nav>

<!-- 🚀 HERO BANNER -->
<div class="container my-4">
    <div class="hero-banner p-4 p-md-5 shadow-sm">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <span class="badge bg-white text-primary fw-bold px-3 py-2 rounded-pill mb-3">
                    <i class="bi bi-stars me-1"></i> Sản Phẩm Chính Hãng 100%
                </span>
                <h1 class="display-5 fw-bold mb-3">Thiết Bị Gia Dụng Thông Minh Cho Ngôi Nhà Bạn</h1>
                <p class="lead opacity-90 mb-4">Nâng tầm không gian sống với các thiết bị tiện ích, tiết kiệm điện năng và hiện đại nhất.</p>
                <a href="#productList" class="btn btn-light text-primary btn-lg fw-bold px-4 rounded-pill shadow-sm">
                    Khám phá ngay <i class="bi bi-arrow-down-short fs-5"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- 📦 DANH SÁCH SẢN PHẨM -->
<div class="container mb-5" id="productList">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1 border-start border-primary border-4 ps-2">
                <c:choose>
                    <c:when test="${not empty param.query}">Kết quả tìm kiếm cho: "${param.query}"</c:when>
                    <c:otherwise>Sản Phẩm Nổi Bật</c:otherwise>
                </c:choose>
            </h3>
            <p class="text-muted small mb-0 ps-2">Lựa chọn những thiết bị gia dụng chất lượng cao hàng đầu</p>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach var="p" items="${products}">
                    <div class="col">
                        <div class="card h-100 product-card">

                            <!-- Khung Chứa Ảnh + Badge -->
                            <div class="product-img-wrapper">
                                <c:choose>
                                    <%-- Trường hợp 1: URL ảnh trực tiếp từ Internet --%>
                                    <c:when test="${not empty p.thumbnailUrl && p.thumbnailUrl.startsWith('http')}">
                                        <img src="${p.thumbnailUrl}"
                                             alt="${p.productName}"
                                             onerror="this.src='https://via.placeholder.com/300x300?text=No+Image';">
                                    </c:when>

                                    <%-- Trường hợp 2: File ảnh nằm trong thư mục webapp/uploads/ --%>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/uploads/${not empty p.thumbnailUrl ? p.thumbnailUrl : 'default.jpg'}"
                                             alt="${p.productName}"
                                             onerror="this.src='https://via.placeholder.com/300x300?text=No+Image';">
                                    </c:otherwise>
                                </c:choose>

                                <%-- Badge Nổi bật nếu Sản phẩm có VideoUrl --%>
                                <c:if test="${not empty p.videoUrl}">
                                    <span class="badge badge-video text-white position-absolute top-0 end-0 m-2 shadow-sm d-flex align-items-center gap-1">
                                        <i class="bi bi-play-circle-fill"></i> Có Video
                                    </span>
                                </c:if>
                            </div>

                            <!-- Nội Dung Sản Phẩm -->
                            <div class="card-body d-flex flex-column p-3">
                                <h6 class="card-title fw-semibold text-dark text-truncate mb-2" title="${p.productName}">
                                    ${p.productName}
                                </h6>

                                <div class="mt-auto pt-2">
                                    <div class="d-flex align-items-baseline justify-content-between mb-3">
                                        <span class="text-danger fw-bold fs-5">
                                            <fmt:formatNumber value="${p.price}" pattern="#,##0"/> <small class="fs-7">VNĐ</small>
                                        </span>
                                    </div>

                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.productID}"
                                       class="btn btn-custom-primary btn-sm w-100 py-2 d-flex align-items-center justify-content-center gap-1">
                                       <i class="bi bi-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </c:when>

            <%-- Trạng thái trống CSDL --%>
            <c:otherwise>
                <div class="col-12 text-center text-muted py-5">
                    <div class="p-4 bg-white rounded-4 border shadow-sm d-inline-block">
                        <i class="bi bi-box-seam fs-1 text-secondary mb-2 d-block"></i>
                        <h5 class="fw-bold text-dark">Không tìm thấy sản phẩm phù hợp!</h5>
                        <p class="small mb-0">Thử tìm kiếm với từ khóa khác hoặc quay lại sau.</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 🦶 FOOTER -->
<footer class="bg-white border-top py-4 mt-auto">
    <div class="container text-center text-muted small">
        <p class="mb-1">&copy; 2026 Cửa Hàng Gia Dụng. Tất cả quyền được bảo lưu.</p>
        <p class="mb-0">Địa chỉ: Hà Nội, Việt Nam | Hotline: 1900 xxxx</p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Script xử lý gợi ý tìm kiếm (Autocomplete) -->
<script>
    const searchInput = document.getElementById('searchQuery');
    const suggestionBox = document.getElementById('suggestionBox');
    let timeout = null;

    searchInput.addEventListener('input', function() {
        clearTimeout(timeout);
        const query = this.value.trim();

        if (query.length === 0) {
            suggestionBox.style.display = 'none';
            return;
        }

        // Debounce: Chờ 300ms sau khi ngừng gõ mới gọi API để tối ưu hiệu năng
        timeout = setTimeout(() => {
            fetch('${pageContext.request.contextPath}/api/search-suggestions?query=' + encodeURIComponent(query))
                .then(response => response.json())
                .then(data => {
                    suggestionBox.innerHTML = '';
                    if (data.length > 0) {
                        data.forEach(item => {
                            const li = document.createElement('li');
                            li.className = 'list-group-item list-group-item-action py-2';
                            li.textContent = item;
                            li.style.cursor = 'pointer';

                            // Khi bấm vào 1 gợi ý -> Tự động điền vào ô input và submit tìm kiếm
                            li.onclick = () => {
                                searchInput.value = item;
                                suggestionBox.style.display = 'none';
                                searchInput.form.submit();
                            };
                            suggestionBox.appendChild(li);
                        });
                        suggestionBox.style.display = 'block';
                    } else {
                        suggestionBox.style.display = 'none';
                    }
                })
                .catch(error => console.error('Lỗi khi tải gợi ý:', error));
        }, 300);
    });

    // Ẩn hộp gợi ý khi click ra chỗ khác ngoài thanh tìm kiếm
    document.addEventListener('click', function(e) {
        if (!searchInput.contains(e.target) && !suggestionBox.contains(e.target)) {
            suggestionBox.style.display = 'none';
        }
    });
</script>

</body>
</html>