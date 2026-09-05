package Controller;

import java.io.IOException;

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
import Utils.UploadHelper;

@WebServlet("/admin/product/delete")
public class ProductDeleteController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !(session.getAttribute("account") instanceof User)) {
            resp.sendRedirect(req.getContextPath() + "/login"); return;
        }
        if (((User) session.getAttribute("account")).getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/user/home"); return;
        }

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.getById(id);
            if (product != null) {
                // Xóa ảnh nếu có
                if (product.getImage() != null && !product.getImage().isEmpty()) {
                    UploadHelper.deleteImage(product.getImage(), req.getServletContext());
                }
                productService.delete(id);
                session.setAttribute("successMessage", "Xóa sản phẩm thành công!");
            }
        } catch (NumberFormatException e) {
            // id không hợp lệ, bỏ qua
        }

        resp.sendRedirect(req.getContextPath() + "/admin/product/list");
    }
}
