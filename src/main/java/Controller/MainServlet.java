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
 * CONTROLLER - Điều hướng chính
 * / -> hiển thị trang chủ với 10 sản phẩm mới nhất
 *      nếu đã đăng nhập -> /waiting
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/", "/error" })
public class MainServlet extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/error".equals(path)) {
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        // Nếu đã đăng nhập -> phân quyền
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            response.sendRedirect(request.getContextPath() + "/waiting");
            return;
        }

        // Chưa đăng nhập -> hiển thị trang chủ với 10 sản phẩm mới nhất
        try {
            List<Product> latestProducts = productService.getLatest(10);
            request.setAttribute("latestProducts", latestProducts);
        } catch (Exception e) {
            // DB chưa sẵn sàng thì vẫn hiển thị trang, list rỗng
            request.setAttribute("latestProducts", java.util.Collections.emptyList());
        }

        request.getRequestDispatcher("/views/index.jsp").forward(request, response);
    }
}
