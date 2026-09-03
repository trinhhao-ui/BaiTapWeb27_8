<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Lỗi</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', Arial, sans-serif;
                    background: #fff;
                    color: #111;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                }

                header {
                    border-bottom: 2px solid #111;
                    padding: 20px 40px;
                }

                header .logo {
                    font-size: 1.2rem;
                    font-weight: 700;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                }

                main {
                    flex: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 60px 40px;
                }

                .content {
                    text-align: center;
                    max-width: 400px;
                }

                .code {
                    font-size: 6rem;
                    font-weight: 900;
                    letter-spacing: -4px;
                    color: #eee;
                    line-height: 1;
                    margin-bottom: 4px;
                }

                .content h2 {
                    font-size: 1.3rem;
                    font-weight: 700;
                    margin-bottom: 10px;
                }

                .content p {
                    font-size: 0.9rem;
                    color: #888;
                    margin-bottom: 32px;
                }

                .btn-group {
                    display: flex;
                    gap: 12px;
                    justify-content: center;
                }

                .btn {
                    display: inline-block;
                    padding: 12px 28px;
                    font-size: 0.82rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    text-decoration: none;
                    transition: all 0.2s;
                }

                .btn-dark {
                    background: #111;
                    color: #fff;
                }

                .btn-dark:hover {
                    background: #333;
                }

                .btn-outline {
                    border: 2px solid #111;
                    color: #111;
                }

                .btn-outline:hover {
                    background: #111;
                    color: #fff;
                }

                footer {
                    border-top: 1px solid #ddd;
                    padding: 16px 40px;
                    text-align: center;
                    font-size: 0.8rem;
                    color: #999;
                    letter-spacing: 1px;
                }
            </style>
        </head>

        <body>

            <header>
                <span class="logo">WebApp</span>
            </header>

            <main>
                <div class="content">
                    <div class="code">401</div>
                    <h2>Đăng nhập thất bại</h2>
                    <p>Tên đăng nhập hoặc mật khẩu không chính xác.</p>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-dark">Thử lại</a>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline">Trang chủ</a>
                    </div>
                </div>
            </main>

            <footer>&copy; 2026 WebApp</footer>

        </body>

        </html>