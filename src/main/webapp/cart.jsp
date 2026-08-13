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
    </style>
</head>
<body>

<!-- 🌐 NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-custom py-3 mb-4 shadow-sm">
    <div class="container" style="max-width: 1100px;">
        <a class="navbar-brand fw-bold text-primary fs-5 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-shop fs-4"></i> Cửa Hàng Gia Dụng
        </a>
        <div class="d-flex align-items-center gap-3">
            <span class="text-secondary small">
                <i class="bi bi-person-circle fs-6 me-1"></i>
                Xin chào, <strong class="text-dark">${sessionScope.user.username != null ? sessionScope.user.username : 'Khách hàng'}</strong>
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-pill px-3">
                <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
            </a>
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
                <p class="text-muted small mb-4">Hãy thêm vài sản phẩm gia dụng yêu thích vào giỏ nhé.</p>
                <div>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary rounded-pill px-4 fw-medium">
                        <i class="bi bi-shop me-1"></i> Khám phá sản phẩm ngay
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- MODAL POP-UP NHẬP ĐỊA CHỈ & XÁC NHẬN ĐẶT HÀNG -->
    <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="modal-header bg-success text-white py-3">
                    <h5 class="modal-title fw-bold fs-6" id="checkoutModalLabel">
                        <i class="bi bi-box-seam me-2"></i>Xác Nhận Đơn Hàng Từ Giỏ Hàng
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-4 text-start">
                    <div class="mb-3">
                        <label for="cartAddressInput" class="form-label fw-bold text-dark">
                            Địa chỉ nhận hàng: <span class="text-danger">*</span>
                        </label>
                        <!-- ĐÃ CẬP NHẬT PLACEHOLDER GIỐNG HỆT TRANG MUA NGAY -->
                        <textarea id="cartAddressInput" class="form-control" rows="3"
                                  placeholder="Nhập địa chỉ nhận hàng chi tiết (Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành)...">${customer.address}</textarea>

                        <!-- ĐÃ CẬP NHẬT CHÚ THÍCH GIỐNG HỆT TRANG MUA NGAY -->
                        <div class="d-flex align-items-center gap-1 text-muted small mt-2">
                            <i class="bi bi-info-circle"></i>
                            <span>Vui lòng ghi rõ tên đường, phường/xã để Shipper giao tận nơi.</span>
                        </div>

                        <div id="cartAddressError" class="alert alert-danger border-0 p-2 mt-2 small fw-semibold d-none">
                            ⚠️ Vui lòng nhập địa chỉ nhận hàng hợp lệ!
                        </div>
                    </div>

                    <!-- PHƯƠNG THỨC THANH TOÁN -->
                    <div class="mb-3">
                        <label class="form-label fw-bold text-dark">
                            Phương thức thanh toán: <span class="text-danger">*</span>
                        </label>
                        <div class="d-flex flex-column gap-2">
                            <div class="form-check border p-3 rounded-3 bg-light m-0" style="cursor: pointer;">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="payCod" value="COD" checked>
                                <label class="form-check-label fw-medium text-dark ms-2" for="payCod" style="cursor: pointer;">
                                    <i class="bi bi-cash-coin text-success me-1"></i> Thanh toán khi nhận hàng (COD)
                                </label>
                            </div>
                            <div class="form-check border p-3 rounded-3 bg-light m-0" style="cursor: pointer;">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="payBank" value="BANK_TRANSFER">
                                <label class="form-check-label fw-medium text-dark ms-2" for="payBank" style="cursor: pointer;">
                                    <i class="bi bi-qr-code-scan text-primary me-1"></i> Chuyển khoản ngân hàng / Quét mã QR
                                </label>
                            </div>
                        </div>
                    </div>

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

