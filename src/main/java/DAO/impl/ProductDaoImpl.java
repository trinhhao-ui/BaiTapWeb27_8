package DAO.impl;

import DAO.ProductDao;
import Model.Product;
import Utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class ProductDaoImpl implements ProductDao {

    // ── Lấy tất cả sản phẩm ─────────────────────────────────
    @Override
    public List<Product> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Product p JOIN FETCH p.category ORDER BY p.id DESC",
                Product.class
            ).getResultList();
        } finally {
            em.close();
        }
    }

    // ── Lọc theo danh mục ────────────────────────────────────
    @Override
    public List<Product> findByCategoryId(int cateId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Product p JOIN FETCH p.category c WHERE c.id = :cateId ORDER BY p.id DESC",
                Product.class
            ).setParameter("cateId", cateId).getResultList();
        } finally {
            em.close();
        }
    }

    // ── Lấy n sản phẩm mới nhất ──────────────────────────────
    @Override
    public List<Product> findLatest(int n) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Product p JOIN FETCH p.category WHERE p.status = 1 ORDER BY p.createdDate DESC, p.id DESC",
                Product.class
            ).setMaxResults(n).getResultList();
        } finally {
            em.close();
        }
    }

    // ── Phân trang ───────────────────────────────────────────
    @Override
    public List<Product> findPage(int page, int size) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Product p JOIN FETCH p.category WHERE p.status = 1 ORDER BY p.createdDate DESC, p.id DESC",
                Product.class
            ).setFirstResult((page - 1) * size)
             .setMaxResults(size)
             .getResultList();
        } finally {
            em.close();
        }
    }

    // ── Đếm sản phẩm đang hiển thị ───────────────────────────
    @Override
    public long countActive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(p) FROM Product p WHERE p.status = 1",
                Long.class
            ).getSingleResult();
        } finally {
            em.close();
        }
    }
    @Override
    public Product findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    // ── Thêm mới ─────────────────────────────────────────────
    @Override
    public void insert(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(product);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ── Cập nhật ─────────────────────────────────────────────
    @Override
    public void update(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(product);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ── Xóa ──────────────────────────────────────────────────
    @Override
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Product p = em.find(Product.class, id);
            if (p != null) em.remove(p);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
