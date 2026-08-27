package DAO.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DAO.UserDao;
import Model.User;
import Utils.DBConnection;

/**
 * TẦNG DAO - Implementation
 * Thực thi các câu SQL thao tác với bảng users
 */
public class UserDaoImpl implements UserDao {

    public Connection        conn = null;
    public PreparedStatement ps   = null;
    public ResultSet         rs   = null;

    // ─── GET BY USERNAME ─────────────────────────────────────
    // Dùng cho đăng nhập - lấy user theo username
    @Override
    public User get(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            conn = DBConnection.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs   = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setPassWord(rs.getString("password"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleid(rs.getInt("roleid"));
                user.setPhone(rs.getString("phone"));
                user.setCreatedDate(rs.getDate("createdDate"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── INSERT ──────────────────────────────────────────────
    // Dùng cho đăng ký - thêm user mới vào database
    @Override
    public void insert(User user) {
        String sql = "INSERT INTO users(email, username, fullname, password, "
                   + "avatar, roleid, phone, createdDate) VALUES (?,?,?,?,?,?,?,?)";
        try {
            conn = DBConnection.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt   (6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate  (8, user.getCreatedDate());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ─── CHECK EXIST EMAIL ───────────────────────────────────
    @Override
    public boolean checkExistEmail(String email) {
        boolean duplicate = false;
        String query = "SELECT * FROM users WHERE email = ?";
        try {
            conn = DBConnection.getConnection();
            ps   = conn.prepareStatement(query);
            ps.setString(1, email);
            rs   = ps.executeQuery();
            if (rs.next()) {
                duplicate = true;
            }
            ps.close();
            conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return duplicate;
    }

    // ─── CHECK EXIST USERNAME ────────────────────────────────
    @Override
    public boolean checkExistUsername(String username) {
        boolean duplicate = false;
        String query = "SELECT * FROM users WHERE username = ?";
        try {
            conn = DBConnection.getConnection();
            ps   = conn.prepareStatement(query);
            ps.setString(1, username);
            rs   = ps.executeQuery();
            if (rs.next()) {
                duplicate = true;
            }
            ps.close();
            conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return duplicate;
    }

    // ─── CHECK EXIST PHONE ───────────────────────────────────
    @Override
    public boolean checkExistPhone(String phone) {
        boolean duplicate = false;
        String query = "SELECT * FROM users WHERE phone = ?";
        try {
            conn = DBConnection.getConnection();
            ps   = conn.prepareStatement(query);
            ps.setString(1, phone);
            rs   = ps.executeQuery();
            if (rs.next()) {
                duplicate = true;
            }
            ps.close();
            conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return duplicate;
    }
}
