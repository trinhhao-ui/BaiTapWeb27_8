package Service;

import Model.Product;
import java.util.List;

public interface ProductService {
    List<Product> getAll();
    List<Product> getByCategoryId(int cateId);
    List<Product> getLatest(int n);
    List<Product> getPage(int page, int size);
    long          countActive();
    Product       getById(int id);
    void          add(Product product);
    void          update(Product product);
    void          delete(int id);
}
