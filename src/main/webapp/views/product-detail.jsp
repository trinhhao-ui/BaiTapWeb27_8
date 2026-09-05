<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="/common/header.jsp">
                <jsp:param name="title" value="${product.name}" />
            </jsp:include>

            <style>
                /* ── BREADCRUMB ── */
                .breadcrumb-wrap {
                    max-width: 1000px;
                    margin: 0 auto;
                    padding: 16px 24px 0;
                    font-size: 0.82rem;
                    color: #aaa;
                    display: flex;
                    gap: 8px;
                    align-items: center;
                }

                .breadcrumb-wrap a {
                    color: #aaa;
                    text-decoration: none;
                }

                .breadcrumb-wrap a:hover {
                    color: #111;
                }

                .breadcrumb-wrap .sep {
                    color: #ddd;
                }

                .breadcrumb-wrap .cur {
                    color: #555;
                    font-weight: 600;
                }

                /* ── LAYOUT ── */
                .detail-wrap {
                    max-width: 1000px;
                    margin: 0 auto;
                    padding: 28px 24px 60px;
                }

                .detail-layout {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 56px;
                    align-items: start;
                }

                /* ── ẢNH ── */
                .img-section .main-img {
                    width: 100%;
                    aspect-ratio: 1/1;
                    background: #f7f7f7;
                    border-radius: 8px;
                    overflow: hidden;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border: 1px solid #eee;
                }

                .img-section .main-img img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .img-section .no-img {
                    font-size: 5rem;
                    color: #ddd;
                }

                /* ── THÔNG TIN ── */
                .info-section {
                    padding-top: 8px;
                }

                .cate-tag {
                    font-size: 0.72rem;
                    font-weight: 700;
                    letter-spacing: 1.5px;
                    text-transform: uppercase;
                    color: #bbb;
                    margin-bottom: 10px;
                }

                .prod-title {
                    font-size: 1.9rem;
                    font-weight: 800;
                    letter-spacing: -1px;
                    line-height: 1.2;
                    margin-bottom: 20px;
                }

                .prod-price {
                    font-size: 2rem;
                    font-weight: 900;
                    color: #e74c3c;
                    margin-bottom: 20px;
                }

                .divider {
                    border: none;
                    border-top: 1px solid #eee;
                    margin: 20px 0;
                }

                .meta-list {
                    list-style: none;
                    margin-bottom: 24px;
                }

                .meta-list li {
                    display: flex;
                    gap: 12px;
                    padding: 9px 0;
                    border-bottom: 1px solid #f5f5f5;
                    font-size: 0.9rem;
                }

                .meta-list li:last-child {
                    border-bottom: none;
                }

                .meta-list .label {
                    width: 110px;
                    font-weight: 700;
                    font-size: 0.75rem;
                    letter-spacing: .5px;
                    text-transform: uppercase;
                    color: #aaa;
                    flex-shrink: 0;
                    padding-top: 2px;
                }

                .meta-list .value {
                    color: #111;
                }

                .badge-active {
                    display: inline-block;
                    padding: 3px 10px;
                    background: #e8f5e9;
                    color: #27ae60;
                    font-size: 0.72rem;
                    font-weight: 700;
                    border-radius: 20px;
                }

                .desc-section {
                    margin-bottom: 28px;
                }

                .desc-section h3 {
                    font-size: 0.78rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    color: #aaa;
                    margin-bottom: 10px;
                }

                .desc-section p {
                    font-size: 0.92rem;
                    line-height: 1.7;
                    color: #444;
                    white-space: pre-wrap;
                }

                .desc-empty {
                    font-size: 0.88rem;
                    color: #ccc;
                    font-style: italic;
                }

                .btn-group {
                    display: flex;
                    gap: 12px;
                    margin-top: 8px;
                }

                .btn {
                    display: inline-block;
                    padding: 12px 28px;
                    font-size: 0.85rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    text-decoration: none;
                    border: none;
                    cursor: pointer;
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
                    background: transparent;
                }

                .btn-outline:hover {
                    background: #111;
                    color: #fff;
                }

                @media (max-width: 700px) {
                    .detail-layout {
                        grid-template-columns: 1fr;
                        gap: 28px;
                    }

                    .prod-title {
                        font-size: 1.4rem;
                    }

                    .detail-wrap {
                        padding: 20px 16px 48px;
                    }
                }
            </style>

            <%-- Breadcrumb --%>
                <div class="breadcrumb-wrap">
                    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                    <span class="sep">/</span>
                    <a href="${pageContext.request.contextPath}/product">Sản phẩm</a>
                    <span class="sep">/</span>
                    <span class="cur">${product.name}</span>
                </div>

                <div class="detail-wrap">
                    <div class="detail-layout">

                        <%-- ẢNH --%>
                            <div class="img-section">
                                <div class="main-img">
                                    <c:choose>
                                        <c:when test="${not empty product.image}">
                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                alt="${product.name}">
                                        </c:when>
                                        <c:otherwise><span class="no-img">🖼️</span></c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <%-- THÔNG TIN --%>
                                <div class="info-section">
                                    <div class="cate-tag">${product.category.name}</div>
                                    <div class="prod-title">${product.name}</div>
                                    <div class="prod-price">
                                        <fmt:formatNumber value="${product.price}" pattern="#,##0" />đ
                                    </div>

                                    <hr class="divider">

                                    <ul class="meta-list">
                                        <li>
                                            <span class="label">Số lượng</span>
                                            <span class="value">${product.quantity} sản phẩm</span>
                                        </li>
                                        <li>
                                            <span class="label">Danh mục</span>
                                            <span class="value">${product.category.name}</span>
                                        </li>
                                        <li>
                                            <span class="label">Trạng thái</span>
                                            <span class="value"><span class="badge-active">Đang bán</span></span>
                                        </li>
                                    </ul>

                                    <hr class="divider">

                                    <div class="desc-section">
                                        <h3>Mô tả sản phẩm</h3>
                                        <c:choose>
                                            <c:when test="${not empty product.description}">
                                                <p>${product.description}</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="desc-empty">Chưa có mô tả cho sản phẩm này.</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="btn-group">
                                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline">←
                                            Quay lại</a>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.account}">
                                                <a href="${pageContext.request.contextPath}/user/home"
                                                    class="btn btn-dark">Trang chủ</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login"
                                                    class="btn btn-dark">Đăng nhập</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                    </div>
                </div>

                <jsp:include page="/common/footer.jsp" />