<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Quên mật khẩu</title>
        </head>

        <body>

            <div class="auth-logo"><i class="bi bi-key-fill"></i></div>
            <h2 class="auth-title">Quên Mật Khẩu</h2>
            <p class="auth-subtitle">Nhập email đã đăng ký để nhận mã OTP đặt lại mật khẩu.</p>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill me-2"></i>${alert}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill me-2"></i>${success}</div>
            </c:if>

            <form id="forgotForm" action="${pageContext.request.contextPath}/forgot-password" method="post" novalidate>
                <div class="form-group">
                    <label class="form-label">Địa chỉ Email <span class="required">*</span></label>
                    <input type="email" class="form-control" id="email" name="email" value="${param.email}"
                        placeholder="example@gmail.com" required autofocus>
                    <div class="invalid-feedback">Vui lòng nhập địa chỉ email hợp lệ.</div>
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-send me-2"></i>Gửi mã OTP
                </button>
            </form>

            <div class="auth-footer">
                <a href="${pageContext.request.contextPath}/login">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
                </a>
            </div>

            <script>
                (function () {
                    'use strict';
                    document.getElementById('forgotForm').addEventListener('submit', function (e) {
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