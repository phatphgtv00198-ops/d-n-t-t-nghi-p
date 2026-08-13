<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm | Admin</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f9;
            color: #334155;
        }

        .navbar-custom {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        }

        .stat-card {
            border: none;
            border-radius: 16px;
            transition: all 0.25s ease-in-out;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05) !important;
        }

        .icon-shape {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }

        .card-custom {
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.03);
        }

        .table > :not(caption) > * > * {
            padding: 0.85rem 1rem;
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.6rem 0.9rem;
            border: 1px solid #cbd5e1;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        .product-img {
            width: 48px;
            height: 48px;
            object-fit: cover;
            border-radius: 10px;
        }

        .action-btn {
            width: 32px;
            height: 32px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
    </style>
</head>
<body>

    <!-- 🌐 NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4 py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold fs-5 d-flex align-items-center gap-2" href="#">
                <div class="bg-primary text-white p-2 rounded-3 d-flex align-items-center justify-content-center" style="width:36px; height:36px;">
                    <i class="bi bi-shop"></i>
                </div>
                <span>Gia Dụng Admin</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </nav>

    <div class="container mb-5">

        <!-- 📊 THỐNG KÊ NHANH -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-primary-subtle text-primary fs-4">
                            <i class="bi bi-box-seam-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Tổng sản phẩm</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">${totalProducts != null ? totalProducts : 0}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-warning-subtle text-warning fs-4">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Sắp hết hàng (≤ 5)</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">${lowStock != null ? lowStock : 0}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-danger-subtle text-danger fs-4">
                            <i class="bi bi-x-circle-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Hết hàng</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">${outOfStock != null ? outOfStock : 0}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 📑 BẢNG DỮ LIỆU & BỘ LỌC -->
        <div class="card card-custom p-4 bg-white">

            <!-- HEADER -->
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <div>
                    <h4 class="fw-bold text-dark mb-1">
                        <i class="bi bi-grid-3x3-gap text-primary me-2"></i>Danh Sách Sản Phẩm
                    </h4>
                    <small class="text-muted">Quản lý toàn bộ danh mục sản phẩm đồ gia dụng</small>
                </div>
                <a href="${pageContext.request.contextPath}/staff/product-add" class="btn btn-primary rounded-pill px-4 shadow-sm fw-semibold">
                    <i class="bi bi-plus-lg me-1"></i> Thêm sản phẩm
                </a>
            </div>

            <!-- SEARCH & FILTER FORM -->
            <form action="${pageContext.request.contextPath}/staff/products" method="get" class="row g-2 mb-4 bg-light p-3 rounded-4 border">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-search"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control border-start-0 ps-0" placeholder="Tìm tên sản phẩm...">
                    </div>
                </div>
                <div class="col-md-4">
                    <select name="categoryId" class="form-select">
                        <option value="">-- Tất cả danh mục --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryID}" ${selectedCategoryId == cat.categoryID ? 'selected' : ''}>
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3 d-flex gap-2">
                    <button class="btn btn-primary rounded-3 w-100 fw-medium" type="submit">
                        <i class="bi bi-funnel me-1"></i> Lọc
                    </button>
                    <c:if test="${not empty keyword || not empty selectedCategoryId}">
                        <a href="${pageContext.request.contextPath}/staff/products" class="btn btn-outline-secondary rounded-3" title="Xóa bộ lọc">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </a>
                    </c:if>
                </div>
            </form>

            <!-- BẢNG SẢN PHẨM -->
            <div class="table-responsive">
                <table class="table table-hover align-middle border-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 90px;">Mã SP</th>
                            <th>Sản phẩm</th>
                            <th class="text-end" style="width: 140px;">Giá bán</th>
                            <th class="text-center" style="width: 100px;">Số lượng</th>
                            <th class="text-center" style="width: 130px;">Trạng thái</th>
                            <th class="text-center" style="width: 140px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty products}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-5">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary opacity-50"></i>
                                    Không tìm thấy sản phẩm phù hợp!
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="p" items="${products}">
                            <tr>
                                <!-- Mã SP -->
                                <td class="text-center fw-bold text-muted">
                                    #SP${p.productID}
                                </td>

                                <!-- Sản phẩm & Thumbnail -->
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <c:choose>
                                            <c:when test="${not empty p.thumbnailUrl}">
                                                <img src="${p.thumbnailUrl}" alt="${p.productName}" class="product-img shadow-sm">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="product-img bg-secondary-subtle text-secondary d-flex align-items-center justify-content-center border">
                                                    <i class="bi bi-image fs-5"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <span class="fw-bold text-dark d-block">${p.productName}</span>
                                            <span class="badge bg-light text-secondary border small mt-1">
                                                ${p.category != null ? p.category.categoryName : 'Chưa phân loại'}
                                            </span>
                                        </div>
                                    </div>
                                </td>

                                <!-- Giá bán -->
                                <td class="text-end text-danger fw-bold">
                                    <fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ
                                </td>

                                <!-- Tồn kho -->
                                <td class="text-center fw-bold text-dark">
                                    ${p.stockQuantity}
                                </td>

                                <!-- Trạng thái -->
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${p.stockQuantity > 5}">
                                            <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1.5 rounded-pill">
                                                <i class="bi bi-check-circle me-1"></i>Đang bán
                                            </span>
                                        </c:when>
                                        <c:when test="${p.stockQuantity > 0}">
                                            <span class="badge bg-warning-subtle text-warning border border-warning-subtle px-3 py-1.5 rounded-pill">
                                                <i class="bi bi-exclamation-triangle me-1"></i>Sắp hết
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-1.5 rounded-pill">
                                                <i class="bi bi-x-circle me-1"></i>Hết hàng
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- Thao tác -->
                                <td class="text-center">
                                    <div class="d-flex justify-content-center gap-1">
                                        <!-- Xem nhanh -->
                                        <button class="btn btn-sm btn-light text-info action-btn" title="Xem nhanh"
                                                data-bs-toggle="modal" data-bs-target="#quickViewModal${p.productID}">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                        <!-- Sửa -->
                                        <a href="${pageContext.request.contextPath}/staff/product-edit?id=${p.productID}"
                                           class="btn btn-sm btn-light text-primary action-btn" title="Sửa">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <!-- Xóa -->
                                        <a href="${pageContext.request.contextPath}/staff/product-delete?id=${p.productID}"
                                           class="btn btn-sm btn-light text-danger action-btn" title="Xóa"
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm SP${p.productID}?');">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>

                                    <!-- MODAL XEM NHANH (Nâng cấp UI) -->
                                    <div class="modal fade text-start" id="quickViewModal${p.productID}" tabindex="-1">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content border-0 rounded-4 shadow">
                                                <div class="modal-header border-bottom">
                                                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-info-circle text-primary me-2"></i>Chi tiết sản phẩm</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body p-4">
                                                    <div class="text-center mb-3 p-3 bg-light rounded-3 border">
                                                        <c:choose>
                                                            <c:when test="${not empty p.thumbnailUrl}">
                                                                <img src="${p.thumbnailUrl}" class="img-fluid rounded" style="max-height: 180px; object-fit: contain;" alt="Image">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="bi bi-image text-muted fs-1 d-block py-4"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <h5 class="fw-bold text-dark mb-3">${p.productName}</h5>
                                                    <div class="row g-2 mb-2">
                                                        <div class="col-6"><span class="text-muted">Mã SP:</span> <strong>#SP${p.productID}</strong></div>
                                                        <div class="col-6"><span class="text-muted">Tồn kho:</span> <strong>${p.stockQuantity}</strong></div>
                                                        <div class="col-12"><span class="text-muted">Giá bán:</span> <span class="text-danger fw-bold fs-5"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</span></div>
                                                    </div>
                                                    <div class="mt-3 pt-3 border-top">
                                                        <label class="fw-semibold text-dark small text-uppercase">Mô tả sản phẩm:</label>
                                                        <p class="text-secondary small mb-0 mt-1">${p.description != null ? p.description : 'Chưa có mô tả cho sản phẩm này.'}</p>
                                                    </div>
                                                    <c:if test="${not empty p.videoUrl}">
                                                        <div class="mt-2">
                                                            <a href="${p.videoUrl}" target="_blank" class="btn btn-sm btn-outline-danger rounded-pill px-3 mt-2">
                                                                <i class="bi bi-youtube me-1"></i> Xem video giới thiệu
                                                            </a>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>