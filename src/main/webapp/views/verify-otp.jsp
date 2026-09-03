<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kích hoạt tài khoản</title>
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
            text-align:center;
        }
        .icon { font-size:3rem; margin-bottom:12px; }
        h2 { font-size:1.6rem; font-weight:800; color:#2c3e50; margin-bottom:6px; }
        .sub {
            font-size:0.9rem; color:#888; margin-bottom:24px; line-height:1.5;
        }
        .email-badge {
            display:inline-block; background:#eaf4ff; color:#2980b9;
            padding:4px 12px; border-radius:20px; font-size:0.85rem;
            font-weight:600; margin-bottom:24px;
        }
        .alert-danger {
            background:#fff5f5; border-left:3px solid #e74c3c;
            color:#c0392b; padding:10px 14px; border-radius:4px;
            font-size:0.88rem; margin-bottom:16px; text-align:left;
        }
        .alert-success {
            background:#f0fff4; border-left:3px solid #27ae60;
            color:#27ae60; padding:10px 14px; border-radius:4px;
            font-size:0.88rem; margin-bottom:16px; text-align:left;
        }
        .otp-input {
            width:100%; padding:14px; font-size:1.8rem; font-weight:700;
            text-align:center; letter-spacing:12px;
            border:2px solid #ddd; border-radius:8px; outline:none;
            color:#2c3e50; transition:border-color .2s;
            margin-bottom:20px;
        }
        .otp-input:focus { border-color:#3498db; }
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
        .timer {
            font-size:0.82rem; color:#bbb; margin-top:14px;
        }
        .timer span { color:#e74c3c; font-weight:700; }
    </style>
</head>
<body>
<div class="card">
    <div class="icon">📧</div>
    <h2>Xác minh Email</h2>
    <p class="sub">Mã OTP đã được gửi đến địa chỉ email của bạn.</p>
    <div class="email-badge">${sessionScope.pendingEmail}</div>

    <c:if test="${not empty alert}">
        <div class="alert-danger">${alert}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert-success">${success}</div>
    </c:if>

    <%-- Form xác minh OTP --%>
    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="hidden" name="action" value="verify">
        <input type="text" name="otp" class="otp-input"
               placeholder="• • • • • •" maxlength="6"
               autocomplete="one-time-code" autofocus>
        <button type="submit" class="btn btn-primary">Kích hoạt tài khoản</button>
    </form>

    <%-- Form gửi lại OTP --%>
    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <input type="hidden" name="action" value="resend">
        <button type="submit" class="btn btn-secondary">Gửi lại mã OTP</button>
    </form>

    <p class="timer">Mã OTP có hiệu lực trong <span>5 phút</span></p>
</div>
</body>
</html>
