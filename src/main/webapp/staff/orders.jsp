<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng | Điện Máy Admin</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

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
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.03);
        }

        .stat-card {
            border: none;
            border-radius: 16px;
            transition: all 0.25s ease-in-out;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05) !important;
        }

        .icon-shape {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }

        .table > :not(caption) > * > * {
            padding: 0.9rem 1rem;
        }

        .action-btn {
            width: 34px;
            height: 34px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }

        #overview-map {
            height: 400px;
            width: 100%;
            border-radius: 16px;
            z-index: 1;
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
                <span>Điện Máy Admin</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                <i class="bi bi-speedometer2 me-1"></i> Dashboard
            </a>
        </div>
    </nav>

    <div class="container mb-5">

        <%-- Hỗ trợ đọc cả 'orders' lẫn 'orderList' --%>
        <c:set var="list" value="${not empty orders ? orders : orderList}" />

        <!-- 📊 THỐNG KÊ NHANH -->
        <c:if test="${not empty list}">
            <c:set var="pendingCount" value="0" />
            <c:set var="approvedCount" value="0" />
            <c:forEach var="item" items="${list}">
                <c:if test="${item.status.name() == 'Pending'}">
                    <c:set var="pendingCount" value="${pendingCount + 1}" />
                </c:if>
                <c:if test="${item.status.name() == 'Paid' || item.status.name() == 'Approved'}">
                    <c:set var="approvedCount" value="${approvedCount + 1}" />
                </c:if>
            </c:forEach>

            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm p-3 bg-white">
                        <div class="d-flex align-items-center gap-3">
                            <div class="icon-shape bg-primary-subtle text-primary fs-4">
                                <i class="bi bi-receipt-cutoff"></i>
                            </div>
                            <div>
                                <span class="text-muted small fw-semibold text-uppercase">Tổng đơn hàng điện máy</span>
                                <h3 class="fw-bold text-dark mt-1 mb-0">${list.size()}</h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card stat-card shadow-sm p-3 bg-white">
                        <div class="d-flex align-items-center gap-3">
                            <div class="icon-shape bg-warning-subtle text-warning fs-4">
                                <i class="bi bi-hourglass-split"></i>
                            </div>
                            <div>
                                <span class="text-muted small fw-semibold text-uppercase">Chờ xử lý</span>
                                <h3 class="fw-bold text-dark mt-1 mb-0">${pendingCount}</h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card stat-card shadow-sm p-3 bg-white">
                        <div class="d-flex align-items-center gap-3">
                            <div class="icon-shape bg-success-subtle text-success fs-4">
                                <i class="bi bi-check2-circle"></i>
                            </div>
                            <div>
                                <span class="text-muted small fw-semibold text-uppercase">Đã duyệt / Thanh toán</span>
                                <h3 class="fw-bold text-dark mt-1 mb-0">${approvedCount}</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- 🗺️ BẢN ĐỒ TỔNG QUAN CÁC ĐƠN HÀNG ĐÃ DUYỆT -->
        <c:if test="${not empty list}">
            <div class="card card-custom p-4 bg-white mb-4">
                <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom">
                    <div>
                        <h5 class="fw-bold text-dark mb-1">
                            <i class="bi bi-map text-danger me-2"></i>Bản đồ tổng quan đơn hàng điện máy đã duyệt
                        </h5>
                        <small class="text-muted">Hiển thị vị trí giao hàng của các đơn đang chuẩn bị vận chuyển</small>
                    </div>
                </div>
                <div id="overview-map"></div>
            </div>
        </c:if>

        <!-- 📑 BẢNG DANH SÁCH ĐƠN HÀNG -->
        <div class="card card-custom p-4 bg-white">
            <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom">
                <div>
                    <h4 class="fw-bold text-dark mb-1">
                        <i class="bi bi-receipt text-primary me-2"></i>Quản Lý Đơn Hàng Điện Máy
                    </h4>
                    <small class="text-muted">Theo dõi và duyệt đơn hàng thiết bị điện máy từ khách hàng</small>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle border-0">
                    <thead class="table-light">
                        <tr>
                            <th style="width: 100px;">Mã ĐH</th>
                            <th>Khách hàng</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center" style="width: 130px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty list}">
                                <c:forEach var="o" items="${list}">
                                    <c:set var="currentId" value="${not empty o.orderID ? o.orderID : (not empty o.orderId ? o.orderId : o.id)}" />

                                    <tr>
                                        <td>
                                            <strong class="text-dark">#${currentId}</strong>
                                        </td>
                                        <td class="fw-medium text-secondary">
                                            <c:choose>
                                                <c:when test="${not empty o.customer && not empty o.customer.fullName}">
                                                    <i class="bi bi-person me-1 text-muted"></i>${o.customer.fullName}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted fst-italic">Khách lẻ</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-secondary small">
                                            <c:choose>
                                                <c:when test="${not empty o.orderDate}">
                                                    <i class="bi bi-calendar3 me-1 text-muted"></i>${o.orderDate}
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-danger fw-bold">
                                            <fmt:formatNumber value="${not empty o.totalAmount ? o.totalAmount : 0}" pattern="#,##0"/> VNĐ
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${o.status.name() == 'Pending'}">
                                                    <span class="badge bg-warning-subtle text-warning border border-warning-subtle px-3 py-1.5 rounded-pill">
                                                        <i class="bi bi-hourglass-split me-1"></i>Chờ xử lý
                                                    </span>
                                                </c:when>
                                                <c:when test="${o.status.name() == 'Paid' || o.status.name() == 'Approved'}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1.5 rounded-pill">
                                                        <i class="bi bi-check-circle me-1"></i>Đã duyệt
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-3 py-1.5 rounded-pill">
                                                        <i class="bi bi-x-circle me-1"></i>Đã hủy
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center gap-1">
                                                <a href="${pageContext.request.contextPath}/staff/order-detail?id=${currentId}"
                                                   class="btn btn-sm btn-light text-info action-btn" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <c:if test="${o.status.name() == 'Pending'}">
                                                    <a href="${pageContext.request.contextPath}/staff/approve-order?id=${currentId}"
                                                       class="btn btn-sm btn-light text-success action-btn"
                                                       title="Duyệt nhanh"
                                                       onclick="return confirm('Bạn có chắc chắn muốn duyệt đơn hàng #${currentId}?');">
                                                        <i class="bi bi-check-lg"></i>
                                                    </a>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-5">
                                        <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary opacity-50"></i>
                                        Chưa có đơn hàng nào trong hệ thống!
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        <c:if test="${not empty list}">
            // Khởi tạo bản đồ tổng quan tại tâm mặc định
            var overviewMap = L.map('overview-map').setView([10.762622, 106.660172], 11);

            L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 19,
                attribution: '&copy; OpenStreetMap contributors'
            }).addTo(overviewMap);

            // Hàm tự động gọi Nominatim API để tìm tọa độ từ chuỗi địa chỉ bất kỳ
            function addMarkerForOrder(address, popupContent) {
                if (!address || address.trim() === "") return;

                fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(address))
                    .then(response => response.json())
                    .then(data => {
                        var lat = 10.762622;
                        var lng = 106.660172;

                        if (data && data.length > 0) {
                            lat = parseFloat(data[0].lat);
                            lng = parseFloat(data[0].lon);
                        }

                        var marker = L.marker([lat, lng]).addTo(overviewMap);
                        marker.bindPopup(popupContent);
                    })
                    .catch(error => {
                        console.error("Lỗi khi tìm tọa độ cho địa chỉ: " + address, error);
                    });
            }

            // Duyệt qua từng đơn hàng đã duyệt và truyền chuỗi địa chỉ thực tế vào hàm
            <c:forEach var="o" items="${list}">
                <c:if test="${o.status.name() == 'Paid' || o.status.name() == 'Approved'}">
                    <c:set var="itemId" value="${not empty o.orderID ? o.orderID : (not empty o.orderId ? o.orderId : o.id)}" />
                    <c:set var="custName" value="${not empty o.customer && not empty o.customer.fullName ? o.customer.fullName : 'Khách lẻ'}" />
                    <c:set var="custAddress" value="${not empty o.customer && not empty o.customer.address ? o.customer.address : 'Bình Dương'}" />

                    var address_${itemId} = "${custAddress}";
                    var popup_${itemId} = "<b>Đơn hàng #${itemId}</b><br>Khách: ${custName}<br>Địa chỉ: " + address_${itemId} + "<br><a href='${pageContext.request.contextPath}/staff/order-detail?id=${itemId}'>Xem chi tiết</a>";

                    addMarkerForOrder(address_${itemId}, popup_${itemId});
                </c:if>
            </c:forEach>
        </c:if>
    </script>
</body>
</html>