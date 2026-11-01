<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ | Cửa Hàng Điện Máy Chính Hãng</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }

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

        .hero-banner {
            background: linear-gradient(135deg, #0d6efd 0%, #0d47a1 100%);
            border-radius: 24px;
            color: #ffffff;
            position: relative;
            overflow: hidden;
        }

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

        .badge-video {
            background: rgba(220, 38, 38, 0.88);
            backdrop-filter: blur(4px);
            border-radius: 20px;
            padding: 5px 10px;
            font-size: 0.75rem;
            font-weight: 600;
        }

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
            opacity: 0.95;
        }

        .nav-btn-icon {
            border-radius: 10px;
            font-weight: 500;
            padding: 0.4rem 0.8rem;
        }

        #suggestionBox {
            border-radius: 0 0 16px 16px;
            border: 1px solid #dee2e6;
            border-top: none;
            max-height: 300px;
            overflow-y: auto;
        }

        /* --- STYLING CHO MODAL ĐĂNG NHẬP / ĐĂNG KÝ / QUÊN MẬT KHẨU CAO CẤP --- */
        .modal-content {
            border: none;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(15, 23, 42, 0.25);
            background: #ffffff;
            overflow: hidden;
        }

        .modal-header {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-bottom: 1px solid #e2e8f0;
            padding: 1.5rem 1.75rem;
        }

        .modal-body {
            padding: 2rem 1.75rem;
        }

        .auth-input-group {
            border: 1.5px solid #cbd5e1;
            border-radius: 14px;
            overflow: hidden;
            background-color: #f8fafc;
            transition: all 0.25s ease;
        }

        .auth-input-group:focus-within {
            border-color: #0d6efd;
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.12);
        }

        .auth-input-group .input-group-text {
            background: transparent;
            border: none;
            color: #64748b;
            padding-left: 1.25rem;
            padding-right: 0.5rem;
            font-size: 1.1rem;
        }

        .auth-input-group .form-control {
            background: transparent;
            border: none;
            padding: 0.85rem 1rem 0.85rem 0;
            font-size: 0.95rem;
            color: #1e293b;
            box-shadow: none !important;
        }

        .btn-auth-submit {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border: none;
            border-radius: 14px;
            padding: 0.85rem;
            font-weight: 600;
            font-size: 1rem;
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.25);
            transition: all 0.25s ease;
        }

        .btn-auth-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(13, 110, 253, 0.35);
            color: #ffffff;
        }

        .modal-brand-icon {
            width: 56px;
            height: 56px;
            background: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            margin: 0 auto 1rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- 🌐 HEADER / NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-custom sticky-top py-2 shadow-sm">
    <div class="container">
        <!-- Logo Brand -->
        <a class="navbar-brand fw-bold text-primary fs-4 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-shop fs-3"></i> Cửa Hàng Điện Máy
        </a>

        <!-- Toggle Mobile -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse mt-2 mt-lg-0" id="navbarContent">
            <!-- Ô Tìm Kiếm -->
            <form class="d-flex mx-auto my-2 my-lg-0 position-relative" style="max-width: 400px; width: 100%;" action="${pageContext.request.contextPath}/home" method="GET">
                <div class="input-group">
                    <input type="text" id="searchQuery" name="query" class="form-control search-input bg-light border-end-0 ps-3" placeholder="Tìm kiếm thiết bị điện máy..." autocomplete="off" value="${param.query}">
                    <button class="btn btn-primary search-btn px-3" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
                <ul id="suggestionBox" class="list-group position-absolute w-100 shadow-sm" style="top: 100%; z-index: 1000; display: none;"></ul>
            </form>

            <!-- Menu Tài Khoản -->
            <div class="d-flex align-items-center gap-2 flex-wrap justify-content-end">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="me-2 text-end d-none d-xl-block">
                            <span class="text-muted small d-block">Xin chào,</span>
                            <strong class="text-dark">${sessionScope.user.username}</strong>
                        </div>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-primary btn-sm nav-btn-icon d-flex align-items-center gap-1">
                            <i class="bi bi-cart3 fs-6"></i> Giỏ hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/order-history" class="btn btn-outline-secondary btn-sm nav-btn-icon d-flex align-items-center gap-1">
                            <i class="bi bi-clock-history fs-6"></i> Lịch sử
                        </a>
                        <c:if test="${sessionScope.user.role == 'Manager' || sessionScope.user.role == 'Staff'}">
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-warning btn-sm nav-btn-icon fw-semibold d-flex align-items-center gap-1">
                                <i class="bi bi-speedometer2"></i> Quản trị
                            </a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm nav-btn-icon" title="Đăng xuất">
                            <i class="bi bi-box-arrow-right"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <!-- Nút kích hoạt Modal Đăng Nhập -->
                        <button type="button" class="btn btn-outline-primary btn-sm nav-btn-icon px-3" data-bs-toggle="modal" data-bs-target="#loginModal">
                            <i class="bi bi-person me-1"></i> Đăng nhập
                        </button>
                        <!-- Nút kích hoạt Modal Đăng Ký -->
                        <button type="button" class="btn btn-primary btn-sm nav-btn-icon px-3" data-bs-toggle="modal" data-bs-target="#registerModal">
                            Đăng ký
                        </button>
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
                <h1 class="display-5 fw-bold mb-3">Thiết Bị Điện Máy Thông Minh Cho Ngôi Nhà Bạn</h1>
                <p class="lead opacity-90 mb-4">Nâng tầm không gian sống với các thiết bị điện máy tiện ích, tiết kiệm điện năng và hiện đại nhất.</p>
                <a href="#productList" class="btn btn-light text-primary btn-lg fw-bold px-4 rounded-pill shadow-sm">
                    Khám phá ngay <i class="bi bi-arrow-down-short fs-5"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- 📦 DANH SÁCH SẢN PHẨM -->
<div class="container mb-5 flex-grow-1" id="productList">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1 border-start border-primary border-4 ps-2">
                <c:choose>
                    <c:when test="${not empty param.query}">Kết quả tìm kiếm cho: "${param.query}"</c:when>
                    <c:otherwise>Sản Phẩm Nổi Bật</c:otherwise>
                </c:choose>
            </h3>
            <p class="text-muted small mb-0 ps-2">Lựa chọn những thiết bị điện máy chất lượng cao hàng đầu</p>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <c:choose>
            <c:when test="${not empty products}">
                <c:forEach var="p" items="${products}">
                    <div class="col">
                        <div class="card h-100 product-card">
                            <div class="product-img-wrapper">
                                <c:choose>
                                    <c:when test="${not empty p.thumbnailUrl && p.thumbnailUrl.startsWith('http')}">
                                        <img src="${p.thumbnailUrl}" alt="${p.productName}" onerror="this.src='https://via.placeholder.com/300x300?text=No+Image';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/uploads/${not empty p.thumbnailUrl ? p.thumbnailUrl : 'default.jpg'}" alt="${p.productName}" onerror="this.src='https://via.placeholder.com/300x300?text=No+Image';">
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty p.videoUrl}">
                                    <span class="badge badge-video text-white position-absolute top-0 end-0 m-2 shadow-sm d-flex align-items-center gap-1">
                                        <i class="bi bi-play-circle-fill"></i> Có Video
                                    </span>
                                </c:if>
                            </div>
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
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.productID}" class="btn btn-custom-primary btn-sm w-100 py-2 d-flex align-items-center justify-content-center gap-1">
                                       <i class="bi bi-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
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

