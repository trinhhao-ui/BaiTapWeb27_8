<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Home</title>
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
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                header .logo {
                    font-size: 1.2rem;
                    font-weight: 700;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                }

                header .right {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                header .username {
                    font-size: 0.85rem;
                    color: #888;
                }

                header a {
                    color: #111;
                    text-decoration: none;
                    font-size: 0.85rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    border-bottom: 2px solid #111;
                    padding-bottom: 2px;
                    transition: opacity 0.2s;
                }

                header a:hover {
                    opacity: 0.5;
                }

                main {
                    flex: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 60px 40px;
                }

                .content {
                    max-width: 560px;
                    width: 100%;
                }

                .content h1 {
                    font-size: 2.8rem;
                    font-weight: 800;
                    letter-spacing: -1px;
                    margin-bottom: 24px;
                }

                .divider {
                    width: 40px;
                    height: 3px;
                    background: #111;
                    margin-bottom: 24px;
                }

                .info-table {
                    width: 100%;
                    border-collapse: collapse;
                }

                .info-table td {
                    padding: 12px 0;
                    font-size: 0.9rem;
                    border-bottom: 1px solid #eee;
                }

                .info-table td:first-child {
                    color: #888;
                    font-size: 0.75rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    width: 120px;
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
                <div class="right">
                    <span class="username">${sessionScope.currentUser.username}</span>
                    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                </div>
            </header>

            <main>
                <div class="content">
                    <h1>Hello,<br>${sessionScope.currentUser.fullName}</h1>
                    <div class="divider"></div>

                    <%-- Hiển thị thông tin user từ session --%>
                        <table class="info-table">
                            <tr>
                                <td>Username</td>
                                <td>${sessionScope.currentUser.username}</td>
                            </tr>
                            <tr>
                                <td>Họ tên</td>
                                <td>${sessionScope.currentUser.fullName}</td>
                            </tr>
                        </table>

                        <a href="${pageContext.request.contextPath}/admin/category/list" style="display:inline-block;margin-top:28px;padding:12px 32px;
                                  background:#1a2942;color:#fff;text-decoration:none;
                                  font-size:0.85rem;font-weight:700;letter-spacing:1px;text-transform:uppercase;">
                            Vào trang Admin
                        </a>
                </div>
            </main>

            <footer>&copy; 2026 WebApp</footer>

        </body>

        </html>