<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng ký</title>
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
                    font-size: 1.1rem;
                    font-weight: 700;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                }

                header a {
                    color: #111;
                    text-decoration: none;
                    font-size: 0.85rem;
                    font-weight: 600;
                    opacity: 0.6;
                }

                header a:hover {
                    opacity: 1;
                }

                main {
                    flex: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 48px 20px;
                }

                .form-wrap {
                    width: 100%;
                    max-width: 380px;
                }

                .form-wrap h2 {
                    font-size: 1.9rem;
                    font-weight: 800;
                    margin-bottom: 24px;
                    letter-spacing: -1px;
                }

                .alert-danger {
                    background: #fff5f5;
                    border-left: 3px solid #c0392b;
                    padding: 11px 14px;
                    font-size: 0.88rem;
                    color: #c0392b;
                    margin-bottom: 18px;
                }

                .field {
                    margin-bottom: 20px;
                }

                .field label {
                    display: block;
                    font-size: 0.75rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    margin-bottom: 8px;
                    color: #555;
                }

                .field input {
                    width: 100%;
                    padding: 12px 0;
                    border: none;
                    border-bottom: 2px solid #ddd;
                    font-size: 1rem;
                    outline: none;
                    background: transparent;
                    color: #111;
                    transition: border-color 0.2s;
                }

                .field input:focus {
                    border-bottom-color: #111;
                }

                .btn-submit {
                    width: 100%;
                    padding: 14px;
                    background: #111;
                    color: #fff;
                    border: none;
                    font-size: 0.85rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    cursor: pointer;
                    margin-top: 8px;
                    transition: background 0.2s;
                }

                .btn-submit:hover {
                    background: #333;
                }

                .link-row {
                    margin-top: 18px;
                    text-align: center;
                    font-size: 0.85rem;
                    color: #888;
                }

                .link-row a {
                    color: #111;
                    font-weight: 700;
                    text-decoration: none;
                    border-bottom: 1px solid #111;
                }

                footer {
                    border-top: 1px solid #ddd;
                    padding: 16px 40px;
                    text-align: center;
                    font-size: 0.8rem;
                    color: #999;
                }
            </style>
        </head>

        <body>

            <header>
                <span class="logo">WebApp</span>
                <a href="${pageContext.request.contextPath}/login">← Đăng nhập</a>
            </header>

            <main>
                <div class="form-wrap">
                    <h2>Tạo tài khoản mới</h2>

                    <%-- Hiển thị alert từ Controller: ${alert} theo đúng slide --%>
                        <c:if test="${not empty alert}">
                            <div class="alert-danger">${alert}</div>
                        </c:if>

                        <%-- Form POST đến /register - theo slide: action="register" method="post" --%>
                            <form action="${pageContext.request.contextPath}/register" method="post">

                                <div class="field">
                                    <label for="username">Tài khoản</label>
                                    <input type="text" id="username" name="username" value="${param.username}"
                                        placeholder="Tài khoản" required autofocus>
                                </div>

                                <div class="field">
                                    <label for="fullname">Họ tên</label>
                                    <input type="text" id="fullname" name="fullname" value="${param.fullname}"
                                        placeholder="Họ tên" required>
                                </div>

                                <div class="field">
                                    <label for="email">Nhập Email</label>
                                    <input type="email" id="email" name="email" value="${param.email}"
                                        placeholder="Nhập Email">
                                </div>

                                <div class="field">
                                    <label for="phone">Số điện thoại</label>
                                    <input type="tel" id="phone" name="phone" value="${param.phone}"
                                        placeholder="Số điện thoại">
                                </div>

                                <div class="field">
                                    <label for="password">Mật khẩu</label>
                                    <input type="password" id="password" name="password" placeholder="Mật khẩu"
                                        required>
                                </div>

                                <div class="field">
                                    <label for="repassword">Nhập lại mật khẩu</label>
                                    <input type="password" id="repassword" name="repassword"
                                        placeholder="Nhập lại mật khẩu" required>
                                </div>

                                <button type="submit" class="btn-submit">Tạo tài khoản</button>
                            </form>

                            <div class="link-row">
                                Nếu bạn đã có tài khoản?
                                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                            </div>
                </div>
            </main>

            <footer>&copy; 2026 WebApp</footer>

        </body>

        </html>