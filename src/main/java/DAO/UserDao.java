package DAO;

import Model.User;

public interface UserDao {

    User    get(String username);
    User    getByEmail(String email);       // thêm mới - dùng cho quên mật khẩu
    void    insert(User user);
    void    updateStatus(int userId, int status);   // kích hoạt / khóa tài khoản
    void    updateOtp(int userId, String otp, java.sql.Timestamp expiry); // lưu OTP
    void    updatePassword(int userId, String newPassword);              // đặt lại mật khẩu

    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
}
