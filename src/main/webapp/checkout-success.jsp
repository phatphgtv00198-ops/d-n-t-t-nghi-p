<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công | Cửa Hàng Gia Dụng</title>

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

        .navbar-custom {
            background-color: #ffffff;
            border-bottom: 1px solid #e2e8f0;
        }

        .success-card {
            border-radius: 20px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
        }

        /* Success Animated Icon Wrapper */
        .icon-box {
            width: 96px;
            height: 96px;
            background-color: #d1e7dd;
            color: #0f5132;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            position: relative;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(25, 135, 84, 0.3);
            }
            70% {
                box-shadow: 0 0 0 18px rgba(25, 135, 84, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(25, 135, 84, 0);
            }
        }

        /* Timeline Step Process */
        .order-step {
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            margin: 2rem 0 1.5rem 0;
            padding: 0 0.5rem;
        }

        .order-step::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 10%;
            right: 10%;
            height: 2px;
            background-color: #e2e8f0;
            z-index: 1;
            transform: translateY(-50%);
        }

        .step-item {
            position: relative;
            z-index: 2;
            background: #ffffff;
            padding: 0 8px;
            text-align: center;
        }

        .step-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 6px auto;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .step-active .step-icon {
            background-color: #198754;
            color: #ffffff;
        }

        .step-pending .step-icon {
            background-color: #f1f5f9;
            color: #94a3b8;
            border: 1px solid #cbd5e1;
        }

        /* Custom Button Hover */
        .btn-custom-primary {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border: none;
            border-radius: 12px;
            font-weight: 600;
            padding: 0.8rem 1.5rem;
            transition: all 0.2s;
        }

        .btn-custom-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.25);
        }

        .btn-custom-outline {
            border-radius: 12px;
            font-weight: 600;
            padding: 0.8rem 1.5rem;
            border: 1.5px solid #cbd5e1;
            color: #475569;
            transition: all 0.2s;
        }

        .btn-custom-outline:hover {
            background-color: #f8fafc;
            color: #0f172a;
            border-color: #94a3b8;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<!-- KIỂM TRA ĐĂNG NHẬP -->
<c:if test="${empty sessionScope.user}">
    <c:redirect url="/login"/>
</c:if>

<!-- 🌐 NAVBAR THU NHỎ -->
<nav class="navbar navbar-custom py-3 mb-4 shadow-sm">
    <div class="container justify-content-center">
        <a class="navbar-brand fw-bold text-primary fs-5 d-flex align-items-center gap-2 m-0" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-shop fs-4"></i> Cửa Hàng Gia Dụng
        </a>
    </div>
</nav>

<div class="container d-flex align-items-center justify-content-center min-vh-100 py-3">
    <div class="card p-4 p-md-5 text-center success-card" style="max-width: 620px; width: 100%;">

        <!-- ICON THÀNH CÔNG DẠNG ANIMATION PULSE -->
        <div class="icon-box mb-4">
            <i class="bi bi-check-lg fs-1"></i>
        </div>

        <h3 class="fw-bold text-success mb-2">Đặt Hàng Thành Công!</h3>
        <p class="text-secondary fs-6 mb-4">
            Cảm ơn <strong>${sessionScope.user.username}</strong> đã tin tưởng và mua sắm tại <strong>Cửa Hàng Gia Dụng</strong>.<br>
            Đơn hàng của bạn đã được tiếp nhận và đang trong quá trình xử lý.
        </p>

        <!-- HIỂN THỊ MÃ ĐƠN HÀNG -->
        <c:if test="${not empty orderId}">
            <div class="bg-light border rounded-3 p-3 mb-4 d-flex align-items-center justify-content-between">
                <span class="text-muted small fw-medium">
                    <i class="bi bi-receipt me-1"></i>Mã đơn hàng:
                </span>
                <span class="badge bg-danger-subtle text-danger fs-6 px-3 py-2 border border-danger-subtle rounded-pill fw-bold">
                    #${orderId}
                </span>
            </div>
        </c:if>

        <!-- TIẾN TRÌNH XỬ LÝ ĐƠN HÀNG (TIMELINE VISUAL) -->
        <div class="order-step">
            <div class="step-item step-active">
                <div class="step-icon">
                    <i class="bi bi-check"></i>
                </div>
                <div class="small fw-semibold text-dark">Đã đặt</div>
            </div>
            <div class="step-item step-active">
                <div class="step-icon">
                    <i class="bi bi-gear-fill"></i>
                </div>
                <div class="small fw-semibold text-dark">Xử lý</div>
            </div>
            <div class="step-item step-pending">
                <div class="step-icon">
                    <i class="bi bi-truck"></i>
                </div>
                <div class="small text-muted">Đang giao</div>
            </div>
            <div class="step-item step-pending">
                <div class="step-icon">
                    <i class="bi bi-box-2"></i>
                </div>
                <div class="small text-muted">Đã nhận</div>
            </div>
        </div>

        <div class="alert alert-info border-0 bg-info-subtle text-info-emphasis small py-2 mb-4">
            <i class="bi bi-info-circle-fill me-1"></i> Nhân viên sẽ liên hệ xác nhận đơn hàng sớm nhất có thể.
        </div>

        <hr class="my-4 text-muted opacity-25">

        <!-- CÁC NÚT ĐIỀU HƯỚNG -->
        <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
            <a href="${pageContext.request.contextPath}/order-history" class="btn btn-custom-outline btn-lg d-flex align-items-center justify-content-center gap-2">
                <i class="bi bi-clock-history"></i> Xem lịch sử đơn hàng
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-custom-primary text-white btn-lg d-flex align-items-center justify-content-center gap-2 shadow-sm">
                <i class="bi bi-house-door"></i> Tiếp tục mua sắm
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>