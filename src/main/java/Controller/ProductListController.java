package Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import Model.Product;
import Model.User;
import Service.ProductService;
import Service.impl.ProductServiceImpl;

@WebServlet("/admin/product/list")
public class ProductListController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Kiểm tra quyền admin
        HttpSession session = req.getSession(false);
        if (session == null || !(session.getAttribute("account") instanceof User)) {
            resp.sendRedirect(req.getContextPath() + "/login"); return;
        }
        if (((User) session.getAttribute("account")).getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/user/home"); return;
        }

        List<Product> productList = productService.getAll();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/views/admin/list-product.jsp").forward(req, resp);
    }
}
