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

@WebServlet("/admin/product/edit")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 5,
    maxRequestSize    = 1024 * 1024 * 10
)
public class ProductEditController extends HttpServlet {

    private final ProductService  productService  = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();

    private static final String VIEW = "/views/admin/edit-product.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req, resp)) return;

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.getById(id);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/product/list"); return;
            }
            req.setAttribute("product", product);
            req.setAttribute("categories", categoryService.getAll());
            req.getRequestDispatcher(VIEW).forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        if (!isAdmin(req, resp)) return;

        String idStr       = req.getParameter("id");
        String name        = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr    = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String cateIdStr   = req.getParameter("cateId");
        String statusStr   = req.getParameter("status");

        int id;
        try { id = Integer.parseInt(idStr); }
        catch (Exception e) { resp.sendRedirect(req.getContextPath() + "/admin/product/list"); return; }

        Product product = productService.getById(id);
        if (product == null) { resp.sendRedirect(req.getContextPath() + "/admin/product/list"); return; }

        // ── Validation ────────────────────────────────────────
        if (name == null || name.trim().isEmpty()) {
            forwardWithError(req, resp, "Tên sản phẩm không được để trống!", product); return;
        }
        name = name.trim();

        BigDecimal price;
        try {
            price = new BigDecimal(priceStr);
            if (price.compareTo(BigDecimal.ZERO) < 0) throw new NumberFormatException();
        } catch (Exception e) {
            forwardWithError(req, resp, "Giá phải là số không âm!", product); return;
        }

        int quantity;
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity < 0) throw new NumberFormatException();
        } catch (Exception e) {
            forwardWithError(req, resp, "Số lượng phải là số nguyên không âm!", product); return;
        }

        int cateId;
        try { cateId = Integer.parseInt(cateIdStr); }
        catch (Exception e) { forwardWithError(req, resp, "Vui lòng chọn danh mục!", product); return; }

        int status = "0".equals(statusStr) ? 0 : 1;

        // ── Upload ảnh mới (nếu có) ───────────────────────────
        try {
            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UploadHelper.getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Xóa ảnh cũ
                    if (product.getImage() != null) {
                        UploadHelper.deleteImage(product.getImage(), req.getServletContext());
                    }
                    product.setImage(UploadHelper.uploadImage(filePart, req.getServletContext()));
                }
            }
        } catch (Exception e) {
            forwardWithError(req, resp, "Lỗi khi upload ảnh: " + e.getMessage(), product); return;
        }

        // ── Cập nhật ─────────────────────────────────────────
        try {
            Category category = categoryService.get(cateId);
            if (category == null) { forwardWithError(req, resp, "Danh mục không tồn tại!", product); return; }

            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setCategory(category);
            productService.update(product);

            req.getSession(true).setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/product/list");
        } catch (Exception e) {
            e.printStackTrace();
            forwardWithError(req, resp, "Lỗi khi cập nhật: " + e.getMessage(), product);
        }
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp,
                                  String msg, Product product) throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.setAttribute("product", product);
        req.setAttribute("categories", categoryService.getAll());
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    private boolean isAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
