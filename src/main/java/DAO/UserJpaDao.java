package DAO;

import Model.User;

/**
 * DAO interface cho User sử dụng JPA.
 * Chỉ chứa các thao tác cần JPA (profile update).
 * Các thao tác khác (login, register, OTP) vẫn dùng JDBC qua UserDao.
 */
public interface UserJpaDao {

    /**
     * Cập nhật thông tin profile: fullname, phone, avatar
     * Dùng em.find() + em.merge() - không thay đổi password/email/username
     */
    boolean updateProfile(int userId, String fullName, String phone, String avatar);

    /**
     * Lấy User theo id bằng JPA em.find()
     */
    User findById(int id);
}
