<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Chỉnh sửa tài khoản' : 'Thêm tài khoản mới'} | Admin</title>

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
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.625rem 0.875rem;
            border-color: #cbd5e1;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        .input-group-text {
            border-radius: 10px 0 0 10px;
            background-color: #f8fafc;
            border-color: #cbd5e1;
            color: #64748b;
        }

        .has-left-icon .form-control {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }

        .btn-toggle-pwd {
            border-top-right-radius: 10px !important;
            border-bottom-right-radius: 10px !important;
            background-color: #f8fafc;
            border-color: #cbd5e1;
            color: #64748b;
        }

        .btn-toggle-pwd:hover {
            background-color: #e2e8f0;
            color: #334155;
        }

        .role-info-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 16px;
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
            <a href="${pageContext.request.contextPath}/manager/accounts" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                <i class="bi bi-arrow-left me-1"></i> Danh sách tài khoản
            </a>
        </div>
    </nav>

    <div class="container py-3" style="max-width: 580px;">

        <!-- CARD FORM -->
        <div class="card card-custom p-4 p-md-5 bg-white">

            <!-- Header -->
            <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom">
                <div class="d-flex align-items-center gap-3">
                    <div class="p-3 ${isEdit ? 'bg-warning-subtle text-warning' : 'bg-primary-subtle text-primary'} rounded-4 d-flex align-items-center justify-content-center">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-person-plus-fill'} fs-3"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold text-dark mb-0">${isEdit ? 'Chỉnh Sửa Tài Khoản' : 'Thêm Tài Khoản Mới'}</h4>
                        <small class="text-muted">${isEdit ? 'Cập nhật thông tin phân quyền & mật khẩu' : 'Tạo mới tài khoản người dùng hệ thống'}</small>
                    </div>
                </div>
            </div>

            <!-- Thống báo Lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                        <div>${error}</div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- FORM -->
            <form action="${pageContext.request.contextPath}/manager/${isEdit ? 'account-edit' : 'account-add'}" method="post">

                <c:if test="${isEdit}">
                    <input type="hidden" name="id" value="${account.accountID != null ? account.accountID : account.id}">
                </c:if>

                <!-- Username -->
                <div class="mb-4">
                    <label class="form-label fw-semibold text-dark">Tên đăng nhập (Username)</label>
                    <div class="input-group has-left-icon">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" name="username" class="form-control ${isEdit ? 'bg-light text-muted' : ''}"
                               placeholder="Nhập tên tài khoản..."
                               value="${account.username}" required ${isEdit ? 'readonly' : ''}>
                    </div>
                    <c:if test="${isEdit}">
                        <div class="form-text text-muted small"><i class="bi bi-info-circle me-1"></i>Tên đăng nhập không thể thay đổi.</div>
                    </c:if>
                </div>

                <!-- Password -->
                <div class="mb-4">
                    <label class="form-label fw-semibold text-dark">Mật khẩu</label>
                    <div class="input-group has-left-icon">
                        <span class="input-group-text"><i class="bi bi-key"></i></span>
                        <input type="password" id="passwordInput" name="password" class="form-control"
                               placeholder="${isEdit ? 'Để trống nếu không muốn thay đổi' : 'Nhập mật khẩu an toàn...'}"
                               ${isEdit ? '' : 'required'}>
                        <button class="btn btn-outline-secondary btn-toggle-pwd" type="button" onclick="togglePassword()">
                            <i class="bi bi-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>

                <!-- Role Selection -->
                <div class="mb-4">
                    <label class="form-label fw-semibold text-dark">Vai trò hệ thống (Role)</label>
                    <div class="input-group has-left-icon mb-2">
                        <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                        <select name="role" id="roleSelect" class="form-select fw-medium" required onchange="updateRoleBadge()">
                            <option value="Staff" ${account.role == 'Staff' ? 'selected' : ''}>Nhân viên (Staff)</option>
                            <option value="Manager" ${account.role == 'Manager' ? 'selected' : ''}>Quản trị viên (Manager)</option>
                            <option value="Customer" ${account.role == 'Customer' ? 'selected' : ''}>Khách hàng (Customer)</option>
                        </select>
                    </div>

                    <!-- Box hiển thị giải thích quyền hạn -->
                    <div class="role-info-box mt-2">
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-secondary" id="roleBadge">Quyền hạn</span>
                            <small class="text-muted" id="roleDesc">Chọn vai trò để xem quyền hạn chi tiết.</small>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/manager/accounts" class="btn btn-light px-4 rounded-pill fw-semibold border">
                        Hủy bỏ
                    </a>
                    <button type="submit" class="btn btn-primary px-4 rounded-pill fw-semibold shadow-sm">
                        <i class="bi bi-check-lg me-1"></i> ${isEdit ? 'Lưu thay đổi' : 'Tạo tài khoản'}
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Script xử lý Toggle Password & Role Info -->
    <script>
        // 1. Chức năng Ẩn/Hiện mật khẩu
        function togglePassword() {
            const pwdInput = document.getElementById('passwordInput');
            const icon = document.getElementById('toggleIcon');
            if (pwdInput.type === 'password') {
                pwdInput.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                pwdInput.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }

        // 2. Chức năng mô tả Role tự động
        function updateRoleBadge() {
            const role = document.getElementById('roleSelect').value;
            const badge = document.getElementById('roleBadge');
            const desc = document.getElementById('roleDesc');

            if (role === 'Manager') {
                badge.className = 'badge bg-danger';
                badge.innerText = 'Manager';
                desc.innerText = 'Toàn quyền quản lý hệ thống, báo cáo và tài khoản.';
            } else if (role === 'Staff') {
                badge.className = 'badge bg-primary';
                badge.innerText = 'Staff';
                desc.innerText = 'Quản lý kho, đơn hàng và xử lý yêu cầu khách hàng.';
            } else {
                badge.className = 'badge bg-success';
                badge.innerText = 'Customer';
                desc.innerText = 'Tài khoản người dùng mua sắm dịch vụ.';
            }
        }

        // Chạy khi trang vừa tải xong
        document.addEventListener("DOMContentLoaded", function() {
            updateRoleBadge();
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>