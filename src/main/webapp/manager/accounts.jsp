<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tài khoản | Admin</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f9;
            color: #334155;
        }

        .navbar-custom {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
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

        .card-custom {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.03);
        }

        .avatar-circle {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, #0d6efd, #0b5ed7);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .table > :not(caption) > * > * {
            padding: 0.85rem 1rem;
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

        <!-- 📊 THỐNG KÊ NHANH -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-primary-subtle text-primary fs-4">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Tổng tài khoản</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">${totalAccounts}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-danger-subtle text-danger fs-4">
                            <i class="bi bi-shield-lock-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Quản trị (Manager)</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">${managerCount}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card stat-card shadow-sm p-3 bg-white">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-shape bg-info-subtle text-info fs-4">
                            <i class="bi bi-person-badge-fill"></i>
                        </div>
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Nhân viên (Staff)</span>
                            <h3 class="fw-bold text-dark mt-1 mb-0">${staffCount}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 🔔 BANNER THÔNG BÁO -->
        <c:if test="${param.status == 'created'}">
            <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3" role="alert">
                <div class="d-flex align-items-center">
                    <i class="bi bi-check-circle-fill fs-5 me-2"></i>
                    <div><strong>Tạo tài khoản thành công!</strong> Tài khoản <strong><c:out value="${param.user}"/></strong> đã được lưu vào hệ thống điện máy.</div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.status == 'updated'}">
            <div class="alert alert-info alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4 p-3" role="alert">
                <div class="d-flex align-items-center">
                    <i class="bi bi-info-circle-fill fs-5 me-2"></i>
                    <div><strong>Cập nhật thành công!</strong> Đã sửa thông tin tài khoản <strong><c:out value="${param.user}"/></strong>.</div>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- 📑 BẢNG DỮ LIỆU TÀI KHOẢN -->
        <div class="card card-custom p-4 bg-white">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <div>
                    <h4 class="fw-bold text-dark mb-1"><i class="bi bi-shield-lock text-danger me-2"></i>Quản Lý Tài Khoản</h4>
                    <small class="text-muted">Danh sách tài khoản và phân quyền người dùng hệ thống điện máy</small>
                </div>
                <a href="${pageContext.request.contextPath}/manager/account-add" class="btn btn-primary rounded-pill px-4 shadow-sm fw-semibold">
                    <i class="bi bi-person-plus me-1"></i> Thêm tài khoản
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle border-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center rounded-start" style="width: 80px;">ID</th>
                            <th>Username</th>
                            <th>Họ và Tên</th>
                            <th class="text-center">Vai trò (Role)</th>
                            <th class="text-center rounded-end" style="width: 140px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty accounts}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-5">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary opacity-50"></i>
                                    Chưa có dữ liệu tài khoản trong CSDL!
                                </td>
                            </tr>
                        </c:if>

                        <c:forEach var="acc" items="${accounts}">
                            <tr class="${not empty param.user && param.user == acc.username ? 'table-success-subtle' : ''}">

                                <!-- ID -->
                                <td class="text-center fw-bold text-muted">
                                    #<c:out value="${acc.accountID}"/>
                                </td>

                                <!-- Username + Avatar -->
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="avatar-circle">
                                            <c:choose>
                                                <c:when test="${not empty acc.username}">
                                                    <c:out value="${acc.username.substring(0, 1).toUpperCase()}"/>
                                                </c:when>
                                                <c:otherwise>?</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <strong class="text-dark"><c:out value="${acc.username}"/></strong>
                                            <c:if test="${not empty param.user && param.user == acc.username && param.status == 'created'}">
                                                <span class="badge bg-success ms-1 small">Vừa thêm</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>

                                <!-- Họ và tên -->
                                <td class="fw-medium text-secondary">
                                    <c:choose>
                                        <c:when test="${not empty acc.staff}">
                                            <c:out value="${acc.staff.fullName}" default="${acc.username}"/>
                                        </c:when>
                                        <c:when test="${not empty acc.customer}">
                                            <c:out value="${acc.customer.fullName}" default="${acc.username}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic"><c:out value="${acc.username}"/></span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- Role -->
                                <td class="text-center">
                                    <c:set var="roleStr" value="${acc.role.name()}"/>
                                    <c:choose>
                                        <c:when test="${roleStr == 'Manager'}">
                                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-1.5 rounded-pill">
                                                <i class="bi bi-shield-check me-1"></i>Manager
                                            </span>
                                        </c:when>
                                        <c:when test="${roleStr == 'Staff'}">
                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1.5 rounded-pill">
                                                <i class="bi bi-person-badge me-1"></i>Staff
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-3 py-1.5 rounded-pill">
                                                <i class="bi bi-person me-1"></i>Customer
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- Thao tác -->
                                <td class="text-center">
                                    <div class="d-flex justify-content-center gap-1">
                                        <a href="${pageContext.request.contextPath}/manager/account-edit?id=${acc.accountID}"
                                           class="btn btn-sm btn-light text-primary rounded-circle" title="Chỉnh sửa" style="width:32px; height:32px; padding:3px;">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/manager/account-delete?id=${acc.accountID}"
                                           class="btn btn-sm btn-light text-danger rounded-circle" title="Xóa"
                                           onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');" style="width:32px; height:32px; padding:3px;">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>