package data.dao;

import java.util.List;
import model.Category;

public interface CategoryDao {
    public List<Category> findAll();
    public Category findCategory(int id);
    public boolean addCategory(Category category);
    public boolean updateCategory(Category category);
    public boolean deleteCategory(int categoryId);
}
