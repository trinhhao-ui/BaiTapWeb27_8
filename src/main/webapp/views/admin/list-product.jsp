<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <title>Quản lý sản phẩm</title>
            </head>

            <body>

                <div class="page-heading mb-4">
                    <div class="page-title"><i class="bi bi-box-seam"></i> Quản lý sản phẩm</div>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item active">Sản phẩm</li>
                        </ol>
                    </nav>
                </div>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-list-ul me-2"></i>Danh sách sản phẩm</span>
                        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary btn-sm">
                            <i class="bi bi-plus-lg me-1"></i>Thêm sản phẩm mới
                        </a>
                    </div>
                    <div class="card-body">

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="d-flex align-items-center gap-2">
                                <select class="form-select form-select-sm" style="width:auto">
                                    <option>10</option>
                                    <option>25</option>
                                    <option>50</option>
                                </select>
                                <span class="text-muted" style="font-size:.85rem">records per page</span>
                            </div>
                            <div class="input-group" style="width:220px">
                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                                <input type="text" class="form-control form-control-sm" id="searchInput"
                                    onkeyup="searchTable()" placeholder="Tìm kiếm...">
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle" id="productTable">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width:50px">STT</th>
                                        <th style="width:90px">Ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Danh mục</th>
                                        <th>Giá</th>
                                        <th>SL</th>
                                        <th>Trạng thái</th>
                                        <th style="width:110px">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty productList}">
                                            <tr>
                                                <td colspan="8" class="text-center py-5 text-muted">Chưa có sản phẩm nào
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${productList}" var="p" varStatus="s">
                                                <tr>
                                                    <td>${s.index + 1}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty p.image}">
                                                                <img src="${pageContext.request.contextPath}/${p.image}"
                                                                    alt="${p.name}"
                                                                    style="width:72px;height:56px;object-fit:cover;border-radius:6px;border:1px solid #dee2e6">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div
                                                                    style="width:72px;height:56px;background:#f8f9fa;border-radius:6px;display:flex;align-items:center;justify-content:center;border:1px solid #dee2e6">
                                                                    <i class="bi bi-image text-muted"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="fw-semibold">${p.name}</td>
                                                    <td>${p.category.name}</td>
                                                    <td class="fw-bold text-danger">
                                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                                    </td>
                                                    <td>${p.quantity}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${p.status == 1}">
                                                                <span class="badge bg-success">Hiển thị</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">Ẩn</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}"
                                                            class="btn btn-sm btn-outline-primary me-1">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.id}"
                                                            class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Xác nhận xóa: ${p.name}?')">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <script>
                    function searchTable() {
                        const q = document.getElementById('searchInput').value.toLowerCase();
                        document.querySelectorAll('#productTable tbody tr').forEach(r => {
                            r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
                        });
                    }
                </script>

            </body>

            </html>