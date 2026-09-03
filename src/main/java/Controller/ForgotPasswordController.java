package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Service.UserService;
import Service.impl.UserServiceImpl;

/**
 * Bước 1 của quên mật khẩu: nhập email để nhận OTP.
 *
 * GET  /forgot-password -> hiện form nhập email
 * POST /forgot-password -> gửi OTP reset password -> redirect /reset-password
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private static final String VIEW = "/views/forgot-password.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập địa chỉ email!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        UserService service = new UserServiceImpl();
        boolean sent = service.sendResetPasswordOtp(email.trim());

        if (!sent) {
            // Email không tồn tại trong hệ thống
            // Không tiết lộ email có tồn tại hay không để bảo mật
            req.setAttribute("alert", "Nếu email tồn tại trong hệ thống, chúng tôi đã gửi OTP.");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // Lưu email vào session để trang reset-password dùng
        HttpSession session = req.getSession(true);
        session.setAttribute("resetEmail", email.trim());

        resp.sendRedirect(req.getContextPath() + "/reset-password");
    }
}
