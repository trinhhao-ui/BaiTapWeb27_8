<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="/common/header.jsp">
                <jsp:param name="title" value="Trang chủ" />
            </jsp:include>

            <style>
                /* ── Thông tin user ── */
                .home-wrap {
                    max-width: 960px;
                    margin: 0 auto;
                }

                .user-section {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                    margin-bottom: 32px;
                }

                .avatar-home {
                    width: 64px;
                    height: 64px;
                    border-radius: 50%;
                    object-fit: cover;
                    border: 2px solid #e8e8e8;
                    flex-shrink: 0;
                }

                .avatar-placeholder {
                    width: 64px;
                    height: 64px;
                    border-radius: 50%;
                    background: #2c3e50;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.8rem;
                    color: #fff;
                    flex-shrink: 0;
                }

                .user-info h1 {
                    font-size: 1.8rem;
                    font-weight: 800;
                    color: #2c3e50;
                    letter-spacing: -1px;
                    margin-bottom: 4px;
                }

                .user-info p {
                    font-size: 0.85rem;
                    color: #aaa;
                }

                .btn-profile {
                    display: inline-block;
                    margin-top: 6px;
                    padding: 7px 18px;
                    background: #2c3e50;
                    color: #fff;
                    text-decoration: none;
                    border-radius: 4px;
                    font-size: 0.8rem;
                    font-weight: 700;
                    letter-spacing: .5px;
                    transition: background .2s;
                }

                .btn-profile:hover {
                    background: #34495e;
                }

                .info-card {
                    background: #fff;
                    border-radius: 10px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
                    overflow: hidden;
                    margin-bottom: 40px;
                }

                .info-table {
                    width: 100%;
                    border-collapse: collapse;
                }

                .info-table td {
                    padding: 13px 20px;
                    font-size: 0.88rem;
                    border-bottom: 1px solid #f0f0f0;
                }

                .info-table tr:last-child td {
                    border-bottom: none;
                }

                .info-table td:first-child {
                    color: #aaa;
                    font-size: 0.72rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    width: 130px;
                    background: #fafafa;
                }

                .badge {
                    display: inline-block;
                    padding: 3px 10px;
                    background: #eaf0ff;
                    color: #2980b9;
                    font-size: 0.72rem;
                    font-weight: 700;
                    border-radius: 20px;
                }

                /* ── Sản phẩm mới nhất ── */
                .section-divider {
                    border: none;
                    border-top: 1px solid #eee;
                    margin: 0 0 36px;
                }

                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-end;
                    margin-bottom: 24px;
                }

                .section-title {
                    font-size: 1.3rem;
                    font-weight: 800;
                    letter-spacing: -0.5px;
                    color: #2c3e50;
                }

                .section-sub {
                    font-size: 0.82rem;
                    color: #bbb;
                    margin-top: 3px;
                }

                .product-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                    gap: 20px;
                    margin-bottom: 16px;
                }

                .product-card {
                    border: 1px solid #eee;
                    border-radius: 6px;
                    overflow: hidden;
                    transition: box-shadow .2s, transform .2s;
                    text-decoration: none;
                    color: inherit;
                    display: block;
                }

                .product-card:hover {
                    box-shadow: 0 6px 24px rgba(0, 0, 0, .09);
                    transform: translateY(-2px);
                }

                .product-card .img-wrap {
                    width: 100%;
                    aspect-ratio: 4/3;
                    background: #f5f5f5;
                    overflow: hidden;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .product-card .img-wrap img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform .3s;
                }

                .product-card:hover .img-wrap img {
                    transform: scale(1.04);
                }

                .product-card .img-wrap .no-img {
                    font-size: 2rem;
                    color: #ddd;
                }

                .product-card .card-body {
                    padding: 12px 14px;
                }

                .product-card .cate-tag {
                    font-size: 0.66rem;
                    font-weight: 700;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    color: #aaa;
                    margin-bottom: 5px;
                }

                .product-card .prod-name {
                    font-size: 0.88rem;
                    font-weight: 700;
                    color: #111;
                    margin-bottom: 7px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .product-card .prod-price {
                    font-size: 0.95rem;
                    font-weight: 800;
                    color: #e74c3c;
                }

                .empty-state {
                    text-align: center;
                    padding: 40px;
                    color: #ccc;
                }

                .empty-state .icon {
                    font-size: 2.5rem;
                    margin-bottom: 8px;
                }
            </style>

            <div class="home-wrap">

                <%-- Thông tin user ─-%>
                    <div class="user-section">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account.avatar}">
                                <img src="${pageContext.request.contextPath}/${sessionScope.account.avatar}"
                                    class="avatar-home" alt="avatar">
                            </c:when>
                            <c:otherwise>
                                <div class="avatar-placeholder">👤</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="user-info">
                            <h1>Xin chào, ${sessionScope.account.fullName}</h1>
                            <p>${sessionScope.account.email}</p>
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn-profile">✎ Chỉnh sửa hồ
                                sơ</a>
                        </div>
                    </div>

                    <div class="info-card">
                        <table class="info-table">
                            <tr>
                                <td>Tài khoản</td>
                                <td>${sessionScope.account.userName}</td>
                            </tr>
                            <tr>
                                <td>Họ tên</td>
                                <td>${sessionScope.account.fullName}</td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td>${not empty sessionScope.account.email ? sessionScope.account.email : '—'}</td>
                            </tr>
                            <tr>
                                <td>Điện thoại</td>
                                <td>${not empty sessionScope.account.phone ? sessionScope.account.phone : '—'}</td>
                            </tr>
                            <tr>
                                <td>Vai trò</td>
                                <td><span class="badge">User</span></td>
                            </tr>
                        </table>
                    </div>

                    <%-- 10 sản phẩm mới nhất --%>
                        <hr class="section-divider">
                        <div class="section-header">
                            <div>
                                <div class="section-title">Sản phẩm mới nhất</div>
                                <div class="section-sub">10 sản phẩm vừa được cập nhật</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/product"
                                style="font-size:0.8rem;font-weight:700;color:#2c3e50;text-decoration:none;letter-spacing:1px;text-transform:uppercase;border-bottom:1px solid #2c3e50;padding-bottom:2px;">Xem
                                tất cả →</a>
                        </div>

                        <c:choose>
                            <c:when test="${empty latestProducts}">
                                <div class="empty-state">
                                    <div class="icon">🛍</div>
                                    <p>Chưa có sản phẩm nào.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="product-grid">
                                    <c:forEach items="${latestProducts}" var="p">
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}"
                                            class="product-card">
                                            <div class="img-wrap">
                                                <c:choose>
                                                    <c:when test="${not empty p.image}">
                                                        <img src="${pageContext.request.contextPath}/${p.image}"
                                                            alt="${p.name}">
                                                    </c:when>
                                                    <c:otherwise><span class="no-img">🖼️</span></c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="card-body">
                                                <div class="cate-tag">${p.category.name}</div>
                                                <div class="prod-name" title="${p.name}">${p.name}</div>
                                                <div class="prod-price">
                                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                                </div>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>

            </div>

            <jsp:include page="/common/footer.jsp" />