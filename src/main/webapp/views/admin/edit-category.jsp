<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Chỉnh sửa danh mục</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', Arial, sans-serif;
                    background: #f0f2f5;
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

                .header a {
                    color: #fff;
                    text-decoration: none;
                    font-size: 0.85rem;
                    opacity: 0.7;
                }

                .header a:hover {
                    opacity: 1;
                }

                .sidebar {
                    width: 220px;
                    background: #1a2942;
                    position: fixed;
                    top: 56px;
                    left: 0;
                    bottom: 0;
                    padding-top: 20px;
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
                    padding: 28px;
                    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.07);
                    max-width: 520px;
                }

                .field {
                    margin-bottom: 22px;
                }

                .field label {
                    display: block;
                    font-size: 0.78rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    margin-bottom: 8px;
                    color: #555;
                }

                .field input[type="text"] {
                    width: 100%;
                    padding: 10px 12px;
                    border: 2px solid #ddd;
                    border-radius: 4px;
                    font-size: 1rem;
                    outline: none;
                    transition: border-color 0.2s;
                }

                .field input[type="text"]:focus {
                    border-color: #1a2942;
                }

                /* Ảnh hiện tại */
                .current-img {
                    display: flex;
                    align-items: center;
                    gap: 14px;
                    padding: 12px;
                    background: #f8fafc;
                    border-radius: 6px;
                    margin-bottom: 12px;
                }

                .current-img img {
                    width: 72px;
                    height: 72px;
                    object-fit: cover;
                    border-radius: 4px;
                    border: 1px solid #eee;
                }

                .current-img .info {
                    font-size: 0.85rem;
                    color: #555;
                }

                .current-img .info span {
                    font-size: 0.75rem;
                    color: #aaa;
                    display: block;
                    margin-top: 2px;
                }

                /* Upload area */
                .upload-area {
                    border: 2px dashed #ddd;
                    border-radius: 8px;
                    padding: 20px;
                    text-align: center;
                    cursor: pointer;
                    transition: border-color 0.2s, background 0.2s;
                    position: relative;
                }

                .upload-area:hover {
                    border-color: #1a2942;
                    background: #f8fafc;
                }

                .upload-area input[type="file"] {
                    position: absolute;
                    inset: 0;
                    opacity: 0;
                    cursor: pointer;
                    width: 100%;
                    height: 100%;
                }

                .upload-text {
                    font-size: 0.88rem;
                    color: #888;
                }

                .upload-text strong {
                    color: #1a2942;
                }

                #previewWrap {
                    margin-top: 12px;
                    display: none;
                }

                #previewWrap img {
                    max-width: 120px;
                    max-height: 120px;
                    border-radius: 6px;
                    border: 1px solid #eee;
                    object-fit: cover;
                }

                #fileName {
                    font-size: 0.82rem;
                    color: #555;
                    margin-top: 6px;
                }

                .msg-error {
                    background: #fff5f5;
                    border-left: 3px solid #e74c3c;
                    padding: 11px 14px;
                    font-size: 0.88rem;
                    color: #e74c3c;
                    margin-bottom: 18px;
                    border-radius: 2px;
                }

                .btn-group {
                    display: flex;
                    gap: 10px;
                    margin-top: 8px;
                }

                .btn {
                    padding: 11px 28px;
                    font-size: 0.85rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    border: none;
                    cursor: pointer;
                    border-radius: 4px;
                    text-decoration: none;
                    display: inline-block;
                    transition: all 0.2s;
                }

                .btn-dark {
                    background: #1a2942;
                    color: #fff;
                }

                .btn-dark:hover {
                    background: #2c3e50;
                }

                .btn-outline {
                    border: 2px solid #555;
                    background: transparent;
                    color: #555;
                }

                .btn-outline:hover {
                    background: #555;
                    color: #fff;
                }
            </style>
        </head>

        <body>

            <div class="header">
                <div class="brand">Dashboard</div>
                <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </div>

            <div class="sidebar">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
                    <span class="icon">📊</span> Dashboard
                </a>
                <div class="menu-item active"><span class="icon">📂</span> Quản lý Danh mục</div>
                <div class="submenu">
                    <a href="${pageContext.request.contextPath}/admin/category/add">Thêm danh mục mới</a>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="active">Danh sách danh
                        mục</a>
                </div>
                <a href="#" class="menu-item"><span class="icon">🛍</span> Quản lý Sản phẩm</a>
                <a href="#" class="menu-item"><span class="icon">👥</span> Quản lý Tài khoản</a>
            </div>

            <div class="main">
                <div class="page-title">Chỉnh sửa danh mục</div>
                <div class="page-sub">Cập nhật thông tin danh mục</div>

                <div class="card">
                    <c:if test="${not empty requestScope.error}">
                        <div class="msg-error">${requestScope.error}</div>
                    </c:if>

                    <%-- enctype="multipart/form-data" bắt buộc khi upload file --%>
                        <form action="${pageContext.request.contextPath}/admin/category/edit" method="POST"
                            enctype="multipart/form-data">

                            <%-- Hidden id - không hiển thị nhưng cần để biết sửa record nào --%>
                                <input type="hidden" name="id" value="${category.id}">

                                <div class="field">
                                    <label for="name">Tên danh mục <span style="color:red">*</span></label>
                                    <input type="text" id="name" name="name" value="${category.name}" required
                                        autofocus>
                                </div>

                                <div class="field">
                                    <label>Ảnh đại diện</label>

                                    <%-- Hiển thị ảnh hiện tại nếu có --%>
                                        <c:if test="${not empty category.icon}">
                                            <div class="current-img">
                                                <img src="${pageContext.request.contextPath}/${category.icon}"
                                                    alt="${category.name}">
                                                <div class="info">
                                                    Ảnh hiện tại
                                                    <span>${category.icon}</span>
                                                </div>
                                            </div>
                                        </c:if>

                                        <div class="upload-area">
                                            <input type="file" name="icon" id="iconFile" accept="image/*"
                                                onchange="previewImage(this)">
                                            <div class="upload-text">
                                                <strong>Chọn ảnh mới</strong> hoặc kéo thả<br>
                                                <small>Để trống nếu không muốn thay đổi ảnh</small>
                                            </div>
                                        </div>
                                        <div id="previewWrap">
                                            <img id="previewImg" src="" alt="Preview mới">
                                            <div id="fileName"></div>
                                        </div>
                                </div>

                                <div class="btn-group">
                                    <button type="submit" class="btn btn-dark">Lưu</button>
                                    <a href="${pageContext.request.contextPath}/admin/category/list"
                                        class="btn btn-outline">Hủy</a>
                                </div>
                        </form>
                </div>
            </div>

            <script>
                function previewImage(input) {
                    const wrap = document.getElementById('previewWrap');
                    const img = document.getElementById('previewImg');
                    const name = document.getElementById('fileName');

                    if (input.files && input.files[0]) {
                        const reader = new FileReader();
                        reader.onload = e => {
                            img.src = e.target.result;
                            name.textContent = '→ ' + input.files[0].name;
                            wrap.style.display = 'block';
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                }
            </script>

        </body>

        </html>