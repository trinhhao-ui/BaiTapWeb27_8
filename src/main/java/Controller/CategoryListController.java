package Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Model.Category;
import Model.User;
import Service.CategoryService;
import Service.impl.CategoryServiceImpl;

/**
 * Hiển thị danh sách tất cả Category
 * URL: /admin/category/list
 */
@WebServlet(urlPatterns = { "/admin/category/list" })
public class CategoryListController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Kiểm tra quyền admin
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("account") == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            Object obj = session.getAttribute("account");
            // Kiểm tra đúng kiểu User
            if (!(obj instanceof User)) {
                session.invalidate();
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            User currentUser = (User) obj;
            if (currentUser.getRoleid() != 1) {
                resp.sendRedirect(req.getContextPath() + "/user/home");
                return;
            }

            List<Category> cateList = cateService.getAll();
            req.setAttribute("cateList", cateList);

            RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/list-category.jsp");
            dispatcher.forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("<h3>Lỗi: " + e.getMessage() + "</h3><pre>");
            e.printStackTrace(resp.getWriter());
            resp.getWriter().println("</pre>");
        }
    }
}
