<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <title>Trang chủ</title>
            </head>

            <body>

                <%-- Thông tin user --%>
                    <div class="card mb-4">
                        <div class="card-body d-flex align-items-center gap-3">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.avatar}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.account.avatar}"
                                        style="width:64px;height:64px;border-radius:50%;object-fit:cover;border:2px solid #dee2e6"
                                        alt="avatar">
                                </c:when>
                                <c:otherwise>
                                    <div
                                        style="width:64px;height:64px;border-radius:50%;background:linear-gradient(135deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;font-size:1.6rem;color:#fff;flex-shrink:0">
                                        <i class="bi bi-person-fill"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div>
                                <h4 class="mb-1">Xin chào, <strong>${sessionScope.account.fullName}</strong></h4>
                                <p class="text-muted mb-2" style="font-size:.88rem">${sessionScope.account.email}</p>
                                <a href="${pageContext.request.contextPath}/user/profile"
                                    class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil me-1"></i>Chỉnh sửa hồ sơ
                                </a>
                            </div>
                        </div>
                    </div>

                    <%-- Thông tin chi tiết --%>
                        <div class="card mb-4">
                            <div class="card-header"><i class="bi bi-person-lines-fill me-2"></i>Thông tin tài khoản
                            </div>
                            <div class="card-body p-0">
                                <table class="table table-borderless mb-0">
                                    <tbody>
                                        <tr>
                                            <td class="text-muted fw-semibold" style="width:140px">Tên đăng nhập</td>
                                            <td>${sessionScope.account.userName}</td>
                                        </tr>
                                        <tr>
                                            <td class="text-muted fw-semibold">Họ tên</td>
                                            <td>${sessionScope.account.fullName}</td>
                                        </tr>
                                        <tr>
                                            <td class="text-muted fw-semibold">Email</td>
                                            <td>${not empty sessionScope.account.email ? sessionScope.account.email :
                                                '—'}</td>
                                        </tr>
                                        <tr>
                                            <td class="text-muted fw-semibold">Điện thoại</td>
                                            <td>${not empty sessionScope.account.phone ? sessionScope.account.phone :
                                                '—'}</td>
                                        </tr>
                                        <tr>
                                            <td class="text-muted fw-semibold">Vai trò</td>
                                            <td><span class="badge bg-primary">User</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <%-- 10 sản phẩm mới nhất --%>
                            <div class="d-flex justify-content-between align-items-end mb-3">
                                <div>
                                    <h5 class="mb-1">Sản phẩm mới nhất</h5>
                                    <p class="text-muted mb-0" style="font-size:.85rem">10 sản phẩm vừa được cập nhật
                                    </p>
                                </div>
                                <a href="${pageContext.request.contextPath}/product"
                                    class="btn btn-sm btn-outline-secondary">Xem tất cả →</a>
                            </div>

                            <c:choose>
                                <c:when test="${empty latestProducts}">
                                    <div class="text-center py-5 text-muted">
                                        <i class="bi bi-bag-x" style="font-size:2.5rem"></i>
                                        <p class="mt-2">Chưa có sản phẩm nào.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-5 g-3">
                                        <c:forEach items="${latestProducts}" var="p">
                                            <div class="col">
                                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}"
                                                    class="card h-100 text-decoration-none text-dark border-0 shadow-sm product-card-hover">
                                                    <div
                                                        style="aspect-ratio:1/1;overflow:hidden;background:#f8f9fa;display:flex;align-items:center;justify-content:center;border-radius:.375rem .375rem 0 0">
                                                        <c:choose>
                                                            <c:when test="${not empty p.image}">
                                                                <img src="${pageContext.request.contextPath}/${p.image}"
                                                                    alt="${p.name}"
                                                                    style="width:100%;height:100%;object-fit:cover">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="bi bi-image text-secondary"
                                                                    style="font-size:2.5rem"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="card-body p-2">
                                                        <p class="text-uppercase text-muted mb-1"
                                                            style="font-size:.65rem;letter-spacing:1px;font-weight:700">
                                                            ${p.category.name}</p>
                                                        <p class="mb-1 fw-semibold"
                                                            style="font-size:.88rem;overflow:hidden;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical">
                                                            ${p.name}</p>
                                                        <p class="mb-0 fw-bold text-danger">
                                                            <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                                        </p>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <style>
                                .product-card-hover {
                                    transition: transform .2s, box-shadow .2s;
                                }

                                .product-card-hover:hover {
                                    transform: translateY(-3px);
                                    box-shadow: 0 8px 24px rgba(0, 0, 0, .12) !important;
                                }
                            </style>

            </body>

            </html>