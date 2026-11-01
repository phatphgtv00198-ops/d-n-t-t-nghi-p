<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Quản Trị - Dashboard Admin</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --sidebar-width: 260px;
            --primary-color: #2563eb;
            --sidebar-bg: #0f172a;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f1f5f9;
            color: #334155;
        }

        /* Top Navbar Custom */
        .navbar-top {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            padding: 0.8rem 1.5rem;
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            background-color: #eff6ff;
            color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        /* Dashboard Stat Cards */
        .stat-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.06);
        }

        .icon-shape {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Action Nav Cards */
        .action-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 1.5rem;
            text-decoration: none;
            color: inherit;
            display: block;
            transition: all 0.2s ease-in-out;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .action-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.08);
            color: inherit;
        }

        .action-card.manager-only {
            border-top: 4px solid #dc3545;
        }

        .action-card.staff-access {
            border-top: 4px solid #0d6efd;
        }

        .action-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
            margin-bottom: 1rem;
        }

        .bg-blue-subtle { background-color: #eff6ff; color: #2563eb; }
        .bg-green-subtle { background-color: #f0fdf4; color: #16a34a; }
        .bg-purple-subtle { background-color: #faf5ff; color: #9333ea; }
        .bg-danger-subtle-custom { background-color: #fef2f2; color: #dc2626; }
    </style>
</head>
<body>

<!-- 🌐 NAVBAR TOP HEADER -->
<nav class="navbar navbar-expand-lg navbar-top sticky-top">
    <div class="container-fluid px-4">
        <!-- Đã sửa thành Cửa Hàng Điện Máy -->
        <a class="navbar-brand fw-bold text-primary fs-5 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/dashboard">
            <i class="bi bi-shop-window fs-4"></i> Cửa Hàng Điện Máy <span class="badge bg-primary-subtle text-primary border border-primary-subtle fs-7 rounded-pill ms-1">Admin</span>
        </a>

        <div class="d-flex align-items-center gap-3">
            <div class="d-flex align-items-center gap-2">
                <div class="user-avatar border">
                    <i class="bi bi-person-fill"></i>
                </div>
                <div class="d-none d-sm-block text-end">
                    <div class="fw-bold text-dark lh-1 small mb-1">${sessionScope.user.username}</div>
                    <span class="badge ${sessionScope.user.role == 'Manager' ? 'bg-danger' : 'bg-info text-dark'} me-1">
                        ${sessionScope.user.role}
                    </span>
                </div>
            </div>

            <div class="vr h-100 mx-1"></div>

            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-pill px-3 d-flex align-items-center gap-1">
                <i class="bi bi-box-arrow-right"></i> <span class="d-none d-md-inline">Đăng xuất</span>
            </a>
        </div>
    </div>
</nav>

<!-- 📦 MAIN CONTENT CONTAINER -->
<div class="container py-4 px-3 px-md-4" style="max-width: 1200px;">

    <!-- TIÊU ĐỀ TRANG -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">Tổng quan hệ thống</h3>
            <p class="text-secondary small mb-0">Theo dõi thông số kỹ thuật và các phím tắt quản lý nhanh.</p>
        </div>
        <span class="badge bg-white text-secondary border px-3 py-2 rounded-pill shadow-sm">
            <i class="bi bi-calendar3 me-1"></i> Dashboard
        </span>
    </div>

    <!-- 📊 KHU VỰC THẺ THỐNG KÊ (METRICS) -->
    <div class="row g-4 mb-5">

        <!-- Thẻ Thống kê Tổng số tài khoản -->
        <div class="col-12 col-md-4">
            <div class="card stat-card p-3">
                <div class="card-body p-2 d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-uppercase fw-semibold text-muted fs-7 tracking-wider">Tổng tài khoản</span>
                        <h2 class="fw-bold text-dark mt-2 mb-0">${totalAccounts != null ? totalAccounts : 0}</h2>
                    </div>
                    <div class="icon-shape bg-blue-subtle">
                        <i class="bi bi-people-fill fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thẻ Trạng thái hệ thống -->
        <div class="col-12 col-md-4">
            <div class="card stat-card p-3">
                <div class="card-body p-2 d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-uppercase fw-semibold text-muted fs-7 tracking-wider">Trạng thái máy chủ</span>
                        <h2 class="fw-bold text-success mt-2 mb-0 fs-3 d-flex align-items-center gap-2">
                            <i class="bi bi-circle-fill fs-6"></i> Hoạt động
                        </h2>
                    </div>
                    <div class="icon-shape bg-green-subtle">
                        <i class="bi bi-check-circle-fill fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thẻ Vai trò hiện tại -->
        <div class="col-12 col-md-4">
            <div class="card stat-card p-3">
                <div class="card-body p-2 d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-uppercase fw-semibold text-muted fs-7 tracking-wider">Quyền hạn truy cập</span>
                        <h3 class="fw-bold text-dark mt-2 mb-0">${sessionScope.user.role}</h3>
                    </div>
                    <div class="icon-shape bg-purple-subtle">
                        <i class="bi bi-shield-check fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- 🛠️ KHU VỰC PHÂN QUYỀN CHỨC NĂNG -->
    <div class="d-flex align-items-center justify-content-between mb-3">
        <h5 class="fw-bold text-dark mb-0">
            <i class="bi bi-grid-fill text-primary me-2"></i>Chức năng quản lý
        </h5>
    </div>

    <div class="row g-4">

        <%-- Chức năng dành cho Nhân viên & Manager (Staff + Manager) --%>
        <div class="col-12 col-sm-6 col-lg-3">
            <a href="${pageContext.request.contextPath}/staff/orders" class="action-card staff-access">
                <div class="action-icon bg-blue-subtle">
                    <i class="bi bi-receipt"></i>
                </div>
                <h6 class="fw-bold text-dark mb-1">Quản lý Đơn hàng</h6>
                <p class="text-muted small mb-0">Xem danh sách, duyệt đơn và cập nhật trạng thái giao hàng.</p>
                <span class="badge bg-light text-secondary border mt-3">Nhân viên & Manager</span>
            </a>
        </div>

        <div class="col-12 col-sm-6 col-lg-3">
            <a href="${pageContext.request.contextPath}/staff/products" class="action-card staff-access">
                <div class="action-icon bg-green-subtle">
                    <i class="bi bi-box-seam"></i>
                </div>
                <h6 class="fw-bold text-dark mb-1">Quản lý Sản phẩm</h6>
                <!-- Đã sửa thành sản phẩm điện máy -->
                <p class="text-muted small mb-0">Thêm mới, cập nhật giá và số lượng kho sản phẩm điện máy.</p>
                <span class="badge bg-light text-secondary border mt-3">Nhân viên & Manager</span>
            </a>
        </div>

        <%-- CHỈ MANAGER MỚI THẤY CÁC THẺ NÀY --%>
        <c:if test="${sessionScope.user.role == 'Manager'}">
            <div class="col-12 col-sm-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/manager/accounts" class="action-card manager-only">
                    <div class="action-icon bg-danger-subtle-custom">
                        <i class="bi bi-shield-lock"></i>
                    </div>
                    <h6 class="fw-bold text-dark mb-1">Quản lý Tài khoản</h6>
                    <p class="text-muted small mb-0">Tạo tài khoản nhân viên, cấp quyền và quản lý tài khoản người dùng.</p>
                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle mt-3">Chỉ Manager</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <a href="${pageContext.request.contextPath}/manager/reports" class="action-card manager-only">
                    <div class="action-icon bg-purple-subtle">
                        <i class="bi bi-bar-chart-line"></i>
                    </div>
                    <h6 class="fw-bold text-dark mb-1">Báo cáo Doanh thu</h6>
                    <p class="text-muted small mb-0">Thống kê doanh số bán hàng, tổng thu nhập và biểu đồ tăng trưởng.</p>
                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle mt-3">Chỉ Manager</span>
                </a>
            </div>
        </c:if>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>