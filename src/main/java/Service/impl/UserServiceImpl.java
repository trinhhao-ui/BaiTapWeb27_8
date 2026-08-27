package Service.impl;

import java.sql.Date;

import DAO.UserDao;
import DAO.impl.UserDaoImpl;
import Model.User;
import Service.UserService;

/**
 * TẦNG SERVICE - Implementation
 * Xử lý logic nghiệp vụ, gọi xuống tầng DAO
 */
public class UserServiceImpl implements UserService {

    UserDao userDao = new UserDaoImpl();

    // ─────────────────────────────────────────────────────────
    //  ĐĂNG NHẬP - Bước 4 slide login
    //  1. Lấy user theo username từ DAO
    //  2. Kiểm tra password có khớp không
    //  3. Trả về User nếu đúng, null nếu sai
    // ─────────────────────────────────────────────────────────
    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    // ─────────────────────────────────────────────────────────
    //  ĐĂNG KÝ - Bước 4 slide register
    //  1. Kiểm tra username đã tồn tại chưa
    //  2. Tạo object User với roleid=5 (user thường)
    //  3. Gọi DAO insert vào DB
    // ─────────────────────────────────────────────────────────
    @Override
    public boolean register(String username, String password,
                            String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username)) {
            return false;
        }
        // Lấy thời gian hiện tại làm ngày tạo
        long millis = System.currentTimeMillis();
        Date date   = new Date(millis);

        // roleid = 5 là user thường (theo slide)
        userDao.insert(new User(email, username, fullname,
                                password, null, 5, phone, date));
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }
}
