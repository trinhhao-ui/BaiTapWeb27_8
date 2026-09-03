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
 * Kích hoạt tài khoản bằng OTP gửi qua email sau khi đăng ký.
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {

    private static final String VIEW = "/views/verify-otp.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Phải có pendingEmail trong session (đặt bởi register_controller)
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("pendingEmail") == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("pendingEmail") == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }

        String email  = (String) session.getAttribute("pendingEmail");
        String otp    = req.getParameter("otp");
        String action = req.getParameter("action"); // "verify" hoặc "resend"

        UserService service = new UserServiceImpl();

        // Gửi lại OTP
        if ("resend".equals(action)) {
            boolean sent = service.sendActivationOtp(email);
            if (sent) {
                req.setAttribute("success", "Đã gửi lại OTP về " + email);
            } else {
                req.setAttribute("alert", "Không thể gửi email, vui lòng thử lại sau.");
            }
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // Xác minh OTP
        if (otp == null || otp.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập mã OTP!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        boolean verified = service.verifyActivationOtp(email, otp.trim());
        if (verified) {
            // Kích hoạt thành công -> xóa session tạm, redirect login
            session.removeAttribute("pendingEmail");
            req.getSession(true).setAttribute("registerSuccess",
                    "Tài khoản đã được kích hoạt! Vui lòng đăng nhập.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("alert", "Mã OTP không đúng hoặc đã hết hạn. Vui lòng thử lại!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
        }
    }
}
