package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import Model.Category;
import Model.User;
import Service.CategoryService;
import Service.impl.CategoryServiceImpl;
import Utils.UploadHelper;

@WebServlet(urlPatterns = { "/admin/category/edit" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 5,
    maxRequestSize    = 1024 * 1024 * 10
)
public class CategoryEditController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CategoryService cateService = new CategoryServiceImpl();

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

        String id = req.getParameter("id");
        Category category = cateService.get(Integer.parseInt(id));
        req.setAttribute("category", category);
        req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String id   = req.getParameter("id");
        String name = req.getParameter("name");

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên danh mục không được để trống!");
            Category category = cateService.get(Integer.parseInt(id));
            req.setAttribute("category", category);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        }

        // Lấy category cũ để giữ ảnh nếu không upload mới
        Category oldCategory = cateService.get(Integer.parseInt(id));
        String iconPath = oldCategory.getIcon();

        // Xử lý ảnh mới nếu có upload
        Part filePart = req.getPart("icon");
        if (filePart != null && filePart.getSize() > 0) {
            // Xóa ảnh cũ
            UploadHelper.deleteImage(oldCategory.getIcon(), req.getServletContext());
            // Upload ảnh mới
            iconPath = UploadHelper.uploadImage(filePart, req.getServletContext());
        }

        Category category = new Category();
        category.setId(Integer.parseInt(id));
        category.setName(name.trim());
        category.setIcon(iconPath);

        cateService.edit(category);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
