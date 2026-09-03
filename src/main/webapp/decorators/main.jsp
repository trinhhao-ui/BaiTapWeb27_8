<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <% // Decorator đơn giản: chỉ include header + footer // Sitemesh sẽ tự inject nội dung trang gốc vào giữa %>
            <jsp:include page="/common/header.jsp">
                <jsp:param name="title" value="User Dashboard" />
            </jsp:include>

            <%-- Sitemesh sẽ tự động inject nội dung body của trang gốc vào đây KHÔNG cần <sitemesh:write> tag
                --%>

                <jsp:include page="/common/footer.jsp" />