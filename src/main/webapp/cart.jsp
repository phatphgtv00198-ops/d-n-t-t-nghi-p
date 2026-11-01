<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng Của Bạn</title>

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
            overflow: hidden;
        }

        .product-img {
            width: 68px;
            height: 68px;
            object-fit: contain;
            background-color: #ffffff;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            padding: 4px;
        }

        .form-check-input {
            width: 1.25em;
            height: 1.25em;
            cursor: pointer;
        }

        .qty-group {
            width: 110px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            overflow: hidden;
            background: #ffffff;
        }

        .qty-btn {
            border: none;
            background: transparent;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #475569;
            transition: background 0.2s;
        }

        .qty-btn:hover {
            background: #f1f5f9;
            color: #0f172a;
        }

        .qty-input {
            border: none;
            text-align: center;
            font-weight: 600;
            font-size: 0.95rem;
            width: 46px;
            background: transparent;
        }

        .qty-input:focus {
            outline: none;
            box-shadow: none;
        }

        .btn-checkout {
            background: linear-gradient(135deg, #198754 0%, #157347 100%);
            border: none;
            border-radius: 10px;
            font-weight: 600;
            padding: 0.75rem 1.75rem;
            transition: all 0.2s;
        }

        .btn-checkout:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(25, 135, 84, 0.25);
            background: linear-gradient(135deg, #157347 0%, #0f5132 100%);
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #cbd5e1;
            padding: 0.65rem 0.9rem;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        /* Payment Select Option Style */
        .payment-card {
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.85rem 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .payment-card:hover {
            border-color: #0d6efd;
            background-color: #f0f7ff;
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
        <div class="d-flex align-items-center gap-3">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="text-secondary small">
                        <i class="bi bi-person-circle fs-6 me-1"></i>
                        Xin chào, <strong class="text-dark">${sessionScope.user.username}</strong>
                    </span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-pill px-3">
                        <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                    </a>
                </c:when>
                <c:otherwise>
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

<!-- 📦 MAIN CONTAINER -->
<div class="container mb-5" style="max-width: 1100px;">

    <div class="d-flex align-items-center justify-content-between mb-4">
        <h4 class="fw-bold text-dark mb-0">
            <i class="bi bi-cart3 text-primary me-2"></i>Giỏ Hàng Của Bạn
        </h4>
    </div>

    <c:choose>
        <c:when test="${not empty cartList}">
            <!-- BẢNG GIỎ HÀNG CHỨA DANH SÁCH SẢN PHẨM -->
            <div class="card card-custom mb-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light border-bottom">
                            <tr class="text-secondary small text-uppercase">
                                <th class="text-center py-3" style="width: 50px;">
                                    <input type="checkbox" id="selectAll" class="form-check-input" checked onclick="toggleSelectAll(this)">
                                </th>
                                <th class="py-3">Sản phẩm</th>
                                <th class="py-3">Đơn giá</th>
                                <th class="text-center py-3" style="width: 140px;">Số lượng</th>
                                <th class="text-end py-3">Thành tiền</th>
                                <th class="text-center py-3" style="width: 90px;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartList}">
                                <c:set var="itemTotal" value="${item.product.price * item.quantity}"/>
                                <tr>
                                    <td class="text-center">
                                        <input type="checkbox" name="selectedCartIds" value="${item.cartID}"
                                               class="form-check-input item-checkbox"
                                               id="chk_${item.cartID}"
                                               data-price="${item.product.price}"
                                               checked onclick="calculateTotal()">
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <c:choose>
                                                <c:when test="${not empty item.product.thumbnailUrl && item.product.thumbnailUrl.startsWith('http')}">
                                                    <img src="${item.product.thumbnailUrl}" alt="${item.product.productName}" class="product-img">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/uploads/${not empty item.product.thumbnailUrl ? item.product.thumbnailUrl : 'default.jpg'}"
                                                         alt="${item.product.productName}" class="product-img">
                                                </c:otherwise>
                                            </c:choose>
                                            <div>
                                                <h6 class="mb-0 fw-bold text-dark">${item.product.productName}</h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="fw-medium text-secondary">
                                        <fmt:formatNumber value="${item.product.price}" pattern="#,##0"/> VNĐ
                                    </td>
                                    <td class="text-center">
                                        <div class="qty-group d-flex align-items-center mx-auto">
                                            <button class="qty-btn" type="button" onclick="changeQuantity(${item.cartID}, -1, ${item.product.price})">-</button>
                                            <input type="number" id="qty_${item.cartID}" value="${item.quantity}" min="1"
                                                   class="qty-input"
                                                   onchange="onQuantityInputChange(${item.cartID}, ${item.product.price})">
                                            <button class="qty-btn" type="button" onclick="changeQuantity(${item.cartID}, 1, ${item.product.price})">+</button>
                                        </div>
                                    </td>
                                    <td class="text-end fw-bold text-danger fs-6">
                                        <span id="subtotal_${item.cartID}">
                                            <fmt:formatNumber value="${itemTotal}" pattern="#,##0"/>
                                        </span> VNĐ
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/cart-remove?id=${item.cartID}"
                                           class="btn btn-light btn-sm text-danger border-0 rounded-circle"
                                           title="Xóa sản phẩm"
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                            <i class="bi bi-trash3 fs-6"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- THANH TỔNG TIỀN VÀ NÚT THANH TOÁN -->
            <div class="card card-custom p-4">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary rounded-pill px-4">
                        <i class="bi bi-arrow-left me-1"></i> Tiếp tục mua sắm
                    </a>

                    <div class="d-flex align-items-center gap-4 text-end">
                        <div>
                            <span class="text-muted d-block small">Tổng thanh toán tạm tính:</span>
                            <h4 class="mb-0 text-danger fw-bold"><span id="displayTotal">0 VNĐ</span></h4>
                        </div>
                        <button type="button" class="btn btn-success btn-checkout text-white rounded-pill shadow-sm" onclick="openCheckoutModal()">
                            <i class="bi bi-credit-card me-1"></i> Thanh Toán Món Đã Chọn
                        </button>
                    </div>
                </div>
            </div>

        </c:when>

        <c:otherwise>
            <!-- GIỎ HÀNG TRỐNG -->
            <div class="card card-custom text-center py-5 px-3">
                <div class="badge bg-primary-subtle text-primary p-3 rounded-circle mx-auto mb-3" style="width: 70px; height: 70px; display: flex; align-items: center; justify-content: center;">
                    <i class="bi bi-cart-x fs-1"></i>
                </div>
                <h5 class="fw-bold text-dark mb-1">Giỏ hàng của bạn đang trống!</h5>
                <p class="text-muted small mb-4">Hãy thêm vài sản phẩm điện máy yêu thích vào giỏ nhé.</p>
                <div>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary rounded-pill px-4 fw-medium">
                        <i class="bi bi-shop me-1"></i> Khám phá sản phẩm ngay
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- MODAL POP-UP NHẬP THÔNG TIN & XÁC NHẬN ĐẶT HÀNG -->
    <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="modal-header bg-success text-white py-3">
                    <h5 class="modal-title fw-bold fs-6" id="checkoutModalLabel">
                        <i class="bi bi-box-seam me-2"></i>Xác Nhận Đơn Hàng Từ Giỏ Hàng
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-4 text-start">

                    <!-- THÔNG TIN NGƯỜI NHẬN -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">Họ và tên người nhận <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" id="cartFullNameInput" class="form-control" placeholder="Nhập họ và tên...">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">Số điện thoại <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-phone"></i></span>
                                <!-- Chỉ cho phép nhập số -->
                                <input type="tel" id="cartPhoneInput" class="form-control" placeholder="Nhập số điện thoại..."
                                       oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="11">
                            </div>
                        </div>
                    </div>

                    <!-- ĐỊA CHỈ NHẬN HÀNG (ĐỂ TRỐNG ĐỂ KHÁCH TỰ NHẬP MỚI) -->
                    <div class="mb-3">
                        <label for="cartAddressInput" class="form-label small fw-semibold text-secondary">
                            Địa chỉ giao hàng chi tiết <span class="text-danger">*</span>
                        </label>
                        <textarea id="cartAddressInput" class="form-control" rows="2"
                                  placeholder="Số nhà, tên đường, phường/xã, quận/huyện..."></textarea>

                        <div class="d-flex align-items-center gap-1 text-muted small mt-1">
                            <i class="bi bi-info-circle"></i>
                            <span>Vui lòng ghi rõ tên đường, phường/xã để Shipper giao tận nơi.</span>
                        </div>

                        <!-- Thông báo lỗi chung -->
                        <div id="cartCheckoutError" class="alert alert-danger border-0 p-2 mt-2 small fw-semibold d-none">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> <span id="cartErrorMsgText">Vui lòng điền đầy đủ thông tin!</span>
                        </div>
                    </div>

                    <!-- PHƯƠNG THỨC THANH TOÁN -->
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary mb-2">
                            Phương thức thanh toán <span class="text-danger">*</span>
                        </label>
                        <div class="row g-2">
                            <div class="col-12">
                                <div class="payment-card d-flex align-items-center gap-3">
                                    <input class="form-check-input mt-0" type="radio" name="paymentOptionRadio" id="payCod" value="COD" checked>
                                    <label class="form-check-label w-100" style="cursor: pointer;" for="payCod">
                                        <div class="fw-semibold text-dark"><i class="bi bi-cash-coin text-success me-1"></i> Thanh toán COD</div>
                                        <div class="text-muted small">Thanh toán khi nhận hàng</div>
                                    </label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="payment-card d-flex align-items-center gap-3">
                                    <input class="form-check-input mt-0" type="radio" name="paymentOptionRadio" id="payBank" value="BANK_TRANSFER">
                                    <label class="form-check-label w-100" style="cursor: pointer;" for="payBank">
                                        <div class="fw-semibold text-dark"><i class="bi bi-qr-code-scan text-primary me-1"></i> Chuyển khoản QR / Ví</div>
                                        <div class="text-muted small">Quét mã qua App Ngân hàng</div>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- KHUNG HIỂN THỊ MÃ QR NGÂN HÀNG (Ẩn mặc định, tự hiện khi chọn Chuyển khoản) -->
                        <div id="cartQrContainer" class="card border-primary bg-light p-3 mt-3 d-none">
                            <div class="text-center">
                                <h6 class="fw-bold text-primary mb-2"><i class="bi bi-qr-code-scan me-1"></i> Quét mã QR để thanh toán</h6>
                                <p class="text-muted small mb-2">Sử dụng App Ngân hàng hoặc Ví điện tử bất kỳ để quét mã</p>

                                <!-- Ảnh QR gọi trực tiếp từ VietQR API -->
                                <div class="bg-white p-2 d-inline-block rounded-3 border shadow-sm">
                                    <img id="cartVietQrImg" src="" alt="Mã QR Chuyển Khoản" style="width: 180px; height: 180px; object-fit: contain;">
                                </div>

                                <div class="mt-2 text-start small bg-white p-2 rounded border">
                                    <div><strong>Ngân hàng:</strong> MB Bank</div>
                                    <div><strong>Chủ tài khoản:</strong> PHAM HOANG GIA PHAT</div>
                                    <div><strong>Số tài khoản:</strong> <span class="text-primary fw-bold">0933099356</span></div>
                                    <div><strong>Số tiền:</strong> <span id="cartQrAmountText" class="text-danger fw-bold">0 VNĐ</span></div>
                                    <div><strong>Nội dung:</strong> <span class="text-dark fw-semibold">Thanh toan don hang Gio Hang</span></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- TÓM TẮT -->
                    <div class="bg-light p-3 rounded-3 border">
                        <div class="d-flex justify-content-between align-items-center mb-2 small text-muted">
                           <span>Số lượng sản phẩm chọn mua:</span>
                            <strong id="modalSelectedCount" class="text-dark fs-6">0</strong>
                        </div>
                        <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                            <span class="fw-bold text-dark">Tổng tiền thanh toán:</span>
                            <strong id="modalTotalAmount" class="text-danger fs-5">0 VNĐ</strong>
                        </div>
                    </div>
                </div>

                <div class="modal-footer bg-light justify-content-center border-0 py-3">
                    <button type="button" class="btn btn-light border rounded-pill px-4" data-bs-dismiss="modal">Hủy bỏ</button>
                    <button type="button" class="btn btn-success rounded-pill px-4 fw-bold shadow-sm" onclick="submitCartCheckout()">
                        <i class="bi bi-check2 me-1"></i> Xác Nhận Đặt Hàng
                    </button>
                </div>
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

<!-- 🦶 FOOTER -->
<footer class="bg-white border-top py-4 mt-auto">
    <div class="container text-center text-muted small">
        <p class="mb-1">&copy; 2026 Cửa Hàng Điện Máy. Tất cả quyền được bảo lưu.</p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- JAVASCRIPT XỬ LÝ GIỎ HÀNG & THANH TOÁN -->
<script>
    function toggleSelectAll(master) {
        const checkboxes = document.querySelectorAll('.item-checkbox');
        checkboxes.forEach(chk => {
            chk.checked = master.checked;
        });
        calculateTotal();
    }

    function calculateTotal() {
        let total = 0;
        let count = 0;
        const checkboxes = document.querySelectorAll('.item-checkbox:checked');

        checkboxes.forEach(chk => {
            count++;
            const cartId = chk.value;
            const price = parseFloat(chk.getAttribute('data-price')) || 0;
            const qtyInput = document.getElementById('qty_' + cartId);
            const qty = parseInt(qtyInput ? qtyInput.value : 1) || 1;
            total += price * qty;
        });

        const formattedTotal = total.toLocaleString('vi-VN') + ' VNĐ';

        const displayTotalEl = document.getElementById('displayTotal');
        if (displayTotalEl) displayTotalEl.innerText = formattedTotal;

        const modalTotalEl = document.getElementById('modalTotalAmount');
        if (modalTotalEl) modalTotalEl.innerText = formattedTotal;

        const qrAmountEl = document.getElementById('cartQrAmountText');
        if (qrAmountEl) qrAmountEl.innerText = formattedTotal;

        const selectedCountEl = document.getElementById('modalSelectedCount');
        if (selectedCountEl) selectedCountEl.innerText = count;

        return total;
    }

    function changeQuantity(cartId, delta, price) {
        const qtyInput = document.getElementById('qty_' + cartId);
        if (!qtyInput) return;

        let currentQty = parseInt(qtyInput.value) || 1;
        let newQty = currentQty + delta;
        if (newQty < 1) newQty = 1;

        qtyInput.value = newQty;

        const subtotalEl = document.getElementById('subtotal_' + cartId);
        if (subtotalEl) {
            let subtotal = newQty * price;
            subtotalEl.innerText = subtotal.toLocaleString('vi-VN');
        }

        updateQuantityInDB(cartId, newQty);
        calculateTotal();
    }

    function onQuantityInputChange(cartId, price) {
        const qtyInput = document.getElementById('qty_' + cartId);
        if (!qtyInput) return;
        let newQty = parseInt(qtyInput.value) || 1;
        if (newQty < 1) {
            newQty = 1;
            qtyInput.value = 1;
        }

        const subtotalEl = document.getElementById('subtotal_' + cartId);
        if (subtotalEl) {
            subtotalEl.innerText = (newQty * price).toLocaleString('vi-VN');
        }

        updateQuantityInDB(cartId, newQty);
        calculateTotal();
    }

    function updateQuantityInDB(cartId, quantity) {
        fetch('${pageContext.request.contextPath}/cart/update?id=' + cartId + '&quantity=' + quantity, {
            method: 'GET'
        }).catch(err => console.error("Lỗi cập nhật số lượng giỏ hàng:", err));
    }

    function openCheckoutModal() {
        const checkboxes = document.querySelectorAll('.item-checkbox:checked');
        if (checkboxes.length === 0) {
            alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
            return;
        }

        const total = calculateTotal();

        const qrImg = document.getElementById('cartVietQrImg');
        if (qrImg) {
            qrImg.src = "https://img.vietqr.io/image/MB-0933099356-compact2.png?amount=" + total + "&addInfo=Thanh%20toan%20don%20hang%20Gio%20Hang&accountName=PHAM%20HOANG%20GIA%20PHAT";
        }

        var checkoutModal = new bootstrap.Modal(document.getElementById('checkoutModal'));
        checkoutModal.show();
    }

    document.addEventListener("DOMContentLoaded", function() {
        const payCod = document.getElementById('payCod');
        const payBank = document.getElementById('payBank');
        const qrContainer = document.getElementById('cartQrContainer');

        if (payCod && payBank && qrContainer) {
            payCod.addEventListener('change', function() {
                if (this.checked) qrContainer.classList.add('d-none');
            });
            payBank.addEventListener('change', function() {
                if (this.checked) qrContainer.classList.remove('d-none');
            });
        }

        calculateTotal();
    });

    function submitCartCheckout() {
        const fullName = document.getElementById('cartFullNameInput').value.trim();
        const phone = document.getElementById('cartPhoneInput').value.trim();
        const address = document.getElementById('cartAddressInput').value.trim();
        const errorDiv = document.getElementById('cartCheckoutError');
        const errorText = document.getElementById('cartErrorMsgText');

        if (!fullName || !phone || !address) {
            errorText.innerText = "Vui lòng điền đầy đủ họ tên, số điện thoại và địa chỉ nhận hàng!";
            errorDiv.classList.remove('d-none');
            return;
        }

        // Kiểm tra định dạng số điện thoại (chỉ nhận từ 10 đến 11 chữ số)
        const phoneRegex = /^[0-9]{10,11}$/;
        if (!phoneRegex.test(phone)) {
            errorText.innerText = "Số điện thoại không hợp lệ! Vui lòng nhập đúng từ 10 đến 11 chữ số.";
            errorDiv.classList.remove('d-none');
            return;
        }

        errorDiv.classList.add('d-none');

        const selectedIds = [];
        document.querySelectorAll('.item-checkbox:checked').forEach(chk => {
            selectedIds.push(chk.value);
        });

        const paymentMethod = document.querySelector('input[name="paymentOptionRadio"]:checked').value;

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/checkout';

        const idsInput = document.createElement('input');
        idsInput.type = 'hidden';
        idsInput.name = 'selectedCartIds';
        idsInput.value = selectedIds.join(',');
        form.appendChild(idsInput);

        const nameInput = document.createElement('input');
        nameInput.type = 'hidden';
        nameInput.name = 'fullName';
        nameInput.value = fullName;
        form.appendChild(nameInput);

        const phoneInput = document.createElement('input');
        phoneInput.type = 'hidden';
        phoneInput.name = 'phone';
        phoneInput.value = phone;
        form.appendChild(phoneInput);

        const addressInput = document.createElement('input');
        addressInput.type = 'hidden';
        addressInput.name = 'address';
        addressInput.value = address;
        form.appendChild(addressInput);

        const paymentInput = document.createElement('input');
        paymentInput.type = 'hidden';
        paymentInput.name = 'paymentMethod';
        paymentInput.value = paymentMethod;
        form.appendChild(paymentInput);

        document.body.appendChild(form);
        form.submit();
    }
</script>
</body>
</html>