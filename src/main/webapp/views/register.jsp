<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Đăng ký</title>
        </head>

        <body>

            <div class="auth-logo"><i class="bi bi-person-plus-fill"></i></div>
            <h2 class="auth-title">Tạo Tài Khoản</h2>
            <p class="auth-subtitle">Điền thông tin để đăng ký tài khoản mới</p>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-circle-fill me-2"></i>${alert}</div>
            </c:if>

            <form id="regForm" action="${pageContext.request.contextPath}/register" method="post" novalidate>

                <div class="form-group">
                    <label class="form-label">Tên đăng nhập <span class="required">*</span></label>
                    <input type="text" class="form-control" id="username" name="username" value="${param.username}"
                        placeholder="Tối thiểu 3 ký tự" pattern="^[a-zA-Z0-9_]{3,50}$" minlength="3" maxlength="50"
                        required autofocus>
                    <div class="invalid-feedback">3–50 ký tự, chỉ chữ cái, số và dấu gạch dưới (_).</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Họ và tên <span class="required">*</span></label>
                    <input type="text" class="form-control" id="fullname" name="fullname" value="${param.fullname}"
                        placeholder="Nhập họ và tên" minlength="3" maxlength="100" required>
                    <div class="invalid-feedback">Họ tên phải có từ 3–100 ký tự.</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Email <span class="required">*</span></label>
                    <input type="email" class="form-control" id="email" name="email" value="${param.email}"
                        placeholder="example@gmail.com" required>
                    <div class="invalid-feedback">Vui lòng nhập địa chỉ email hợp lệ.</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Số điện thoại</label>
                    <input type="tel" class="form-control" id="phone" name="phone" value="${param.phone}"
                        placeholder="0xxxxxxxxx" pattern="^0[0-9]{9}$">
                    <div class="invalid-feedback">Số điện thoại phải có 10 chữ số và bắt đầu bằng 0.</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Mật khẩu <span class="required">*</span></label>
                    <input type="password" class="form-control" id="password" name="password"
                        placeholder="Tối thiểu 6 ký tự" minlength="6" maxlength="50" required>
                    <div class="invalid-feedback">Mật khẩu phải có từ 6–50 ký tự.</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Nhập lại mật khẩu <span class="required">*</span></label>
                    <input type="password" class="form-control" id="repassword" name="repassword"
                        placeholder="Nhập lại mật khẩu" required>
                    <div class="invalid-feedback" id="repasswordFeedback">Vui lòng nhập lại mật khẩu.</div>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-person-check me-2"></i>Tạo tài khoản
                </button>
            </form>

            <div class="auth-footer">
                <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
            </div>

            <script>
                (function () {
                    'use strict';
                    const form = document.getElementById('regForm');
                    const pwd = document.getElementById('password');
                    const rpwd = document.getElementById('repassword');
                    const rFeed = document.getElementById('repasswordFeedback');

                    // Real-time check password match
                    function checkMatch() {
                        if (rpwd.value && rpwd.value !== pwd.value) {
                            rpwd.setCustomValidity('Mật khẩu nhập lại không khớp!');
                            rFeed.textContent = 'Mật khẩu nhập lại không khớp!';
                        } else {
                            rpwd.setCustomValidity('');
                            rFeed.textContent = 'Vui lòng nhập lại mật khẩu.';
                        }
                    }
                    pwd.addEventListener('input', checkMatch);
                    rpwd.addEventListener('input', checkMatch);

                    form.addEventListener('submit', function (e) {
                        checkMatch();
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