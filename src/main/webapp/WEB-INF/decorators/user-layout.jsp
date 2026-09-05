<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.sitemesh.content.Content,org.sitemesh.webapp.WebAppContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Content _c = (Content) request.getAttribute(WebAppContext.CONTENT_KEY);
String _body  = (_c != null && _c.getExtractedProperties().getChild("body").hasValue())
                ? _c.getExtractedProperties().getChild("body").getValue() : "";
String _title = (_c != null && _c.getExtractedProperties().getChild("title").hasValue())
                ? _c.getExtractedProperties().getChild("title").getValue().trim() : "Trang nguoi dung";
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
body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background:#f0f4f8;min-height:100vh;display:flex;flex-direction:column;}
.navbar-main{background:linear-gradient(135deg,#1a1a2e 0%,#16213e 100%);padding:0 24px;height:64px;display:flex;align-items:center;position:sticky;top:0;z-index:1000;box-shadow:0 2px 12px rgba(0,0,0,.2);}
.navbar-brand{font-size:1.2rem;font-weight:700;color:#fff;text-decoration:none;display:flex;align-items:center;gap:10px;}
.navbar-brand i{color:#4fc3f7;font-size:1.4rem;}
.navbar-right{margin-left:auto;display:flex;align-items:center;gap:8px;}
.nav-link-item{color:rgba(255,255,255,.75);font-size:.9rem;padding:8px 12px;border-radius:8px;text-decoration:none;transition:background .2s,color .2s;display:flex;align-items:center;gap:6px;}
.nav-link-item:hover{background:rgba(255,255,255,.1);color:#fff;}
.user-btn{display:flex;align-items:center;gap:8px;background:rgba(255,255,255,.1);border:none;color:#fff;border-radius:24px;padding:4px 14px 4px 4px;cursor:pointer;transition:background .2s;}
.user-btn:hover{background:rgba(255,255,255,.18);}
.user-btn .avatar{width:34px;height:34px;border-radius:50%;object-fit:cover;border:2px solid rgba(255,255,255,.3);}
.user-btn .avatar-ph{width:34px;height:34px;border-radius:50%;background:#4fc3f7;display:flex;align-items:center;justify-content:center;font-size:1rem;color:#fff;}
.user-btn .uname{font-size:.88rem;font-weight:600;}
.dropdown-menu{border:none;border-radius:12px;box-shadow:0 8px 32px rgba(0,0,0,.15);padding:8px;}
.dropdown-item{border-radius:8px;font-size:.88rem;padding:8px 14px;display:flex;align-items:center;gap:8px;}
.dropdown-item:hover{background:#f0f4f8;}
.dropdown-item.text-danger:hover{background:#fff0f0;}
.page-content{flex:1;padding:32px 20px;max-width:1200px;margin:0 auto;width:100%;}
footer{background:#1a1a2e;color:rgba(255,255,255,.5);text-align:center;padding:16px 20px;font-size:.82rem;}
footer a{color:#4fc3f7;text-decoration:none;}
.form-control,.form-select{border:1.5px solid #d0d5dd;border-radius:10px;padding:10px 14px;font-size:.95rem;transition:border-color .2s,box-shadow .2s;}
.form-control:focus,.form-select:focus{border-color:#667eea;box-shadow:0 0 0 3px rgba(102,126,234,.2);}
.form-control.is-invalid{border-color:#dc3545;}.form-control.is-valid{border-color:#28a745;}
.card{border:none;border-radius:14px;box-shadow:0 4px 16px rgba(0,0,0,.08);}
.card-header{background:#fff;border-bottom:1px solid #f0f0f0;border-radius:14px 14px 0 0 !important;font-weight:700;color:#1a1a2e;}
.btn-primary{background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);border:none;border-radius:10px;font-weight:600;transition:opacity .2s,transform .15s;}
.btn-primary:hover{opacity:.9;transform:translateY(-1px);}
.alert{border-radius:10px;}
@media(max-width:576px){.page-content{padding:20px 12px;}.uname{display:none;}}
</style>
</head>
<body>
<nav class="navbar-main">
    <a href="${pageContext.request.contextPath}/user/home" class="navbar-brand">
        <i class="bi bi-shop"></i> Cua Hang
    </a>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/user/home" class="nav-link-item">
            <i class="bi bi-house"></i><span class="d-none d-md-inline">Trang chu</span>
        </a>
        <div class="dropdown">
            <button class="user-btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                <c:choose>
                    <c:when test="${not empty sessionScope.account.avatar}">
                        <img class="avatar" src="${pageContext.request.contextPath}/img?name=${sessionScope.account.avatar}" alt="Avatar">
                    </c:when>
                    <c:otherwise><div class="avatar-ph"><i class="bi bi-person-fill"></i></div></c:otherwise>
                </c:choose>
                <span class="uname">${sessionScope.account.fullName}</span>
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile"><i class="bi bi-person-circle"></i> Ho so ca nhan</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Dang xuat</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="page-content">
    <%= _body %>
</div>
<footer>
    <p>&copy; 2026 Cua Hang. Bao luu moi quyen. | <a href="#">Dieu khoan</a> | <a href="#">Bao mat</a></p>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>