<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công | Cửa Hàng Điện Máy</title>

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

        /* --- STYLING CHO MODAL ĐĂNG NHẬP / ĐĂNG KÝ / QUÊN MẬT KHẨU --- */
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
            transition: all 0.2s ease;
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
<body>

<!-- 🌐 NAVBAR THU NHỎ -->
<nav class="navbar navbar-custom py-3 mb-4 shadow-sm">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold text-primary fs-5 d-flex align-items-center gap-2 m-0" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-shop fs-4"></i> Cửa Hàng Điện Máy
        </a>
        <div class="d-flex align-items-center gap-2">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="text-secondary small">
                        Xin chào, <strong class="text-dark">${sessionScope.user.username}</strong>
                    </span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-pill px-3 ms-2">
                        <i class="bi bi-box-arrow-right"></i>
                    </a>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-outline-primary btn-sm px-3 rounded-pill" data-bs-toggle="modal" data-bs-target="#loginModal">
                        Đăng nhập
                    </button>
                    <button type="button" class="btn btn-primary btn-sm px-3 rounded-pill" data-bs-toggle="modal" data-bs-target="#registerModal">
                        Đăng ký
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
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
            Cảm ơn <strong>${not empty sessionScope.user ? sessionScope.user.username : 'Quý khách'}</strong> đã tin tưởng và mua sắm tại <strong>Cửa Hàng Điện Máy</strong>.<br>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>