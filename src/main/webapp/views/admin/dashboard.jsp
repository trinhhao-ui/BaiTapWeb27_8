<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Dashboard</title>
        </head>

        <body>

            <div class="page-heading mb-4">
                <div class="page-title"><i class="bi bi-speedometer2"></i> Tổng quan hệ thống</div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                </nav>
            </div>

            <%-- Stats --%>
                <div class="row g-3 mb-4">
                    <div class="col-6 col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body d-flex align-items-center gap-3">
                                <div
                                    style="width:48px;height:48px;border-radius:10px;background:#dbeafe;display:flex;align-items:center;justify-content:center;font-size:1.4rem">
                                    📂</div>
                                <div>
                                    <div class="fw-bold fs-4" style="color:#1e3a5f">${totalCategory}</div>
                                    <div class="text-muted" style="font-size:.82rem">Danh mục</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body d-flex align-items-center gap-3">
                                <div
                                    style="width:48px;height:48px;border-radius:10px;background:#dcfce7;display:flex;align-items:center;justify-content:center;font-size:1.4rem">
                                    🛍</div>
                                <div>
                                    <div class="fw-bold fs-4" style="color:#1e3a5f">${totalProduct}</div>
                                    <div class="text-muted" style="font-size:.82rem">Sản phẩm</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body d-flex align-items-center gap-3">
                                <div
                                    style="width:48px;height:48px;border-radius:10px;background:#fef3c7;display:flex;align-items:center;justify-content:center;font-size:1.4rem">
                                    👥</div>
                                <div>
                                    <div class="fw-bold fs-4" style="color:#1e3a5f">0</div>
                                    <div class="text-muted" style="font-size:.82rem">Tài khoản</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body d-flex align-items-center gap-3">
                                <div
                                    style="width:48px;height:48px;border-radius:10px;background:#fce7f3;display:flex;align-items:center;justify-content:center;font-size:1.4rem">
                                    📦</div>
                                <div>
                                    <div class="fw-bold fs-4" style="color:#1e3a5f">0</div>
                                    <div class="text-muted" style="font-size:.82rem">Đơn hàng</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Quick links --%>
                    <h6 class="fw-bold mb-3">Truy cập nhanh</h6>
                    <div class="row g-3">
                        <div class="col-6 col-md-3">
                            <a href="${pageContext.request.contextPath}/admin/category/list"
                                class="card border-0 shadow-sm text-decoration-none text-dark text-center p-3 quick-hover">
                                <div style="font-size:2rem" class="mb-2">📋</div>
                                <div class="fw-semibold" style="font-size:.88rem">Danh sách danh mục</div>
                            </a>
                        </div>
                        <div class="col-6 col-md-3">
                            <a href="${pageContext.request.contextPath}/admin/category/add"
                                class="card border-0 shadow-sm text-decoration-none text-dark text-center p-3 quick-hover">
                                <div style="font-size:2rem" class="mb-2">➕</div>
                                <div class="fw-semibold" style="font-size:.88rem">Thêm danh mục</div>
                            </a>
                        </div>
                        <div class="col-6 col-md-3">
                            <a href="${pageContext.request.contextPath}/admin/product/list"
                                class="card border-0 shadow-sm text-decoration-none text-dark text-center p-3 quick-hover">
                                <div style="font-size:2rem" class="mb-2">🛍</div>
                                <div class="fw-semibold" style="font-size:.88rem">Danh sách sản phẩm</div>
                            </a>
                        </div>
                        <div class="col-6 col-md-3">
                            <a href="${pageContext.request.contextPath}/admin/product/add"
                                class="card border-0 shadow-sm text-decoration-none text-dark text-center p-3 quick-hover">
                                <div style="font-size:2rem" class="mb-2">🆕</div>
                                <div class="fw-semibold" style="font-size:.88rem">Thêm sản phẩm</div>
                            </a>
                        </div>
                    </div>

                    <style>
                        .quick-hover {
                            transition: transform .2s, box-shadow .2s;
                        }

                        .quick-hover:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 6px 20px rgba(0, 0, 0, .1) !important;
                        }
                    </style>

        </body>

        </html>