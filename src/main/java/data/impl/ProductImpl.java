package data.impl;

import data.dao.ProductDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductImpl implements ProductDao {
    @Override
    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return list;
        }
        try {
            // Truy vấn SQL để lấy tất cả sản phẩm, sắp xếp theo ID giảm dần
            String sql = "select * from products order by id desc";
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            
            // Duyệt qua kết quả và tạo danh sách Product
            while(rs.next()) {
                Product product = new Product(rs);
                list.add(product);
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong findAll: " + ex.getMessage());
        }
        return list;
    }
    
    public List<Product> findAllWithCategoryName() {
        List<Product> list = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return list;
        }   // chuẩn bị statement từ connection với SQL trên, thực thi truy vấn, nhận kết quả vào ResultSet.
            //map một dòng RS → đối tượng Product
        try {
            // Truy vấn SQL để lấy sản phẩm kèm tên danh mục (JOIN với bảng categories)
            String sql = "SELECT p.*, c.name as category_name FROM products p " +
                        "LEFT JOIN categories c ON p.id_category = c.id " +
                        "ORDER BY p.id DESC";
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while(rs.next()) {
                Product product = new Product(rs);
                // Đặt tên danh mục nếu có sẵn
                try {
                    String categoryName = rs.getString("category_name");        // đọc thêm cột category_name từ RS gán vào
                    if (categoryName != null) {
                        product.setCategoryName(categoryName);
                    } else {
                        product.setCategoryName("Danh mục không xác định");
                    }
                } catch (Exception e) {
                    product.setCategoryName("Danh mục không xác định");
                }
                list.add(product);  
            } // thêm vào ds trả về
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong findAllWithCategoryName: " + ex.getMessage());
        }
        return list;
    }
    
    @Override
    public List<Product> findByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return list;
        }
        
        try {
            // Truy vấn SQL để lấy sản phẩm theo danh mục
            String sql = "select * from products where id_category = ? order by id desc";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, categoryId);
            ResultSet rs = sttm.executeQuery();
            
            while(rs.next()) {
                Product product = new Product(rs);
                list.add(product);
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong findByCategory: " + ex.getMessage());
        }
        return list;
    }
    
    @Override
    public Product findProduct(int id_product) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return null;
        }
        
        try {
            // Truy vấn SQL để tìm sản phẩm theo ID
            String sql = "select * from products where id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, id_product);
            ResultSet rs = sttm.executeQuery();
            
            if(rs.next()) {
                Product product = new Product(rs);
                rs.close();
                sttm.close();
                con.close();
                return product;
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong findProduct: " + ex.getMessage());
        }
        return null;
    }
    //nhận tham số keyword và thực hiện logic tìm kiếm        ts truyền vào từ bước 2

    
    @Override
    public List<Product> searchByName(String keyword) {
        List<Product> list = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return list;
        } //Pre giúp gán tham số an toàn, chống SQL injection
        try {  // tạo ds rong để lưu kết quả tìm kiếm
            // Truy vấn SQL để tìm kiếm sản phẩm theo tên (sử dụng LIKE với logic chính xác hơn)
            String sql = "SELECT * FROM products WHERE LOWER(name) LIKE LOWER(?) ORDER BY id DESC";
            PreparedStatement sttm = con.prepareStatement(sql);
            // Tìm kiếm chính xác hơn: từ khóa phải xuất hiện ở đầu hoặc giữa tên sản phẩm
            String searchPattern = "%" + keyword.trim() + "%";
            sttm.setString(1, searchPattern);   
            //Gán từ khóa tìm kiếm vào tham số vào dấu ? trong SQL
            System.out.println("Tìm kiếm với từ khóa: '" + keyword + "'");
            System.out.println("Pattern tìm kiếm: '" + searchPattern + "'");
            ResultSet rs = sttm.executeQuery();
            while(rs.next()) {
                Product product = new Product(rs);
                list.add(product);
            } //executeQ chạy SELECT và trả về bảng kết quả ResultSet
            System.out.println("Tìm thấy " + list.size() + " sản phẩm cho từ khóa: '" + keyword + "'");
            rs.close(); 
            sttm.close();
            con.close(); // đóng kết nối
            // Lọc kết quả để chính xác hơn
            list = filterSearchResults(list, keyword.trim());
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong searchByName: " + ex.getMessage());
        }
        return list;
    }
    
    /**
     * Lọc kết quả tìm kiếm để chính xác hơn
     */
    private List<Product> filterSearchResults(List<Product> products, String keyword) {
        if (products.isEmpty() || keyword.isEmpty()) {
            return products;
        }
        
        List<Product> filteredList = new ArrayList<>();
        String lowerKeyword = keyword.toLowerCase();
        
        for (Product product : products) {
            String productName = product.getName().toLowerCase();
            
            // Kiểm tra xem tên sản phẩm có chứa từ khóa chính xác không
            if (productName.contains(lowerKeyword)) {
                // Ưu tiên sản phẩm có từ khóa ở đầu tên
                if (productName.startsWith(lowerKeyword)) {
                    filteredList.add(0, product); // Thêm vào đầu danh sách
                } else {
                    filteredList.add(product); // Thêm vào cuối danh sách
                }
            }
        }
        
        System.out.println("Sau khi lọc: " + filteredList.size() + " sản phẩm chính xác");
        return filteredList;
    }
    
    @Override
    public boolean addProduct(Product product) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return false;
        }
        // cbi câu lệnh SQL tránh thực thi, trả về số dòng bị ảnh hưởng (>=1 là thành công) , trả về boolean cho Controller.
        try {
            // Truy vấn SQL để thêm sản phẩm mới
            String sql   = "INSERT INTO products (id_category, name, image, price, quantity, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement sttm = con.prepareStatement(sql);     
            sttm.setInt(1, product.getId_category());   // gán gt vào tham số thứ 1 id_category từ product.
            sttm.setString(2, product.getName());
            sttm.setString(3, product.getImage());
            sttm.setDouble(4, product.getPrice());
            sttm.setInt(5, product.getQuantity());
            sttm.setBoolean(6, product.isStatus());
            int result = sttm.executeUpdate(); 
            sttm.close();
            con.close(); // execeU phụ thuộc vào insert hoặc Upd, Del
            return result > 0;
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong addProduct: " + ex.getMessage());
            return false;
        }
    }
    @Override
    public boolean updateProduct(Product product) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return false;
        }
        try {
            // Dùng WHERE id = ? để đảm bảo chỉ update đúng sản phẩm theo productId
            String sql = "UPDATE products SET id_category = ?, name = ?, image = ?, price = ?, quantity = ?, status = ? WHERE id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, product.getId_category()); // gán gt vào tham số thứ 1 id_category từ product.
            sttm.setString(2, product.getName());
            sttm.setString(3, product.getImage());
            sttm.setDouble(4, product.getPrice());
            sttm.setInt(5, product.getQuantity());
            sttm.setBoolean(6, product.isStatus());
            sttm.setInt(7, product.getId());
            int result = sttm.executeUpdate();
            sttm.close();
            con.close(); // Thực thi câu lệnh insert executeUP trả về số dòng bị ảnh hưởng Nếu thêm thành công thì rs ≥ 1
            return result > 0; //// execeU phụ thuộc vào insert hoặc Upd, Del
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong updateProduct: " + ex.getMessage());
            return false;
        }
    }
    @Override
    public boolean deleteProduct(int productId) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            return false;
           //  gán giá trị productId vào dấu ? tham số thứ nhất 
        } //tạo PreparedStatement để chạy SQL an toàn   
        try {
            // Truy vấn SQL để xóa sản phẩm theo ID
            String sql = "DELETE FROM products WHERE id = ?";
            PreparedStatement sttm = con.prepareStatement(sql); 
            sttm.setInt(1, productId);
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            return result > 0;//// execeU phụ thuộc vào insert hoặc Upd, Del
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL trong deleteProduct: " + ex.getMessage());
            return false;
        } // nếu có ít nhất 1 dòng bị xóa thì trả về true ngược lại là false
    }
}// thực thi lệnh Dele trả về số dòng bị ảnh hưởng
