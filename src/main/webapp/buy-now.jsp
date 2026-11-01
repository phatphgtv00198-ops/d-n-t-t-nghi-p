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

    <!-- 🌐 NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom py-3 mb-4 shadow-sm">
        <div class="container" style="max-width: 1100px;">
            <a class="navbar-brand fw-bold text-primary fs-5 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-shop fs-4"></i> Cửa Hàng Điện Máy
            </a>
            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="text-secondary small d-flex align-items-center gap-2">
                            <i class="bi bi-person-circle fs-5"></i>
                            <span>Tài khoản: <strong class="text-dark">${sessionScope.user.username}</strong></span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Nút kích hoạt Modal Đăng Nhập / Đăng Ký -->
                        <button type="button" class="btn btn-outline-primary btn-sm px-3 rounded-pill" data-bs-toggle="modal" data-bs-target="#loginModal">
                            <i class="bi bi-person me-1"></i> Đăng nhập
                        </button>
                        <button type="button" class="btn btn-primary btn-sm px-3 rounded-pill" data-bs-toggle="modal" data-bs-target="#registerModal">
                            Đăng ký
                        </button>
                    </c:otherwise>
                </c:choose>
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

                <!-- 2. THÔNG TIN NHẬN HÀNG -->
                <div class="card card-custom p-4 mb-4">
                    <div class="section-header">
                        <i class="bi bi-geo-alt-fill text-primary"></i> 2. Thông tin nhận hàng <span class="text-danger">*</span>
                    </div>

                    <div class="row g-3 mb-3">
                        <!-- Họ và tên người nhận -->
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">Họ và tên người nhận <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" id="fullNameInput" class="form-control" placeholder="Nhập họ và tên..." value="${customer.fullName}">
                            </div>
                        </div>

                        <!-- Số điện thoại -->
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">Số điện thoại <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-phone"></i></span>
                                <input type="tel" id="phoneInput" class="form-control" placeholder="Nhập số điện thoại..." value="${customer.phone}">
                            </div>
                        </div>
                    </div>

                    <!-- Địa chỉ chi tiết -->
                    <div class="mb-2">
                        <label class="form-label small fw-semibold text-secondary">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                        <textarea id="addressInput" class="form-control" rows="2"
                                  placeholder="Số nhà, tên đường, phường/xã, quận/huyện...">${customer.address}</textarea>

                        <div class="d-flex align-items-center gap-1 text-muted small mt-2">
                            <i class="bi bi-info-circle"></i>
                            <span>Vui lòng điền đầy đủ thông tin để Shipper liên hệ giao hàng thuận lợi.</span>
                        </div>

                        <div id="checkoutError" class="alert alert-danger border-0 p-2 mt-2 small fw-semibold d-none">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> <span id="errorMsgText">Vui lòng điền đầy đủ thông tin!</span>
                        </div>
                    </div>
                </div>

                <!-- 3. PHƯƠNG THỨC THANH TOÁN -->
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

                    <!-- KHUNG HIỂN THỊ MÃ QR NGÂN HÀNG (Ẩn mặc định, tự hiện khi chọn Chuyển khoản) -->
                    <div id="qrCodeContainer" class="card border-primary bg-light p-3 mt-3 d-none">
                        <div class="text-center">
                            <h6 class="fw-bold text-primary mb-2"><i class="bi bi-qr-code-scan me-1"></i> Quét mã QR để thanh toán</h6>
                            <p class="text-muted small mb-2">Sử dụng App Ngân hàng hoặc Ví điện tử bất kỳ để quét mã</p>

                            <!-- Ảnh QR gọi trực tiếp từ VietQR API -->
                            <div class="bg-white p-2 d-inline-block rounded-3 border shadow-sm">
                                <img id="vietQrImg" src="" alt="Mã QR Chuyển Khoản" style="width: 200px; height: 200px; object-fit: contain;">
                            </div>

                            <div class="mt-2 text-start small bg-white p-2 rounded border">
                                <div><strong>Ngân hàng:</strong> MB Bank</div>
                                <div><strong>Chủ tài khoản:</strong> PHAM HOANG GIA PHAT</div>
                                <div><strong>Số tài khoản:</strong> <span class="text-primary fw-bold">0933099356</span></div>
                                <div><strong>Số tiền:</strong> <span id="qrAmountText" class="text-danger fw-bold">0 VNĐ</span></div>
                                <div><strong>Nội dung:</strong> <span class="text-dark fw-semibold">Thanh toan don hang Dien May</span></div>
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
                        <input type="hidden" name="fullName" id="hiddenFullName">
                        <input type="hidden" name="phone" id="hiddenPhone">
                        <input type="hidden" name="address" id="hiddenAddress">
                        <input type="hidden" name="paymentMethod" id="hiddenPaymentMethod" value="COD">
                        <input type="hidden" name="action" value="confirmOrder">

                        <button type="button" class="btn btn-success btn-checkout w-100 text-white shadow-sm mb-3" onclick="handleCheckoutClick()">
                            <i class="bi bi-shield-check me-1"></i> Đặt Hàng Ngay
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.productID}" class="btn btn-light border w-100 rounded-pill text-secondary">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại chi tiết
                    </a>
                </div>
            </div>

        </div>
    </div>

    <!-- MODAL POP-UP XÁC NHẬN ĐẶT HÀNG -->
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
                    <p class="text-muted small mb-3">Vui lòng kiểm tra lại thông tin nhận hàng trước khi đồng ý.</p>

                    <div class="text-start bg-light p-3 rounded-3 border small">
                        <div class="mb-2"><strong>Sản phẩm:</strong> <span class="text-dark">${product.productName}</span></div>
                        <div class="mb-2"><strong>Số lượng:</strong> <span class="badge bg-secondary">${quantity}</span></div>
                        <div class="mb-2"><strong>Người nhận:</strong> <span id="modalFullNameText" class="text-dark fw-semibold"></span></div>
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

    <!-- SCRIPTS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Lắng nghe sự kiện thay đổi phương thức thanh toán để hiện/ẩn QR
        document.querySelectorAll('input[name="paymentOptionRadio"]').forEach(radio => {
            radio.addEventListener('change', function() {
                toggleQrBox(this.value);
            });
        });

        function toggleQrBox(paymentMethod) {
            let qrContainer = document.getElementById('qrCodeContainer');
            let qrImg = document.getElementById('vietQrImg');
            let qrAmountText = document.getElementById('qrAmountText');

            if (paymentMethod === 'BANK_TRANSFER') {
                qrContainer.classList.remove('d-none');

                // Lấy tổng số tiền từ backend chuyển xuống
                let rawAmount = ${totalAmount};

                // Hiển thị số tiền định dạng VNĐ
                qrAmountText.innerText = new Intl.NumberFormat('vi-VN').format(rawAmount) + ' VNĐ';

                // Cấu hình thông tin ngân hàng của bạn
                let bankId = "MB";                    // Mã ngân hàng (MB, VCB, TCB,...)
                let accountNo = "0933099356";          // Số tài khoản của bạn
                let template = "compact2";            // Kiểu hiển thị QR
                let addInfo = "Thanh toan don hang Dien May"; // Nội dung

                // Tạo URL VietQR tự động sinh số tiền
                let qrUrl = `https://img.vietqr.io/image/\${bankId}-\${accountNo}-\${template}.png?amount=\${rawAmount}&addInfo=\${encodeURIComponent(addInfo)}`;
                qrImg.src = qrUrl;
            } else {
                qrContainer.classList.add('d-none');
            }
        }

        function handleCheckoutClick() {
            let fullNameInput = document.getElementById('fullNameInput');
            let phoneInput = document.getElementById('phoneInput');
            let addressInput = document.getElementById('addressInput');

            let fullNameVal = fullNameInput.value.trim();
            let phoneVal = phoneInput.value.trim();
            let addressVal = addressInput.value.trim();

            // 1. Kiểm tra Họ tên
            if (fullNameVal === '') {
                showError('Vui lòng nhập họ và tên người nhận!', fullNameInput);
                return;
            }

            // 2. Kiểm tra Số điện thoại (10-11 chữ số)
            let phoneRegex = /^[0-9]{10,11}$/;
            if (!phoneRegex.test(phoneVal)) {
                showError('Số điện thoại không hợp lệ (phải gồm 10-11 chữ số)!', phoneInput);
                return;
            }

            // 3. Kiểm tra Địa chỉ
            if (addressVal === '' || addressVal.length < 10) {
                showError('⚠️ Vui lòng nhập địa chỉ chi tiết (Số nhà, tên đường, phường/xã) để giao hàng chính xác!', addressInput);
                return;
            }

            // Ẩn thông báo lỗi nếu dữ liệu hợp lệ
            let errorDiv = document.getElementById('checkoutError');
            if (errorDiv) errorDiv.classList.add('d-none');
            fullNameInput.classList.remove('is-invalid');
            phoneInput.classList.remove('is-invalid');
            addressInput.classList.remove('is-invalid');

            // Lấy phương thức thanh toán đang chọn
            let selectedPayment = document.querySelector('input[name="paymentOptionRadio"]:checked');
            let paymentVal = selectedPayment ? selectedPayment.value : 'COD';

            // Gán dữ liệu vào các thẻ input ẩn của form
            document.getElementById('hiddenFullName').value = fullNameVal;
            document.getElementById('hiddenPhone').value = phoneVal;
            document.getElementById('hiddenAddress').value = addressVal;
            document.getElementById('hiddenPaymentMethod').value = paymentVal;

            // Đưa thông tin lên Modal xác nhận
            document.getElementById('modalFullNameText').innerText = fullNameVal + ' (' + phoneVal + ')';
            document.getElementById('modalAddressText').innerText = addressVal;
            document.getElementById('modalPaymentText').innerText = (paymentVal === 'BANK_TRANSFER') ? 'Chuyển khoản QR / Ví' : 'Thanh toán COD';

            let confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
            confirmModal.show();
        }

        function showError(message, inputElement) {
            let errorDiv = document.getElementById('checkoutError');
            let errorMsgText = document.getElementById('errorMsgText');
            if (errorDiv && errorMsgText) {
                errorMsgText.innerText = message;
                errorDiv.classList.remove('d-none');
            }
            if (inputElement) {
                inputElement.classList.add('is-invalid');
                inputElement.focus();
            }
        }

        function submitOrderForm() {
            document.getElementById('finalOrderForm').submit();
        }
    </script>
</body>
</html>