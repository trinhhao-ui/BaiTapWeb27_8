package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import Model.Product;
import Service.ProductService;
import Service.impl.ProductServiceImpl;

/**
 * GET /product/detail?id=
 * Hiển thị chi tiết một sản phẩm.
 * Không yêu cầu đăng nhập.
 */
@WebServlet("/product/detail")
public class ProductDetailController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            Product product = productService.getById(id);

            if (product == null || product.getStatus() == 0) {
                // Sản phẩm không tồn tại hoặc đang ẩn → về danh sách
                resp.sendRedirect(req.getContextPath() + "/product");
                return;
            }

            req.setAttribute("product", product);
            req.getRequestDispatcher("/views/product-detail.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }
}
