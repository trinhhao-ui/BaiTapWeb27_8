<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${param.title != null ? param.title : 'WebApp'}</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', Arial, sans-serif;
                    background: #f4f6f9;
                    color: #111;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                }

                .app-header {
                    background: #fff;
                    border-bottom: 2px solid #111;
                    padding: 16px 40px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    position: sticky;
                    top: 0;
                    z-index: 100;
                }

                .app-header .logo {
                    font-size: 1.1rem;
                    font-weight: 800;
                    letter-spacing: 3px;
                    text-transform: uppercase;
                    text-decoration: none;
                    color: #111;
                }

                .app-header nav {
                    display: flex;
                    align-items: center;
                    gap: 24px;
                }

                .app-header nav a {
                    color: #555;
                    text-decoration: none;
                    font-size: 0.85rem;
                    font-weight: 600;
                    letter-spacing: .5px;
                    text-transform: uppercase;
                    padding-bottom: 2px;
                    border-bottom: 2px solid transparent;
                    transition: all .2s;
                }

                .app-header nav a:hover {
                    color: #111;
                    border-bottom-color: #111;
                }

                .app-header nav a.btn-logout {
                    color: #e74c3c;
                }

                .app-header nav a.btn-logout:hover {
                    border-bottom-color: #e74c3c;
                }

                .app-header nav a.btn-login {
                    background: #111;
                    color: #fff;
                    padding: 7px 18px;
                    border-bottom: none;
                }

                .app-header nav a.btn-login:hover {
                    background: #333;
                }

                .header-avatar {
                    width: 30px;
                    height: 30px;
                    border-radius: 50%;
                    object-fit: cover;
                    border: 2px solid #ddd;
                    vertical-align: middle;
                }

                .header-username {
                    font-size: 0.82rem;
                    color: #999;
                }

                .app-main {
                    flex: 1;
                    padding: 36px 20px;
                }

                .app-footer {
                    border-top: 1px solid #ddd;
                    padding: 14px 40px;
                    text-align: center;
                    font-size: 0.78rem;
                    color: #aaa;
                }

                .alert-danger {
                    background: #fff5f5;
                    border-left: 3px solid #e74c3c;
                    color: #c0392b;
                    padding: 10px 16px;
                    border-radius: 4px;
                    font-size: 0.88rem;
                    margin-bottom: 18px;
                }

                .alert-success {
                    background: #f0fff4;
                    border-left: 3px solid #27ae60;
                    color: #27ae60;
                    padding: 10px 16px;
                    border-radius: 4px;
                    font-size: 0.88rem;
                    margin-bottom: 18px;
                }
            </style>
        </head>

        <body>

            <header class="app-header">
                <%-- Logo: đã login -> user/home, chưa -> / --%>
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <a href="${pageContext.request.contextPath}/user/home" class="logo">WebApp</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/" class="logo">WebApp</a>
                        </c:otherwise>
                    </c:choose>

                    <nav>
                        <%-- Nav links chung --%>
                            <c:choose>
                                <c:when test="${not empty sessionScope.account}">
                                    <%-- Đã đăng nhập --%>
                                        <c:if test="${not empty sessionScope.account.avatar}">
                                            <img src="${pageContext.request.contextPath}/${sessionScope.account.avatar}"
                                                class="header-avatar" alt="avatar">
                                        </c:if>
                                        <span class="header-username">${sessionScope.account.userName}</span>
                                        <a href="${pageContext.request.contextPath}/user/home">Trang chủ</a>
                                        <a href="${pageContext.request.contextPath}/product">Sản phẩm</a>
                                        <a href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a>
                                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Đăng
                                            xuất</a>
                                </c:when>
                                <c:otherwise>
                                    <%-- Chưa đăng nhập --%>
                                        <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                                        <a href="${pageContext.request.contextPath}/product">Sản phẩm</a>
                                        <a href="${pageContext.request.contextPath}/login" class="btn-login">Đăng
                                            nhập</a>
                                </c:otherwise>
                            </c:choose>
                    </nav>
            </header>

            <main class="app-main">