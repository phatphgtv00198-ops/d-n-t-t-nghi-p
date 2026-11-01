<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi Mật Khẩu & Hồ Sơ | Điện Máy Admin</title>

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

        .card-custom {
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        }

        .form-control {
            border-radius: 10px;
            padding: 0.65rem 0.9rem;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        .avatar-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #0d6efd 0%, #0b5ed7 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 700;
            margin: 0 auto;
        }

        .input-group-text {
            border-radius: 0 10px 10px 0;
            cursor: pointer;
            border: 1px solid #cbd5e1;
            border-left: none;
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
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </nav>

    <div class="container mb-5" style="max-width: 900px;">

        <!-- THÔNG BÁO LỖI / THÀNH CÔNG -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center">
                <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                <div>${errorMessage}</div>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center">
                <i class="bi bi-check-circle-fill fs-5 me-2"></i>
                <div>${successMessage}</div>
            </div>
        </c:if>

        <div class="row g-4">

            <!-- CỘT TRÁI: THÔNG TIN TÀI KHOẢN -->
            <div class="col-md-4">
                <div class="card card-custom p-4 bg-white text-center h-100">
                    <div class="avatar-circle shadow-sm mb-3">
                        <i class="bi bi-person"></i>
                    </div>
                    <h5 class="fw-bold text-dark mb-1">${user.fullName != null ? user.fullName : 'Admin User'}</h5>
                    <p class="text-muted small mb-2">${user.email != null ? user.email : 'admin@dienmay.com'}</p>
                    <div>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-3 py-1">
                            <i class="bi bi-shield-check me-1"></i>${user.role != null ? user.role : 'Quản trị viên'}
                        </span>
                    </div>

                    <hr class="my-4 text-muted opacity-25">

                    <div class="text-start small text-secondary">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tên đăng nhập:</span>
                            <strong class="text-dark">${user.username != null ? user.username : 'admin'}</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Trạng thái:</span>
                            <span class="text-success fw-bold"><i class="bi bi-dot"></i> Hoạt động</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Bảo mật:</span>
                            <strong class="text-dark">Mật khẩu</strong>
                        </div>
                    </div>
                </div>
            </div>

            <!-- CỘT PHẢI: FORM ĐỔI MẬT KHẨU -->
            <div class="col-md-8">
                <div class="card card-custom p-4 p-md-5 bg-white">
                    <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                        <div class="bg-primary-subtle text-primary p-3 rounded-circle d-flex align-items-center justify-content-center" style="width: 48px; height: 48px;">
                            <i class="bi bi-key-fill fs-4"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold text-dark mb-1">Đổi Mật Khẩu</h4>
                            <small class="text-muted">Cập nhật mật khẩu định kỳ để bảo mật tài khoản hệ thống điện máy</small>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/change-password" method="post">

                        <!-- Mật khẩu hiện tại -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="password" id="oldPassword" name="oldPassword" class="form-control" required placeholder="Nhập mật khẩu hiện tại...">
                                <span class="input-group-text bg-light text-muted" onclick="togglePassword('oldPassword', this)">
                                    <i class="bi bi-eye"></i>
                                </span>
                            </div>
                        </div>

                        <!-- Mật khẩu mới -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu mới <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="password" id="newPassword" name="newPassword" class="form-control" required minlength="6" placeholder="Tối thiểu 6 ký tự...">
                                <span class="input-group-text bg-light text-muted" onclick="togglePassword('newPassword', this)">
                                    <i class="bi bi-eye"></i>
                                </span>
                            </div>
                        </div>

                        <!-- Xác nhận mật khẩu mới -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required placeholder="Nhập lại mật khẩu mới...">
                                <span class="input-group-text bg-light text-muted" onclick="togglePassword('confirmPassword', this)">
                                    <i class="bi bi-eye"></i>
                                </span>
                            </div>
                        </div>

                        <!-- NÚT BẤM -->
                        <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light border rounded-pill px-4 fw-medium">
                                Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill px-4 fw-semibold shadow-sm">
                                <i class="bi bi-check2-circle me-1"></i> Cập Nhật Mật Khẩu
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>

    <!-- SCRIPT ẨN/HIỆN MẬT KHẨU -->
    <script>
        function togglePassword(inputId, iconContainer) {
            const input = document.getElementById(inputId);
            const icon = iconContainer.querySelector('i');

            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>