<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Chỉnh sửa sản phẩm</title>
        </head>

        <body>

            <div class="page-heading mb-4">
                <div class="page-title"><i class="bi bi-bag-check"></i> Chỉnh sửa sản phẩm</div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a
                                href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/product/list">Sản
                                phẩm</a></li>
                        <li class="breadcrumb-item active">Chỉnh sửa</li>
                    </ol>
                </nav>
            </div>

            <div class="row">
                <div class="col-12 col-lg-8">
                    <div class="card">
                        <div class="card-header"><i class="bi bi-pencil me-2"></i>Cập nhật thông tin</div>
                        <div class="card-body">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-2"></i>${error}
                                </div>
                            </c:if>

                            <form id="editProdForm" action="${pageContext.request.contextPath}/admin/product/edit"
                                method="POST" enctype="multipart/form-data" novalidate>
                                <input type="hidden" name="id" value="${product.id}">

                                <div class="mb-3">
                                    <label class="form-label fw-semibold">
                                        Tên sản phẩm <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="prodName" name="name"
                                        value="${product.name}" minlength="3" maxlength="255" required autofocus>
                                    <div class="invalid-feedback">Tên sản phẩm phải có từ 3–255 ký tự.</div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Mô tả</label>
                                    <textarea class="form-control" name="description"
                                        rows="3">${product.description}</textarea>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-6">
                                        <label class="form-label fw-semibold">
                                            Giá (VNĐ) <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="price" name="price"
                                            value="${product.price}" min="0" step="1000" required>
                                        <div class="invalid-feedback">Giá phải là số không âm.</div>
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label fw-semibold">
                                            Số lượng <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="quantity" name="quantity"
                                            value="${product.quantity}" min="0" step="1" required>
                                        <div class="invalid-feedback">Số lượng phải là số nguyên không âm.</div>
                                    </div>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-6">
                                        <label class="form-label fw-semibold">
                                            Danh mục <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="cateId" name="cateId" required>
                                            <c:forEach items="${categories}" var="cate">
                                                <option value="${cate.id}" ${cate.id==product.category.id ? 'selected'
                                                    : '' }>${cate.name}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Vui lòng chọn danh mục.</div>
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label fw-semibold">Trạng thái</label>
                                        <select class="form-select" name="status">
                                            <option value="1" ${product.status==1 ? 'selected' : '' }>Hiển thị</option>
                                            <option value="0" ${product.status==0 ? 'selected' : '' }>Ẩn</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-semibold">Ảnh sản phẩm</label>
                                    <c:if test="${not empty product.image}">
                                        <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 mb-2">
                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                alt="${product.name}"
                                                style="width:80px;height:64px;object-fit:cover;border-radius:6px;border:1px solid #dee2e6">
                                            <div>
                                                <p class="mb-0 fw-semibold" style="font-size:.88rem">Ảnh hiện tại</p>
                                                <small class="text-muted">${product.image}</small>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="border border-dashed rounded-3 p-3 text-center position-relative"
                                        style="cursor:pointer">
                                        <input type="file" name="image" id="imageFile" accept="image/*"
                                            onchange="previewImg(this,'imgPreviewWrap','imgError')"
                                            style="position:absolute;inset:0;opacity:0;cursor:pointer;width:100%;height:100%">
                                        <p class="mb-0 text-muted" style="font-size:.88rem">
                                            <strong class="text-primary">Chọn ảnh mới</strong> hoặc kéo thả<br>
                                            <small>Để trống nếu không muốn thay đổi</small>
                                        </p>
                                    </div>
                                    <div id="imgError" class="text-danger mt-1" style="font-size:.82rem;display:none">
                                    </div>
                                    <div id="imgPreviewWrap" class="mt-2 d-none">
                                        <img id="imgPreview" src="" alt="Preview mới"
                                            style="max-width:140px;max-height:110px;border-radius:6px;border:1px solid #dee2e6;object-fit:cover">
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check2 me-1"></i>Lưu thay đổi
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/product/list"
                                        class="btn btn-outline-secondary">Hủy</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                (function () {
                    'use strict';

                    function previewImg(input, wrapId, errId) {
                        const wrap = document.getElementById(wrapId);
                        const errEl = document.getElementById(errId);
                        errEl.style.display = 'none';
                        if (!input.files || !input.files[0]) return;
                        const file = input.files[0];
                        const allowed = ['image/png', 'image/jpeg', 'image/gif', 'image/webp'];
                        if (!allowed.includes(file.type)) {
                            errEl.textContent = 'Chỉ cho phép ảnh PNG, JPG, GIF, WEBP.';
                            errEl.style.display = 'block';
                            input.value = '';
                            return;
                        }
                        if (file.size > 5 * 1024 * 1024) {
                            errEl.textContent = 'Kích thước ảnh không được vượt quá 5MB.';
                            errEl.style.display = 'block';
                            input.value = '';
                            return;
                        }
                        const reader = new FileReader();
                        reader.onload = e => {
                            document.getElementById('imgPreview').src = e.target.result;
                            wrap.classList.remove('d-none');
                        };
                        reader.readAsDataURL(file);
                    }
                    window.previewImg = previewImg;

                    document.getElementById('editProdForm').addEventListener('submit', function (e) {
                        if (document.getElementById('imgError').style.display === 'block') {
                            e.preventDefault(); return;
                        }
                        if (!this.checkValidity()) {
                            e.preventDefault();
                            e.stopPropagation();
                        }
                        this.classList.add('was-validated');
                    });
                })();
            </script>
        </body>

        </html>