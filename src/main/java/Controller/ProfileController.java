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
 * GET  /user/profile  -> hiện form profile
 * POST /user/profile  -> xử lý update fullname, phone, avatar (multipart)
 */
@SuppressWarnings("serial")
@WebServlet("/user/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB - bắt đầu ghi ra file tạm
    maxFileSize       = 5 * 1024 * 1024,  // 5MB - giới hạn mỗi file
    maxRequestSize    = 10 * 1024 * 1024  // 10MB - giới hạn toàn request
)
public class ProfileController extends HttpServlet {

    private static final String VIEW = "/views/user/profile.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("account");

        String fullName = req.getParameter("fullname");
        String phone    = req.getParameter("phone");

        // Validate fullname
        if (fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("alert", "Họ tên không được để trống!");
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // Xử lý upload avatar (multipart)
        String avatarPath = currentUser.getAvatar(); // giữ ảnh cũ mặc định
        try {
            Part filePart = req.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0
                    && UploadHelper.getFileName(filePart) != null
                    && !UploadHelper.getFileName(filePart).isEmpty()) {

                // Xóa ảnh cũ trước khi upload ảnh mới
                if (avatarPath != null && !avatarPath.isEmpty()) {
                    UploadHelper.deleteImage(avatarPath, getServletContext());
                }
                avatarPath = UploadHelper.uploadImage(filePart, getServletContext());
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Lỗi khi upload ảnh: " + e.getMessage());
            req.getRequestDispatcher(VIEW).forward(req, resp);
            return;
        }

        // Gọi Service -> JPA updateProfile
        UserService service = new UserServiceImpl();
        boolean ok = service.updateProfile(
                currentUser.getId(), fullName.trim(), phone, avatarPath);

        if (ok) {
            // Cập nhật lại session để hiển thị thông tin mới ngay
            currentUser.setFullName(fullName.trim());
            currentUser.setPhone(phone);
            currentUser.setAvatar(avatarPath);
            session.setAttribute("account", currentUser);

            req.setAttribute("success", "Cập nhật thông tin thành công!");
        } else {
            req.setAttribute("alert", "Đã xảy ra lỗi, vui lòng thử lại!");
        }

        req.getRequestDispatcher(VIEW).forward(req, resp);
    }
}
