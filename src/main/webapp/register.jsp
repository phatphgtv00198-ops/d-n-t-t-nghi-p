<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản | Cửa Hàng Điện Máy</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
        }

        .auth-card {
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            background: #ffffff;
            box-shadow: 0 15px 35px rgba(15, 23, 42, 0.08);
            overflow: hidden;
        }

        .auth-brand-icon {
            width: 60px;
            height: 60px;
            background: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            margin: 0 auto 1rem;
        }

        .form-control, .input-group-text {
            border-color: #cbd5e1;
            padding: 0.75rem 1rem;
            border-radius: 12px;
            font-size: 0.95rem;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.15);
        }

        .input-group .form-control {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        .input-group .btn-toggle-pwd {
            border: 1px solid #cbd5e1;
            border-left: none;
            background: #ffffff;
            border-top-right-radius: 12px;
            border-bottom-right-radius: 12px;
            color: #64748b;
        }

        .btn-submit-register {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border: none;
            border-radius: 12px;
            padding: 0.85rem;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        .btn-submit-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(13, 110, 253, 0.3);
        }

        /* Avatar Preview Circle */
        .avatar-preview-box {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 2px dashed #cbd5e1;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background: #f8fafc;
            margin: 0 auto;
        }

        .avatar-preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .back-home-link {
            color: #64748b;
            text-decoration: none;
            transition: color 0.2s;
        }

        .back-home-link:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center py-5">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-5">

            <!-- Nút Quay về trang chủ -->
            <div class="mb-3 text-start">
                <a href="${pageContext.request.contextPath}/home" class="back-home-link small d-inline-flex align-items-center gap-1">
                    <i class="bi bi-arrow-left"></i> Quay lại trang chủ
                </a>
            </div>

            <!-- CARD ĐĂNG KÝ -->
            <div class="card auth-card border-0">
                <div class="card-body p-4 p-sm-5">

                    <!-- Icon Thương Hiệu & Tiêu Đề -->
                    <div class="text-center mb-4">
                        <div class="auth-brand-icon">
                            <i class="bi bi-person-plus-fill"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">Tạo Tài Khoản Mới</h4>
                        <p class="text-muted small mb-0">Đăng ký để trải nghiệm mua sắm tại Cửa Hàng Điện Máy</p>
                    </div>

                    <%-- Thông báo lỗi từ RegisterServlet (Giữ nguyên Java Scriptlet) --%>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm rounded-3 py-2.5 small d-flex align-items-center gap-2 mb-4" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-6"></i>
                            <div><%= request.getAttribute("error") %></div>
                            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>

                    <!-- FORM ĐĂNG KÝ -->
                    <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data" id="registerForm">

                        <!-- Tên đăng nhập -->
                        <div class="mb-3">
                            <label for="username" class="form-label small fw-semibold text-secondary">
                                Tên đăng nhập <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-white text-muted"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="username" name="username" required placeholder="Nhập tên đăng nhập">
                            </div>
                        </div>

                        <!-- Email (Dùng để khôi phục mật khẩu) -->
                        <div class="mb-3">
                            <label for="email" class="form-label small fw-semibold text-secondary">
                                Địa chỉ Email <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-white text-muted"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" required placeholder="nhapemail@gmail.com">
                            </div>
                        </div>

                        <!-- Mật khẩu -->
                        <div class="mb-3">
                            <label for="password" class="form-label small fw-semibold text-secondary">
                                Mật khẩu <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-white text-muted"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" required placeholder="Tạo mật khẩu">
                                <button class="btn btn-toggle-pwd" type="button" onclick="togglePassword('password', 'toggleIcon1')">
                                    <i class="bi bi-eye" id="toggleIcon1"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Xác nhận Mật khẩu -->
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label small fw-semibold text-secondary">
                                Xác nhận mật khẩu <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-white text-muted"><i class="bi bi-shield-lock"></i></span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required placeholder="Nhập lại mật khẩu">
                                <button class="btn btn-toggle-pwd" type="button" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                                    <i class="bi bi-eye" id="toggleIcon2"></i>
                                </button>
                            </div>
                            <div id="passwordError" class="text-danger small mt-1 d-none">
                                <i class="bi bi-x-circle me-1"></i> Mật khẩu xác nhận chưa trùng khớp.
                            </div>
                        </div>

                        <!-- Upload & Xem trước Ảnh đại diện -->
                        <div class="mb-4">
                            <label for="avatar" class="form-label small fw-semibold text-secondary">
                                Ảnh đại diện <span class="text-muted font-normal">(không bắt buộc)</span>
                            </label>

                            <!-- Khung preview avatar -->
                            <div class="text-center mb-2">
                                <div class="avatar-preview-box" id="avatarPreviewBox">
                                    <i class="bi bi-camera text-muted fs-4" id="avatarPlaceholder"></i>
                                    <img src="" id="avatarImage" class="d-none" alt="Preview Avatar">
                                </div>
                            </div>

                            <input type="file" class="form-control form-control-sm" id="avatar" name="avatar" accept="image/*" onchange="previewAvatar(this)">
                        </div>

                        <!-- Nút Đăng ký -->
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary btn-submit-register text-white d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-person-check-fill"></i> Đăng Ký TÀI KHOẢN
                            </button>
                        </div>
                    </form>

                    <hr class="my-4 opacity-25">

                    <!-- Chuyển sang Đăng nhập -->
                    <div class="text-center small">
                        <span class="text-muted">Đã có tài khoản?</span>
                        <a href="${pageContext.request.contextPath}/login" class="fw-bold text-primary text-decoration-none ms-1">
                            Đăng nhập ngay
                        </a>
                    </div>

                </div>
            </div>

            <!-- Footer bản quyền mỏng -->
            <div class="text-center text-muted small mt-4">
                &copy; 2026 Cửa Hàng Điện Máy. Tất cả quyền được bảo lưu.
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Ẩn/Hiện mật khẩu
    function togglePassword(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('bi-eye', 'bi-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('bi-eye-slash', 'bi-eye');
        }
    }

    // Live Preview Ảnh Đại Diện khi Chọn File
    function previewAvatar(input) {
        const previewBox = document.getElementById('avatarImage');
        const placeholder = document.getElementById('avatarPlaceholder');

        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                previewBox.src = e.target.result;
                previewBox.classList.remove('d-none');
                placeholder.classList.add('d-none');
            }
            reader.readAsDataURL(input.files[0]);
        } else {
            previewBox.classList.add('d-none');
            placeholder.classList.remove('d-none');
        }
    }

    // Validations mật khẩu khớp trước khi submit
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const pwd = document.getElementById('password').value;
        const confirmPwd = document.getElementById('confirmPassword').value;
        const errorDiv = document.getElementById('passwordError');

        if (pwd !== confirmPwd) {
            e.preventDefault();
            errorDiv.classList.remove('d-none');
        } else {
            errorDiv.classList.add('d-none');
        }
    });
</script>
</body>
</html>