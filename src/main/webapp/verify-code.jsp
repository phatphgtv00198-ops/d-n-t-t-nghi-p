<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực Mã OTP | Cửa Hàng Điện Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card border-0 shadow rounded-4 p-4" style="max-width: 420px; width: 100%;">
        <h4 class="fw-bold text-dark mb-2">Nhập Mã Xác Thực</h4>
        <p class="text-muted small mb-4">Mã OTP 6 số đã được gửi đến email của bạn.</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2 small"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/verify-code" method="post">
            <div class="mb-3">
                <input type="text" name="otp" class="form-control text-center fs-4 tracking-widest" required maxlength="6" placeholder="------">
            </div>
            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3">Xác nhận</button>
        </form>
    </div>
</body>
</html>