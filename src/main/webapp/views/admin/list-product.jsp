<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý sản phẩm</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Segoe UI', Arial, sans-serif;
                        background: #f0f2f5;
                        min-height: 100vh;
                    }

                    .header {
                        background: #1a2942;
                        color: #fff;
                        padding: 0 24px;
                        height: 56px;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        position: fixed;
                        top: 0;
                        left: 0;
                        right: 0;
                        z-index: 100;
                    }

                    .header .brand {
                        font-size: 1.1rem;
                        font-weight: 700;
                        letter-spacing: 1px;
                    }

                    .header .right {
                        display: flex;
                        align-items: center;
                        gap: 16px;
                        font-size: 0.9rem;
                    }

                    .btn-logout {
                        background: #e74c3c;
                        color: #fff;
                        border: none;
                        padding: 6px 16px;
                        border-radius: 4px;
                        cursor: pointer;
                        font-size: 0.85rem;
                        font-weight: 600;
                        text-decoration: none;
                    }

                    .btn-logout:hover {
                        background: #c0392b;
                    }

                    .sidebar {
                        width: 220px;
                        background: #1a2942;
                        position: fixed;
                        top: 56px;
                        left: 0;
                        bottom: 0;
                        overflow-y: auto;
                        padding-top: 20px;
                    }

                    .sidebar .profile {
                        text-align: center;
                        padding: 16px;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                        margin-bottom: 8px;
                    }

                    .sidebar .avatar {
                        width: 72px;
                        height: 72px;
                        border-radius: 50%;
                        background: #2c3e50;
                        margin: 0 auto 10px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 2rem;
                    }

                    .sidebar .role {
                        color: #e74c3c;
                        font-size: 0.8rem;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                    }

                    .sidebar .menu-item {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: 12px 20px;
                        color: rgba(255, 255, 255, 0.7);
                        text-decoration: none;
                        font-size: 0.9rem;
                        transition: background 0.2s;
                    }

                    .sidebar .menu-item:hover,
                    .sidebar .menu-item.active {
                        background: rgba(255, 255, 255, 0.1);
                        color: #fff;
                    }

                    .sidebar .menu-item .icon {
                        font-size: 1.1rem;
                        width: 20px;
                    }

                    .sidebar .submenu {
                        background: rgba(0, 0, 0, 0.2);
                    }

                    .sidebar .submenu a {
                        display: block;
                        padding: 9px 20px 9px 50px;
                        color: rgba(255, 255, 255, 0.6);
                        text-decoration: none;
                        font-size: 0.85rem;
                        transition: color 0.2s;
                    }

                    .sidebar .submenu a:hover,
                    .sidebar .submenu a.active {
                        color: #fff;
                    }

                    .sidebar .submenu a::before {
                        content: '- ';
                    }

                    .main {
                        margin-left: 220px;
                        margin-top: 56px;
                        padding: 28px;
                    }

                    .page-title {
                        font-size: 1.3rem;
                        font-weight: 700;
                        margin-bottom: 4px;
                    }

                    .page-sub {
                        font-size: 0.85rem;
                        color: #888;
                        margin-bottom: 24px;
                    }

                    .card {
                        background: #fff;
                        border-radius: 8px;
                        padding: 24px;
                        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.07);
                    }

                    .card-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 16px;
                        padding-bottom: 14px;
                        border-bottom: 1px solid #eee;
                    }

                    .card-header h3 {
                        font-size: 1rem;
                        font-weight: 700;
                        color: #333;
                    }

                    .btn-add {
                        background: #1a2942;
                        color: #fff;
                        padding: 8px 18px;
                        border-radius: 4px;
                        text-decoration: none;
                        font-size: 0.85rem;
                        font-weight: 600;
                    }

                    .btn-add:hover {
                        background: #2c3e50;
                    }

                    .toolbar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 14px;
                    }

                    .toolbar .per-page {
                        font-size: 0.85rem;
                        color: #666;
                    }

                    .toolbar .per-page select {
                        padding: 4px 8px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                    }

                    .toolbar .search-box {
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        font-size: 0.85rem;
                        color: #666;
                    }

                    .toolbar .search-box input {
                        padding: 6px 10px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        font-size: 0.85rem;
                        outline: none;
                    }

                    .toolbar .search-box input:focus {
                        border-color: #1a2942;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    thead tr {
                        background: #f8f9fa;
                    }

                    th {
                        padding: 11px 14px;
                        text-align: left;
                        font-size: 0.8rem;
                        font-weight: 700;
                        color: #555;
                        letter-spacing: 0.5px;
                        border-bottom: 2px solid #eee;
                    }

                    td {
                        padding: 11px 14px;
                        border-bottom: 1px solid #f0f0f0;
                        font-size: 0.88rem;
                        vertical-align: middle;
                    }

                    tr:hover td {
                        background: #fafbfc;
                    }

                    .product-img {
                        width: 64px;
                        height: 52px;
                        object-fit: cover;
                        border-radius: 4px;
                        border: 1px solid #eee;
                    }

                    .no-img {
                        width: 64px;
                        height: 52px;
                        background: #f5f5f5;
                        border-radius: 4px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 0.72rem;
                        color: #bbb;
                    }

                    .price {
                        font-weight: 700;
                        color: #e74c3c;
                    }

                    .badge {
                        display: inline-block;
                        padding: 2px 10px;
                        border-radius: 20px;
                        font-size: 0.75rem;
                        font-weight: 700;
                    }

                    .badge-active {
                        background: #e8f5e9;
                        color: #27ae60;
                    }

                    .badge-hidden {
                        background: #ffeaea;
                        color: #e74c3c;
                    }

                    .action-link {
                        color: #1a73e8;
                        text-decoration: none;
                        font-size: 0.85rem;
                        font-weight: 600;
                        margin-right: 8px;
                    }

                    .action-link:hover {
                        text-decoration: underline;
                    }

                    .action-link.del {
                        color: #e74c3c;
                    }

                    .empty-row td {
                        text-align: center;
                        padding: 40px;
                        color: #aaa;
                    }
                </style>
            </head>

            <body>

                <div class="header">
                    <div class="brand">Dashboard</div>
                    <div class="right">
                        <span>Xin chào <strong>${sessionScope.account.fullName}</strong></span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Đăng xuất</a>
                    </div>
                </div>

                <div class="sidebar">
                    <div class="profile">
                        <div class="avatar">👤</div>
                        <div class="role">Bạn là Admin</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
                        <span class="icon">📊</span> Dashboard
                    </a>
                    <div class="menu-item">
                        <span class="icon">📂</span> Quản lý Danh mục
                    </div>
                    <div class="submenu">
                        <a href="${pageContext.request.contextPath}/admin/category/add">Thêm danh mục mới</a>
                        <a href="${pageContext.request.contextPath}/admin/category/list">Danh sách danh mục</a>
                    </div>
                    <div class="menu-item active">
                        <span class="icon">🛍</span> Quản lý Sản phẩm
                    </div>
                    <div class="submenu">
                        <a href="${pageContext.request.contextPath}/admin/product/add">Thêm sản phẩm mới</a>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="active">Danh sách sản
                            phẩm</a>
                    </div>
                    <a href="#" class="menu-item"><span class="icon">👥</span> Quản lý Tài khoản</a>
                </div>

                <div class="main">
                    <div class="page-title">Quản lý sản phẩm</div>
                    <div class="page-sub">Danh sách toàn bộ sản phẩm</div>

                    <div class="card">
                        <div class="card-header">
                            <h3>Danh sách sản phẩm</h3>
                            <a href="${pageContext.request.contextPath}/admin/product/add" class="btn-add">+ Thêm sản
                                phẩm mới</a>
                        </div>

                        <div class="toolbar">
                            <div class="per-page">
                                <select>
                                    <option>10</option>
                                    <option>25</option>
                                    <option>50</option>
                                </select> records per page
                            </div>
                            <div class="search-box">
                                Search: <input type="text" id="searchInput" onkeyup="searchTable()"
                                    placeholder="Tìm kiếm...">
                            </div>
                        </div>

                        <table id="productTable">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Danh mục</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty productList}">
                                        <tr class="empty-row">
                                            <td colspan="8">Chưa có sản phẩm nào</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${productList}" var="p" varStatus="s">
                                            <tr>
                                                <td>${s.index + 1}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty p.image}">
                                                            <img class="product-img"
                                                                src="${pageContext.request.contextPath}/${p.image}"
                                                                alt="${p.name}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="no-img">Không có ảnh</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><strong>${p.name}</strong></td>
                                                <td>${p.category.name}</td>
                                                <td class="price">
                                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                                </td>
                                                <td>${p.quantity}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.status == 1}"><span
                                                                class="badge badge-active">Hiển thị</span></c:when>
                                                        <c:otherwise><span class="badge badge-hidden">Ẩn</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}"
                                                        class="action-link">Sửa</a>
                                                    |
                                                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.id}"
                                                        class="action-link del"
                                                        onclick="return confirm('Xác nhận xóa sản phẩm: ${p.name}?')">Xóa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <script>
                    function searchTable() {
                        const input = document.getElementById("searchInput").value.toLowerCase();
                        document.querySelectorAll("#productTable tbody tr").forEach(row => {
                            row.style.display = row.textContent.toLowerCase().includes(input) ? "" : "none";
                        });
                    }
                </script>
            </body>

            </html>