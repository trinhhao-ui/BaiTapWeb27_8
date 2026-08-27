package DAO;

import java.util.List;
import Model.Category;

/**
 * TẦNG 2 - DAO INTERFACE
 * Định nghĩa các thao tác CRUD với database
 * Các class impl sẽ implement interface này
 */
public interface CategoryDao {

    // Thêm danh mục mới
    void insert(Category category);

    // Cập nhật danh mục
    void edit(Category category);

    // Xóa danh mục theo id
    void delete(int id);

    // Lấy 1 danh mục theo id
    Category get(int id);

    // Lấy 1 danh mục theo tên
    Category get(String name);

    // Lấy toàn bộ danh mục
    List<Category> getAll();

    // Tìm kiếm theo từ khóa
    List<Category> search(String keyword);
}
