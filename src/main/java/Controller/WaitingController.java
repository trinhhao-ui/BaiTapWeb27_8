package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Model.User;
import Service.UserService;
import Service.impl.UserServiceImpl;

/**
 * TẦNG CONTROLLER - Phân quyền sau đăng nhập *
 * Xử lý 2 trường hợp:
 * 1. Đăng nhập thường  -> session key "account" chứa object User
 * 2. Đăng nhập cookie  -> session key "username" chứa String username
 *                         -> load User từ DB rồi lưu vào "account"
 *
 * Phân quyền theo roleid:
 *   roleid == 1  -> /admin/category/list
 *   roleid == 2  -> /manager/home
 *   còn lại      -> /user/home
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/waiting")
public class WaitingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User u = null;

        // ── Trường hợp 1: đăng nhập thường -> session "account" là User object
        if (session.getAttribute("account") != null
                && session.getAttribute("account") instanceof User) {
            u = (User) session.getAttribute("account");
        }

        // ── Trường hợp 2: login bằng cookie -> session "username" là String
        //    Theo slide trang 15: session.setAttribute("username", cookie.getValue())
        else if (session.getAttribute("username") != null) {
            String username = (String) session.getAttribute("username");
            UserService service = new UserServiceImpl();
            u = service.get(username);

            if (u != null) {
                // Load được User -> lưu vào "account" để dùng sau
                session.setAttribute("account", u);
            }
        }

        // ── Có User -> phân quyền theo roleid
        if (u != null) {
            req.setAttribute("username", u.getUserName());

            if (u.getRoleid() == 1) {
                // Admin
                resp.sendRedirect(req.getContextPath() + "/admin/category/list");

            } else if (u.getRoleid() == 2) {
                // Manager
                resp.sendRedirect(req.getContextPath() + "/manager/home");

            } else {
                // User thường
                resp.sendRedirect(req.getContextPath() + "/user/home");
            }

        } else {
            // Không tìm được User -> về login
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
