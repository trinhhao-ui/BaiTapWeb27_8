package Controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import Model.Category;
import Model.Product;
import Model.User;
import Service.CategoryService;
import Service.ProductService;
import Service.impl.CategoryServiceImpl;
import Service.impl.ProductServiceImpl;
import Utils.UploadHelper;

@WebServlet("/admin/product/add")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 5,
    maxRequestSize    = 1024 * 1024 * 10
)
public class ProductAddController extends HttpServlet {

    private final ProductService  productService  = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();

    private static final String VIEW = "/views/admin/add-product.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req, resp)) return;

        List<Category> categories = categoryService.getAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        if (!isAdmin(req, resp)) return;

        String name        = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr    = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String cateIdStr   = req.getParameter("cateId");
        String statusStr   = req.getParameter("status");

        // ── Validation ────────────────────────────────────────
        if (name == null || name.trim().isEmpty()) {
            forwardWithError(req, resp, "Tên sản phẩm không được để trống!"); return;
        }
        name = name.trim();
        if (name.length() < 3 || name.length() > 255) {
            forwardWithError(req, resp, "Tên sản phẩm phải từ 3-255 ký tự!"); return;
        }

        BigDecimal price;
        try {
            price = new BigDecimal(priceStr);
            if (price.compareTo(BigDecimal.ZERO) < 0) throw new NumberFormatException();
        } catch (Exception e) {
            forwardWithError(req, resp, "Giá phải là số không âm!"); return;
        }

        int quantity;
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity < 0) throw new NumberFormatException();
        } catch (Exception e) {
            forwardWithError(req, resp, "Số lượng phải là số nguyên không âm!"); return;
        }

        int cateId;
        try {
            cateId = Integer.parseInt(cateIdStr);
        } catch (Exception e) {
            forwardWithError(req, resp, "Vui lòng chọn danh mục!"); return;
        }

        int status = "0".equals(statusStr) ? 0 : 1;

        // ── Upload ảnh ────────────────────────────────────────
        String imagePath = null;
        try {
            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UploadHelper.getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    imagePath = UploadHelper.uploadImage(filePart, req.getServletContext());
                }
            }
        } catch (Exception e) {
            forwardWithError(req, resp, "Lỗi khi upload ảnh: " + e.getMessage()); return;
        }

        // ── Lưu DB ────────────────────────────────────────────
        try {
            Category category = categoryService.get(cateId);
            if (category == null) {
                forwardWithError(req, resp, "Danh mục không tồn tại!"); return;
            }
            Product product = new Product(name, description, price, quantity, imagePath, status, category);
            productService.add(product);

            req.getSession(true).setAttribute("successMessage", "Thêm sản phẩm thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        } catch (Exception e) {
            e.printStackTrace();
            forwardWithError(req, resp, "Lỗi khi thêm sản phẩm: " + e.getMessage());
        }
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, String msg)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        List<Category> categories = categoryService.getAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    private boolean isAdmin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !(session.getAttribute("account") instanceof User)) {
            resp.sendRedirect(req.getContextPath() + "/login"); return false;
        }
        if (((User) session.getAttribute("account")).getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/user/home"); return false;
        }
        return true;
    }
}