<!-- ========================================================= -->
<!-- 🔐 1. MODAL ĐĂNG NHẬP -->
<!-- ========================================================= -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 440px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold text-dark d-flex align-items-center gap-2" id="loginModalLabel">
                    <i class="bi bi-box-arrow-in-right text-primary fs-4"></i> Đăng Nhập Hệ Thống
                </h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
                        <div class="input-group auth-input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" name="username" required placeholder="Nhập tên đăng nhập của bạn">
                        </div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small fw-semibold text-secondary">Mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group auth-input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" name="password" required placeholder="Nhập mật khẩu">
                        </div>
                    </div>
                    <div class="d-flex justify-content-end mb-4 small">
                        <a href="#" class="text-decoration-none text-primary fw-semibold" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                            Quên mật khẩu?
                        </a>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-auth-submit">Đăng Nhập Ngay</button>
                    </div>
                </form>
                <div class="text-center mt-4 small text-muted">
                    Chưa có tài khoản thành viên?
                    <a href="#" class="fw-bold text-primary text-decoration-none ms-1" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#registerModal">Đăng ký ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ========================================================= -->
<!-- 📝 2. MODAL ĐĂNG KÝ -->
<!-- ========================================================= -->
<div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 460px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold text-dark d-flex align-items-center gap-2" id="registerModalLabel">
                    <i class="bi bi-person-plus-fill text-primary fs-4"></i> Tạo Tài Khoản Mới
                </h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
                        <div class="input-group auth-input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" name="username" required placeholder="Chọn tên đăng nhập của bạn">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Địa chỉ Email <span class="text-danger">*</span></label>
                        <div class="input-group auth-input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" name="email" required placeholder="name@gmail.com">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group auth-input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" name="password" required placeholder="Tạo mật khẩu bảo mật">
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label small fw-semibold text-secondary">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group auth-input-group">
                            <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                            <input type="password" class="form-control" name="confirmPassword" required placeholder="Nhập lại mật khẩu">
                        </div>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-auth-submit">Đăng Ký Tài Khoản</button>
                    </div>
                </form>
                <div class="text-center mt-4 small text-muted">
                    Đã có sẵn tài khoản?
                    <a href="#" class="fw-bold text-primary text-decoration-none ms-1" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#loginModal">Đăng nhập ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ========================================================= -->
