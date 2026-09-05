<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Xác minh OTP</title>
        </head>

        <body>

            <div class="auth-logo"><i class="bi bi-envelope-check-fill"></i></div>
            <h2 class="auth-title">Xác Minh Email</h2>
            <p class="auth-subtitle">Mã OTP đã được gửi đến</p>

            <div class="text-center mb-3">
                <span class="badge rounded-pill"
                    style="background:#eaf4ff;color:#2980b9;font-size:.9rem;padding:6px 16px;font-weight:600">
                    ${sessionScope.pendingEmail}
                </span>
            </div>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill me-2"></i>${alert}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill me-2"></i>${success}</div>
            </c:if>

            <form id="otpForm" action="${pageContext.request.contextPath}/verify-otp" method="post" novalidate>
                <input type="hidden" name="action" value="verify">
                <div class="form-group">
                    <label class="form-label text-center d-block">Nhập mã OTP 6 chữ số</label>
                    <input type="text" class="form-control text-center" id="otp" name="otp" maxlength="6" minlength="6"
                        pattern="^[0-9]{6}$" autocomplete="one-time-code" placeholder="• • • • • •" autofocus required
                        style="font-size:1.8rem;font-weight:700;letter-spacing:10px">
                    <div class="invalid-feedback text-center">Mã OTP phải gồm đúng 6 chữ số.</div>
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-shield-check me-2"></i>Kích hoạt tài khoản
                </button>
            </form>

            <div class="divider"><span>hoặc</span></div>

            <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                <input type="hidden" name="action" value="resend">
                <button type="submit" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-repeat me-2"></i>Gửi lại mã OTP
                </button>
            </form>

            <p class="text-center mt-3" style="font-size:.82rem;color:#adb5bd">
                Mã OTP có hiệu lực trong <strong style="color:#e74c3c">5 phút</strong>
            </p>

            <script>
                (function () {
                    'use strict';
                    const otpInput = document.getElementById('otp');

                    // Chỉ cho nhập số
                    otpInput.addEventListener('input', function () {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    });

                    document.getElementById('otpForm').addEventListener('submit', function (e) {
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