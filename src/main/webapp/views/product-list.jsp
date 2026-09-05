<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="/common/header.jsp">
                <jsp:param name="title" value="Sản Phẩm" />
            </jsp:include>

            <style>
                /* ── BREADCRUMB ── */
                .breadcrumb-wrap {
                    max-width: 1100px;
                    margin: 0 auto 0;
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

                /* ── CONTAINER ── */
                .pl-wrap {
                    max-width: 1100px;
                    margin: 0 auto;
                    padding: 28px 24px 52px;
                }

                .page-heading {
                    margin-bottom: 28px;
                }

                .page-heading h1 {
                    font-size: 2rem;
                    font-weight: 800;
                    letter-spacing: -1px;
                    margin-bottom: 4px;
                }

                .page-heading p {
                    font-size: 0.88rem;
                    color: #999;
                }

                /* ── GRID ── */
                .product-grid {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 28px;
                    margin-bottom: 48px;
                }

                .product-card {
                    border: 1px solid #eee;
                    border-radius: 6px;
                    overflow: hidden;
                    text-decoration: none;
                    color: inherit;
                    display: block;
                    transition: box-shadow .2s, transform .2s;
                    background: #fff;
                }

                .product-card:hover {
                    box-shadow: 0 8px 28px rgba(0, 0, 0, .1);
                    transform: translateY(-3px);
                }

                .product-card .img-wrap {
                    width: 100%;
                    aspect-ratio: 4/3;
                    background: #f7f7f7;
                    overflow: hidden;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .product-card .img-wrap img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform .35s;
                }

                .product-card:hover .img-wrap img {
                    transform: scale(1.06);
                }

                .product-card .img-wrap .no-img {
                    font-size: 3rem;
                    color: #ddd;
                }

                .product-card .card-body {
                    padding: 16px;
                }

                .cate-tag {
                    font-size: 0.68rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    color: #bbb;
                    margin-bottom: 6px;
                }

                .prod-name {
                    font-size: 0.95rem;
                    font-weight: 700;
                    color: #111;
                    margin-bottom: 8px;
                    line-height: 1.3;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                }

                .prod-price {
                    font-size: 1.05rem;
                    font-weight: 800;
                    color: #e74c3c;
                }

                .prod-stock {
                    font-size: 0.75rem;
                    color: #bbb;
                    margin-top: 4px;
                }

                /* ── EMPTY ── */
                .empty-state {
                    text-align: center;
                    padding: 80px 20px;
                    color: #ccc;
                }

                .empty-state .icon {
                    font-size: 4rem;
                    margin-bottom: 16px;
                }

                .empty-state h3 {
                    font-size: 1.1rem;
                    color: #999;
                    margin-bottom: 8px;
                }

                /* ── PAGINATION ── */
                .pagination {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 8px;
                    margin-top: 8px;
                }

                .pagination a,
                .pagination span {
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    width: 38px;
                    height: 38px;
                    border: 1px solid #ddd;
                    border-radius: 4px;
                    font-size: 0.85rem;
                    font-weight: 600;
                    text-decoration: none;
                    color: #555;
                    transition: all .2s;
                }

                .pagination a:hover {
                    background: #111;
                    color: #fff;
                    border-color: #111;
                }

                .pagination span.current {
                    background: #111;
                    color: #fff;
                    border-color: #111;
                }

                .pagination span.dots {
                    border: none;
                    color: #bbb;
                    cursor: default;
                }

                .pagination a.prev,
                .pagination a.next {
                    width: auto;
                    padding: 0 14px;
                    font-size: 0.8rem;
                    letter-spacing: .5px;
                }

                .pagination-info {
                    text-align: center;
                    margin-top: 14px;
                    font-size: 0.82rem;
                    color: #aaa;
                }

                @media (max-width: 768px) {
                    .product-grid {
                        grid-template-columns: repeat(2, 1fr);
                        gap: 16px;
                    }

                    .pl-wrap {
                        padding: 20px 16px 40px;
                    }
                }

                @media (max-width: 480px) {
                    .product-grid {
                        grid-template-columns: 1fr;
                    }
                }
            </style>

            <%-- Breadcrumb --%>
                <div class="breadcrumb-wrap">
                    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                    <span class="sep">/</span>
                    <span class="cur">Sản phẩm</span>
                </div>

                <div class="pl-wrap">
                    <div class="page-heading">
                        <h1>Tất cả sản phẩm</h1>
                        <p>${totalProducts} sản phẩm &nbsp;·&nbsp; Trang ${currentPage} / ${totalPages}</p>
                    </div>

                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="empty-state">
                                <div class="icon">🛍</div>
                                <h3>Chưa có sản phẩm nào</h3>
                                <p>Hãy quay lại sau!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="product-grid">
                                <c:forEach items="${products}" var="p">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}"
                                        class="product-card">
                                        <div class="img-wrap">
                                            <c:choose>
                                                <c:when test="${not empty p.image}">
                                                    <img src="${pageContext.request.contextPath}/${p.image}"
                                                        alt="${p.name}" loading="lazy">
                                                </c:when>
                                                <c:otherwise><span class="no-img">🖼️</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="card-body">
                                            <div class="cate-tag">${p.category.name}</div>
                                            <div class="prod-name">${p.name}</div>
                                            <div class="prod-price">
                                                <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                            </div>
                                            <div class="prod-stock">Còn ${p.quantity} sản phẩm</div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>

                            <%-- PHÂN TRANG --%>
                                <c:if test="${totalPages > 1}">
                                    <div class="pagination">
                                        <c:choose>
                                            <c:when test="${currentPage > 1}">
                                                <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}"
                                                    class="prev">← Trước</a>
                                            </c:when>
                                            <c:otherwise><span class="prev" style="opacity:.3;cursor:default">←
                                                    Trước</span></c:otherwise>
                                        </c:choose>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <c:choose>
                                                <c:when test="${i == currentPage}">
                                                    <span class="current">${i}</span>
                                                </c:when>
                                                <c:when
                                                    test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                                                    <a
                                                        href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                                                </c:when>
                                                <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                                                    <span class="dots">…</span>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>

                                        <c:choose>
                                            <c:when test="${currentPage < totalPages}">
                                                <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}"
                                                    class="next">Sau →</a>
                                            </c:when>
                                            <c:otherwise><span class="next" style="opacity:.3;cursor:default">Sau
                                                    →</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="pagination-info">
                                        Hiển thị ${(currentPage - 1) * pageSize + 1} –
                                        <c:choose>
                                            <c:when test="${currentPage * pageSize < totalProducts}">${currentPage *
                                                pageSize}</c:when>
                                            <c:otherwise>${totalProducts}</c:otherwise>
                                        </c:choose>
                                        trong số ${totalProducts} sản phẩm
                                    </div>
                                </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>

                <jsp:include page="/common/footer.jsp" />