<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let currentRawTotal = 0;

    function changeQuantity(cartId, delta, unitPrice) {
        let input = document.getElementById('qty_' + cartId);
        let currentQty = parseInt(input.value) || 1;
        let newQty = currentQty + delta;
        if (newQty < 1) newQty = 1;
        input.value = newQty;
        updateItemAndCartTotal(cartId, newQty, unitPrice);
    }

    function onQuantityInputChange(cartId, unitPrice) {
        let input = document.getElementById('qty_' + cartId);
        let newQty = parseInt(input.value);
        if (isNaN(newQty) || newQty < 1) {
            newQty = 1;
            input.value = 1;
        }
        updateItemAndCartTotal(cartId, newQty, unitPrice);
    }

    function updateItemAndCartTotal(cartId, newQty, unitPrice) {
        let subtotal = newQty * unitPrice;
        document.getElementById('subtotal_' + cartId).innerText = new Intl.NumberFormat('vi-VN').format(subtotal);
        calculateTotal();

        fetch('${pageContext.request.contextPath}/cart-update', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'cartId=' + cartId + '&quantity=' + newQty
        });
    }

    function calculateTotal() {
        let checkboxes = document.querySelectorAll('.item-checkbox');
        let total = 0;
        let allChecked = true;

        checkboxes.forEach(cb => {
            if (cb.checked) {
                let cartId = cb.id.replace('chk_', '');
                let qty = parseInt(document.getElementById('qty_' + cartId).value) || 1;
                let unitPrice = parseFloat(cb.getAttribute('data-price'));
                total += qty * unitPrice;
            } else {
                allChecked = false;
            }
        });

        currentRawTotal = total;

        if (document.getElementById('selectAll')) {
            document.getElementById('selectAll').checked = allChecked && checkboxes.length > 0;
        }
        document.getElementById('displayTotal').innerText = new Intl.NumberFormat('vi-VN').format(total) + ' VNĐ';
    }

    function toggleSelectAll(selectAllCb) {
        let checkboxes = document.querySelectorAll('.item-checkbox');
        checkboxes.forEach(cb => {
            cb.checked = selectAllCb.checked;
        });
        calculateTotal();
    }

    function openCheckoutModal() {
        let selected = document.querySelectorAll('.item-checkbox:checked');
        if (selected.length === 0) {
            alert('Vui lòng tích chọn ít nhất 1 sản phẩm để thanh toán!');
            return;
        }

        document.getElementById('cartAddressInput').value = '';
        document.getElementById('cartAddressInput').classList.remove('is-invalid');
        let errorDiv = document.getElementById('cartAddressError');
        if (errorDiv) errorDiv.classList.add('d-none');

        document.getElementById('payCod').checked = true;

        document.getElementById('modalSelectedCount').innerText = selected.length;
        document.getElementById('modalTotalAmount').innerText = document.getElementById('displayTotal').innerText;

        let checkoutModal = new bootstrap.Modal(document.getElementById('checkoutModal'));
        checkoutModal.show();
    }

    function submitCartCheckout() {
        let addressInput = document.getElementById('cartAddressInput');
        let addressVal = addressInput.value.trim();

        if (addressVal === '' || addressVal.length < 3) {
            let errorDiv = document.getElementById('cartAddressError');
            if (errorDiv) {
                errorDiv.innerText = '⚠️ Vui lòng nhập địa chỉ nhận hàng hợp lệ (từ 3 ký tự trở lên)!';
                errorDiv.classList.remove('d-none');
            }
            addressInput.classList.add('is-invalid');
            addressInput.focus();
            return;
        }

        let errorDiv = document.getElementById('cartAddressError');
        if (errorDiv) errorDiv.classList.add('d-none');
        addressInput.classList.remove('is-invalid');

        let selectedCheckboxes = document.querySelectorAll('.item-checkbox:checked');
        if (selectedCheckboxes.length === 0) {
            alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
            return;
        }

        let paymentMethodVal = document.querySelector('input[name="paymentMethod"]:checked').value;

        // Tạo Form động hoàn toàn an toàn và gửi dữ liệu lên CheckoutServlet
        let dynamicForm = document.createElement('form');
        dynamicForm.method = 'POST';
        dynamicForm.action = '${pageContext.request.contextPath}/checkout';

        // 1. Gắn địa chỉ giao hàng
        let inputAddress = document.createElement('input');
        inputAddress.type = 'hidden';
        inputAddress.name = 'address';
        inputAddress.value = addressVal;
        dynamicForm.appendChild(inputAddress);

        // 2. Gắn phương thức thanh toán
        let inputPayment = document.createElement('input');
        inputPayment.type = 'hidden';
        inputPayment.name = 'paymentMethod';
        inputPayment.value = paymentMethodVal;
        dynamicForm.appendChild(inputPayment);

        // 3. Gắn từng ID sản phẩm được chọn
        selectedCheckboxes.forEach(cb => {
            let inputId = document.createElement('input');
            inputId.type = 'hidden';
            inputId.name = 'selectedCartIds';
            inputId.value = cb.value;
            dynamicForm.appendChild(inputId);
        });

        document.body.appendChild(dynamicForm);
        dynamicForm.submit();
    }

    document.addEventListener('DOMContentLoaded', calculateTotal);
</script>
</body>
</html>