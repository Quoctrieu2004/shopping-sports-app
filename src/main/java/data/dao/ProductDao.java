package data.dao;

import java.util.List;
import model.Product;
// interface chỉ bao gồm các hàm còn phần thực hiện hàm nằm ở bên Impl
public interface ProductDao {
    public List<Product> findAll();
    public List<Product> findAllWithCategoryName();
    public List<Product> findByCategory(int categoryId);
    public Product findProduct(int id_product);
    // Search
    public List<Product> searchByName(String keyword);
    public boolean addProduct(Product product);
    public boolean updateProduct(Product product);
    public boolean deleteProduct(int productId);
}
