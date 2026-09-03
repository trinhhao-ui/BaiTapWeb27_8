<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
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
            padding:40px 36px; width:100%; max-width:400px;
        }
        .back-link {
            display:inline-flex; align-items:center; gap:6px;
            font-size:0.85rem; color:#888; text-decoration:none;
            margin-bottom:24px;
        }
        .back-link:hover { color:#2c3e50; }
        .icon { font-size:2.5rem; margin-bottom:12px; }
        h2 { font-size:1.5rem; font-weight:800; color:#2c3e50; margin-bottom:6px; }
        .sub { font-size:0.88rem; color:#888; margin-bottom:28px; line-height:1.5; }
        .alert-danger {
            background:#fff5f5; border-left:3px solid #e74c3c;
            color:#c0392b; padding:10px 14px; border-radius:4px;
            font-size:0.88rem; margin-bottom:16px;
        }
        .field { margin-bottom:20px; }
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
        .btn-submit {
            width:100%; padding:13px;
            background:#2c3e50; color:#fff;
            border:none; border-radius:6px;
            font-size:0.9rem; font-weight:700;
            letter-spacing:.5px; cursor:pointer;
            transition:background .2s;
        }
        .btn-submit:hover { background:#34495e; }
    </style>
</head>
<body>
<div class="card">
    <a href="${pageContext.request.contextPath}/login" class="back-link">← Quay lại đăng nhập</a>

    <div class="icon">🔑</div>
    <h2>Quên Mật Khẩu</h2>
    <p class="sub">Nhập địa chỉ email đã đăng ký. Chúng tôi sẽ gửi mã OTP để đặt lại mật khẩu.</p>

    <c:if test="${not empty alert}">
        <div class="alert-danger">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="field">
            <label for="email">Địa chỉ Email</label>
            <input type="email" id="email" name="email"
                   placeholder="example@gmail.com"
                   value="${param.email}" required autofocus>
        </div>
        <button type="submit" class="btn-submit">Gửi mã OTP</button>
    </form>
</div>
</body>
</html>
