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

        // Validate không rỗng
        if (username == null || username.isEmpty()
                || password == null || password.isEmpty()) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không được để trống!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        UserService service = new UserServiceImpl();
        User user = service.login(username, password);

        if (user == null) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không đúng!");
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
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // Đăng nhập thành công
        HttpSession session = req.getSession(true);
        session.setAttribute(SESSION_ACCOUNT, user);

        if (rememberMe) {
            Cookie cookie = new Cookie(COOKIE_REMEMBER, username);
            cookie.setMaxAge(30 * 60); // 30 phút
            resp.addCookie(cookie);
        }

        resp.sendRedirect(req.getContextPath() + "/waiting");
    }
}
