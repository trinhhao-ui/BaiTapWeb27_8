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

        String username        = req.getParameter("username");
        String password        = req.getParameter("password");
        String confirmPassword = req.getParameter("repassword");
        String email           = req.getParameter("email");
        String fullname        = req.getParameter("fullname");
        String phone           = req.getParameter("phone");

        // ========== SERVER-SIDE VALIDATION ==========

        // 1. Validate required fields
        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("alert", "Tên đăng nhập không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (password == null || password.isEmpty()) {
            req.setAttribute("alert", "Mật khẩu không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (confirmPassword == null || confirmPassword.isEmpty()) {
            req.setAttribute("alert", "Vui lòng xác nhận mật khẩu!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Email không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (fullname == null || fullname.trim().isEmpty()) {
            req.setAttribute("alert", "Họ tên không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 2. Trim values
        username = username.trim();
        email = email.trim();
        fullname = fullname.trim();
        if (phone != null) {
            phone = phone.trim();
        }

        // 3. Validate username length (3-50)
        if (username.length() < 3 || username.length() > 50) {
            req.setAttribute("alert", "Tên đăng nhập phải có từ 3-50 ký tự!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 4. Validate username format (alphanumeric + underscore)
        if (!username.matches("^[a-zA-Z0-9_]+$")) {
            req.setAttribute("alert", "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 5. Validate password length (6-50)
        if (password.length() < 6 || password.length() > 50) {
            req.setAttribute("alert", "Mật khẩu phải có từ 6-50 ký tự!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 6. Validate password confirmation
        if (!password.equals(confirmPassword)) {
            req.setAttribute("alert", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 7. Validate email format
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        if (!email.matches(emailRegex)) {
            req.setAttribute("alert", "Địa chỉ email không hợp lệ!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 8. Validate fullname length (3-100)
        if (fullname.length() < 3 || fullname.length() > 100) {
            req.setAttribute("alert", "Họ tên phải có từ 3-100 ký tự!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 9. Validate phone format (optional but validate if provided)
        if (phone != null && !phone.isEmpty()) {
            if (!phone.matches("^0[0-9]{9}$")) {
                req.setAttribute("alert", "Số điện thoại phải có 10 chữ số và bắt đầu bằng 0!");
                req.setAttribute("alertClass", "alert-danger");
                req.getRequestDispatcher(REGISTER).forward(req, resp);
                return;
            }
        }

        // 10. Security: Check for SQL injection patterns
        String[] sqlPatterns = {"'", "\"", "--", ";", "/*", "*/", "xp_", "sp_"};
        for (String pattern : sqlPatterns) {
            if (username.contains(pattern) || email.contains(pattern) || fullname.contains(pattern)) {
                req.setAttribute("alert", "Phát hiện ký tự không hợp lệ trong thông tin đăng ký!");
                req.setAttribute("alertClass", "alert-danger");
                req.getRequestDispatcher(REGISTER).forward(req, resp);
                return;
            }
        }

        // ========== BUSINESS VALIDATION ==========
        UserService service = new UserServiceImpl();

        // 11. Check email exists
        if (service.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã được sử dụng!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // 12. Check username exists
        if (service.checkExistUsername(username)) {
            req.setAttribute("alert", "Tên đăng nhập đã tồn tại!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // ========== REGISTRATION ==========
        boolean registered = false;
        try {
            // Đăng ký tài khoản (status=0 - chưa kích hoạt)
            registered = service.register(username, password, email, fullname, phone);
        } catch (Exception e) {
            req.setAttribute("alert", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        if (!registered) {
            req.setAttribute("alert", "Đã xảy ra lỗi, vui lòng thử lại!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(REGISTER).forward(req, resp);
            return;
        }

        // Gửi OTP kích hoạt qua email
        boolean sent = service.sendActivationOtp(email);
        if (!sent) {
            req.setAttribute("alert", "Đăng ký thành công nhưng không gửi được email. "
                    + "Liên hệ admin để kích hoạt tài khoản.");
            req.setAttribute("alertClass", "alert-warning");
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
