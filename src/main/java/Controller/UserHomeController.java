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
import Service.ProductService;
import Service.impl.ProductServiceImpl;

/**
 * Trang dành cho USER thường sau khi đăng nhập (roleid != 1)
 * URL: /user/home  — hiển thị thông tin user + 10 SP mới nhất
 */
@SuppressWarnings("serial")
@WebServlet("/user/home")
public class UserHomeController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Product> latestProducts = productService.getLatest(10);
            request.setAttribute("latestProducts", latestProducts);
        } catch (Exception e) {
            request.setAttribute("latestProducts", java.util.Collections.emptyList());
        }

        request.getRequestDispatcher("/views/user/home.jsp").forward(request, response);
    }
}
