<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="/common/header.jsp">
            <jsp:param name="title" value="Hồ sơ cá nhân" />
        </jsp:include>

        <style>
            .profile-wrap {
                max-width: 520px;
                margin: 0 auto;
            }

            .profile-card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, .07);
                padding: 36px 40px;
            }

            .profile-card h2 {
                font-size: 1.6rem;
                font-weight: 800;
                color: #2c3e50;
                margin-bottom: 4px;
            }

            .profile-card .sub {
                color: #aaa;
                font-size: 0.85rem;
                margin-bottom: 28px;
            }

            /* Avatar */
            .avatar-section {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 28px;
            }

            .avatar-img {
                width: 96px;
                height: 96px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #e8e8e8;
                margin-bottom: 10px;
                cursor: pointer;
                transition: opacity .2s;
            }

            .avatar-img:hover {
                opacity: .8;
            }

            .avatar-hint {
                font-size: 0.78rem;
                color: #3498db;
                font-weight: 600;
                cursor: pointer;
            }

            #avatarInput {
                display: none;
            }

            /* Form fields */
            .field {
                margin-bottom: 18px;
            }

            .field label {
                display: block;
                font-size: 0.72rem;
                font-weight: 700;
                letter-spacing: 1px;
                text-transform: uppercase;
                color: #888;
                margin-bottom: 7px;
            }

            .field input {
                width: 100%;
                padding: 11px 14px;
                border: 2px solid #eee;
                border-radius: 6px;
                font-size: 0.95rem;
                color: #111;
                outline: none;
                transition: border-color .2s;
                background: #fff;
            }

            .field input:focus {
                border-color: #3498db;
            }

            .field input[readonly] {
                background: #f8f8f8;
                color: #bbb;
                cursor: not-allowed;
            }

            .divider {
                border: none;
                border-top: 1px solid #f0f0f0;
                margin: 20px 0;
            }

            .btn-save {
                width: 100%;
                padding: 13px;
                background: #2c3e50;
                color: #fff;
                border: none;
                border-radius: 6px;
                font-size: 0.9rem;
                font-weight: 700;
                letter-spacing: .5px;
                cursor: pointer;
                transition: background .2s;
            }

            .btn-save:hover {
                background: #34495e;
            }

            /* Badge JPA */
            .jpa-badge {
                display: inline-block;
                background: #eaf0ff;
                color: #2980b9;
                font-size: 0.7rem;
                font-weight: 700;
                padding: 2px 8px;
                border-radius: 12px;
                letter-spacing: .5px;
                margin-left: 8px;
                vertical-align: middle;
            }
        </style>

        <div class="profile-wrap">
            <div class="profile-card">

                <h2>Hồ Sơ Cá Nhân <span class="jpa-badge">JPA</span></h2>
                <p class="sub">Cập nhật thông tin hiển thị của bạn</p>

                <%-- Alert / Success --%>
                    <c:if test="${not empty alert}">
                        <div class="alert-danger">${alert}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert-success">${success}</div>
                    </c:if>

                    <%-- Form multipart (bắt buộc để upload file) --%>
                        <form action="${pageContext.request.contextPath}/user/profile" method="post"
                            enctype="multipart/form-data">

                            <%-- ── Avatar ──────────────────────────────────── --%>
                                <div class="avatar-section">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.account.avatar}">
                                            <img id="avatarPreview"
                                                src="${pageContext.request.contextPath}/${sessionScope.account.avatar}"
                                                class="avatar-img" alt="Avatar"
                                                onclick="document.getElementById('avatarInput').click()">
                                        </c:when>
                                        <c:otherwise>
                                            <img id="avatarPreview"
                                                src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=2c3e50&color=fff&size=96&bold=true"
                                                class="avatar-img" alt="Avatar"
                                                onclick="document.getElementById('avatarInput').click()">
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="avatar-hint" onclick="document.getElementById('avatarInput').click()">
                                        &#128247; Đổi ảnh đại diện
                                    </span>
                                    <input type="file" id="avatarInput" name="avatar"
                                        accept="image/png, image/jpeg, image/gif, image/webp">
                                </div>

                                <%-- ── Readonly fields ────────────────────────── --%>
                                    <div class="field">
                                        <label>Tên đăng nhập</label>
                                        <input type="text" value="${sessionScope.account.userName}" readonly>
                                    </div>
                                    <div class="field">
                                        <label>Email</label>
                                        <input type="text" value="${sessionScope.account.email}" readonly>
                                    </div>

                                    <hr class="divider">

                                    <%-- ── Editable fields ────────────────────────── --%>
                                        <div class="field">
                                            <label for="fullname">Họ và tên <span style="color:#e74c3c">*</span></label>
                                            <input type="text" id="fullname" name="fullname"
                                                value="${sessionScope.account.fullName}" placeholder="Nhập họ và tên"
                                                required>
                                        </div>

                                        <div class="field">
                                            <label for="phone">Số điện thoại</label>
                                            <input type="tel" id="phone" name="phone"
                                                value="${sessionScope.account.phone}" placeholder="Nhập số điện thoại">
                                        </div>

                                        <button type="submit" class="btn-save">&#10003; Lưu thay đổi</button>
                        </form>

            </div>
        </div>

        <script>
            // Preview ảnh trước khi upload
            document.getElementById('avatarInput').addEventListener('change', function () {
                if (this.files && this.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('avatarPreview').src = e.target.result;
                    };
                    reader.readAsDataURL(this.files[0]);
                }
            });
        </script>

        <jsp:include page="/common/footer.jsp" />