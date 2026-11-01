<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu | Cửa Hàng Điện Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card border-0 shadow rounded-4 p-4" style="max-width: 420px; width: 100%;">
        <h4 class="fw-bold text-dark mb-2">Tạo Mật Khẩu Mới</h4>
        <p class="text-muted small mb-4">Nhập mật khẩu mới cho tài khoản của bạn.</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2 small"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <div class="mb-3">
                <label class="form-label small fw-semibold">Mật khẩu mới</label>
                <input type="password" name="newPassword" class="form-control" required minlength="6" placeholder="Tối thiểu 6 ký tự">
            </div>
            <button type="submit" class="btn btn-success w-100 py-2 fw-semibold rounded-3">Cập nhật mật khẩu</button>
        </form>
    </div>
</body>
</html>