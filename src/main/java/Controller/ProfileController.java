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

import Model.User;
import Service.UserService;
import Service.impl.UserServiceImpl;
import Utils.UploadHelper;

/**
 * GET  /user/profile  → hiển thị form profile
 * POST /user/profile  → xử lý update fullname, phone, avatar (multipart/form-data)
 *
 * JPA: UserServiceImpl.updateProfile() → UserJpaDaoImpl.updateProfile()
 *      → em.find() + em.merge() + commit
 */
@SuppressWarnings("serial")
@WebServlet("/user/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,       // 1 MB – bắt đầu ghi ra file tạm
    maxFileSize       = 5 * 1024 * 1024,   // 5 MB – giới hạn mỗi file
    maxRequestSize    = 10 * 1024 * 1024   // 10 MB – giới hạn toàn request
)
public class ProfileController extends HttpServlet {

    private static final String VIEW = "/views/user/profile.jsp";

    // ── GET ───────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !(session.getAttribute("account") instanceof User)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    // ── POST ──────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 1. Kiểm tra session
        HttpSession session = req.getSession(false);
        if (session == null || !(session.getAttribute("account") instanceof User)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User currentUser = (User) session.getAttribute("account");

        String fullName = req.getParameter("fullname");
        String phone    = req.getParameter("phone");

        // ── SERVER-SIDE VALIDATION ──────────────────────────

        // 2. Fullname bắt buộc
        if (fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("alert",      "Họ tên không được để trống!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }
        fullName = fullName.trim();

        // 3. Fullname độ dài 3-100
        if (fullName.length() < 3 || fullName.length() > 100) {
            req.setAttribute("alert",      "Họ tên phải có từ 3-100 ký tự!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // 4. Phone: tùy chọn, nếu nhập phải đúng định dạng
        if (phone != null) phone = phone.trim();
        if (phone != null && !phone.isEmpty()) {
            if (!phone.matches("^0[0-9]{9}$")) {
                req.setAttribute("alert",      "Số điện thoại phải có 10 chữ số và bắt đầu bằng 0!");
                req.setAttribute("alertClass", "alert-danger");
                req.getRequestDispatcher(VIEW).forward(req, resp);
                return;
            }
        }

        // ── XỬ LÝ UPLOAD ẢNH ────────────────────────────────
        String avatarPath = currentUser.getAvatar(); // giữ ảnh cũ mặc định

        try {
            Part filePart = req.getPart("avatar");

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UploadHelper.getFileName(filePart);

                if (fileName != null && !fileName.isEmpty()) {
                    // 5. Validate MIME type
                    String contentType = filePart.getContentType();
                    if (contentType == null ||
                        !contentType.matches("image/(png|jpeg|gif|webp)")) {
                        req.setAttribute("alert",      "Chỉ được upload file ảnh (PNG, JPG, GIF, WEBP)!");
                        req.setAttribute("alertClass", "alert-danger");
                        req.getRequestDispatcher(VIEW).forward(req, resp);
                        return;
                    }

                    // 6. Validate kích thước (5MB)
                    if (filePart.getSize() > 5 * 1024 * 1024) {
                        req.setAttribute("alert",      "Kích thước ảnh không được vượt quá 5MB!");
                        req.setAttribute("alertClass", "alert-danger");
                        req.getRequestDispatcher(VIEW).forward(req, resp);
                        return;
                    }

                    // 7. Validate extension
                    int dot = fileName.lastIndexOf('.');
                    String ext = dot > 0 ? fileName.substring(dot + 1).toLowerCase() : "";
                    if (!ext.matches("png|jpg|jpeg|gif|webp")) {
                        req.setAttribute("alert",      "File phải có định dạng: PNG, JPG, GIF, WEBP!");
                        req.setAttribute("alertClass", "alert-danger");
                        req.getRequestDispatcher(VIEW).forward(req, resp);
                        return;
                    }

                    // Upload file
                    avatarPath = UploadHelper.uploadImage(filePart, req.getServletContext());
                }
            }

        } catch (IllegalStateException e) {
            // Bắt lỗi vượt quá maxFileSize của @MultipartConfig
            req.setAttribute("alert",      "File quá lớn! Kích thước tối đa là 5MB.");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // ── CẬP NHẬT JPA ────────────────────────────────────
        UserService service = new UserServiceImpl();
        boolean ok = service.updateProfile(currentUser.getId(), fullName, phone, avatarPath);

        if (!ok) {
            req.setAttribute("alert",      "Đã xảy ra lỗi khi cập nhật hồ sơ. Vui lòng thử lại!");
            req.setAttribute("alertClass", "alert-danger");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // 8. Cập nhật lại session với thông tin mới
        currentUser.setFullName(fullName);
        currentUser.setPhone(phone);
        if (avatarPath != null && !avatarPath.isEmpty()) {
            currentUser.setAvatar(avatarPath);
        }
        session.setAttribute("account", currentUser);

        // 9. Redirect với thông báo thành công
        req.setAttribute("alert",      "Cập nhật hồ sơ thành công!");
        req.setAttribute("alertClass", "alert-success");
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }
}
