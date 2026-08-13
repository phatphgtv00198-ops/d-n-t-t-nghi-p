<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đơn Hàng | Mua Ngay</title>

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

        .card-custom {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
        }

        .section-header {
            font-size: 1.05rem;
            font-weight: 700;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .product-img {
            width: 80px;
            height: 80px;
            object-fit: contain;
            background-color: #ffffff;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 4px;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #cbd5e1;
            padding: 0.65rem 0.9rem;
            font-size: 0.95rem;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        /* Payment Select Option */
        .payment-card {
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .payment-card:hover {
            border-color: #0d6efd;
            background-color: #f0f7ff;
        }

        .btn-checkout {
            background: linear-gradient(135deg, #198754 0%, #157347 100%);
            border: none;
            border-radius: 10px;
            font-weight: 600;
            padding: 0.8rem 1.5rem;
            transition: all 0.2s;
        }

        .btn-checkout:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(25, 135, 84, 0.3);
            background: linear-gradient(135deg, #157347 0%, #0f5132 100%);
        }

        .summary-card {
            position: sticky;
            top: 20px;
        }
    </style>
</head>
<body>

    <!-- 🌐 NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom py-3 mb-4 shadow-sm">
        <div class="container" style="max-width: 1100px;">
            <a class="navbar-brand fw-bold text-primary fs-5 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-shop fs-4"></i> Cửa Hàng Gia Dụng
            </a>
            <div class="d-flex align-items-center gap-2 text-secondary small">
                <i class="bi bi-person-circle fs-5"></i>
                <span>Tài khoản: <strong class="text-dark">${sessionScope.user.username != null ? sessionScope.user.username : 'Khách hàng'}</strong></span>
            </div>
        </div>
    </nav>

    <!-- 📦 CONTAINER CHÍNH -->
    <div class="container mb-5" style="max-width: 1100px;">

        <div class="d-flex align-items-center justify-content-between mb-4">
            <h4 class="fw-bold mb-0 text-dark">
                <i class="bi bi-bag-check-fill text-primary me-2"></i>Xác Nhận Đơn Hàng
            </h4>
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-3 py-2">
                ⚡ Mua ngay
            </span>
        </div>

        <div class="row g-4">

            <!-- CỘT TRÁI: THÔNG TIN CHI TIẾT -->
            <div class="col-lg-7 col-xl-8">

                <!-- 1. SẢN PHẨM THANH TOÁN -->
                <div class="card card-custom p-4 mb-4">
                    <div class="section-header">
                        <i class="bi bi-box-seam text-primary"></i> 1. Sản phẩm thanh toán
                    </div>

                    <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 border">
                        <c:choose>
                            <c:when test="${not empty product.thumbnailUrl && product.thumbnailUrl.startsWith('http')}">
                                <img src="${product.thumbnailUrl}" alt="${product.productName}" class="product-img">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/uploads/${not empty product.thumbnailUrl ? product.thumbnailUrl : 'default.jpg'}"
                                     alt="${product.productName}" class="product-img">
                            </c:otherwise>
                        </c:choose>

                        <div class="flex-grow-1">
                            <h6 class="fw-bold mb-1 text-dark">${product.productName}</h6>
                            <div class="text-muted small">Đơn giá: <span class="fw-semibold text-dark"><fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ</span></div>
                            <div class="text-muted small">Số lượng: <strong class="text-dark">${quantity}</strong></div>
                        </div>

                        <div class="text-end">
                            <span class="small text-muted d-block">Thành tiền</span>
                            <h5 class="text-danger fw-bold mb-0">
                                <fmt:formatNumber value="${totalAmount}" pattern="#,##0"/> VNĐ
                            </h5>
                        </div>
                    </div>
                </div>

                <!-- 2. ĐỊA CHỈ NHẬN HÀNG -->
                <div class="card card-custom p-4 mb-4">
                    <div class="section-header">
                        <i class="bi bi-geo-alt-fill text-primary"></i> 2. Địa chỉ nhận hàng <span class="text-danger">*</span>
                    </div>

                    <div class="mb-2">
                        <textarea id="addressInput" class="form-control" rows="3"
                                  placeholder="Nhập địa chỉ nhận hàng chi tiết (Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành)...">${customer.address}</textarea>

                        <div class="d-flex align-items-center gap-1 text-muted small mt-2">
                            <i class="bi bi-info-circle"></i>
                            <span>Vui lòng ghi rõ tên đường, phường/xã để Shipper giao tận nơi.</span>
                        </div>

                        <div id="addressError" class="alert alert-danger border-0 p-2 mt-2 small fw-semibold d-none">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> Vui lòng nhập địa chỉ nhận hàng hợp lệ!
                        </div>
                    </div>
                </div>

                <!-- 3. PHƯƠNG THỨC THANH TOÁN (ĐÃ MỞ KHÓA QR) -->
                <div class="card card-custom p-4 mb-4">
                    <div class="section-header">
                        <i class="bi bi-credit-card-2-front-fill text-primary"></i> 3. Phương thức thanh toán
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="payment-card d-flex align-items-center gap-3">
                                <input class="form-check-input mt-0" type="radio" name="paymentOptionRadio" id="paymentCod" value="COD" checked>
                                <label class="form-check-label w-100" style="cursor: pointer;" for="paymentCod">
                                    <div class="fw-semibold text-dark"><i class="bi bi-cash-coin text-success me-1"></i> Thanh toán COD</div>
                                    <div class="text-muted small">Thanh toán khi nhận hàng</div>
                                </label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="payment-card d-flex align-items-center gap-3">
                                <input class="form-check-input mt-0" type="radio" name="paymentOptionRadio" id="paymentQr" value="BANK_TRANSFER">
                                <label class="form-check-label w-100" style="cursor: pointer;" for="paymentQr">
                                    <div class="fw-semibold text-dark"><i class="bi bi-qr-code-scan text-primary me-1"></i> Chuyển khoản QR / Ví</div>
                                    <div class="text-muted small">Quét mã qua App Ngân hàng</div>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- CỘT PHẢI: TÓM TẮT ĐƠN HÀNG -->
            <div class="col-lg-5 col-xl-4">
                <div class="card card-custom p-4 summary-card">
                    <h5 class="fw-bold mb-3 text-dark border-bottom pb-3">Tóm tắt đơn hàng</h5>

                    <div class="d-flex justify-content-between mb-2 text-muted">
                        <span>Tiền hàng:</span>
                        <span class="fw-semibold text-dark"><fmt:formatNumber value="${totalAmount}" pattern="#,##0"/> VNĐ</span>
                    </div>

                    <div class="d-flex justify-content-between mb-3 text-muted">
                        <span>Phí vận chuyển:</span>
                        <span class="text-success fw-semibold"><i class="bi bi-truck me-1"></i>Miễn phí</span>
                    </div>

                    <hr class="text-muted opacity-25">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold fs-6">Tổng thanh toán:</span>
                        <strong class="text-danger fs-4"><fmt:formatNumber value="${totalAmount}" pattern="#,##0"/> VNĐ</strong>
                    </div>

                    <!-- FORM SUBMIT ẨN -->
                    <form action="${pageContext.request.contextPath}/buy-now" method="post" id="finalOrderForm">
                        <input type="hidden" name="productId" value="${product.productID}">
                        <input type="hidden" name="quantity" value="${quantity}">
                        <input type="hidden" name="address" id="hiddenAddress">
                        <input type="hidden" name="paymentMethod" id="hiddenPaymentMethod" value="COD">
                        <input type="hidden" name="action" value="confirmOrder">

                        <button type="button" class="btn btn-success btn-checkout w-100 text-white shadow-sm mb-3" onclick="handleCheckoutClick()">
                            <i class="bi bi-shield-check me-1"></i> Thanh Toán Ngay
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.productID}" class="btn btn-light border w-100 rounded-pill text-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại chi tiết
                    </a>
                </div>
            </div>

        </div>
    </div>

    <!-- MODAL POP-UP XÁC NHẬN THANH TOÁN -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="modal-header bg-success text-white py-3">
                    <h5 class="modal-title fw-bold fs-6" id="confirmModalLabel">
                        <i class="bi bi-check-circle-fill me-2"></i>⚡ Xác nhận đặt hàng
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4 text-center">
                    <div class="badge bg-success-subtle text-success p-3 rounded-circle mb-3">
                        <i class="bi bi-cart-check-fill fs-1"></i>
                    </div>
                    <h5 class="fw-bold text-dark mb-1">Xác nhận hoàn tất đơn hàng?</h5>
                    <p class="text-muted small mb-3">Vui lòng kiểm tra lại địa chỉ giao hàng trước khi đồng ý.</p>

                    <div class="text-start bg-light p-3 rounded-3 border small">
                        <div class="mb-2"><strong>Sản phẩm:</strong> <span class="text-dark">${product.productName}</span></div>
                        <div class="mb-2"><strong>Số lượng:</strong> <span class="badge bg-secondary">${quantity}</span></div>
                        <div class="mb-2"><strong>Địa chỉ giao:</strong> <span id="modalAddressText" class="text-primary fw-semibold"></span></div>
                        <div class="mb-2"><strong>Thanh toán:</strong> <span id="modalPaymentText" class="text-success fw-semibold">Thanh toán COD</span></div>
                        <div class="pt-2 border-top"><strong>Tổng thanh toán:</strong> <span class="text-danger fw-bold fs-6"><fmt:formatNumber value="${totalAmount}" pattern="#,##0"/> VNĐ</span></div>
                    </div>
                </div>
                <div class="modal-footer bg-light justify-content-center border-0 py-3">
                    <button type="button" class="btn btn-light border rounded-pill px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                    <button type="button" class="btn btn-success rounded-pill px-4 fw-bold shadow-sm" onclick="submitOrderForm()">
                        <i class="bi bi-check2 me-1"></i> Đồng Ý Thanh Toán
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- SCRIPTS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function handleCheckoutClick() {
            let addressInput = document.getElementById('addressInput');
            let addressVal = addressInput.value.trim();

            if (addressVal === '') {
                showError('⚠️ Vui lòng nhập địa chỉ nhận hàng!');
                return;
            }

            if (addressVal.length < 10) {
                showError('⚠️ Địa chỉ quá ngắn! Vui lòng nhập chi tiết số nhà, tên đường, phường/xã, quận/huyện.');
                return;
            }

            let errorDiv = document.getElementById('addressError');
            if (errorDiv) errorDiv.classList.add('d-none');
            addressInput.classList.remove('is-invalid');

            // Lấy phương thức thanh toán đang chọn
            let selectedPayment = document.querySelector('input[name="paymentOptionRadio"]:checked');
            let paymentVal = selectedPayment ? selectedPayment.value : 'COD';

            document.getElementById('hiddenAddress').value = addressVal;
            document.getElementById('hiddenPaymentMethod').value = paymentVal;

            document.getElementById('modalAddressText').innerText = addressVal;
            document.getElementById('modalPaymentText').innerText = (paymentVal === 'BANK_TRANSFER') ? 'Chuyển khoản QR / Ví' : 'Thanh toán COD';

            let confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
            confirmModal.show();
        }

        function showError(message) {
            let addressInput = document.getElementById('addressInput');
            let errorDiv = document.getElementById('addressError');
            if (errorDiv) {
                errorDiv.innerHTML = message;
                errorDiv.classList.remove('d-none');
            }
            addressInput.classList.add('is-invalid');
            addressInput.focus();
        }

        function submitOrderForm() {
            document.getElementById('finalOrderForm').submit();
        }
    </script>
</body>
</html>