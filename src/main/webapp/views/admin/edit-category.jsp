<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Chỉnh sửa danh mục</title>
        </head>

        <body>

            <div class="page-heading mb-4">
                <div class="page-title"><i class="bi bi-pencil-square"></i> Chỉnh sửa danh mục</div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a
                                href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a
                                href="${pageContext.request.contextPath}/admin/category/list">Danh mục</a></li>
                        <li class="breadcrumb-item active">Chỉnh sửa</li>
                    </ol>
                </nav>
            </div>

            <div class="row">
                <div class="col-12 col-md-7 col-lg-6">
                    <div class="card">
                        <div class="card-header"><i class="bi bi-pencil me-2"></i>Cập nhật thông tin</div>
                        <div class="card-body">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-2"></i>${error}
                                </div>
                            </c:if>
                            <c:if test="${not empty alert}">
                                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-2"></i>${alert}
                                </div>
                            </c:if>

                            <form id="editCateForm" action="${pageContext.request.contextPath}/admin/category/edit"
                                method="POST" enctype="multipart/form-data" novalidate>
                                <input type="hidden" name="id" value="${category.id}">

                                <div class="mb-3">
                                    <label class="form-label fw-semibold">
                                        Tên danh mục <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="cateName" name="name"
                                        value="${category.name}" minlength="3" maxlength="100" required autofocus>
                                    <div class="invalid-feedback">Tên danh mục phải có từ 3–100 ký tự.</div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-semibold">Ảnh đại diện</label>

                                    <c:if test="${not empty category.icon}">
                                        <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3 mb-2">
                                            <img src="${pageContext.request.contextPath}/${category.icon}"
                                                alt="${category.name}"
                                                style="width:72px;height:56px;object-fit:cover;border-radius:6px;border:1px solid #dee2e6">
                                            <div>
                                                <p class="mb-0 fw-semibold" style="font-size:.88rem">Ảnh hiện tại</p>
                                                <small class="text-muted">${category.icon}</small>
                                            </div>
                                        </div>
                                    </c:if>

                                    <div class="border border-dashed rounded-3 p-3 text-center position-relative"
                                        style="cursor:pointer">
                                        <input type="file" name="icon" id="iconFile" accept="image/*"
                                            onchange="previewImg(this,'previewWrap','iconError')"
                                            style="position:absolute;inset:0;opacity:0;cursor:pointer;width:100%;height:100%">
                                        <p class="mb-0 text-muted" style="font-size:.88rem">
                                            <strong class="text-primary">Chọn ảnh mới</strong> hoặc kéo thả<br>
                                            <small>Để trống nếu không muốn thay đổi</small>
                                        </p>
                                    </div>
                                    <div id="iconError" class="text-danger mt-1" style="font-size:.82rem;display:none">
                                    </div>
                                    <div id="previewWrap" class="mt-2 d-none">
                                        <img id="previewImg" src="" alt="Preview mới"
                                            style="max-width:120px;max-height:100px;border-radius:6px;border:1px solid #dee2e6;object-fit:cover">
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check2 me-1"></i>Lưu thay đổi
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/category/list"
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
                        errEl.textContent = '';

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
                            document.getElementById('previewImg').src = e.target.result;
                            wrap.classList.remove('d-none');
                        };
                        reader.readAsDataURL(file);
                    }
                    window.previewImg = previewImg;

                    document.getElementById('editCateForm').addEventListener('submit', function (e) {
                        if (document.getElementById('iconError').style.display === 'block') {
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