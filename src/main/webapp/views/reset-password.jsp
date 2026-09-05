<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Đặt lại mật khẩu</title>
        </head>

        <body>

            <div class="auth-logo"><i class="bi bi-lock-fill"></i></div>
            <h2 class="auth-title">Đặt Lại Mật Khẩu</h2>
            <p class="auth-subtitle">Nhập mã OTP đã gửi đến</p>

            <div class="text-center mb-3">
                <span class="badge rounded-pill"
                    style="background:#eaf4ff;color:#2980b9;font-size:.9rem;padding:6px 16px;font-weight:600">
                    ${sessionScope.resetEmail}
                </span>
            </div>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill me-2"></i>${alert}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill me-2"></i>${success}</div>
            </c:if>

            <form id="resetForm" action="${pageContext.request.contextPath}/reset-password" method="post" novalidate>
                <input type="hidden" name="action" value="reset">

                <div class="form-group">
                    <label class="form-label text-center d-block">Mã OTP</label>
                    <input type="text" class="form-control text-center" id="otp" name="otp" maxlength="6" minlength="6"
                        pattern="^[0-9]{6}$" autocomplete="one-time-code" placeholder="• • • • • •" required autofocus
                        style="font-size:1.5rem;font-weight:700;letter-spacing:8px">
                    <div class="invalid-feedback text-center">Mã OTP phải gồm đúng 6 chữ số.</div>
                </div>

                <hr class="my-3">

                <div class="form-group">
                    <label class="form-label">Mật khẩu mới <span class="required">*</span></label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword"
                        placeholder="Tối thiểu 6 ký tự" minlength="6" maxlength="50" required>
                    <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Nhập lại mật khẩu <span class="required">*</span></label>
                    <input type="password" class="form-control" id="rePassword" name="rePassword"
                        placeholder="Nhập lại mật khẩu mới" required>
                    <div class="invalid-feedback" id="rePwdFeedback">Vui lòng nhập lại mật khẩu.</div>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-check2-circle me-2"></i>Đặt lại mật khẩu
                </button>
            </form>

            <div class="divider"><span>hoặc</span></div>

            <form action="${pageContext.request.contextPath}/reset-password" method="post">
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
                    const otp = document.getElementById('otp');
                    const newPwd = document.getElementById('newPassword');
                    const rePwd = document.getElementById('rePassword');
                    const reFeed = document.getElementById('rePwdFeedback');

                    // Chỉ cho nhập số vào OTP
                    otp.addEventListener('input', function () {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    });

                    // Kiểm tra confirm match
                    function checkMatch() {
                        if (rePwd.value && rePwd.value !== newPwd.value) {
                            rePwd.setCustomValidity('Mật khẩu nhập lại không khớp!');
                            reFeed.textContent = 'Mật khẩu nhập lại không khớp!';
                        } else {
                            rePwd.setCustomValidity('');
                            reFeed.textContent = 'Vui lòng nhập lại mật khẩu.';
                        }
                    }
                    newPwd.addEventListener('input', checkMatch);
                    rePwd.addEventListener('input', checkMatch);

                    document.getElementById('resetForm').addEventListener('submit', function (e) {
                        checkMatch();
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