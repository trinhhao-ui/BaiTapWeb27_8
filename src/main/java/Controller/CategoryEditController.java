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

        // Check admin authentication
        HttpSession session = req.getSession(false);
        if (session == null || !(session.getAttribute("account") instanceof User)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if (((User) session.getAttribute("account")).getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/user/home");
            return;
        }

        String categoryidStr = req.getParameter("categoryid");
        String categoryname  = req.getParameter("categoryname");
        String statusStr     = req.getParameter("status");

        // ========== SERVER-SIDE VALIDATION ==========

        // 1. Validate categoryid
        if (categoryidStr == null || categoryidStr.isEmpty()) {
            req.setAttribute("alert", "ID danh mục không hợp lệ!");
            req.setAttribute("alertClass", "alert-danger");
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            return;
        }

        int categoryid;
        try {
            categoryid = Integer.parseInt(categoryidStr);
        } catch (NumberFormatException e) {
            req.setAttribute("alert", "ID danh mục không hợp lệ!");
            req.setAttribute("alertClass", "alert-danger");
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            return;
        }

        // 2. Check if category exists
        Category oldCategory = cateService.get(categoryid);
        if (oldCategory == null) {
            req.setAttribute("alert", "Danh mục không tồn tại!");
            req.setAttribute("alertClass", "alert-danger");
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            return;
        }

        // 3. Validate categoryname required
        if (categoryname == null || categoryname.trim().isEmpty()) {
            req.setAttribute("alert", "Tên danh mục không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        }

        // 4. Trim categoryname
        categoryname = categoryname.trim();

        // 5. Validate categoryname length (3-100)
        if (categoryname.length() < 3 || categoryname.length() > 100) {
            req.setAttribute("alert", "Tên danh mục phải có từ 3-100 ký tự!");
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        }

        // 6. Validate status required
        if (statusStr == null || statusStr.isEmpty()) {
            req.setAttribute("alert", "Vui lòng chọn trạng thái!");
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        }

        // 7. Parse and validate status value
        int status;
        try {
            status = Integer.parseInt(statusStr);
            if (status != 0 && status != 1) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            req.setAttribute("alert", "Trạng thái không hợp lệ!");
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        }

        // 8. Security: Check for SQL injection patterns
        String[] sqlPatterns = {"'", "\"", "--", ";", "/*", "*/", "xp_", "sp_"};
        for (String pattern : sqlPatterns) {
            if (categoryname.contains(pattern)) {
                req.setAttribute("alert", "Phát hiện ký tự không hợp lệ trong tên danh mục!");
                req.setAttribute("alertClass", "alert-danger");
                req.setAttribute("category", oldCategory);
                req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                return;
            }
        }

        // 9. Check duplicate category name (exclude current category)
        Category existingCategory = cateService.get(categoryname);
        if (existingCategory != null && existingCategory.getId() != categoryid) {
            req.setAttribute("alert", "Tên danh mục đã tồn tại!");
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        }

        // ========== FILE UPLOAD VALIDATION ==========
        String imagesPath = oldCategory.getIcon(); // Keep old image by default
        
        try {
            Part filePart = req.getPart("images");
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UploadHelper.getFileName(filePart);
                
                if (fileName != null && !fileName.isEmpty()) {
                    // 10. Validate file type
                    String contentType = filePart.getContentType();
                    String[] allowedTypes = {"image/png", "image/jpeg", "image/jpg", "image/gif", "image/webp"};
                    boolean validType = false;
                    
                    for (String type : allowedTypes) {
                        if (type.equals(contentType)) {
                            validType = true;
                            break;
                        }
                    }
                    
                    if (!validType) {
                        req.setAttribute("alert", "Chỉ được upload file ảnh (PNG, JPG, GIF, WEBP)!");
                        req.setAttribute("alertClass", "alert-danger");
                        req.setAttribute("category", oldCategory);
                        req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                        return;
                    }

                    // 11. Validate file size
                    long fileSize = filePart.getSize();
                    long maxSize = 5 * 1024 * 1024; // 5MB
                    
                    if (fileSize > maxSize) {
                        req.setAttribute("alert", "Kích thước file không được vượt quá 5MB!");
                        req.setAttribute("alertClass", "alert-danger");
                        req.setAttribute("category", oldCategory);
                        req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                        return;
                    }

                    // 12. Validate file extension
                    String fileExtension = "";
                    int lastDotIndex = fileName.lastIndexOf('.');
                    if (lastDotIndex > 0) {
                        fileExtension = fileName.substring(lastDotIndex + 1).toLowerCase();
                    }
                    
                    String[] allowedExtensions = {"png", "jpg", "jpeg", "gif", "webp"};
                    boolean validExtension = false;
                    
                    for (String ext : allowedExtensions) {
                        if (ext.equals(fileExtension)) {
                            validExtension = true;
                            break;
                        }
                    }
                    
                    if (!validExtension) {
                        req.setAttribute("alert", "File phải có định dạng: PNG, JPG, GIF, WEBP!");
                        req.setAttribute("alertClass", "alert-danger");
                        req.setAttribute("category", oldCategory);
                        req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                        return;
                    }

                    // Valid file - delete old and upload new
                    if (imagesPath != null && !imagesPath.isEmpty()) {
                        UploadHelper.deleteImage(imagesPath, req.getServletContext());
                    }
                    
                    imagesPath = UploadHelper.uploadImage(filePart, req.getServletContext());
                }
            }
        } catch (IllegalStateException e) {
            req.setAttribute("alert", "File quá lớn! Kích thước tối đa là 5MB.");
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Lỗi khi upload ảnh: " + e.getMessage());
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
            return;
        }

        // ========== UPDATE CATEGORY ==========
        try {
            Category category = new Category();
            category.setId(categoryid);
            category.setName(categoryname);
            category.setIcon(imagesPath);
            
            cateService.edit(category);
            
            // Success - redirect to list with success message
            session.setAttribute("successMessage", "Cập nhật danh mục thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Đã xảy ra lỗi khi cập nhật danh mục: " + e.getMessage());
            req.setAttribute("alertClass", "alert-danger");
            req.setAttribute("category", oldCategory);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
        }
    }
}
