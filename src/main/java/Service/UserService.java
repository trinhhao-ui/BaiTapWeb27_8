package Service;

import Model.User;

/**
 * TẦNG SERVICE - Interface
 * Định nghĩa các nghiệp vụ liên quan đến User
 */
public interface UserService {

    // ── Đăng nhập ──────────────────────────────────────────
    // Lấy user theo username từ DB, kiểm tra password trong ServiceImpl
    User login(String username, String password);

    // Lấy user theo username (dùng nội bộ trong login)
    User get(String username);

    // ── Đăng ký ────────────────────────────────────────────
    void insert(User user);

    boolean register(String username, String password,
                     String email, String fullname, String phone);

    boolean checkExistEmail(String email);

    boolean checkExistUsername(String username);

    boolean checkExistPhone(String phone);
}
