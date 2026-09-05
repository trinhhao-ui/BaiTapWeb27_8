<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>WebApp — Trang Chủ</title>
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

                    /* ── HEADER ── */
                    header {
                        border-bottom: 2px solid #111;
                        padding: 18px 40px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        position: sticky;
                        top: 0;
                        background: #fff;
                        z-index: 100;
                    }

                    header .logo {
                        font-size: 1.1rem;
                        font-weight: 800;
                        letter-spacing: 3px;
                        text-transform: uppercase;
                        text-decoration: none;
                        color: #111;
                    }

                    header nav {
                        display: flex;
                        gap: 20px;
                        align-items: center;
                    }

                    header nav a {
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

                    header nav a:hover {
                        color: #111;
                        border-bottom-color: #111;
                    }

                    header nav a.btn-login {
                        background: #111;
                        color: #fff;
                        padding: 8px 20px;
                        border-bottom: none;
                    }

                    header nav a.btn-login:hover {
                        background: #333;
                    }

                    /* ── HERO ── */
                    .hero {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 70px 40px 50px;
                        text-align: center;
                    }

                    .hero-inner {
                        max-width: 560px;
                    }

                    .hero h1 {
                        font-size: 3.8rem;
                        font-weight: 900;
                        letter-spacing: -3px;
                        line-height: 1;
                        margin-bottom: 18px;
                    }

                    .hero p {
                        font-size: 1rem;
                        color: #666;
                        margin-bottom: 32px;
                        line-height: 1.6;
                    }

                    .btn-group {
                        display: flex;
                        gap: 12px;
                        justify-content: center;
                    }

                    .btn {
                        display: inline-block;
                        padding: 13px 32px;
                        font-size: 0.85rem;
                        font-weight: 700;
                        letter-spacing: 1px;
                        text-transform: uppercase;
                        text-decoration: none;
                        transition: all .2s;
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

                    /* ── DIVIDER ── */
                    .section-divider {
                        border: none;
                        border-top: 1px solid #eee;
                        margin: 0 40px;
                    }

                    /* ── SẢN PHẨM MỚI NHẤT ── */
                    .products-section {
                        padding: 52px 40px 60px;
                        flex: 1;
                    }

                    .section-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-end;
                        margin-bottom: 32px;
                    }

                    .section-title {
                        font-size: 1.6rem;
                        font-weight: 800;
                        letter-spacing: -1px;
                    }

                    .section-sub {
                        font-size: 0.85rem;
                        color: #999;
                        margin-top: 4px;
                    }

                    .section-header a {
                        font-size: 0.8rem;
                        font-weight: 700;
                        color: #111;
                        text-decoration: none;
                        letter-spacing: 1px;
                        text-transform: uppercase;
                        border-bottom: 1px solid #111;
                        padding-bottom: 2px;
                    }

                    /* Grid sản phẩm */
                    .product-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                        gap: 24px;
                    }

                    .product-card {
                        border: 1px solid #eee;
                        border-radius: 4px;
                        overflow: hidden;
                        transition: box-shadow .2s, transform .2s;
                        cursor: pointer;
                        text-decoration: none;
                        color: inherit;
                        display: block;
                    }

                    .product-card:hover {
                        box-shadow: 0 6px 24px rgba(0, 0, 0, .1);
                        transform: translateY(-3px);
                    }

                    .product-card .img-wrap {
                        width: 100%;
                        aspect-ratio: 4/3;
                        background: #f5f5f5;
                        overflow: hidden;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .product-card .img-wrap img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        transition: transform .3s;
                    }

                    .product-card:hover .img-wrap img {
                        transform: scale(1.05);
                    }

                    .product-card .img-wrap .no-img {
                        font-size: 2.5rem;
                        color: #ddd;
                    }

                    .product-card .card-body {
                        padding: 14px;
                    }

                    .product-card .cate-tag {
                        font-size: 0.68rem;
                        font-weight: 700;
                        letter-spacing: 1px;
                        text-transform: uppercase;
                        color: #999;
                        margin-bottom: 6px;
                    }

                    .product-card .prod-name {
                        font-size: 0.92rem;
                        font-weight: 700;
                        color: #111;
                        margin-bottom: 8px;
                        line-height: 1.3;
                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }

                    .product-card .prod-price {
                        font-size: 1rem;
                        font-weight: 800;
                        color: #e74c3c;
                    }

                    /* Empty state */
                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                        color: #bbb;
                    }

                    .empty-state .icon {
                        font-size: 3rem;
                        margin-bottom: 12px;
                    }

                    .empty-state p {
                        font-size: 0.9rem;
                    }

                    /* ── FOOTER ── */
                    footer {
                        border-top: 1px solid #ddd;
                        padding: 16px 40px;
                        text-align: center;
                        font-size: 0.78rem;
                        color: #aaa;
                    }
                </style>
            </head>

            <body>

                <header>
                    <a href="${pageContext.request.contextPath}/" class="logo">WebApp</a>
                    <nav>
                        <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                        <a href="${pageContext.request.contextPath}/product">Sản phẩm</a>
                        <a href="${pageContext.request.contextPath}/login" class="btn-login">Đăng nhập</a>
                    </nav>
                </header>

                <%-- ── HERO ── --%>
                    <section class="hero">
                        <div class="hero-inner">
                            <h1>Welcome</h1>
                            <p>Khám phá bộ sưu tập sản phẩm mới nhất của chúng tôi.<br>Đăng nhập để trải nghiệm đầy đủ
                                tính năng.</p>
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-dark">Đăng nhập</a>
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline">Tạo tài
                                    khoản</a>
                            </div>
                        </div>
                    </section>

                    <hr class="section-divider">

                    <%-- ── 10 SẢN PHẨM MỚI NHẤT ── --%>
                        <section class="products-section">
                            <div class="section-header">
                                <div>
                                    <div class="section-title">Sản phẩm mới nhất</div>
                                    <div class="section-sub">Cập nhật liên tục mỗi ngày</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/login">Xem tất cả →</a>
                            </div>

                            <c:choose>
                                <c:when test="${empty latestProducts}">
                                    <div class="empty-state">
                                        <div class="icon">🛍</div>
                                        <p>Chưa có sản phẩm nào. Hãy quay lại sau!</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="product-grid">
                                        <c:forEach items="${latestProducts}" var="p">
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}"
                                                class="product-card">
                                                <div class="img-wrap">
                                                    <c:choose>
                                                        <c:when test="${not empty p.image}">
                                                            <img src="${pageContext.request.contextPath}/${p.image}"
                                                                alt="${p.name}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="no-img">🖼️</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="card-body">
                                                    <div class="cate-tag">${p.category.name}</div>
                                                    <div class="prod-name" title="${p.name}">${p.name}</div>
                                                    <div class="prod-price">
                                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                                    </div>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </section>

                        <footer>&copy; 2026 WebApp</footer>

            </body>

            </html>