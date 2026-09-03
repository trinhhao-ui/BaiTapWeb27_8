package Service.impl;

import java.sql.Date;
import java.sql.Timestamp;

import DAO.UserDao;
import DAO.impl.UserDaoImpl;
import Model.User;
import Service.UserService;
import Utils.EmailUtil;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    /** OTP hết hạn sau 5 phút */
    private static final long OTP_VALID_MILLIS = 5 * 60 * 1000L;

    // ── ĐĂNG NHẬP ────────────────────────────────────────────
    @Override
    public User login(String username, String password) {
        User user = userDao.get(username);
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    // ── ĐĂNG KÝ ──────────────────────────────────────────────
    @Override
    public boolean register(String username, String password,
                            String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username)) return false;
        Date date = new Date(System.currentTimeMillis());
        // status = 0: chưa kích hoạt
        User user = new User(email, username, fullname, password, null, 5, phone, date);
        user.setStatus(0);
        userDao.insert(user);
        return true;
    }

    @Override public boolean checkExistEmail(String email)       { return userDao.checkExistEmail(email); }
    @Override public boolean checkExistUsername(String username) { return userDao.checkExistUsername(username); }
    @Override public boolean checkExistPhone(String phone)       { return userDao.checkExistPhone(phone); }
    @Override public void    insert(User user)                   { userDao.insert(user); }

    // ── GỬI OTP KÍCH HOẠT ────────────────────────────────────
    @Override
    public boolean sendActivationOtp(String email) {
        User user = userDao.getByEmail(email);
        if (user == null) return false;
        try {
            String otp    = EmailUtil.generateOtp();
            Timestamp exp = new Timestamp(System.currentTimeMillis() + OTP_VALID_MILLIS);
            userDao.updateOtp(user.getId(), otp, exp);
            EmailUtil.sendActivationOtp(email, otp);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── XÁC MINH OTP KÍCH HOẠT ───────────────────────────────
    @Override
    public boolean verifyActivationOtp(String email, String otp) {
        User user = userDao.getByEmail(email);
        if (user == null || user.getOtp() == null) return false;
        if (!user.getOtp().equals(otp))            return false;
        if (user.getOtpExpiry() == null)           return false;
        if (user.getOtpExpiry().before(new Timestamp(System.currentTimeMillis()))) return false;

        // OTP đúng và còn hạn → kích hoạt tài khoản, xóa OTP
        userDao.updateStatus(user.getId(), 1);
        userDao.updateOtp(user.getId(), null, null);
        return true;
    }

    // ── GỬI OTP RESET MẬT KHẨU ──────────────────────────────
    @Override
    public boolean sendResetPasswordOtp(String email) {
        User user = userDao.getByEmail(email);
        if (user == null) return false;
        try {
            String otp    = EmailUtil.generateOtp();
            Timestamp exp = new Timestamp(System.currentTimeMillis() + OTP_VALID_MILLIS);
            userDao.updateOtp(user.getId(), otp, exp);
            EmailUtil.sendResetPasswordOtp(email, otp);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── XÁC MINH OTP RESET MẬT KHẨU ────────────────────────
    @Override
    public boolean verifyResetPasswordOtp(String email, String otp) {
        User user = userDao.getByEmail(email);
        if (user == null || user.getOtp() == null) return false;
        if (!user.getOtp().equals(otp))            return false;
        if (user.getOtpExpiry() == null)           return false;
        if (user.getOtpExpiry().before(new Timestamp(System.currentTimeMillis()))) return false;
        return true;
    }

    // ── ĐẶT LẠI MẬT KHẨU ────────────────────────────────────
    @Override
    public boolean resetPassword(String email, String newPassword) {
        User user = userDao.getByEmail(email);
        if (user == null) return false;
        userDao.updatePassword(user.getId(), newPassword);
        return true;
    }

    // ── PROFILE (JPA) ─────────────────────────────────────────
    @Override
    public boolean updateProfile(int userId, String fullName, String phone, String avatar) {
        return new DAO.impl.UserJpaDaoImpl().updateProfile(userId, fullName, phone, avatar);
    }
}
