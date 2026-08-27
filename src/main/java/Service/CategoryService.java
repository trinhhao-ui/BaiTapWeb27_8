package Service;

import java.util.List;
import Model.Category;

/**
 * TẦNG 3 - SERVICE INTERFACE
 * Định nghĩa các nghiệp vụ liên quan đến Category
 * Tách biệt logic nghiệp vụ khỏi tầng DAO
 */
public interface CategoryService {

    void insert(Category category);

    void edit(Category category);

    void delete(int id);

    Category get(int id);

    Category get(String name);

    List<Category> getAll();

    List<Category> search(String keyword);
}
