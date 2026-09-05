<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <title>${product.name}</title>
            </head>

            <body>

                <%-- Breadcrumb --%>
                    <nav aria-label="breadcrumb" class="mb-4">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product">Sản
                                    phẩm</a></li>
                            <li class="breadcrumb-item active">${product.name}</li>
                        </ol>
                    </nav>

                    <div class="row g-5">

                        <%-- Ảnh sản phẩm --%>
                            <div class="col-12 col-md-5">
                                <div class="card border-0 shadow-sm"
                                    style="aspect-ratio:1/1;overflow:hidden;display:flex;align-items:center;justify-content:center;background:#f8f9fa">
                                    <c:choose>
                                        <c:when test="${not empty product.image}">
                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                alt="${product.name}" style="width:100%;height:100%;object-fit:cover">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-image text-secondary" style="font-size:5rem"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <%-- Thông tin --%>
                                <div class="col-12 col-md-7">
                                    <p class="text-uppercase text-muted mb-1"
                                        style="font-size:.72rem;letter-spacing:1.5px;font-weight:700">
                                        ${product.category.name}</p>
                                    <h2 class="fw-bold mb-3">${product.name}</h2>
                                    <h3 class="text-danger fw-bold mb-4">
                                        <fmt:formatNumber value="${product.price}" pattern="#,##0" />đ
                                    </h3>

                                    <hr>

                                    <table class="table table-borderless mb-4">
                                        <tbody>
                                            <tr>
                                                <td class="text-muted fw-semibold ps-0" style="width:120px">Số lượng
                                                </td>
                                                <td>${product.quantity} sản phẩm</td>
                                            </tr>
                                            <tr>
                                                <td class="text-muted fw-semibold ps-0">Danh mục</td>
                                                <td>${product.category.name}</td>
                                            </tr>
                                            <tr>
                                                <td class="text-muted fw-semibold ps-0">Trạng thái</td>
                                                <td><span class="badge bg-success">Đang bán</span></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <hr>

                                    <div class="mb-4">
                                        <p class="text-muted fw-semibold text-uppercase mb-2"
                                            style="font-size:.75rem;letter-spacing:1px">Mô tả sản phẩm</p>
                                        <c:choose>
                                            <c:when test="${not empty product.description}">
                                                <p style="line-height:1.7;color:#444;white-space:pre-wrap">
                                                    ${product.description}</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="text-muted fst-italic">Chưa có mô tả cho sản phẩm này.</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/product"
                                            class="btn btn-outline-secondary">
                                            <i class="bi bi-arrow-left me-1"></i>Quay lại
                                        </a>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.account}">
                                                <a href="${pageContext.request.contextPath}/user/home"
                                                    class="btn btn-primary">
                                                    <i class="bi bi-house me-1"></i>Trang chủ
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login"
                                                    class="btn btn-primary">
                                                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                    </div>

            </body>

            </html>