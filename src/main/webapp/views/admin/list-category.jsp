<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý danh mục</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Segoe UI', Arial, sans-serif;
                        background: #f0f2f5;
                        display: flex;
                        flex-direction: column;
                        min-height: 100vh;
                    }

                    /* ── HEADER ── */
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

                    .header .right span {
                        opacity: 0.85;
                    }

                    .header .btn-logout {
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

                    .header .btn-logout:hover {
                        background: #c0392b;
                    }

                    /* ── SIDEBAR ── */
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
                        color: #fff;
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
                        transition: background 0.2s, color 0.2s;
                        cursor: pointer;
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

                    .sidebar .submenu a:hover {
                        color: #fff;
                    }

                    .sidebar .submenu a::before {
                        content: '- ';
                    }

                    /* ── MAIN CONTENT ── */
                    .main {
                        margin-left: 220px;
                        margin-top: 56px;
                        padding: 28px;
                        flex: 1;
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

                    /* Search bar */
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
                        margin: 0 4px;
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

                    /* Table */
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
                        padding: 12px 14px;
                        border-bottom: 1px solid #f0f0f0;
                        font-size: 0.9rem;
                        vertical-align: middle;
                    }

                    tr:hover td {
                        background: #fafbfc;
                    }

                    .cate-img {
                        width: 80px;
                        height: 60px;
                        object-fit: cover;
                        border-radius: 4px;
                        border: 1px solid #eee;
                    }

                    .no-img {
                        width: 80px;
                        height: 60px;
                        background: #f5f5f5;
                        border-radius: 4px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 0.75rem;
                        color: #bbb;
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

                <!-- HEADER -->
                <div class="header">
                    <div class="brand">Dashboard</div>
                    <div class="right">
                        <span>Xin chào <strong>${sessionScope.account.fullName}</strong></span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Đăng xuất</a>
                    </div>
                </div>

                <!-- SIDEBAR -->
                <div class="sidebar">
                    <div class="profile">
                        <div class="avatar">👤</div>
                        <div class="role">Bạn là Admin</div>
                    </div>

                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
                        <span class="icon">📊</span> Dashboard
                    </a>

                    <div class="menu-item active">
                        <span class="icon">📂</span> Quản lý Danh mục
                    </div>
                    <div class="submenu">
                        <a href="${pageContext.request.contextPath}/admin/category/add">Thêm danh mục mới</a>
                        <a href="${pageContext.request.contextPath}/admin/category/list">Danh sách danh mục</a>
                    </div>

                    <a href="#" class="menu-item">
                        <span class="icon">🛍</span> Quản lý Sản phẩm
                    </a>

                    <a href="#" class="menu-item">
                        <span class="icon">👥</span> Quản lý Tài khoản
                    </a>
                </div>

                <!-- MAIN CONTENT -->
                <div class="main">
                    <div class="page-title">Quản lý danh mục</div>
                    <div class="page-sub">Nơi bạn có thể quản lý danh mục của mình</div>

                    <div class="card">
                        <div class="card-header">
                            <h3>Danh sách danh mục</h3>
                            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn-add">+ Thêm danh
                                mục
                                mới</a>
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

                        <table id="cateTable">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Hình ảnh</th>
                                    <th>Tên danh mục</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty cateList}">
                                        <tr class="empty-row">
                                            <td colspan="4">Chưa có danh mục nào</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                            <tr>
                                                <td>${STT.index + 1}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty cate.icon}">
                                                            <img class="cate-img"
                                                                src="${pageContext.request.contextPath}/img?name=${fn:substringAfter(cate.icon, 'images/')}"
                                                                alt="${cate.name}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="no-img">Không có ảnh</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${cate.name}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}"
                                                        class="action-link">Sửa</a>
                                                    |
                                                    <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}"
                                                        class="action-link del"
                                                        onclick="return confirm('Xác nhận xóa: ${cate.name}?')">Xóa</a>
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
                    // Tìm kiếm client-side đơn giản
                    function searchTable() {
                        const input = document.getElementById("searchInput").value.toLowerCase();
                        const rows = document.querySelectorAll("#cateTable tbody tr");
                        rows.forEach(row => {
                            const text = row.textContent.toLowerCase();
                            row.style.display = text.includes(input) ? "" : "none";
                        });
                    }
                </script>

            </body>

            </html>