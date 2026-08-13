<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng #${order.orderID} | Admin</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f4f6f9; color: #334155; }
        .navbar-custom { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); }
        .card-custom { border: none; border-radius: 20px; box-shadow: 0 4px 18px rgba(0, 0, 0, 0.03); }
        .info-card { background-color: #f8fafc; border: 1px solid #e2e8f0; border-radius: 14px; padding: 18px; }
        #map { height: 350px !important; width: 100% !important; border-radius: 12px; z-index: 1; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4 py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold fs-5 d-flex align-items-center gap-2" href="#">
                <div class="bg-primary text-white p-2 rounded-3 d-flex align-items-center justify-content-center" style="width:36px; height:36px;">
                    <i class="bi bi-shop"></i>
                </div>
                <span>Gia Dụng Admin</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </nav>

    <div class="container mb-5" style="max-width: 960px;">
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/staff/orders" class="btn btn-light border btn-sm rounded-pill px-3 fw-medium">
                <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty order}">
                <div class="card card-custom p-4 p-md-5 bg-white">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 mb-4 pb-3 border-bottom">
                        <div>
                            <h4 class="fw-bold text-dark mb-1"><i class="bi bi-receipt text-primary me-2"></i>Chi Tiết Đơn Hàng #${order.orderID}</h4>
                            <small class="text-muted">Ngày đặt: ${order.formattedOrderDate}</small>
                        </div>
                        <div>
                            <c:choose>
                                <c:when test="${order.status.name() == 'Pending'}">
                                    <span class="badge bg-warning-subtle text-warning border border-warning-subtle fs-6 px-3 py-2 rounded-pill">
                                        <i class="bi bi-hourglass-split me-1"></i>Chờ xử lý
                                    </span>
                                </c:when>
                                <c:when test="${order.status.name() == 'Paid' || order.status.name() == 'Approved'}">
                                    <span class="badge bg-success-subtle text-success border border-success-subtle fs-6 px-3 py-2 rounded-pill">
                                        <i class="bi bi-check-circle me-1"></i>Đã duyệt
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle fs-6 px-3 py-2 rounded-pill">
                                        <i class="bi bi-x-circle me-1"></i>Đã hủy
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <div class="info-card h-100">
                                <h6 class="fw-bold text-dark mb-3"><i class="bi bi-person-circle text-primary me-2"></i>Thông tin khách hàng</h6>
                                <p class="mb-1.5 text-secondary"><strong>Khách hàng:</strong>
                                    <c:choose>
                                        <c:when test="${not empty order.customer && not empty order.customer.fullName}">${order.customer.fullName}</c:when>
                                        <c:otherwise>Khách lẻ</c:otherwise>
                                    </c:choose>
                                </p>
                                <p class="mb-1.5 text-secondary"><strong>Số điện thoại:</strong> ${not empty order.customer && not empty order.customer.phone ? order.customer.phone : 'N/A'}</p>

                                <!-- ĐỊA CHỈ GIAO HÀNG ĐỘNG CỦA RIÊNG ĐƠN HÀNG NÀY -->
                                <p class="mb-0 text-secondary"><strong>Địa chỉ giao:</strong>
                                    <span id="order-address">
                                        <c:choose>
                                            <c:when test="${not empty order.shippingAddress}">${order.shippingAddress}</c:when>
                                            <c:when test="${not empty order.customer && not empty order.customer.address}">${order.customer.address}</c:when>
                                            <c:otherwise>Việt Nam</c:otherwise>
                                        </c:choose>
                                    </span>
                                </p>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="info-card h-100 d-flex flex-column justify-content-between">
                                <div>
                                    <h6 class="fw-bold text-dark mb-3"><i class="bi bi-credit-card text-success me-2"></i>Thanh toán</h6>
                                    <p class="mb-1.5 text-secondary"><strong>Mã đơn hàng:</strong> #${order.orderID}</p>
                                </div>
                                <div>
                                    <span class="text-muted small">Tổng tiền thanh toán:</span>
                                    <h3 class="fw-bold text-danger mt-1 mb-0"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- BẢN ĐỒ TỰ ĐỘNG -->
                    <div class="card info-card p-4 mb-4 border border-success-subtle bg-white">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <h6 class="fw-bold text-dark mb-0"><i class="bi bi-geo-alt-fill text-danger me-2"></i>Bản đồ đường đi & Địa chỉ giao hàng</h6>
                            <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1 rounded-pill"><i class="bi bi-truck me-1"></i>Định vị động</span>
                        </div>
                        <p class="text-secondary small mb-3">
                            <i class="bi bi-info-circle me-1"></i> Địa chỉ nhận hàng: <strong id="display-addr-text">Đang tải...</strong>
                        </p>
                        <div id="map"></div>
                    </div>

                    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
                    <script>
                        var currentAddress = document.getElementById('order-address').innerText.trim();
                        document.getElementById('display-addr-text').innerText = currentAddress;

                        function smartGeocode(addressToSearch) {
                            var query = addressToSearch ? addressToSearch + ", Việt Nam" : "Việt Nam";
                            fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(query))
                                .then(response => response.json())
                                .then(data => {
                                    if (data && data.length > 0) {
                                        initMap(parseFloat(data[0].lat), parseFloat(data[0].lon));
                                    } else {
                                        fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(addressToSearch))
                                            .then(res => res.json())
                                            .then(fallbackData => {
                                                if (fallbackData && fallbackData.length > 0) {
                                                    initMap(parseFloat(fallbackData[0].lat), parseFloat(fallbackData[0].lon));
                                                } else {
                                                    initMap(10.762622, 106.660172);
                                                }
                                            });
                                    }
                                })
                                .catch(err => initMap(10.762622, 106.660172));
                        }

                        function initMap(lat, lng) {
                            var map = L.map('map').setView([lat, lng], 15);
                            L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                maxZoom: 19,
                                attribution: '&copy; OpenStreetMap contributors'
                            }).addTo(map);

                            var marker = L.marker([lat, lng]).addTo(map);
                            marker.bindPopup("<b>Đơn hàng #${order.orderID}</b><br>Địa chỉ: " + currentAddress).openPopup();

                            setTimeout(function() { map.invalidateSize(); }, 250);
                        }

                        window.onload = function() {
                            smartGeocode(currentAddress);
                        };
                    </script>

                    <!-- DANH SÁCH SẢN PHẨM -->
                    <h6 class="fw-bold text-dark mb-3"><i class="bi bi-box-seam text-warning me-2"></i>Danh sách sản phẩm</h6>
                    <div class="table-responsive mb-4">
                        <table class="table align-middle border">
                            <thead class="table-light">
                                <tr>
                                    <th class="text-center" style="width: 60px;">STT</th>
                                    <th>Sản phẩm</th>
                                    <th class="text-end" style="width: 140px;">Đơn giá</th>
                                    <th class="text-center" style="width: 100px;">Số lượng</th>
                                    <th class="text-end" style="width: 160px;">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty order.orderDetails}">
                                        <c:forEach var="detail" items="${order.orderDetails}" varStatus="loop">
                                            <tr>
                                                <td class="text-center text-muted fw-medium">${loop.index + 1}</td>
                                                <td><strong class="text-dark">${not empty detail.product ? detail.product.productName : 'Sản phẩm không tồn tại'}</strong></td>
                                                <td class="text-end text-secondary"><fmt:formatNumber value="${detail.unitPrice}" pattern="#,##0"/> VNĐ</td>
                                                <td class="text-center fw-bold text-dark">${detail.quantity}</td>
                                                <td class="text-end fw-bold text-primary"><fmt:formatNumber value="${detail.unitPrice * detail.quantity}" pattern="#,##0"/> VNĐ</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr><td colspan="5" class="text-center text-muted py-4">Không tìm thấy sản phẩm nào trong đơn hàng này.</td></tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- NÚT THAO TÁC -->
                    <c:if test="${order.status.name() == 'Pending'}">
                        <div class="d-flex gap-2 justify-content-end pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/staff/cancel-order?id=${order.orderID}" class="btn btn-outline-danger rounded-pill px-4 fw-semibold" onclick="return confirm('Hủy đơn hàng #${order.orderID}?');">
                                <i class="bi bi-x-lg me-1"></i> Hủy đơn
                            </a>
                            <a href="${pageContext.request.contextPath}/staff/approve-order?id=${order.orderID}" class="btn btn-success rounded-pill px-4 fw-semibold shadow-sm" onclick="return confirm('Duyệt đơn hàng #${order.orderID}?');">
                                <i class="bi bi-check-lg me-1"></i> Duyệt đơn hàng
                            </a>
                        </div>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger text-center">Không tìm thấy đơn hàng!</div>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>