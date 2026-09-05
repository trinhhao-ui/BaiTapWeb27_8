package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Model.User;
import Service.UserService;
import Service.impl.UserServiceImpl;

/**
 * GET  /login -> kiểm tra session/cookie -> hiện login.jsp
 * POST /login -> xác thực -> kiểm tra status -> redirect
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/login")
public class login_controller extends HttpServlet {

    public static final String SESSION_ACCOUNT = "account";
    public static final String COOKIE_REMEMBER = "username";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(COOKIE_REMEMBER)) {
                    session = req.getSession(true);
                    session.setAttribute("username", cookie.getValue());
                    resp.sendRedirect(req.getContextPath() + "/waiting");
                    return;
                }
            }
        }

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username  = req.getParameter("username");
        String password  = req.getParameter("password");
        String remember  = req.getParameter("remember");
        boolean rememberMe = "on".equals(remember);

        // ========== SERVER-SIDE VALIDATION ==========
        
        // 1. Validate không rỗng
        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("alert", "Tên đăng nhập không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        if (password == null || password.isEmpty()) {
            req.setAttribute("alert", "Mật khẩu không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // 2. Validate độ dài username (min 3 chars)
        username = username.trim();
        if (username.length() < 3) {
            req.setAttribute("alert", "Tên đăng nhập phải có ít nhất 3 ký tự!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // 3. Validate độ dài password (min 6 chars)
        if (password.length() < 6) {
            req.setAttribute("alert", "Mật khẩu phải có ít nhất 6 ký tự!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // 4. Validate username format (chỉ chữ, số và underscore)
        if (!username.matches("^[a-zA-Z0-9_]+$")) {
            req.setAttribute("alert", "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // 5. Kiểm tra SQL Injection patterns (basic security)
        String[] sqlPatterns = {"'", "\"", "--", ";", "/*", "*/", "xp_", "sp_", "DROP", "DELETE", "INSERT", "UPDATE"};
        for (String pattern : sqlPatterns) {
            if (username.toUpperCase().contains(pattern) || password.toUpperCase().contains(pattern)) {
                req.setAttribute("alert", "Phát hiện ký tự không hợp lệ trong thông tin đăng nhập!");
                req.setAttribute("alertClass", "alert-danger");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                return;
            }
        }

        // ========== AUTHENTICATION ==========
        UserService service = new UserServiceImpl();
        User user = null;
        
        try {
            user = service.login(username, password);
        } catch (Exception e) {
            req.setAttribute("alert", "Đã xảy ra lỗi trong quá trình đăng nhập. Vui lòng thử lại!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        if (user == null) {
            req.setAttribute("alert", "Tên đăng nhập hoặc mật khẩu không đúng!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra tài khoản đã kích hoạt chưa (status = 0 là chưa kích hoạt)
        if (user.getStatus() == 0) {
            // Gửi lại OTP kích hoạt
            service.sendActivationOtp(user.getEmail());
            // Lưu email vào session để redirect sang verify-otp
            HttpSession session = req.getSession(true);
            session.setAttribute("pendingEmail", user.getEmail());
            req.setAttribute("alert", "Tài khoản chưa được kích hoạt! "
                    + "Chúng tôi đã gửi lại OTP về email " + user.getEmail());
            req.setAttribute("alertClass", "alert-warning");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // Đăng nhập thành công
        HttpSession session = req.getSession(true);
        session.setAttribute(SESSION_ACCOUNT, user);

        if (rememberMe) {
            Cookie cookie = new Cookie(COOKIE_REMEMBER, username);
            cookie.setMaxAge(30 * 60); // 30 phút
            cookie.setHttpOnly(true); // Security: prevent XSS
            cookie.setPath(req.getContextPath() + "/");
            resp.addCookie(cookie);
        }

        resp.sendRedirect(req.getContextPath() + "/waiting");
    }
}
