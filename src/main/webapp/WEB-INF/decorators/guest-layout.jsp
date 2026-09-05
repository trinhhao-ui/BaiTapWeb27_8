<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.sitemesh.content.Content,org.sitemesh.webapp.WebAppContext" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Content _c = (Content) request.getAttribute(WebAppContext.CONTENT_KEY);
String _body  = (_c != null && _c.getExtractedProperties().getChild("body").hasValue())
                ? _c.getExtractedProperties().getChild("body").getValue() : "";
String _title = (_c != null && _c.getExtractedProperties().getChild("title").hasValue())
                ? _c.getExtractedProperties().getChild("title").getValue().trim() : "Xac thuc";
%><!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= _title %></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;}
body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;min-height:100vh;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);display:flex;align-items:center;justify-content:center;padding:20px;}
.auth-wrapper{width:100%;max-width:480px;animation:slideUp .4s ease;}
@keyframes slideUp{from{opacity:0;transform:translateY(24px);}to{opacity:1;transform:translateY(0);}}
.auth-card{background:#fff;border-radius:20px;padding:40px 36px;box-shadow:0 24px 64px rgba(0,0,0,.25);}
.auth-logo{width:64px;height:64px;border-radius:16px;background:linear-gradient(135deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;font-size:1.8rem;color:#fff;margin:0 auto 16px;}
.auth-title{font-size:1.6rem;font-weight:700;color:#1a1a2e;text-align:center;margin:0 0 6px;}
.auth-subtitle{font-size:.9rem;color:#6c757d;text-align:center;margin:0 0 28px;}
.form-group{margin-bottom:18px;}
.form-label{font-weight:600;font-size:.875rem;color:#344054;margin-bottom:6px;}
.required{color:#e74c3c;}
.form-control,.form-select{border:1.5px solid #d0d5dd;border-radius:10px;padding:10px 14px;font-size:.95rem;transition:border-color .2s,box-shadow .2s;}
.form-control:focus,.form-select:focus{border-color:#667eea;box-shadow:0 0 0 3px rgba(102,126,234,.2);}
.form-control.is-invalid{border-color:#dc3545;}.form-control.is-valid{border-color:#28a745;}
.password-field{position:relative;}.password-field .form-control{padding-right:44px;}
.password-toggle{position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;color:#6c757d;cursor:pointer;padding:0;font-size:1.05rem;}
.password-toggle:hover{color:#667eea;}
.btn-primary{background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);border:none;border-radius:10px;padding:11px;font-size:1rem;font-weight:600;width:100%;transition:opacity .2s,transform .15s;}
.btn-primary:hover{opacity:.9;transform:translateY(-1px);}
.btn-outline-secondary{border-radius:10px;padding:10px;font-size:.95rem;width:100%;}
.divider{display:flex;align-items:center;gap:10px;margin:20px 0;color:#adb5bd;font-size:.85rem;}
.divider::before,.divider::after{content:'';flex:1;height:1px;background:#e9ecef;}
.alert{border-radius:10px;font-size:.9rem;}
.auth-footer{text-align:center;margin-top:20px;font-size:.85rem;color:#6c757d;}
.auth-footer a{color:#667eea;font-weight:600;text-decoration:none;}
.auth-links{display:flex;justify-content:center;gap:16px;margin-top:8px;}
.auth-links a{font-size:.8rem;color:#adb5bd;text-decoration:none;}
.invalid-feedback,.valid-feedback{font-size:.8rem;}
</style>
</head>
<body>
<div class="auth-wrapper">
<div class="auth-card">
<%= _body %>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>