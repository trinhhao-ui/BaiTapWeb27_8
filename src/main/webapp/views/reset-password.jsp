<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family:'Segoe UI',Arial,sans-serif;
            background:#f4f6f9;
            min-height:100vh;
            display:flex; align-items:center; justify-content:center;
        }
        .card {
            background:#fff; border-radius:10px;
            box-shadow:0 4px 20px rgba(0,0,0,.08);
            padding:40px 36px; width:100%; max-width:420px;
        }
        .icon { font-size:2.5rem; margin-bottom:12px; text-align:center; }
        h2 {
            font-size:1.5rem; font-weight:800; color:#2c3e50;
            margin-bottom:6px; text-align:center;
        }
        .sub {
            font-size:0.88rem; color:#888; text-align:center;
            margin-bottom:6px; line-height:1.5;
        }
        .email-badge {
            display:block; text-align:center;
            background:#eaf4ff; color:#2980b9;
            padding:4px 12px; border-radius:20px;
            font-size:0.85rem; font-weight:600;
            margin:0 auto 24px; width:fit-content;
        }
        .alert-danger {
            background:#fff5f5; border-left:3px solid #e74c3c;
            color:#c0392b; padding:10px 14px; border-radius:4px;
            font-size:0.88rem; margin-bottom:16px;
        }
        .alert-success {
            background:#f0fff4; border-left:3px solid #27ae60;
            color:#27ae60; padding:10px 14px; border-radius:4px;
            font-size:0.88rem; margin-bottom:16px;
        }
        .field { margin-bottom:18px; }
        .field label {
            display:block; font-size:0.75rem; font-weight:700;
            letter-spacing:1px; text-transform:uppercase;
            color:#555; margin-bottom:8px;
        }
        .field input {
            width:100%; padding:12px 14px;
            border:2px solid #e8e8e8; border-radius:6px;
            font-size:0.95rem; outline:none; color:#2c3e50;
            transition:border-color .2s;
        }
        .field input:focus { border-color:#3498db; }
        .otp-field input {
            font-size:1.6rem; font-weight:700;
            text-align:center; letter-spacing:10px;
        }
        .divider { border:none; border-top:1px solid #f0f0f0; margin:20px 0; }
        .btn {
            width:100%; padding:13px; border:none; border-radius:6px;
            font-size:0.9rem; font-weight:700; cursor:pointer;
            letter-spacing:.5px; transition:background .2s;
        }
        .btn-primary { background:#2c3e50; color:#fff; margin-bottom:10px; }
        .btn-primary:hover { background:#34495e; }
        .btn-secondary {
            background:transparent; color:#888;
            border:1px solid #ddd; font-size:0.85rem;
        }
        .btn-secondary:hover { background:#f8f8f8; }
        .timer { font-size:0.82rem; color:#bbb; text-align:center; margin-top:12px; }
        .timer span { color:#e74c3c; font-weight:700; }
    </style>
</head>
<body>
<div class="card">
    <div class="icon">🔒</div>
    <h2>Đặt Lại Mật Khẩu</h2>
    <p class="sub">Nhập mã OTP đã gửi đến</p>
    <span class="email-badge">${sessionScope.resetEmail}</span>

    <c:if test="${not empty alert}">
        <div class="alert-danger">${alert}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert-success">${success}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="action" value="reset">

        <%-- OTP --%>
        <div class="field otp-field">
            <label for="otp">Mã OTP</label>
            <input type="text" id="otp" name="otp"
                   placeholder="• • • • • •" maxlength="6"
                   autocomplete="one-time-code" autofocus>
        </div>

        <hr class="divider">

        <%-- Mật khẩu mới --%>
        <div class="field">
            <label for="newPassword">Mật khẩu mới</label>
            <input type="password" id="newPassword" name="newPassword"
                   placeholder="Ít nhất 6 ký tự" minlength="6">
        </div>

        <div class="field">
            <label for="rePassword">Nhập lại mật khẩu</label>
            <input type="password" id="rePassword" name="rePassword"
                   placeholder="Nhập lại mật khẩu mới">
        </div>

        <button type="submit" class="btn btn-primary">Đặt lại mật khẩu</button>
    </form>

    <%-- Gửi lại OTP --%>
    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <input type="hidden" name="action" value="resend">
        <button type="submit" class="btn btn-secondary">Gửi lại mã OTP</button>
    </form>

    <p class="timer">Mã OTP có hiệu lực trong <span>5 phút</span></p>
</div>

<script>
    // Chỉ cho phép nhập số vào ô OTP
    document.getElementById('otp').addEventListener('input', function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
</script>
</body>
</html>
