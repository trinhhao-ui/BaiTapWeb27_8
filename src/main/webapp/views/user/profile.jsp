<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Hồ sơ cá nhân</title>
        </head>

        <body>

            <div class="row justify-content-center">
                <div class="col-12 col-md-7 col-lg-6">
                    <div class="card shadow-sm">
                        <div class="card-header">
                            <i class="bi bi-person-circle me-2"></i>Hồ Sơ Cá Nhân
                            <span class="badge bg-primary ms-2" style="font-size:.7rem">JPA</span>
                        </div>
                        <div class="card-body">

                            <c:if test="${not empty alert}">
                                <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-2"></i>${alert}
                                </div>
                            </c:if>
                            <c:if test="${not empty success}">
                                <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i>${success}</div>
                            </c:if>

                            <form id="profileForm" action="${pageContext.request.contextPath}/user/profile"
                                method="post" enctype="multipart/form-data" novalidate>

                                <%-- Avatar --%>
                                    <div class="text-center mb-4">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.account.avatar}">
                                                <img id="avatarPreview"
                                                    src="${pageContext.request.contextPath}/${sessionScope.account.avatar}"
                                                    style="width:96px;height:96px;border-radius:50%;object-fit:cover;border:3px solid #dee2e6;cursor:pointer"
                                                    alt="Avatar"
                                                    onclick="document.getElementById('avatarInput').click()">
                                            </c:when>
                                            <c:otherwise>
                                                <img id="avatarPreview"
                                                    src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=667eea&color=fff&size=96&bold=true"
                                                    style="width:96px;height:96px;border-radius:50%;object-fit:cover;border:3px solid #dee2e6;cursor:pointer"
                                                    alt="Avatar"
                                                    onclick="document.getElementById('avatarInput').click()">
                                            </c:otherwise>
                                        </c:choose>
                                        <br>
                                        <small class="text-primary" style="cursor:pointer"
                                            onclick="document.getElementById('avatarInput').click()">
                                            <i class="bi bi-camera me-1"></i>Đổi ảnh đại diện
                                        </small>
                                        <input type="file" id="avatarInput" name="avatar"
                                            accept="image/png,image/jpeg,image/gif,image/webp" class="d-none">
                                        <div id="avatarError" class="text-danger mt-1"
                                            style="font-size:.82rem;display:none"></div>
                                    </div>

                                    <%-- Readonly --%>
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Tên đăng nhập</label>
                                            <input type="text" class="form-control"
                                                value="${sessionScope.account.userName}" readonly>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Email</label>
                                            <input type="text" class="form-control"
                                                value="${sessionScope.account.email}" readonly>
                                        </div>
                                        <hr>

                                        <%-- Editable --%>
                                            <div class="mb-3">
                                                <label class="form-label fw-semibold">
                                                    Họ và tên <span class="text-danger">*</span>
                                                </label>
                                                <input type="text" class="form-control" id="fullname" name="fullname"
                                                    value="${sessionScope.account.fullName}"
                                                    placeholder="Nhập họ và tên" minlength="3" maxlength="100" required>
                                                <div class="invalid-feedback">Họ tên phải có từ 3–100 ký tự.</div>
                                            </div>

                                            <div class="mb-4">
                                                <label class="form-label fw-semibold">Số điện thoại</label>
                                                <input type="tel" class="form-control" id="phone" name="phone"
                                                    value="${sessionScope.account.phone}" placeholder="0xxxxxxxxx"
                                                    pattern="^0[0-9]{9}$">
                                                <div class="invalid-feedback">Số điện thoại phải có 10 chữ số, bắt đầu
                                                    bằng 0.</div>
                                            </div>

                                            <button type="submit" class="btn btn-primary w-100">
                                                <i class="bi bi-check2 me-2"></i>Lưu thay đổi
                                            </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                (function () {
                    'use strict';
                    const form = document.getElementById('profileForm');
                    const avatarInput = document.getElementById('avatarInput');
                    const avatarError = document.getElementById('avatarError');
                    const preview = document.getElementById('avatarPreview');

                    // Preview + validate ảnh
                    avatarInput.addEventListener('change', function () {
                        avatarError.style.display = 'none';
                        avatarError.textContent = '';

                        if (!this.files || !this.files[0]) return;
                        const file = this.files[0];
                        const allowed = ['image/png', 'image/jpeg', 'image/gif', 'image/webp'];

                        if (!allowed.includes(file.type)) {
                            avatarError.textContent = 'Chỉ cho phép ảnh PNG, JPG, GIF, WEBP.';
                            avatarError.style.display = 'block';
                            this.value = '';
                            return;
                        }
                        if (file.size > 5 * 1024 * 1024) {
                            avatarError.textContent = 'Kích thước ảnh không được vượt quá 5MB.';
                            avatarError.style.display = 'block';
                            this.value = '';
                            return;
                        }
                        const reader = new FileReader();
                        reader.onload = e => { preview.src = e.target.result; };
                        reader.readAsDataURL(file);
                    });

                    form.addEventListener('submit', function (e) {
                        // Kiểm tra nếu có lỗi avatar
                        if (avatarError.style.display === 'block') {
                            e.preventDefault();
                            return;
                        }
                        if (!form.checkValidity()) {
                            e.preventDefault();
                            e.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    });
                })();
            </script>
        </body>

        </html>