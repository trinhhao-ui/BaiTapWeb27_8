<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f0f2f5; }
        .header { background: #1a2942; color: #fff; padding: 0 24px; height: 56px; display: flex; align-items: center; justify-content: space-between; position: fixed; top: 0; left: 0; right: 0; z-index: 100; }
        .header .brand { font-size: 1.1rem; font-weight: 700; letter-spacing: 1px; }
        .header .right { display: flex; align-items: center; gap: 16px; font-size: 0.9rem; }
        .header .right span { opacity: 0.85; }
        .btn-logout { background: #e74c3c; color: #fff; border: none; padding: 6px 16px; border-radius: 4px; cursor: pointer; font-size: 0.85rem; font-weight: 600; text-decoration: none; }
        .btn-logout:hover { background: #c0392b; }
        .sidebar { width: 220px; background: #1a2942; position: fixed; top: 56px; left: 0; bottom: 0; overflow-y: auto; padding-top: 20px; }
        .sidebar .profile { text-align: center; padding: 16px; border-bottom: 1px solid rgba(255,255,255,0.1); margin-bottom: 8px; }
        .sidebar .avatar { width: 72px; height: 72px; border-radius: 50%; background: #2c3e50; margin: 0 auto 10px; display: flex; align-items: center; justify-content: center; font-size: 2rem; color: #fff; }
        .sidebar .role { color: #e74c3c; font-size: 0.8rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; }
        .sidebar .menu-item { display: flex; align-items: center; gap: 10px; padding: 12px 20px; color: rgba(255,255,255,0.7); text-decoration: none; font-size: 0.9rem; transition: background 0.2s; cursor: pointer; }
        .sidebar .menu-item:hover, .sidebar .menu-item.active { background: rgba(255,255,255,0.1); color: #fff; }
        .sidebar .menu-item .icon { font-size: 1.1rem; width: 20px; }
        .sidebar .submenu { background: rgba(0,0,0,0.2); }
        .sidebar .submenu a { display: block; padding: 9px 20px 9px 50px; color: rgba(255,255,255,0.6); text-decoration: none; font-size: 0.85rem; transition: color 0.2s; }
        .sidebar .submenu a:hover { color: #fff; }
        .sidebar .submenu a::before { content: '- '; }
        .main { margin-left: 220px; margin-top: 56px; padding: 28px; }
        .page-title { font-size: 1.4rem; font-weight: 700; margin-bottom: 4px; }
        .page-sub { font-size: 0.85rem; color: #888; margin-bottom: 28px; }

        /* Stats cards */
        .stats { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; margin-bottom: 32px; }
        .stat-card { background: #fff; border-radius: 8px; padding: 24px; box-shadow: 0 1px 4px rgba(0,0,0,0.07); display: flex; align-items: center; gap: 16px; }
        .stat-icon { width: 52px; height: 52px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.6rem; }
        .stat-icon.blue   { background: #dbeafe; }
        .stat-icon.green  { background: #dcfce7; }
        .stat-icon.orange { background: #fef3c7; }
        .stat-icon.pink   { background: #fce7f3; }
        .stat-info .value { font-size: 1.8rem; font-weight: 800; color: #1a2942; line-height: 1; }
        .stat-info .label { font-size: 0.82rem; color: #888; margin-top: 4px; }

        /* Quick links */
        .section-title { font-size: 1rem; font-weight: 700; margin-bottom: 16px; color: #333; }
        .quick-links { display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); gap: 14px; }
        .quick-link { background: #fff; border-radius: 8px; padding: 20px; box-shadow: 0 1px 4px rgba(0,0,0,0.07); text-decoration: none; color: #333; transition: transform 0.2s, box-shadow 0.2s; text-align: center; }
        .quick-link:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.12); }
        .quick-link .ql-icon { font-size: 2rem; margin-bottom: 10px; }
        .quick-link .ql-text { font-size: 0.88rem; font-weight: 600; color: #555; }
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

    <%-- Dashboard link trỏ đúng vào /admin/dashboard --%>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item active">
        <span class="icon">📊</span> Dashboard
    </a>

    <div class="menu-item">
        <span class="icon">📂</span> Quản lý Danh mục
    </div>
    <div class="submenu">
        <a href="${pageContext.request.contextPath}/admin/category/add">Thêm danh mục mới</a>
        <a href="${pageContext.request.contextPath}/admin/category/list">Danh sách danh mục</a>
    </div>

    <a href="#" class="menu-item"><span class="icon">🛍</span> Quản lý Sản phẩm</a>
    <a href="#" class="menu-item"><span class="icon">👥</span> Quản lý Tài khoản</a>
</div>

<div class="main">
    <div class="page-title">Tổng quan hệ thống</div>
    <div class="page-sub">Chào mừng trở lại, <strong>${sessionScope.account.fullName}</strong></div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-icon blue">📂</div>
            <div class="stat-info">
                <div class="value">${totalCategory}</div>
                <div class="label">Danh mục</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green">🛍</div>
            <div class="stat-info">
                <div class="value">0</div>
                <div class="label">Sản phẩm</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon orange">👥</div>
            <div class="stat-info">
                <div class="value">0</div>
                <div class="label">Tài khoản</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon pink">📦</div>
            <div class="stat-info">
                <div class="value">0</div>
                <div class="label">Đơn hàng</div>
            </div>
        </div>
    </div>

    <div class="section-title">Truy cập nhanh</div>
    <div class="quick-links">
        <a href="${pageContext.request.contextPath}/admin/category/list" class="quick-link">
            <div class="ql-icon">📋</div>
            <div class="ql-text">Danh sách danh mục</div>
        </a>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="quick-link">
            <div class="ql-icon">➕</div>
            <div class="ql-text">Thêm danh mục</div>
        </a>
        <a href="#" class="quick-link">
            <div class="ql-icon">🛍</div>
            <div class="ql-text">Quản lý sản phẩm</div>
        </a>
        <a href="#" class="quick-link">
            <div class="ql-icon">👤</div>
            <div class="ql-text">Quản lý tài khoản</div>
        </a>
    </div>
</div>

</body>
</html>
