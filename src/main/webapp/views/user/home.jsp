<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="/common/header.jsp">
            <jsp:param name="title" value="Trang chủ" />
        </jsp:include>

        <style>
            .home-wrap {
                max-width: 560px;
                margin: 0 auto;
            }

            .home-wrap h1 {
                font-size: 2.6rem;
                font-weight: 800;
                letter-spacing: -1px;
                margin-bottom: 14px;
                color: #2c3e50;
                line-height: 1.2;
            }

            .home-divider {
                width: 40px;
                height: 3px;
                background: #2c3e50;
                margin-bottom: 28px;
                border-radius: 2px;
            }

            .info-card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, .07);
                overflow: hidden;
            }

            .info-table {
                width: 100%;
                border-collapse: collapse;
            }

            .info-table td {
                padding: 14px 20px;
                font-size: 0.9rem;
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
                letter-spacing: .5px;
                text-transform: uppercase;
                border-radius: 20px;
            }

            .avatar-home {
                width: 56px;
                height: 56px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #e8e8e8;
                margin-bottom: 16px;
                display: block;
            }

            .btn-profile {
                display: inline-block;
                margin-top: 20px;
                padding: 11px 24px;
                background: #2c3e50;
                color: #fff;
                text-decoration: none;
                border-radius: 6px;
                font-size: 0.85rem;
                font-weight: 700;
                letter-spacing: .5px;
                transition: background .2s;
            }

            .btn-profile:hover {
                background: #34495e;
            }
        </style>

        <div class="home-wrap">

            <%-- Avatar --%>
                <c:if test="${not empty sessionScope.account.avatar}">
                    <img src="${pageContext.request.contextPath}/${sessionScope.account.avatar}" class="avatar-home"
                        alt="avatar">
                </c:if>

                <h1>Xin chào,<br>${sessionScope.account.fullName}</h1>
                <div class="home-divider"></div>

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

                <a href="${pageContext.request.contextPath}/user/profile" class="btn-profile">
                    &#9998; Chỉnh sửa hồ sơ
                </a>

        </div>

        <jsp:include page="/common/footer.jsp" />