package DAO;

import Model.Product;
import java.util.List;

public interface ProductDao {
    List<Product> findAll();
    List<Product> findByCategoryId(int cateId);
    List<Product> findLatest(int n);
    List<Product> findPage(int page, int size);
    long          countActive();
    Product       findById(int id);
    void          insert(Product product);
    void          update(Product product);
    void          delete(int id);
}
