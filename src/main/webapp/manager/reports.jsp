<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo doanh thu | Admin</title>

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
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08) !important;
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
            border-radius: 16px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.03);
        }

        /* Rank Badge Colors */
        .rank-1 { background-color: #fef3c7; color: #d97706; }
        .rank-2 { background-color: #f1f5f9; color: #475569; }
        .rank-3 { background-color: #ffedd5; color: #c2410c; }
        .rank-default { background-color: #f8fafc; color: #64748b; }
    </style>
</head>
<body>

    <!-- 🌐 NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4 py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold fs-5 d-flex align-items-center gap-2" href="#">
                <div class="bg-success text-white p-2 rounded-3 d-flex align-items-center justify-content-center" style="width:36px; height:36px;">
                    <i class="bi bi-shop"></i>
                </div>
                <span>Gia Dụng Admin</span>
            </a>
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                    <i class="bi bi-speedometer2 me-1"></i> Dashboard
                </a>
            </div>
        </div>
    </nav>

    <div class="container mb-5">

        <!-- 📑 HEADER & BỘ LỌC THỜI GIAN -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="bi bi-graph-up-arrow text-success me-2"></i> Báo Cáo Doanh Thu
                </h3>
                <p class="text-muted small mb-0">Theo dõi tăng trưởng doanh số và hiệu suất bán hàng thực tế</p>
            </div>

            <form action="${pageContext.request.contextPath}/manager/reports" method="GET" class="d-flex align-items-center gap-2 bg-white p-2 rounded-4 shadow-sm border">
                <i class="bi bi-calendar3 text-muted ms-2"></i>
                <select name="filter" class="form-select form-select-sm border-0 bg-transparent fw-medium pe-4" onchange="this.form.submit()" style="cursor: pointer;">
                    <option value="this_month" ${selectedFilter == 'this_month' ? 'selected' : ''}>Tháng này</option>
                    <option value="last_month" ${selectedFilter == 'last_month' ? 'selected' : ''}>Tháng trước</option>
                    <option value="this_year" ${selectedFilter == 'this_year' ? 'selected' : ''}>Năm nay</option>
                </select>
            </form>
        </div>

        <!-- 📈 KHỐI THỐNG KÊ TỔNG QUAN -->
        <div class="row g-3 mb-4">
            <!-- Doanh thu -->
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-success-subtle text-success fs-4">
                            <i class="bi bi-currency-dollar"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase tracking-wide">
                                Doanh thu (${selectedFilter == 'this_year' ? 'Năm nay' : (selectedFilter == 'last_month' ? 'Tháng trước' : 'Tháng này')})
                            </span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">
                                <fmt:formatNumber value="${not empty monthlyRevenue ? monthlyRevenue : 0}" type="currency" currencySymbol="đ"/>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Đơn hàng thành công -->
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-primary-subtle text-primary fs-4">
                            <i class="bi bi-bag-check-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase tracking-wide">Đơn hàng thành công</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">
                                ${not empty completedOrders ? completedOrders : 0} <span class="fs-6 fw-normal text-muted">đơn</span>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sản phẩm đã bán -->
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-warning-subtle text-warning fs-4">
                            <i class="bi bi-box-seam-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase tracking-wide">Sản phẩm đã bán</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">
                                ${not empty soldProducts ? soldProducts : 0} <span class="fs-6 fw-normal text-muted">SP</span>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 📊 BIỂU ĐỒ DOANH THU & TOP BÁN CHẠY -->
        <div class="row g-4">
            <!-- Biểu đồ tăng trưởng -->
            <div class="col-lg-8">
                <div class="card card-custom p-4 bg-white h-100">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h5 class="fw-bold text-dark mb-1">
                                <i class="bi bi-bar-chart-line text-primary me-2"></i>Biểu đồ tăng trưởng
                            </h5>
                            <small class="text-muted">Biến động doanh thu qua các tháng trong năm</small>
                        </div>
                        <span class="badge bg-light text-secondary border px-3 py-2 rounded-pill font-monospace">
                            <i class="bi bi-clock-history me-1"></i>12 Tháng
                        </span>
                    </div>
                    <div style="position: relative; height:320px;">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Top Sản Phẩm Bán Chạy -->
            <div class="col-lg-4">
                <div class="card card-custom p-4 bg-white h-100">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-trophy-fill text-warning me-2"></i>Top Bán Chạy
                        </h5>
                        <small class="text-muted">Top 5</small>
                    </div>

                    <c:choose>
                        <c:when test="${empty topProducts}">
                            <div class="d-flex flex-column align-items-center justify-content-center h-75 text-muted py-5">
                                <i class="bi bi-inbox fs-1 text-secondary opacity-50 mb-2"></i>
                                <p class="mb-0 fw-medium">Chưa có dữ liệu bán hàng!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="list-group list-group-flush">
                                <c:forEach var="p" items="${topProducts}" varStatus="status">
                                    <div class="list-group-item border-0 d-flex align-items-center justify-content-between px-0 py-3">
                                        <div class="d-flex align-items-center gap-3 me-2" style="min-width: 0;">
                                            <!-- Rank Badge -->
                                            <span class="badge rounded-circle p-2 d-flex align-items-center justify-content-center fw-bold
                                                ${status.count == 1 ? 'rank-1' : (status.count == 2 ? 'rank-2' : (status.count == 3 ? 'rank-3' : 'rank-default'))}"
                                                style="width: 32px; height: 32px; flex-shrink: 0;">
                                                #${status.count}
                                            </span>
                                            <div class="text-truncate">
                                                <strong class="d-block text-dark text-truncate small fw-semibold" title="${p.productName}">
                                                    ${p.productName}
                                                </strong>
                                                <small class="text-muted">Đã bán: <span class="fw-semibold text-dark">${p.quantity}</span></small>
                                            </div>
                                        </div>
                                        <div class="text-end" style="flex-shrink: 0;">
                                            <span class="badge bg-success-subtle text-success fw-bold px-2.5 py-1.5 rounded-pill">
                                                <fmt:formatNumber value="${p.totalPrice}" type="currency" currencySymbol="đ"/>
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </div>

    <!-- 📊 SCRIPT KHỞI TẠO CHART.JS GRADIENT -->
    <script>
        const ctx = document.getElementById('revenueChart').getContext('2d');

        // Tạo Gradient hiệu ứng cho đồ thị
        const gradient = ctx.createLinearGradient(0, 0, 0, 300);
        gradient.addColorStop(0, 'rgba(25, 135, 84, 0.35)');
        gradient.addColorStop(1, 'rgba(25, 135, 84, 0.0)');

        // Dùng EL biểu thức trực tiếp (đã xử lý null an toàn)
        const rawData = ${not empty chartData ? chartData : "[0,0,0,0,0,0,0,0,0,0,0,0]"};
        const rawLabels = ${not empty chartLabels ? chartLabels : "['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12']"};

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: rawLabels,
                datasets: [{
                    label: 'Doanh thu',
                    data: rawData,
                    borderColor: '#198754',
                    borderWidth: 3,
                    backgroundColor: gradient,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 5,
                    pointHoverRadius: 8,
                    pointBackgroundColor: '#198754',
                    pointHoverBackgroundColor: '#ffffff',
                    pointHoverBorderColor: '#198754',
                    pointHoverBorderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: '#0f172a',
                        titleFont: { size: 13, family: 'Inter' },
                        bodyFont: { size: 14, weight: 'bold', family: 'Inter' },
                        padding: 12,
                        cornerRadius: 10,
                        displayColors: false,
                        callbacks: {
                            label: function(context) {
                                let value = context.raw || 0;
                                return ' Doanh thu: ' + value.toLocaleString('vi-VN') + ' đ';
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { font: { family: 'Inter' }, color: '#64748b' }
                    },
                    y: {
                        beginAtZero: true,
                        grid: { color: '#f1f5f9' },
                        ticks: {
                            font: { family: 'Inter' },
                            color: '#64748b',
                            callback: function(value) {
                                if (value >= 1000000) {
                                    return (value / 1000000) + ' tr';
                                }
                                return value.toLocaleString('vi-VN') + ' đ';
                            }
                        }
                    }
                }
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>