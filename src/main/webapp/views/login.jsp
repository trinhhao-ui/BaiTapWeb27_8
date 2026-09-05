<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Đăng nhập</title>
        </head>

        <body>

            <div class="auth-logo"><i class="bi bi-shield-lock-fill"></i></div>
            <h2 class="auth-title">Đăng Nhập</h2>
            <p class="auth-subtitle">Nhập thông tin tài khoản của bạn</p>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill me-2"></i>${alert}</div>
            </c:if>
            <c:if test="${not empty sessionScope.registerSuccess}">
                <div class="alert alert-success"><i
                        class="bi bi-check-circle-fill me-2"></i>${sessionScope.registerSuccess}</div>
                <c:remove var="registerSuccess" scope="session" />
            </c:if>

            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" novalidate>

                <div class="form-group">
                    <label class="form-label">Tên đăng nhập <span class="required">*</span></label>
                    <input type="text" class="form-control" id="username" name="username"
                        placeholder="Nhập tên đăng nhập" pattern="^[a-zA-Z0-9_]{3,50}$" minlength="3" maxlength="50"
                        required autofocus>
                    <div class="invalid-feedback">Tối thiểu 3 ký tự, chỉ chữ cái, số và dấu gạch dưới (_).</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Mật khẩu <span class="required">*</span></label>
                    <input type="password" class="form-control" id="password" name="password"
                        placeholder="Nhập mật khẩu" minlength="6" required>
                    <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="remember" name="remember">
                        <label class="form-check-label" for="remember" style="font-size:.87rem">Ghi nhớ đăng
                            nhập</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password"
                        style="font-size:.87rem;color:#667eea;text-decoration:none;font-weight:600">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
                </button>
            </form>

            <div class="divider"><span>hoặc</span></div>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-secondary">
                <i class="bi bi-person-plus me-2"></i>Tạo tài khoản mới
            </a>
            <div class="auth-footer">
                <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>
            </div>

            <script>
                (function () {
                    'use strict';
                    document.getElementById('loginForm').addEventListener('submit', function (e) {
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