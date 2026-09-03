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
 * GET  /register -> hiện form đăng ký
 * POST /register -> xử lý đăng ký -> gửi OTP -> redirect /verify-otp
 */
@SuppressWarnings({"serial"})
@WebServlet(urlPatterns = "/register")
public class register_controller extends HttpServlet {

    public static final String REGISTER = "/views/register.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Đã đăng nhập -> về waiting
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }
        req.getRequestDispatcher(REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username   = req.getParameter("username");
        String password   = req.getParameter("password");
        String repassword = req.getParameter("repassword");
        String email      = req.getParameter("email");
        String fullname   = req.getParameter("fullname");
        String phone      = req.getParameter("phone");

        UserService service = new UserServiceImpl();

        // Validate: mật khẩu nhập lại
        if (!password.equals(repassword)) {
            req.setAttribute("alert", "Mật khẩu nhập lại không khớp!");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // Validate: email trùng
        if (service.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã được sử dụng!");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // Validate: username trùng
        if (service.checkExistUsername(username)) {
            req.setAttribute("alert", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // Đăng ký tài khoản (status=0 - chưa kích hoạt)
        boolean registered = service.register(username, password, email, fullname, phone);
        if (!registered) {
            req.setAttribute("alert", "Đã xảy ra lỗi, vui lòng thử lại!");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // Gửi OTP kích hoạt qua email
        boolean sent = service.sendActivationOtp(email);
        if (!sent) {
            req.setAttribute("alert", "Đăng ký thành công nhưng không gửi được email. "
                    + "Liên hệ admin để kích hoạt tài khoản.");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // Lưu email vào session để trang verify-otp dùng
        HttpSession session = req.getSession(true);
        session.setAttribute("pendingEmail", email);

        // Redirect sang trang nhập OTP
        resp.sendRedirect(req.getContextPath() + "/verify-otp");
    }
}
