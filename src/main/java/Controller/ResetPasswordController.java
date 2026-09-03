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
 * Bước 2 của quên mật khẩu: nhập OTP + mật khẩu mới.
 *
 * GET  /reset-password -> hiện form nhập OTP + mật khẩu mới
 * POST /reset-password -> xác minh OTP -> đặt mật khẩu mới -> redirect /login
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/reset-password")
public class ResetPasswordController extends HttpServlet {

    private static final String VIEW = "/views/reset-password.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Phải có resetEmail trong session
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("resetEmail") == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("resetEmail") == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        String email       = (String) session.getAttribute("resetEmail");
        String otp         = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String rePassword  = req.getParameter("rePassword");
        String action      = req.getParameter("action"); // "reset" hoặc "resend"

        UserService service = new UserServiceImpl();

        // Gửi lại OTP
        if ("resend".equals(action)) {
            boolean sent = service.sendResetPasswordOtp(email);
            if (sent) {
                req.setAttribute("success", "Đã gửi lại OTP về " + email);
            } else {
                req.setAttribute("alert", "Không thể gửi email, vui lòng thử lại sau.");
            }
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // Validate
        if (otp == null || otp.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập mã OTP!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }
        if (newPassword == null || newPassword.length() < 6) {
            req.setAttribute("alert", "Mật khẩu phải có ít nhất 6 ký tự!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }
        if (!newPassword.equals(rePassword)) {
            req.setAttribute("alert", "Mật khẩu nhập lại không khớp!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // Xác minh OTP
        boolean verified = service.verifyResetPasswordOtp(email, otp.trim());
        if (!verified) {
            req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // Đặt lại mật khẩu
        boolean done = service.resetPassword(email, newPassword);
        if (done) {
            session.removeAttribute("resetEmail");
            session.setAttribute("registerSuccess", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("alert", "Đã xảy ra lỗi, vui lòng thử lại!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
        }
    }
}
