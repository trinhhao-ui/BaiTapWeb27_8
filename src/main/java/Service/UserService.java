package Service;

import Model.User;

public interface UserService {

    User    login(String username, String password);
    User    get(String username);
    void    insert(User user);
    boolean register(String username, String password,
                     String email, String fullname, String phone);

    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);

    // ── OTP & Kích hoạt tài khoản ───────────────────────────
    /** Tạo OTP, lưu DB, gửi email kích hoạt. Trả về false nếu gửi thất bại. */
    boolean sendActivationOtp(String email);

    /** Xác minh OTP kích hoạt. Trả về true nếu đúng & chưa hết hạn → kích hoạt tài khoản. */
    boolean verifyActivationOtp(String email, String otp);

    // ── Quên mật khẩu ───────────────────────────────────────
    /** Tạo OTP, lưu DB, gửi email reset password. Trả về false nếu email không tồn tại. */
    boolean sendResetPasswordOtp(String email);

    /** Xác minh OTP reset password. Trả về true nếu đúng & chưa hết hạn. */
    boolean verifyResetPasswordOtp(String email, String otp);

    /** Đặt lại mật khẩu mới sau khi OTP đã xác minh. */
    boolean resetPassword(String email, String newPassword);

    // ── Profile ──────────────────────────────────────────────
    /** Cập nhật fullname, phone, avatar bằng JPA */
    boolean updateProfile(int userId, String fullName, String phone, String avatar);
}
