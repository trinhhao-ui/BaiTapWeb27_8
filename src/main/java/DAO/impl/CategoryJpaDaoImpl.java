package DAO.impl;

import java.util.Collections;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import DAO.CategoryJpaDao;
import Model.Category;
import Utils.JPAUtil;

/**
 * CRUD Category sử dụng JPA (Hibernate 6 + Jakarta Persistence 3.1)
 *
 * Pattern chung cho mỗi thao tác ghi (insert/edit/delete):
 *   1. Lấy EntityManager từ JPAUtil
 *   2. Bắt đầu transaction (et.begin())
 *   3. Thực hiện thao tác
 *   4. Commit (et.commit()) hoặc rollback nếu có lỗi
 *   5. Đóng EntityManager trong finally
 *
 * Thao tác đọc (get/getAll/search) không cần transaction.
 */
public class CategoryJpaDaoImpl implements CategoryJpaDao {

    // ─── INSERT ──────────────────────────────────────────────────────────────
    @Override
    public void insert(Category category) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            em.persist(category);   // INSERT INTO Category ...
            et.commit();
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ─── EDIT (UPDATE) ───────────────────────────────────────────────────────
    @Override
    public void edit(Category category) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            em.merge(category);     // UPDATE Category SET ... WHERE cate_id = ?
            et.commit();
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ─── DELETE ──────────────────────────────────────────────────────────────
    @Override
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            Category category = em.find(Category.class, id);
            if (category != null) {
                em.remove(category);    // DELETE FROM Category WHERE cate_id = ?
            }
            et.commit();
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ─── GET BY ID ───────────────────────────────────────────────────────────
    @Override
    public Category get(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // em.find() trả về null nếu không tìm thấy (an toàn hơn getReference)
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

    // ─── GET BY NAME ─────────────────────────────────────────────────────────
    @Override
    public Category get(String name) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // JPQL dùng tên field Java (name), không phải tên cột SQL (cate_name)
            TypedQuery<Category> query = em.createQuery(
                "SELECT c FROM Category c WHERE c.name = :name", Category.class);
            query.setParameter("name", name);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;    // không tìm thấy -> trả null thay vì throw exception
        } finally {
            em.close();
        }
    }

    // ─── GET ALL ─────────────────────────────────────────────────────────────
    @Override
    public List<Category> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery(
                "SELECT c FROM Category c ORDER BY c.id", Category.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    // ─── SEARCH ──────────────────────────────────────────────────────────────
    @Override
    public List<Category> search(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery(
                "SELECT c FROM Category c WHERE c.name LIKE :keyword ORDER BY c.id",
                Category.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }
}
