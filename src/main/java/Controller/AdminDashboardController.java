package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Model.User;
import Service.CategoryService;
import Service.ProductService;
import Service.impl.CategoryServiceImpl;
import Service.impl.ProductServiceImpl;

/**
 * CONTROLLER - Trang Dashboard admin
 * URL: /admin/dashboard
 */
@SuppressWarnings("serial")
@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    CategoryService cateService    = new CategoryServiceImpl();
    ProductService  productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !(session.getAttribute("account") instanceof User)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User u = (User) session.getAttribute("account");
        if (u.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/user/home");
            return;
        }

        // Đếm số danh mục để hiển thị trên dashboard
        int totalCategory = cateService.getAll().size();
        req.setAttribute("totalCategory", totalCategory);

        long totalProduct = productService.countActive();
        req.setAttribute("totalProduct", totalProduct);

        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }
}
