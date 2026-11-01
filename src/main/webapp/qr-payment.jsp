<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quét Mã QR Thanh Toán | Cửa Hàng Điện Máy</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }
        .card-custom {
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 justify-content-center align-items-center py-5">

    <div class="container" style="max-width: 500px;">
        <div class="card card-custom p-4 text-center">

            <div class="mb-3">
                <div class="badge bg-primary-subtle text-primary p-3 rounded-circle mx-auto mb-2" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
                    <i class="bi bi-qr-code-scan fs-3"></i>
                </div>
                <h4 class="fw-bold text-dark">Thanh Toán Chuyển Khoản</h4>
                <p class="text-muted small">Mã đơn hàng của bạn: <strong class="text-primary">#${order.orderID}</strong></p>
            </div>

            <!-- Khung QR Code tự động ghép số tiền vào URL API VietQR -->
            <div class="bg-light p-3 rounded-4 border d-inline-block mx-auto mb-3 shadow-sm">
                <img src="https://img.vietqr.io/image/MB-0933099356-compact2.png?amount=${order.totalAmount}&addInfo=Thanh%20toan%20don%20hang%20${order.orderID}&accountName=PHAM%20HOANG%20GIA%20PHAT" alt="QR Code" class="img-fluid rounded" style="max-width: 240px;">
            </div>

            <!-- Thông tin tài khoản -->
            <div class="text-start bg-light p-3 rounded-3 small mb-3 border">
                <div class="d-flex justify-content-between mb-1.5">
                    <span class="text-muted">Ngân hàng:</span>
                    <strong class="text-dark">MB Bank</strong>
                </div>
                <div class="d-flex justify-content-between mb-1.5">
                    <span class="text-muted">Chủ tài khoản:</span>
                    <strong class="text-dark">PHAM HOANG GIA PHAT</strong>
                </div>
                <div class="d-flex justify-content-between mb-1.5">
                    <span class="text-muted">Số tài khoản:</span>
                    <strong class="text-primary font-monospace">0933099356</strong>
                </div>
                <div class="d-flex justify-content-between mb-1.5">
                    <span class="text-muted">Số tiền:</span>
                    <strong class="text-danger"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ</strong>
                </div>
                <div class="d-flex justify-content-between">
                    <span class="text-muted">Nội dung chuyển khoản:</span>
                    <strong class="text-dark">Thanh toan don hang ${order.orderID}</strong>
                </div>
            </div>

            <!-- THÔNG BÁO LỖI NẾU CHƯA NHẬN ĐƯỢC TIỀN -->
            <div id="paymentAlert" class="alert alert-danger p-2.5 small d-none mb-3 text-start fw-semibold">
                <i class="bi bi-exclamation-triangle-fill me-1"></i> <span id="paymentAlertText"></span>
            </div>

            <!-- Nút bấm kiểm tra thanh toán -->
            <div class="d-grid gap-2">
                <button type="button" id="btnCheckPayment" class="btn btn-success py-2.5 rounded-pill fw-semibold shadow-sm d-flex align-items-center justify-content-center gap-2" onclick="verifyBankPayment(${order.orderID})">
                    <i class="bi bi-shield-check fs-5"></i> Tôi đã chuyển khoản xong
                </button>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-light border py-2.5 rounded-pill fw-semibold text-secondary">
                    Quay về trang chủ
                </a>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function verifyBankPayment(orderId) {
            const btn = document.getElementById('btnCheckPayment');
            const alertBox = document.getElementById('paymentAlert');
            const alertText = document.getElementById('paymentAlertText');

            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Đang kiểm tra tài khoản...';
            alertBox.classList.add('d-none');

            fetch('${pageContext.request.contextPath}/api/check-payment?orderId=' + orderId)
                .then(response => response.json())
                .then(data => {
                    btn.disabled = false;
                    btn.innerHTML = '<i class="bi bi-shield-check fs-5"></i> Tôi đã chuyển khoản xong';

                    if (data.success) {
                        alert('✅ ' + data.message);
                        window.location.href = '${pageContext.request.contextPath}/order-history';
                    } else {
                        alertText.innerText = data.message;
                        alertBox.classList.remove('d-none');
                    }
                })
                .catch(err => {
                    btn.disabled = false;
                    btn.innerHTML = '<i class="bi bi-shield-check fs-5"></i> Tôi đã chuyển khoản xong';
                    alertText.innerText = "Lỗi kết nối kiểm tra ngân hàng. Vui lòng thử lại sau!";
                    alertBox.classList.remove('d-none');
                });
        }
    </script>
</body>
</html>