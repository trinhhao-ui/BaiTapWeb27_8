package DAO;

import Model.User;

/**
 * TẦNG DAO - Interface
 * Định nghĩa các thao tác với bảng users trong database
 */
public interface UserDao {

    // Lấy user theo username - dùng cho đăng nhập
    User get(String username);

    // Thêm user mới - dùng cho đăng ký
    void insert(User user);

    // Kiểm tra email đã tồn tại chưa
    boolean checkExistEmail(String email);

    // Kiểm tra username đã tồn tại chưa
    boolean checkExistUsername(String username);

    // Kiểm tra phone đã tồn tại chưa
    boolean checkExistPhone(String phone);
}
