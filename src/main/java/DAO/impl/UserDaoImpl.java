package DAO.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import DAO.UserDao;
import Model.User;
import Utils.DBConnection;

public class UserDaoImpl implements UserDao {

    // ─── GET BY USERNAME ─────────────────────────────────────
    @Override
    public User get(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ─── GET BY EMAIL ────────────────────────────────────────
    @Override
    public User getByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ─── INSERT ──────────────────────────────────────────────
    @Override
    public void insert(User user) {
        String sql = "INSERT INTO users(email, username, fullname, password, "
                   + "avatar, roleid, phone, createdDate, status) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt   (6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate  (8, user.getCreatedDate());
            ps.setInt   (9, user.getStatus()); // 0 = chưa kích hoạt
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ─── UPDATE STATUS ───────────────────────────────────────
    @Override
    public void updateStatus(int userId, int status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ─── UPDATE OTP ──────────────────────────────────────────
    @Override
    public void updateOtp(int userId, String otp, Timestamp expiry) {
        String sql = "UPDATE users SET otp = ?, otp_expiry = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString   (1, otp);
            ps.setTimestamp(2, expiry);
            ps.setInt      (3, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ─── UPDATE PASSWORD ─────────────────────────────────────
    @Override
    public void updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ?, otp = NULL, otp_expiry = NULL WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt   (2, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ─── CHECK EXIST ─────────────────────────────────────────
    @Override
    public boolean checkExistEmail(String email) {
        return checkExist("SELECT 1 FROM users WHERE email = ?", email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return checkExist("SELECT 1 FROM users WHERE username = ?", username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return checkExist("SELECT 1 FROM users WHERE phone = ?", phone);
    }

    // ─── HELPER ──────────────────────────────────────────────
    private boolean checkExist(String sql, String value) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, value);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    /** Map một hàng ResultSet thành User object */
    private User mapRow(ResultSet rs) throws Exception {
        User user = new User();
        user.setId         (rs.getInt      ("id"));
        user.setEmail      (rs.getString   ("email"));
        user.setUserName   (rs.getString   ("username"));
        user.setFullName   (rs.getString   ("fullname"));
        user.setPassWord   (rs.getString   ("password"));
        user.setAvatar     (rs.getString   ("avatar"));
        user.setRoleid     (rs.getInt      ("roleid"));
        user.setPhone      (rs.getString   ("phone"));
        user.setCreatedDate(rs.getDate     ("createdDate"));
        user.setStatus     (rs.getInt      ("status"));
        user.setOtp        (rs.getString   ("otp"));
        user.setOtpExpiry  (rs.getTimestamp("otp_expiry"));
        return user;
    }
}
