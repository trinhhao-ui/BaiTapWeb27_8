package DAO;

import java.util.List;
import Model.Category;

/**
 * Interface CRUD Category sử dụng JPA.
 * Giữ cùng contract với CategoryDao để dễ so sánh JDBC vs JPA.
 */
public interface CategoryJpaDao {

    /** Thêm danh mục mới - dùng em.persist() */
    void insert(Category category);

    /** Cập nhật danh mục - dùng em.merge() */
    void edit(Category category);

    /** Xóa danh mục theo id - dùng em.remove() */
    void delete(int id);

    /** Lấy 1 danh mục theo id - dùng em.find() */
    Category get(int id);

    /** Lấy 1 danh mục theo tên - dùng JPQL */
    Category get(String name);

    /** Lấy toàn bộ danh mục - dùng JPQL */
    List<Category> getAll();

    /** Tìm kiếm theo từ khóa - dùng JPQL LIKE */
    List<Category> search(String keyword);
}
