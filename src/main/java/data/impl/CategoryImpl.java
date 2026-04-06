package data.impl;

import data.dao.CategoryDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryImpl implements CategoryDao {
    
    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return list;
        }
        
        try {
            // Truy vấn SQL để lấy tất cả danh mục
            String sql = "select * from categories";
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            
            // Duyệt qua kết quả và tạo danh sách Category
            while(rs.next()) {
                Category category = new Category(rs);
                list.add(category);
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("SQL Exception in findAll: " + ex.getMessage());
        }
        return list;
    }
    
    @Override
    public Category findCategory(int id) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return null;
        }
        
        try {
            // Truy vấn SQL để tìm danh mục theo ID
            String sql = "select * from categories where id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, id);
            ResultSet rs = sttm.executeQuery();
            
            if(rs.next()) {
                Category category = new Category(rs);
                rs.close();
                sttm.close();
                con.close();
                return category;
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("SQL Exception in findCategory: " + ex.getMessage());
        }
        return null;
    }
    
    @Override
    public boolean addCategory(Category category) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return false;
        }
        
        try {
            // Truy vấn SQL để thêm danh mục mới
            String sql = "INSERT INTO categories (name) VALUES (?)";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, category.getName());
            
            System.out.println("SQL: " + sql);
            System.out.println("Parameters: name=" + category.getName());
            
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            
            if (result > 0) {
                System.out.println("Category added successfully: " + category.getName());
                return true;
            } else {
                System.out.println("Failed to add category");
                return false;
            }
            
        } catch (SQLException ex) {
            System.out.println("SQL Exception in addCategory: " + ex.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean updateCategory(Category category) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return false;
        }
        try {
            String sql = "UPDATE categories SET name = ? WHERE id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, category.getName());
            sttm.setInt(2, category.getId());
            
            System.out.println("SQL: " + sql);
            System.out.println("Parameters: name=" + category.getName() + ", id=" + category.getId());
            
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            
            if (result > 0) {
                System.out.println("Category updated successfully: " + category.getName());
                return true;
            } else {
                System.out.println("No category found with ID: " + category.getId());
                return false;
            }
            
        } catch (SQLException ex) {
            System.out.println("SQL Exception in updateCategory: " + ex.getMessage());
            return false;
        }
    }
    @Override
    public boolean deleteCategory(int categoryId) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return false;
        }
        try {
            String sql = "DELETE FROM categories WHERE id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, categoryId);
            
            System.out.println("SQL: " + sql);
            System.out.println("Parameters: categoryId=" + categoryId);
            
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            
            if (result > 0) {
                System.out.println("Category deleted successfully with ID: " + categoryId);
                return true;
            } else {
                System.out.println("No category found with ID: " + categoryId);
                return false;
            }
            
        } catch (SQLException ex) {
            System.out.println("SQL Exception in deleteCategory: " + ex.getMessage());
            return false;
        }
    }
}
