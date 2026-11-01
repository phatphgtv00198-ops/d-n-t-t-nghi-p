<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Điện Máy Admin</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts & Chart.js -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
            width: 52px;
            height: 52px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 14px;
        }

        .card-custom {
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.03);
        }

        .quick-action-btn {
            border-radius: 12px;
            padding: 0.8rem 1rem;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.2s;
            text-decoration: none;
        }

        .quick-action-btn:hover {
            transform: translateX(4px);
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
                <span>Điện Máy Admin</span>
            </a>
            <div class="d-flex align-items-center gap-2">
                <span class="text-light small d-none d-md-inline me-2">Xin chào, <strong>Admin</strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                    <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mb-5">

        <!-- HEADER BANNER -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Tổng Quan Hệ Thống Điện Máy</h3>
                <p class="text-muted small mb-0">Theo dõi báo cáo doanh thu, đơn hàng thiết bị điện máy và hoạt động kinh doanh</p>
            </div>
            <div>
                <span class="badge bg-white text-dark shadow-sm px-3 py-2 border rounded-pill">
                    <i class="bi bi-calendar3 text-primary me-1"></i> Hôm nay: <strong id="currentDate">--/--/----</strong>
                </span>
            </div>
        </div>

        <!-- 📊 4 THẺ THỐNG KÊ CHÍNH -->
        <div class="row g-3 mb-4">
            <!-- Doanh Thu -->
            <div class="col-md-3 col-sm-6">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-success-subtle text-success fs-3">
                            <i class="bi bi-cash-stack"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Doanh Thu</span>
                            <h4 class="fw-bold text-dark mt-1 mb-0">
                                <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" pattern="#,##0"/> đ
                            </h4>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tổng Đơn Hàng -->
            <div class="col-md-3 col-sm-6">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-primary-subtle text-primary fs-3">
                            <i class="bi bi-receipt"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Tổng Đơn Hàng</span>
                            <h4 class="fw-bold text-dark mt-1 mb-0">${totalOrders != null ? totalOrders : 0}</h4>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tổng Sản Phẩm -->
            <div class="col-md-3 col-sm-6">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-warning-subtle text-warning fs-3">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Thiết Bị Điện Máy</span>
                            <h4 class="fw-bold text-dark mt-1 mb-0">${totalProducts != null ? totalProducts : 0}</h4>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Khách Hàng -->
            <div class="col-md-3 col-sm-6">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-info-subtle text-info fs-3">
                            <i class="bi bi-people"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Khách Hàng</span>
                            <h4 class="fw-bold text-dark mt-1 mb-0">${totalCustomers != null ? totalCustomers : 0}</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 📈 BIỂU ĐỒ & QUICK ACTIONS -->
        <div class="row g-4 mb-4">
            <!-- Biểu Đồ Doanh Thu -->
            <div class="col-lg-8">
                <div class="card card-custom p-4 bg-white h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-dark mb-0"><i class="bi bi-bar-chart-line text-primary me-2"></i>Biểu Đồ Doanh Thu Điện Máy</h5>
                        <span class="badge bg-light text-secondary border">Năm 2026</span>
                    </div>
                    <div class="position-relative" style="height: 280px;">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Thao Tác Nhanh (Quick Actions) -->
            <div class="col-lg-4">
                <div class="card card-custom p-4 bg-white h-100">
                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-lightning-charge text-warning me-2"></i>Thao Tác Nhanh</h5>

                    <div class="d-flex flex-column gap-2">
                        <a href="${pageContext.request.contextPath}/staff/orders" class="quick-action-btn bg-primary-subtle text-primary">
                            <i class="bi bi-receipt-cutoff fs-4"></i>
                            <div>
                                <div class="fw-bold">Quản lý Đơn Hàng</div>
                                <div class="small opacity-75">Xem và phê duyệt đơn hàng mới</div>
                            </div>
                        </a>

                        <a href="${pageContext.request.contextPath}/staff/products" class="quick-action-btn bg-success-subtle text-success">
                            <i class="bi bi-box-seam-fill fs-4"></i>
                            <div>
                                <div class="fw-bold">Danh Sách Sản Phẩm</div>
                                <div class="small opacity-75">Quản lý giá và kho hàng điện máy</div>
                            </div>
                        </a>

                        <a href="${pageContext.request.contextPath}/staff/product-add" class="quick-action-btn bg-warning-subtle text-warning">
                            <i class="bi bi-plus-circle-fill fs-4"></i>
                            <div>
                                <div class="fw-bold">Thêm Sản Phẩm Mới</div>
                                <div class="small opacity-75">Đăng bán thiết bị điện máy mới</div>
                            </div>
                        </a>

                        <a href="${pageContext.request.contextPath}/admin/accounts" class="quick-action-btn bg-info-subtle text-info">
                            <i class="bi bi-person-gear fs-4"></i>
                            <div>
                                <div class="fw-bold">Quản Lý Tài Khoản</div>
                                <div class="small opacity-75">Phân quyền Nhân viên & Khách hàng</div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- 📜 JS SCRIPTS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hiển thị ngày hiện tại
        document.getElementById('currentDate').innerText = new Date().toLocaleDateString('vi-VN');

        // Biểu đồ Chart.js
        const ctx = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Thg 1', 'Thg 2', 'Thg 3', 'Thg 4', 'Thg 5', 'Thg 6', 'Thg 7', 'Thg 8'],
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: [12000000, 19000000, 15000000, 25000000, 22000000, 30000000, 28000000, 35000000],
                    borderColor: '#0d6efd',
                    backgroundColor: 'rgba(13, 110, 253, 0.08)',
                    fill: true,
                    tension: 0.35,
                    borderWidth: 3,
                    pointRadius: 4,
                    pointBackgroundColor: '#0d6efd'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: '#f1f5f9' },
                        ticks: {
                            callback: function(value) {
                                return (value / 1000000) + 'Tr';
                            }
                        }
                    },
                    x: { grid: { display: false } }
                }
            }
        });
    </script>
</body>
</html>