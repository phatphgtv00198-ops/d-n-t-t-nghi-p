<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập | Cửa Hàng Điện Máy</title>

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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-card {
            border-radius: 24px;
            border: 1px solid #e2e8f0;
            background: #ffffff;
            box-shadow: 0 20px 30px -10px rgba(15, 23, 42, 0.08);
            overflow: hidden;
            width: 100%;
            max-width: 900px;
        }

        /* Side Banner */
        .auth-banner {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            color: #ffffff;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
        }

        .auth-banner::before {
            content: '';
            position: absolute;
            bottom: -20%;
            right: -20%;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            pointer-events: none;
        }

        /* Form Inputs Custom */
        .custom-input-group {
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            overflow: hidden;
            background-color: #f8fafc;
            transition: all 0.2s ease;
        }

        .custom-input-group:focus-within {
            border-color: #0d6efd;
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.15);
        }

        .custom-input-group .input-group-text,
        .custom-input-group .form-control,
        .custom-input-group .btn-toggle-pwd {
            background: transparent;
            border: none;
            box-shadow: none;
        }

        .custom-input-group .input-group-text {
            color: #64748b;
            padding-left: 1rem;
            padding-right: 0.5rem;
        }

        .custom-input-group .form-control {
            padding: 0.75rem 0.75rem 0.75rem 0;
            font-size: 0.95rem;
            color: #1e293b;
        }

        .custom-input-group .btn-toggle-pwd {
            color: #64748b;
            padding-right: 1rem;
        }

        .custom-input-group .btn-toggle-pwd:hover {
            color: #0d6efd;
        }

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
    </style>
</head>
<body>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="auth-card mx-auto">
                <div class="row g-0">

                    <!-- 🎨 CỘT TRÁI: BANNER THƯƠNG HIỆU -->
                    <div class="col-lg-5 d-none d-lg-flex auth-banner">
                        <div>
                            <a href="${pageContext.request.contextPath}/home" class="text-white text-decoration-none fw-bold fs-4 d-flex align-items-center gap-2 mb-4">
                                <i class="bi bi-shop fs-3"></i> Điện Máy Store
                            </a>
                            <span class="badge bg-white text-primary px-3 py-2 rounded-pill fw-semibold mb-3">Tài khoản thành viên</span>
                            <h3 class="fw-bold mb-3">Chào mừng bạn quay trở lại!</h3>
                            <p class="opacity-75 small leading-relaxed">
                                Đăng nhập để trải nghiệm mua sắm thiết bị điện máy chính hãng, theo dõi đơn hàng và nhận nhiều ưu đãi hấp dẫn.
                            </p>
                        </div>

                        <div class="pt-4 border-top border-white border-opacity-25">
                            <div class="d-flex align-items-center gap-2 small opacity-90">
                                <i class="bi bi-shield-check fs-5 text-warning"></i>
                                <span>Bảo mật thông tin & Mua sắm an toàn 100%</span>
                            </div>
                        </div>
                    </div>

                    <!-- 📝 CỘT PHẢI: FORM ĐĂNG NHẬP -->
                    <div class="col-lg-7 p-4 p-md-5 d-flex flex-column justify-content-center">

                        <div class="mb-4">
                            <h3 class="fw-bold text-dark mb-1">Đăng Nhập</h3>
                            <p class="text-muted small">Vui lòng nhập thông tin tài khoản của bạn để tiếp tục.</p>
                        </div>

                        <!-- 🔔 THÔNG BÁO KHI ĐĂNG KÝ THÀNH CÔNG -->
                        <c:if test="${param.registered == 'true'}">
                            <div class="alert alert-success alert-dismissible fade show border-0 bg-success-subtle text-success-emphasis small mb-4 rounded-3" role="alert">
                                <i class="bi bi-check-circle-fill me-1"></i> Đăng ký tài khoản thành công! Vui lòng đăng nhập.
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- ⚠️ THÔNG BÁO LỖI TỪ LOGIN SERVLET -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show border-0 bg-danger-subtle text-danger-emphasis small mb-4 rounded-3" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- FORM ĐĂNG NHẬP -->
                        <form action="${pageContext.request.contextPath}/login" method="post">

                            <!-- Tên đăng nhập -->
                            <div class="mb-3">
                                <label for="username" class="form-label small fw-semibold text-secondary">Tên đăng nhập <span class="text-danger">*</span></label>
                                <div class="input-group custom-input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control" id="username" name="username" required placeholder="Nhập tên đăng nhập của bạn">
                                </div>
                            </div>

                            <!-- Mật khẩu -->
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <label for="password" class="form-label small fw-semibold text-secondary mb-0">Mật khẩu <span class="text-danger">*</span></label>
                                </div>
                                <div class="input-group custom-input-group">
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" required placeholder="Nhập mật khẩu">
                                    <button class="btn btn-toggle-pwd" type="button" id="togglePassword" aria-label="Hiện/Ẩn mật khẩu">
                                        <i class="bi bi-eye" id="toggleIcon"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Link Quên Mật Khẩu -->
                            <div class="d-flex justify-content-end mb-4">
                                <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none text-primary fw-medium">
                                    Quên mật khẩu?
                                </a>
                            </div>

                            <!-- Nút Submit -->
                            <div class="d-grid mb-4">
                                <button type="submit" class="btn btn-custom-primary text-white btn-lg fs-6">
                                    Đăng nhập <i class="bi bi-arrow-right ms-1"></i>
                                </button>
                            </div>
                        </form>

                        <hr class="my-3 opacity-25">

                        <!-- Điều hướng Đăng ký / Trang chủ -->
                        <div class="text-center small">
                            <span class="text-muted">Chưa có tài khoản?</span>
                            <a href="${pageContext.request.contextPath}/register" class="fw-bold text-primary text-decoration-none ms-1">
                                Đăng ký ngay
                            </a>
                        </div>

                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none small d-inline-flex align-items-center gap-1">
                                <i class="bi bi-arrow-left"></i> Quay lại trang chủ
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // JS Bật/Tắt ẩn hiện mật khẩu
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');
    const toggleIcon = document.querySelector('#toggleIcon');

    if (togglePassword) {
        togglePassword.addEventListener('click', function () {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            toggleIcon.classList.toggle('bi-eye');
            toggleIcon.classList.toggle('bi-eye-slash');
        });
    }
</script>
</body>
</html>