package Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import Model.Product;
import Service.ProductService;
import Service.impl.ProductServiceImpl;

/**
 * GET /product?page=1
 * Hiển thị tất cả sản phẩm, phân trang 6 sản phẩm/trang.
 * Không yêu cầu đăng nhập.
 */
@WebServlet("/product")
public class ProductPageController extends HttpServlet {

    private static final int PAGE_SIZE = 6;
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ── Lấy số trang hiện tại ────────────────────────────
        int currentPage = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // ── Tính tổng trang ──────────────────────────────────
        long totalProducts = 0;
        int  totalPages    = 1;
        List<Product> products;

        try {
            totalProducts = productService.countActive();
            totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
            if (totalPages < 1) totalPages = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            products = productService.getPage(currentPage, PAGE_SIZE);
        } catch (Exception e) {
            e.printStackTrace();
            products = java.util.Collections.emptyList();
        }

        req.setAttribute("products",      products);
        req.setAttribute("currentPage",   currentPage);
        req.setAttribute("totalPages",    totalPages);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("pageSize",      PAGE_SIZE);

        req.getRequestDispatcher("/views/product-list.jsp").forward(req, resp);
    }
}
