<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <title>Sản phẩm</title>
            </head>

            <body>

                <%-- Breadcrumb --%>
                    <nav aria-label="breadcrumb" class="mb-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Sản phẩm</li>
                        </ol>
                    </nav>

                    <div class="d-flex justify-content-between align-items-end mb-4">
                        <div>
                            <h4 class="mb-1">Tất cả sản phẩm</h4>
                            <p class="text-muted mb-0" style="font-size:.88rem">
                                ${totalProducts} sản phẩm &nbsp;·&nbsp; Trang ${currentPage} / ${totalPages}
                            </p>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-bag-x" style="font-size:3rem"></i>
                                <h5 class="mt-3">Chưa có sản phẩm nào</h5>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mb-4">
                                <c:forEach items="${products}" var="p">
                                    <div class="col">
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}"
                                            class="card h-100 text-decoration-none text-dark border-0 shadow-sm product-hover">
                                            <div
                                                style="aspect-ratio:4/3;overflow:hidden;background:#f8f9fa;display:flex;align-items:center;justify-content:center;border-radius:.375rem .375rem 0 0">
                                                <c:choose>
                                                    <c:when test="${not empty p.image}">
                                                        <img src="${pageContext.request.contextPath}/${p.image}"
                                                            alt="${p.name}"
                                                            style="width:100%;height:100%;object-fit:cover;transition:transform .35s"
                                                            class="product-img">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bi bi-image text-secondary"
                                                            style="font-size:3rem"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="card-body">
                                                <p class="text-uppercase text-muted mb-1"
                                                    style="font-size:.68rem;letter-spacing:1px;font-weight:700">
                                                    ${p.category.name}</p>
                                                <h6 class="card-title mb-2"
                                                    style="overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical">
                                                    ${p.name}</h6>
                                                <p class="fw-bold text-danger mb-1">
                                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                                </p>
                                                <p class="text-muted mb-0" style="font-size:.78rem">Còn ${p.quantity}
                                                    sản phẩm</p>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>

                            <%-- Phân trang --%>
                                <c:if test="${totalPages > 1}">
                                    <nav>
                                        <ul class="pagination justify-content-center">
                                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                    href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">←
                                                    Trước</a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${i == currentPage}">
                                                        <li class="page-item active"><span class="page-link">${i}</span>
                                                        </li>
                                                    </c:when>
                                                    <c:when
                                                        test="${i == 1 || i == totalPages || (i >= currentPage-2 && i <= currentPage+2)}">
                                                        <li class="page-item">
                                                            <a class="page-link"
                                                                href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                                                        </li>
                                                    </c:when>
                                                    <c:when test="${i == currentPage-3 || i == currentPage+3}">
                                                        <li class="page-item disabled"><span class="page-link">…</span>
                                                        </li>
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                    href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">Sau
                                                    →</a>
                                            </li>
                                        </ul>
                                    </nav>
                                    <p class="text-center text-muted" style="font-size:.82rem">
                                        Hiển thị ${(currentPage-1)*pageSize+1}–
                                        <c:choose>
                                            <c:when test="${currentPage*pageSize < totalProducts}">
                                                ${currentPage*pageSize}</c:when>
                                            <c:otherwise>${totalProducts}</c:otherwise>
                                        </c:choose>
                                        trong số ${totalProducts} sản phẩm
                                    </p>
                                </c:if>
                        </c:otherwise>
                    </c:choose>

                    <style>
                        .product-hover {
                            transition: transform .2s, box-shadow .2s;
                        }

                        .product-hover:hover {
                            transform: translateY(-4px);
                            box-shadow: 0 10px 28px rgba(0, 0, 0, .12) !important;
                        }

                        .product-hover:hover .product-img {
                            transform: scale(1.06);
                        }
                    </style>

            </body>

            </html>