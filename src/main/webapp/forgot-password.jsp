<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu | Cửa Hàng Điện Máy</title>

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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-card {
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            background: #ffffff;
            box-shadow: 0 15px 35px rgba(15, 23, 42, 0.08);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
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
        .custom-input-group .form-control {
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

        .btn-submit {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border: none;
            border-radius: 12px;
            padding: 0.85rem;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(13, 110, 253, 0.3);
        }

        .back-link {
            color: #64748b;
            text-decoration: none;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6 d-flex justify-content-center">

            <div class="card auth-card border-0 p-4 p-sm-5">

                <!-- Icon Khóa / Key & Tiêu đề -->
                <div class="text-center mb-4">
                    <div class="auth-brand-icon">
                        <i class="bi bi-key-fill"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-1">Quên Mật Khẩu?</h4>
                    <p class="text-muted small mb-0 px-2">Nhập địa chỉ email đã đăng ký của bạn để nhận mã xác thực khôi phục tài khoản.</p>
                </div>

                <!-- ⚠️ THÔNG BÁO LỖI (NẾU CÓ) -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show border-0 bg-danger-subtle text-danger-emphasis small mb-4 rounded-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- FORM NHẬP EMAIL -->
                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <div class="mb-4">
                        <label for="email" class="form-label small fw-semibold text-secondary">Email tài khoản <span class="text-danger">*</span></label>
                        <div class="input-group custom-input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" required placeholder="name@gmail.com" autocomplete="off">
                        </div>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-submit text-white d-flex align-items-center justify-content-center gap-2">
                            <i class="bi bi-send-fill"></i> Gửi mã xác thực
                        </button>
                    </div>
                </form>

                <hr class="my-3 opacity-25">

                <!-- Quay lại đăng nhập -->
                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/login" class="back-link small d-inline-flex align-items-center gap-1 fw-medium">
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