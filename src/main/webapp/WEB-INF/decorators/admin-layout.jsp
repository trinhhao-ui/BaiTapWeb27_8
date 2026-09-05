<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.sitemesh.content.Content,org.sitemesh.webapp.WebAppContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Content _c = (Content) request.getAttribute(WebAppContext.CONTENT_KEY);
String _body  = (_c != null && _c.getExtractedProperties().getChild("body").hasValue())
                ? _c.getExtractedProperties().getChild("body").getValue() : "";
String _title = (_c != null && _c.getExtractedProperties().getChild("title").hasValue())
                ? _c.getExtractedProperties().getChild("title").getValue().trim() : "Admin Panel";
%><!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= _title %></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background:#f4f6f9;min-height:100vh;}
.topbar{position:fixed;top:0;left:0;right:0;z-index:1000;height:60px;background:#1e3a5f;display:flex;align-items:center;padding:0 20px;box-shadow:0 2px 8px rgba(0,0,0,.2);}
.topbar-brand{font-size:1.15rem;font-weight:700;color:#fff;text-decoration:none;display:flex;align-items:center;gap:10px;}
.topbar-brand i{font-size:1.3rem;color:#4fc3f7;}
.topbar-toggle{background:none;border:none;color:rgba(255,255,255,.7);font-size:1.3rem;cursor:pointer;margin-left:20px;display:none;}
.topbar-right{margin-left:auto;display:flex;align-items:center;gap:16px;}
.topbar-right .user-info{color:rgba(255,255,255,.85);font-size:.9rem;}
.topbar-right .user-info strong{color:#fff;}
.btn-logout{background:#e74c3c;color:#fff;border:none;border-radius:8px;padding:6px 16px;font-size:.85rem;font-weight:600;text-decoration:none;transition:background .2s;}
.btn-logout:hover{background:#c0392b;color:#fff;}
.sidebar{position:fixed;top:60px;left:0;bottom:0;width:240px;z-index:900;background:#1e3a5f;overflow-y:auto;transition:transform .25s ease;}
.sidebar-profile{padding:20px 16px;border-bottom:1px solid rgba(255,255,255,.08);text-align:center;}
.sidebar-avatar{width:56px;height:56px;border-radius:50%;background:rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;margin:0 auto 8px;font-size:1.5rem;overflow:hidden;}
.sidebar-avatar img{width:100%;height:100%;object-fit:cover;border-radius:50%;}
.sidebar-name{color:#fff;font-size:.85rem;font-weight:600;}
.sidebar-role{font-size:.72rem;font-weight:700;letter-spacing:1px;color:#4fc3f7;text-transform:uppercase;margin-top:2px;}
.sidebar-section{padding:8px 16px 4px;font-size:.7rem;font-weight:700;letter-spacing:1px;color:rgba(255,255,255,.35);text-transform:uppercase;margin-top:8px;}
.sidebar-link{display:flex;align-items:center;gap:10px;padding:10px 20px;color:rgba(255,255,255,.65);text-decoration:none;font-size:.88rem;transition:background .2s,color .2s;border-left:3px solid transparent;}
.sidebar-link:hover,.sidebar-link.active{background:rgba(255,255,255,.08);color:#fff;border-left-color:#4fc3f7;}
.sidebar-link.active{font-weight:600;background:rgba(79,195,247,.12);}
.sidebar-link i{font-size:1rem;width:20px;text-align:center;}
.sidebar-submenu{background:rgba(0,0,0,.15);}
.sidebar-submenu .sidebar-link{padding-left:48px;font-size:.84rem;}
.main-wrapper{margin-left:240px;margin-top:60px;padding:28px;min-height:calc(100vh - 60px);}
.page-heading{margin-bottom:24px;}
.page-title{font-size:1.35rem;font-weight:700;color:#1e3a5f;display:flex;align-items:center;gap:10px;}
.page-title i{color:#4fc3f7;}
.breadcrumb{font-size:.82rem;margin-top:4px;}
.breadcrumb-item a{color:#4fc3f7;text-decoration:none;}
.card{border:none;border-radius:12px;box-shadow:0 2px 10px rgba(0,0,0,.07);margin-bottom:24px;}
.card-header{background:#fff;border-bottom:1px solid #e9ecef;border-radius:12px 12px 0 0 !important;padding:16px 20px;font-weight:700;font-size:.95rem;color:#1e3a5f;display:flex;align-items:center;gap:8px;}
.card-header i{color:#4fc3f7;}
.card-body{padding:20px;}
.form-control,.form-select{border:1.5px solid #d0d5dd;border-radius:8px;padding:9px 13px;font-size:.92rem;transition:border-color .2s,box-shadow .2s;}
.form-control:focus,.form-select:focus{border-color:#1e3a5f;box-shadow:0 0 0 3px rgba(30,58,95,.12);}
.form-control.is-invalid{border-color:#dc3545;}.form-control.is-valid{border-color:#28a745;}
.btn-primary{background:#1e3a5f;border-color:#1e3a5f;border-radius:8px;font-weight:600;}
.btn-primary:hover{background:#16304f;border-color:#16304f;}
.alert{border-radius:10px;font-size:.9rem;}
.toast-success{position:fixed;top:76px;right:20px;z-index:9999;background:#28a745;color:#fff;padding:12px 20px;border-radius:10px;font-size:.9rem;font-weight:600;box-shadow:0 4px 16px rgba(40,167,69,.3);animation:toastIn .3s ease;}
@keyframes toastIn{from{opacity:0;transform:translateX(30px);}to{opacity:1;transform:translateX(0);}}
@media(max-width:768px){.sidebar{transform:translateX(-100%);}.sidebar.open{transform:translateX(0);}.main-wrapper{margin-left:0;padding:16px;}.topbar-toggle{display:block;}}
</style>
</head>
<body>
<nav class="topbar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="topbar-brand">
        <i class="bi bi-speedometer2"></i> Admin Panel
    </a>
    <button class="topbar-toggle" onclick="document.getElementById('sidebar').classList.toggle('open')">
        <i class="bi bi-list"></i>
    </button>
    <div class="topbar-right">
        <span class="user-info d-none d-md-block">Xin chao, <strong>${sessionScope.account.fullName}</strong></span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
            <i class="bi bi-box-arrow-right"></i> Dang xuat
        </a>
    </div>
</nav>
<aside class="sidebar" id="sidebar">
    <div class="sidebar-profile">
        <div class="sidebar-avatar">
            <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                    <img src="${pageContext.request.contextPath}/img?name=${sessionScope.account.avatar}" alt="avatar">
                </c:when>
                <c:otherwise><i class="bi bi-person-fill text-white"></i></c:otherwise>
            </c:choose>
        </div>
        <div class="sidebar-name">${sessionScope.account.fullName}</div>
        <div class="sidebar-role">Administrator</div>
    </div>
    <div class="sidebar-section">Tong quan</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
    <div class="sidebar-section">Quan ly</div>
    <a href="${pageContext.request.contextPath}/admin/category/list" class="sidebar-link"><i class="bi bi-folder2-open"></i> Danh muc</a>
    <div class="sidebar-submenu">
        <a href="${pageContext.request.contextPath}/admin/category/list" class="sidebar-link"><i class="bi bi-list-ul"></i> Danh sach</a>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="sidebar-link"><i class="bi bi-plus-circle"></i> Them moi</a>
    </div>
    <a href="#" class="sidebar-link"><i class="bi bi-box-seam"></i> San pham</a>
    <a href="#" class="sidebar-link"><i class="bi bi-people"></i> Tai khoan</a>
</aside>
<main class="main-wrapper">
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="toast-success" id="successToast"><i class="bi bi-check-circle-fill me-2"></i>${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>
    <%= _body %>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
const toast=document.getElementById('successToast');
if(toast)setTimeout(()=>{toast.style.opacity='0';setTimeout(()=>toast.remove(),400);},3500);
const p=window.location.pathname;
document.querySelectorAll('.sidebar-link').forEach(l=>{try{if(l.href&&l.href!=='#'&&p.includes(new URL(l.href).pathname))l.classList.add('active');}catch(e){}});
</script>
</body>
</html>