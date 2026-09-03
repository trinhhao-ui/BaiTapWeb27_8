package DAO.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import DAO.UserJpaDao;
import Model.User;
import Utils.JPAUtil;

/**
 * Implement UserJpaDao dùng JPA (Hibernate 6 + Jakarta Persistence 3.1)
 *
 * updateProfile:
 *   1. em.find(User.class, userId)  -> load entity từ DB
 *   2. Cập nhật các field cần thiết (fullName, phone, avatar)
 *   3. em.merge(user)               -> Hibernate sinh UPDATE SQL
 *   4. Commit transaction
 */
public class UserJpaDaoImpl implements UserJpaDao {

    // ── UPDATE PROFILE ───────────────────────────────────────
    @Override
    public boolean updateProfile(int userId, String fullName, String phone, String avatar) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();

            User user = em.find(User.class, userId);
            if (user == null) {
                et.rollback();
                return false;
            }

            // Chỉ cập nhật 3 field được phép - không đụng password/email/username
            user.setFullName(fullName);
            user.setPhone(phone);
            if (avatar != null && !avatar.isEmpty()) {
                user.setAvatar(avatar);
            }

            em.merge(user);
            et.commit();
            return true;

        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // ── FIND BY ID ───────────────────────────────────────────
    @Override
    public User findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }
}
