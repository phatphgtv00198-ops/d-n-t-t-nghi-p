<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} | Admin</title>

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

        .card-custom {
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        }

        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.6rem 0.9rem;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }

        .preview-box {
            width: 100%;
            height: 160px;
            border: 2px dashed #cbd5e1;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background-color: #f8fafc;
        }

        .preview-box img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .section-title {
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748b;
            margin-bottom: 12px;
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
            <a href="${pageContext.request.contextPath}/staff/products" class="btn btn-outline-light btn-sm px-3 rounded-pill">
                <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>
    </nav>

    <div class="container mb-5" style="max-width: 860px;">
        <div class="card card-custom p-4 p-md-5 bg-white">

            <!-- HEADER -->
            <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                <div class="bg-primary-subtle text-primary p-3 rounded-circle d-flex align-items-center justify-content-center" style="width: 52px; height: 52px;">
                    <i class="bi bi-box-seam fs-4"></i>
                </div>
                <div>
                    <h4 class="fw-bold text-dark mb-1">${pageTitle}</h4>
                    <small class="text-muted">Nhập chi tiết thông tin thiết bị điện máy để lưu vào hệ thống</small>
                </div>
            </div>

            <!-- THÔNG BÁO LỖI -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center">
                    <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                    <div>${errorMessage}</div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/staff/product-add" method="post">
                <!-- ID Ẩn nếu là cập nhật -->
                <input type="hidden" name="productID" value="${product.productID}">

                <!-- KHỐI 1: THÔNG TIN CƠ BẢN -->
                <div class="mb-4">
                    <div class="section-title"><i class="bi bi-info-circle me-1"></i> Thông tin cơ bản</div>
                    <div class="row g-3">
                        <!-- Tên sản phẩm -->
                        <div class="col-md-8">
                            <label class="form-label fw-semibold">Tên sản phẩm điện máy <span class="text-danger">*</span></label>
                            <input type="text" name="productName" value="${product.productName}" class="form-control" required placeholder="Ví dụ: Tivi Samsung 4K, Tủ lạnh Inverter...">
                        </div>

                        <!-- Danh mục -->
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryID}" ${product.category != null && product.category.categoryID == c.categoryID ? 'selected' : ''}>
                                        ${c.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- KHỐI 2: GIÁ BÁN VÀ TỒN KHO -->
                <div class="mb-4">
                    <div class="section-title"><i class="bi bi-currency-dollar me-1"></i> Giá cả & Kho hàng</div>
                    <div class="row g-3">
                        <!-- Giá bán -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" name="price" value="${product.price}" class="form-control" required step="1000" min="0" placeholder="0">
                                <span class="input-group-text bg-light text-muted">VNĐ</span>
                            </div>
                        </div>

                        <!-- Số lượng tồn kho -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Số lượng tồn kho <span class="text-danger">*</span></label>
                            <input type="number" name="stockQuantity" value="${product.stockQuantity != null ? product.stockQuantity : 0}" class="form-control" required min="0" placeholder="0">
                        </div>
                    </div>
                </div>

                <!-- KHỐI 3: MEDIA (ẢNH & VIDEO) -->
                <div class="mb-4">
                    <div class="section-title"><i class="bi bi-images me-1"></i> Hình ảnh & Media</div>
                    <div class="row g-3">
                        <div class="col-md-8">
                            <!-- URL Ảnh Thumbnail -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">URL Ảnh đại diện</label>
                                <input type="text" id="thumbnailInput" name="thumbnailUrl" value="${product.thumbnailUrl}" class="form-control" placeholder="https://example.com/image.jpg">
                            </div>

                            <!-- URL Video -->
                            <div>
                                <label class="form-label fw-semibold">URL Video giới thiệu</label>
                                <input type="text" name="videoUrl" value="${product.videoUrl}" class="form-control" placeholder="https://youtube.com/watch?v=...">
                            </div>
                        </div>

                        <!-- Khung xem trước ảnh -->
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Xem trước ảnh</label>
                            <div class="preview-box">
                                <c:choose>
                                    <c:when test="${not empty product.thumbnailUrl}">
                                        <img id="imgPreview" src="${product.thumbnailUrl}" alt="Preview" onerror="this.src=''; this.nextElementSibling.classList.remove('d-none');">
                                        <div id="previewPlaceholder" class="text-center text-muted d-none">
                                            <i class="bi bi-image fs-1 opacity-50"></i>
                                            <div class="small">Lỗi tải ảnh</div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <img id="imgPreview" src="" alt="Preview" class="d-none">
                                        <div id="previewPlaceholder" class="text-center text-muted">
                                            <i class="bi bi-image fs-1 opacity-50"></i>
                                            <div class="small">Chưa có ảnh</div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- KHỐI 4: MÔ TẢ SẢN PHẨM -->
                <div class="mb-4">
                    <div class="section-title"><i class="bi bi-file-earmark-text me-1"></i> Chi tiết mô tả</div>
                    <label class="form-label fw-semibold">Mô tả sản phẩm điện máy</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả chi tiết về tính năng, công suất, bảo hành, xuất xứ thiết bị...">${product.description}</textarea>
                </div>

                <!-- NÚT BẤM THAO TÁC -->
                <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/staff/products" class="btn btn-light border rounded-pill px-4 fw-medium">
                        Hủy bỏ
                    </a>
                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-semibold shadow-sm">
                        <i class="bi bi-save me-1"></i> Lưu thông tin
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Script tự động hiển thị xem trước ảnh -->
    <script>
        const thumbnailInput = document.getElementById('thumbnailInput');
        const imgPreview = document.getElementById('imgPreview');
        const previewPlaceholder = document.getElementById('previewPlaceholder');

        thumbnailInput.addEventListener('input', function () {
            const url = this.value.trim();
            if (url) {
                imgPreview.src = url;
                imgPreview.classList.remove('d-none');
                previewPlaceholder.classList.add('d-none');
            } else {
                imgPreview.src = '';
                imgPreview.classList.add('d-none');
                previewPlaceholder.classList.remove('d-none');
            }
        });

        imgPreview.addEventListener('error', function () {
            imgPreview.classList.add('d-none');
            previewPlaceholder.classList.remove('d-none');
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>