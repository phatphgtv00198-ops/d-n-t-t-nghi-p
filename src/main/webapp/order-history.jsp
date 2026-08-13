<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đơn Hàng | Gia Dụng Store</title>

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

        /* Order Card & Accordion Styling */
        .order-accordion-item {
            border: 1px solid #e2e8f0 !important;
            border-radius: 16px !important;
            overflow: hidden;
            background: #ffffff;
            transition: all 0.2s ease;
        }

        .order-accordion-item:hover {
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.04);
            border-color: #cbd5e1 !important;
        }

        .accordion-button {
            background-color: #ffffff;
            padding: 1.25rem 1.5rem;
            box-shadow: none !important;
        }

        .accordion-button:not(.collapsed) {
            background-color: #f8fafc;
            color: #0d6efd;
        }

        /* Product Image Container */
        .order-product-img {
            width: 56px;
            height: 56px;
            object-fit: contain;
            background-color: #f8fafc;
            border-radius: 10px;
            padding: 4px;
            border: 1px solid #e2e8f0;
        }

        /* Custom Badges */
        .badge-status {
            padding: 0.5em 0.85em;
            border-radius: 30px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .table-custom th {
            background-color: #f8fafc;
            color: #64748b;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem;
        }

        .table-custom td {
            padding: 1rem;
        }

        .btn-custom-outline {
            border-radius: 10px;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <!-- 🌐 NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom sticky-top py-2 shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary fs-4 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-shop fs-3"></i> Gia Dụng Store
            </a>

            <div class="d-flex align-items-center gap-2">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm btn-custom-outline d-flex align-items-center gap-1">
                    <i class="bi bi-house"></i>
                    <span class="d-none d-sm-inline">Trang chủ</span>
                </a>
                <a href="${pageContext.request.contextPath}/home#productList" class="btn btn-primary btn-sm btn-custom-outline d-flex align-items-center gap-1">
                    <i class="bi bi-bag-plus"></i>
                    <span>Tiếp tục mua sắm</span>
                </a>
            </div>
        </div>
    </nav>

    <!-- 📦 MAIN CONTAINER -->
    <div class="container mb-5" style="max-width: 960px;">

        <!-- Header Page -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h3 class="fw-bold mb-1 border-start border-primary border-4 ps-2 text-dark">Lịch Sử Đơn Hàng</h3>
                <p class="text-muted small mb-0 ps-2">Theo dõi và quản lý các đơn hàng bạn đã mua</p>
            </div>
        </div>

        <%-- 1. TRƯỜNG HỢP KHÔNG CÓ ĐƠN HÀNG --%>
        <c:if test="${empty orders}">
            <div class="text-center py-5 bg-white rounded-4 border shadow-sm">
                <i class="bi bi-receipt-cutoff fs-1 text-muted mb-3 d-block"></i>
                <h5 class="fw-bold text-dark mb-2">Chưa có đơn hàng nào</h5>
                <p class="text-muted small mb-4">Bạn chưa thực hiện giao dịch mua hàng nào tại Cửa Hàng Gia Dụng.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-custom-outline px-4 py-2">
                    <i class="bi bi-cart-plus me-1"></i> Khám phá sản phẩm ngay
                </a>
            </div>
        </c:if>

        <%-- 2. TRƯỜNG HỢP CÓ ĐƠN HÀNG --%>
        <c:if test="${not empty orders}">
            <div class="accordion d-flex flex-column gap-3" id="accordionOrders">
                <c:forEach var="order" items="${orders}" varStatus="loop">

                    <div class="accordion-item order-accordion-item shadow-sm">
                        <!-- HEADER CỦA ĐƠN HÀNG -->
                        <h2 class="accordion-header" id="heading${order.orderID}">
                            <button class="accordion-button ${loop.first ? '' : 'collapsed'}" type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapse${order.orderID}"
                                    aria-expanded="${loop.first ? 'true' : 'false'}"
                                    aria-controls="collapse${order.orderID}">

                                <div class="d-flex flex-wrap justify-content-between align-items-center w-100 me-3 gap-2">

                                    <!-- Mã Đơn & Ngày Đặt -->
                                    <div>
                                        <div class="d-flex align-items-center gap-2">
                                            <span class="fw-bold fs-6 text-dark">Đơn hàng #${order.orderID}</span>
                                        </div>
                                        <small class="text-muted">
                                            <i class="bi bi-calendar3 me-1"></i> Ngày đặt: ${order.formattedOrderDate}
                                        </small>
                                    </div>

                                    <!-- Tổng Tiền & Badge Trạng Thái -->
                                    <div class="d-flex align-items-center gap-3 ms-auto ms-sm-0">
                                        <div class="text-end me-1">
                                            <small class="text-muted d-none d-sm-block">Tổng tiền</small>
                                            <span class="fw-bold text-danger fs-6">
                                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> <small class="fs-7">VNĐ</small>
                                            </span>
                                        </div>

                                        <!-- Badge Trạng Thái -->
                                        <c:choose>
                                            <c:when test="${order.status.name() == 'Pending'}">
                                                <span class="badge badge-status bg-warning-subtle text-warning-emphasis border border-warning-subtle d-flex align-items-center gap-1">
                                                    <i class="bi bi-hourglass-split"></i> Chờ duyệt
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status.name() == 'Paid'}">
                                                <span class="badge badge-status bg-success-subtle text-success border border-success-subtle d-flex align-items-center gap-1">
                                                    <i class="bi bi-check-circle-fill"></i> Đã thanh toán
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status.name() == 'Cancelled'}">
                                                <span class="badge badge-status bg-danger-subtle text-danger border border-danger-subtle d-flex align-items-center gap-1">
                                                    <i class="bi bi-x-circle-fill"></i> Đã hủy
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-status bg-secondary-subtle text-secondary border border-secondary-subtle">
                                                    ${order.status}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                </div>
                            </button>
                        </h2>

                        <!-- BẢNG CHI TIẾT SẢN PHẨM BÊN TRONG -->
                        <div id="collapse${order.orderID}"
                             class="accordion-collapse collapse ${loop.first ? 'show' : ''}"
                             aria-labelledby="heading${order.orderID}"
                             data-bs-parent="#accordionOrders">

                            <div class="accordion-body p-3 p-md-4 border-top">
                                <h6 class="fw-bold text-secondary mb-3 d-flex align-items-center gap-2">
                                    <i class="bi bi-box-seam text-primary"></i> Danh sách sản phẩm mua
                                </h6>

                                <div class="table-responsive rounded-3 border">
                                    <table class="table table-custom align-middle mb-0">
                                        <thead>
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th class="text-center">Số lượng</th>
                                                <th class="text-end">Đơn giá</th>
                                                <th class="text-end">Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="detail" items="${order.orderDetails}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-3">
                                                            <!-- Hiển thị Ảnh Sản Phẩm (Linh hoạt URL / Local Upload) -->
                                                            <c:choose>
                                                                <c:when test="${not empty detail.product.thumbnailUrl && detail.product.thumbnailUrl.startsWith('http')}">
                                                                    <img src="${detail.product.thumbnailUrl}"
                                                                         alt="${detail.product.productName}"
                                                                         class="order-product-img"
                                                                         onerror="this.src='https://via.placeholder.com/100?text=No+Img';">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${pageContext.request.contextPath}/uploads/${not empty detail.product.thumbnailUrl ? detail.product.thumbnailUrl : 'default.jpg'}"
                                                                         alt="${detail.product.productName}"
                                                                         class="order-product-img"
                                                                         onerror="this.src='https://via.placeholder.com/100?text=No+Img';">
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <span class="fw-semibold text-dark text-truncate" style="max-width: 250px;" title="${detail.product.productName}">
                                                                ${detail.product.productName}
                                                            </span>
                                                        </div>
                                                    </td>
                                                    <td class="text-center fw-bold text-dark">${detail.quantity}</td>
                                                    <td class="text-end text-muted">
                                                        <fmt:formatNumber value="${detail.unitPrice}" pattern="#,##0"/> VNĐ
                                                    </td>
                                                    <td class="text-end fw-semibold text-primary">
                                                        <fmt:formatNumber value="${detail.quantity * detail.unitPrice}" pattern="#,##0"/> VNĐ
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot class="table-light">
                                            <tr>
                                                <td colspan="3" class="text-end fw-bold text-secondary">Tổng thanh toán:</td>
                                                <td class="text-end text-danger fw-bold fs-5">
                                                    <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>

                                <!-- NÚT HỦY ĐƠN HÀNG (Nếu đang Chờ duyệt - Pending) -->
                                <c:if test="${order.status.name() == 'Pending'}">
                                    <div class="d-flex justify-content-end mt-3 pt-2 border-top">
                                        <a href="${pageContext.request.contextPath}/cancel-order?id=${order.orderID}"
                                           class="btn btn-outline-danger btn-sm btn-custom-outline px-3 py-2 d-flex align-items-center gap-1"
                                           onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.orderID} này không?');">
                                            <i class="bi bi-x-circle"></i> Hủy đơn hàng này
                                        </a>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </div>

                </c:forEach>
            </div>
        </c:if>

    </div>

    <!-- 🦶 FOOTER -->
    <footer class="bg-white border-top py-4 mt-auto">
        <div class="container text-center text-muted small">
            <p class="mb-1">&copy; 2026 Cửa Hàng Gia Dụng. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>