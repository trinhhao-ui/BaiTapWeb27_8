<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm sản phẩm</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f0f2f5; }

        .header { background: #1a2942; color: #fff; padding: 0 24px; height: 56px; display: flex; align-items: center; justify-content: space-between; position: fixed; top: 0; left: 0; right: 0; z-index: 100; }
        .header .brand { font-size: 1.1rem; font-weight: 700; }
        .header a { color: #fff; text-decoration: none; font-size: 0.85rem; opacity: 0.75; }
        .header a:hover { opacity: 1; }

        .sidebar { width: 220px; background: #1a2942; position: fixed; top: 56px; left: 0; bottom: 0; padding-top: 20px; }
        .sidebar .menu-item { display: flex; align-items: center; gap: 10px; padding: 12px 20px; color: rgba(255,255,255,0.7); text-decoration: none; font-size: 0.9rem; transition: background 0.2s; }
        .sidebar .menu-item:hover, .sidebar .menu-item.active { background: rgba(255,255,255,0.1); color: #fff; }
        .sidebar .menu-item .icon { font-size: 1.1rem; width: 20px; }
        .sidebar .submenu { background: rgba(0,0,0,0.2); }
        .sidebar .submenu a { display: block; padding: 9px 20px 9px 50px; color: rgba(255,255,255,0.6); text-decoration: none; font-size: 0.85rem; transition: color 0.2s; }
        .sidebar .submenu a:hover, .sidebar .submenu a.active { color: #fff; }
        .sidebar .submenu a::before { content: '- '; }

        .main { margin-left: 220px; margin-top: 56px; padding: 28px; }
        .page-title { font-size: 1.3rem; font-weight: 700; margin-bottom: 4px; }
        .page-sub { font-size: 0.85rem; color: #888; margin-bottom: 24px; }
        .card { background: #fff; border-radius: 8px; padding: 28px; box-shadow: 0 1px 4px rgba(0,0,0,0.07); max-width: 600px; }

        .row-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
        .field { margin-bottom: 20px; }
        .field label { display: block; font-size: 0.78rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 8px; color: #555; }
        .field input[type="text"], .field input[type="number"], .field select, .field textarea {
            width: 100%; padding: 10px 12px; border: 2px solid #ddd; border-radius: 4px;
            font-size: 0.95rem; outline: none; transition: border-color 0.2s; font-family: inherit;
        }
        .field input:focus, .field select:focus, .field textarea:focus { border-color: #1a2942; }
        .field textarea { resize: vertical; min-height: 90px; }

        .upload-area { border: 2px dashed #ddd; border-radius: 8px; padding: 24px; text-align: center; cursor: pointer; transition: border-color 0.2s; position: relative; }
        .upload-area:hover { border-color: #1a2942; background: #f8fafc; }
        .upload-area input[type="file"] { position: absolute; inset: 0; opacity: 0; cursor: pointer; width: 100%; height: 100%; }
        .upload-text { font-size: 0.88rem; color: #888; }
        .upload-text strong { color: #1a2942; }
        #previewWrap { margin-top: 12px; display: none; }
        #previewWrap img { max-width: 120px; max-height: 100px; border-radius: 6px; border: 1px solid #eee; object-fit: cover; }

        .msg-error { background: #fff5f5; border-left: 3px solid #e74c3c; padding: 11px 14px; font-size: 0.88rem; color: #e74c3c; margin-bottom: 18px; border-radius: 2px; }
        .btn-group { display: flex; gap: 10px; margin-top: 8px; }
        .btn { padding: 11px 28px; font-size: 0.85rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; border: none; cursor: pointer; border-radius: 4px; text-decoration: none; display: inline-block; transition: all 0.2s; }
        .btn-dark { background: #1a2942; color: #fff; }
        .btn-dark:hover { background: #2c3e50; }
        .btn-outline { border: 2px solid #1a2942; background: transparent; color: #1a2942; }
        .btn-outline:hover { background: #1a2942; color: #fff; }
    </style>
</head>
<body>

<div class="header">
    <div class="brand">Dashboard</div>
    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</div>

<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item"><span class="icon">📊</span> Dashboard</a>
    <div class="menu-item"><span class="icon">📂</span> Quản lý Danh mục</div>
    <div class="submenu">
        <a href="${pageContext.request.contextPath}/admin/category/add">Thêm danh mục mới</a>
        <a href="${pageContext.request.contextPath}/admin/category/list">Danh sách danh mục</a>
    </div>
    <div class="menu-item active"><span class="icon">🛍</span> Quản lý Sản phẩm</div>
    <div class="submenu">
        <a href="${pageContext.request.contextPath}/admin/product/add" class="active">Thêm sản phẩm mới</a>
        <a href="${pageContext.request.contextPath}/admin/product/list">Danh sách sản phẩm</a>
    </div>
    <a href="#" class="menu-item"><span class="icon">👥</span> Quản lý Tài khoản</a>
</div>

<div class="main">
    <div class="page-title">Thêm sản phẩm mới</div>
    <div class="page-sub">Điền thông tin sản phẩm</div>

    <div class="card">
        <c:if test="${not empty error}">
            <div class="msg-error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/product/add" method="POST" enctype="multipart/form-data">

            <div class="field">
                <label>Tên sản phẩm <span style="color:red">*</span></label>
                <input type="text" name="name" value="${param.name}" placeholder="Nhập tên sản phẩm..." required autofocus>
            </div>

            <div class="field">
                <label>Mô tả</label>
                <textarea name="description" placeholder="Mô tả sản phẩm...">${param.description}</textarea>
            </div>

            <div class="row-2">
                <div class="field">
                    <label>Giá (VNĐ) <span style="color:red">*</span></label>
                    <input type="number" name="price" value="${param.price}" placeholder="0" min="0" required>
                </div>
                <div class="field">
                    <label>Số lượng <span style="color:red">*</span></label>
                    <input type="number" name="quantity" value="${param.quantity}" placeholder="0" min="0" required>
                </div>
            </div>

            <div class="row-2">
                <div class="field">
                    <label>Danh mục <span style="color:red">*</span></label>
                    <select name="cateId" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach items="${categories}" var="cate">
                            <option value="${cate.id}">${cate.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="field">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="1">Hiển thị</option>
                        <option value="0">Ẩn</option>
                    </select>
                </div>
            </div>

            <div class="field">
                <label>Ảnh sản phẩm</label>
                <div class="upload-area">
                    <input type="file" name="image" accept="image/*" onchange="previewImage(this)">
                    <div class="upload-text">
                        <strong>Chọn ảnh</strong> hoặc kéo thả vào đây<br>
                        <small>PNG, JPG tối đa 5MB</small>
                    </div>
                </div>
                <div id="previewWrap">
                    <img id="previewImg" src="" alt="Preview">
                </div>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-dark">Thêm sản phẩm</button>
                <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline">Hủy</a>
            </div>
        </form>
    </div>
</div>

<script>
    function previewImage(input) {
        const wrap = document.getElementById('previewWrap');
        const img  = document.getElementById('previewImg');
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => { img.src = e.target.result; wrap.style.display = 'block'; };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>