<!-- 🔑 3. MODAL QUÊN MẬT KHẨU -->
<!-- ========================================================= -->
<div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 440px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold text-dark d-flex align-items-center gap-2" id="forgotPasswordModalLabel">
                    <i class="bi bi-key-fill text-primary fs-4"></i> Khôi Phục Mật Khẩu
                </h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <div class="modal-brand-icon">
                    <i class="bi bi-envelope-at-fill"></i>
                </div>
                <h6 class="fw-bold text-dark mb-1">Bạn quên mật khẩu?</h6>
                <p class="text-muted small mb-4 px-2">Nhập email đã đăng ký của bạn để nhận mã xác thực OTP khôi phục mật khẩu.</p>

                <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="text-start">
                    <div class="mb-4">
                        <label class="form-label small fw-semibold text-secondary">Email tài khoản <span class="text-danger">*</span></label>
                        <div class="input-group auth-input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" name="email" required placeholder="name@gmail.com">
                        </div>
                    </div>
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-auth-submit d-flex align-items-center justify-content-center gap-2">
                            <i class="bi bi-send-fill"></i> Gửi mã xác thực OTP
                        </button>
                    </div>
                </form>

                <div class="text-center mt-3">
                    <a href="#" class="text-decoration-none text-secondary small fw-semibold d-inline-flex align-items-center gap-1" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#loginModal">
                        <i class="bi bi-arrow-left"></i> Quay lại đăng nhập
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 🦶 FOOTER -->
<footer class="bg-white border-top py-4 mt-auto">
    <div class="container text-center text-muted small">
        <p class="mb-1">&copy; 2026 Cửa Hàng Điện Máy. Tất cả quyền được bảo lưu.</p>
        <p class="mb-0">Địa chỉ: Hà Nội, Việt Nam | Hotline: 1900 xxxx</p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Script xử lý gợi ý tìm kiếm -->
<script>
    const searchInput = document.getElementById('searchQuery');
    const suggestionBox = document.getElementById('suggestionBox');
    let timeout = null;

    if (searchInput && suggestionBox) {
        searchInput.addEventListener('input', function() {
            clearTimeout(timeout);
            const query = this.value.trim();

            if (query.length === 0) {
                suggestionBox.style.display = 'none';
                return;
            }

            timeout = setTimeout(() => {
                fetch('${pageContext.request.contextPath}/api/search-suggestions?query=' + encodeURIComponent(query))
                    .then(response => response.json())
                    .then(data => {
                        suggestionBox.innerHTML = '';
                        if (data && data.length > 0) {
                            data.forEach(item => {
                                const li = document.createElement('li');
                                li.className = 'list-group-item list-group-item-action py-2';
                                li.textContent = item;
                                li.style.cursor = 'pointer';

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

        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !suggestionBox.contains(e.target)) {
                suggestionBox.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>