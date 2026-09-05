package Service.impl;

import DAO.ProductDao;
import DAO.impl.ProductDaoImpl;
import Model.Product;
import Service.ProductService;

import java.util.List;

public class ProductServiceImpl implements ProductService {

    private final ProductDao dao = new ProductDaoImpl();

    @Override public List<Product> getAll()                      { return dao.findAll(); }
    @Override public List<Product> getByCategoryId(int cateId)   { return dao.findByCategoryId(cateId); }
    @Override public List<Product> getLatest(int n)              { return dao.findLatest(n); }
    @Override public List<Product> getPage(int page, int size)   { return dao.findPage(page, size); }
    @Override public long          countActive()                  { return dao.countActive(); }
    @Override public Product       getById(int id)               { return dao.findById(id); }
    @Override public void          add(Product product)          { dao.insert(product); }
    @Override public void          update(Product product)       { dao.update(product); }
    @Override public void          delete(int id)                { dao.delete(id); }
}
