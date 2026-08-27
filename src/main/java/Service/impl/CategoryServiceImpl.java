package Service.impl;

import java.util.List;

import DAO.CategoryDao;
import DAO.impl.CategoryDaoImpl;
import Model.Category;
import Service.CategoryService;

/**
 * TẦNG 3 - SERVICE IMPLEMENTATION
 * Thực hiện logic nghiệp vụ, gọi xuống tầng DAO
 * - DAO chỉ biết SQL, không biết nghiệp vụ
 * - Service xử lý logic trước khi gọi DAO
 * - Controller chỉ gọi Service, không gọi DAO trực tiếp
 */
public class CategoryServiceImpl implements CategoryService {

    // Khởi tạo DAO để gọi xuống tầng dưới
    CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        // Lấy dữ liệu cũ từ DB
        Category oldCategory = categoryDao.get(newCategory.getId());

        // Cập nhật tên mới
        oldCategory.setName(newCategory.getName());

        // Nếu có icon mới thì cập nhật, không thì giữ icon cũ
        if (newCategory.getIcon() != null && !newCategory.getIcon().isEmpty()) {
            oldCategory.setIcon(newCategory.getIcon());
        }

        categoryDao.edit(oldCategory);
    }

    @Override
    public void delete(int id) {
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.search(keyword);
    }
}
