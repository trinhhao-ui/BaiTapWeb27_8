<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #fff; color: #111; min-height: 100vh; display: flex; flex-direction: column; }
        header { border-bottom: 2px solid #111; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        header .logo { font-size: 1.2rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; }
        header nav { display: flex; gap: 24px; }
        header nav a { color: #111; text-decoration: none; font-size: 0.9rem; font-weight: 600; letter-spacing: 1px; text-transform: uppercase; border-bottom: 2px solid transparent; padding-bottom: 2px; transition: border-color 0.2s; }
        header nav a:hover { border-bottom-color: #111; }
        main { flex: 1; display: flex; align-items: center; justify-content: center; padding: 60px 40px; }
        .hero { text-align: center; max-width: 500px; }
        .hero h1 { font-size: 3.5rem; font-weight: 800; letter-spacing: -2px; line-height: 1; margin-bottom: 16px; }
        .hero p { font-size: 1rem; color: #666; margin-bottom: 36px; line-height: 1.6; }
        .btn-group { display: flex; gap: 12px; justify-content: center; }
        .btn { display: inline-block; padding: 13px 32px; font-size: 0.85rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; text-decoration: none; transition: all 0.2s; }
        .btn-dark { background: #111; color: #fff; }
        .btn-dark:hover { background: #333; }
        .btn-outline { border: 2px solid #111; color: #111; }
        .btn-outline:hover { background: #111; color: #fff; }
        footer { border-top: 1px solid #ddd; padding: 16px 40px; text-align: center; font-size: 0.8rem; color: #999; letter-spacing: 1px; }
    </style>
</head>
<body>

<header>
    <span class="logo">WebApp</span>
    <nav>
        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
    </nav>
</header>

<main>
    <div class="hero">
        <h1>Welcome</h1>
        <p>Đăng nhập để tiếp tục hoặc tạo tài khoản mới.</p>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/login"    class="btn btn-dark">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline">Đăng ký</a>
        </div>
    </div>
</main>

<footer>&copy; 2026 WebApp</footer>

</body>
</html>
