<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng nhập</title>
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
                    font-size: 1.1rem;
                    font-weight: 700;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                }

                main {
                    flex: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 60px 20px;
                }

                .form-wrap {
                    width: 100%;
                    max-width: 360px;
                }

                .form-wrap h2 {
                    font-size: 2rem;
                    font-weight: 800;
                    margin-bottom: 6px;
                    letter-spacing: -1px;
                }

                .subtitle {
                    font-size: 0.9rem;
                    color: #888;
                    margin-bottom: 28px;
                }

                /* Alert - theo slide dùng ${alert} */
                .alert-danger {
                    background: #fff5f5;
                    border-left: 3px solid #c0392b;
                    padding: 11px 14px;
                    font-size: 0.88rem;
                    color: #c0392b;
                    margin-bottom: 18px;
                    border-radius: 2px;
                }

                .field {
                    margin-bottom: 22px;
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

                .remember-row {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 20px;
                    font-size: 0.85rem;
                    color: #888;
                }

                .remember-row label {
                    display: flex;
                    align-items: center;
                    gap: 6px;
                    cursor: pointer;
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
                    transition: background 0.2s;
                }

                .btn-submit:hover {
                    background: #333;
                }

                .divider {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    margin: 20px 0;
                }

                .divider::before,
                .divider::after {
                    content: '';
                    flex: 1;
                    height: 1px;
                    background: #eee;
                }

                .divider span {
                    font-size: 0.75rem;
                    color: #bbb;
                }

                .btn-register {
                    display: block;
                    width: 100%;
                    padding: 13px;
                    border: 2px solid #111;
                    background: transparent;
                    color: #111;
                    font-size: 0.85rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    text-align: center;
                    text-decoration: none;
                    transition: all 0.2s;
                }

                .btn-register:hover {
                    background: #111;
                    color: #fff;
                }

                .msg-success {
                    background: #f5fff5;
                    border-left: 3px solid #27ae60;
                    padding: 11px 14px;
                    font-size: 0.85rem;
                    color: #27ae60;
                    margin-bottom: 18px;
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
            </header>

            <main>
                <div class="form-wrap">
                    <h2>Đăng Nhập Vào Hệ Thống</h2>
                    <p class="subtitle">Nhập thông tin tài khoản của bạn</p>

                    <%-- Hiển thị alert từ Controller: ${alert} theo đúng slide --%>
                        <c:if test="${not empty alert}">
                            <div class="alert-danger">${alert}</div>
                        </c:if>

                        <%-- Thông báo đăng ký thành công --%>
                            <c:if test="${not empty sessionScope.registerSuccess}">
                                <div class="msg-success">${sessionScope.registerSuccess}</div>
                                <c:remove var="registerSuccess" scope="session" />
                            </c:if>

                            <%-- Form POST đến /login - theo slide: action="login" method="post" --%>
                                <form action="${pageContext.request.contextPath}/login" method="post">

                                    <div class="field">
                                        <label for="username">Tài khoản</label>
                                        <input type="text" id="username" name="username" placeholder="Tài khoản"
                                            required autofocus>
                                    </div>

                                    <div class="field">
                                        <label for="password">Mật khẩu</label>
                                        <input type="password" id="password" name="password" placeholder="Mật khẩu"
                                            required>
                                    </div>

                                    <div class="remember-row">
                                        <label>
                                            <input type="checkbox" name="remember"> Nhớ tôi
                                        </label>
                                        <a href="${pageContext.request.contextPath}/forgot-password"
                                           style="color:#111;font-size:0.85rem;text-decoration:none;font-weight:600">
                                            Quên mật khẩu?
                                        </a>
                                    </div>

                                    <button type="submit" class="btn-submit">Đăng nhập</button>
                                </form>

                                <div class="divider"><span>hoặc</span></div>

                                <a href="${pageContext.request.contextPath}/register" class="btn-register">
                                    Tạo tài khoản mới
                                </a>

                                <p style="text-align:center;margin-top:16px;font-size:0.85rem;color:#888">
                                    Nếu bạn chưa có tài khoản trên hệ thống, thì hãy
                                    <a href="${pageContext.request.contextPath}/register"
                                        style="color:#111;font-weight:700">Đăng ký</a>
                                </p>
                </div>
            </main>

            <footer>&copy; 2026 WebApp</footer>

        </body>

        </html>