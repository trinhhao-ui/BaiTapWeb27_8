package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * CONTROLLER - Điều hướng chính
 * / -> nếu đã đăng nhập -> /waiting, chưa -> /login
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/", "/error" })
public class MainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/error".equals(path)) {
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        // URL "/" -> kiểm tra session rồi điều hướng
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            response.sendRedirect(request.getContextPath() + "/waiting");
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
