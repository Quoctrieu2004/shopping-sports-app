/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt để thay đổi giấy phép này
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java để chỉnh sửa template này
 */
package data.impl;

import data.dao.UserDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;
import java.util.ArrayList;
import model.User;
import data.utils.API;

/**
 *
 * @author ASUS
 */
public class UserImpl implements UserDao {
    
    @Override
    public User findUser(String emailphone, String password ){
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return null;
        }
        
        try {
            String sql;
            if(emailphone.contains("@")) {
                sql = "select * from users where email=?";
            } else {
                sql = "select * from users where phone=?";
            }
            
            System.out.println("SQL Query: " + sql);
            System.out.println("Email/Phone: " + emailphone);
            System.out.println("Password: " + password);
            
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, emailphone);
            ResultSet rs = sttm.executeQuery();
            
            if(rs.next()) {
                String storedPassword = rs.getString("password");
                System.out.println("Stored password: " + storedPassword);
                
                // Kiểm tra mật khẩu có khớp không (văn bản thuần hoặc đã mã hóa)
                boolean passwordMatches = false;
                
                // Đầu tiên thử so sánh trực tiếp (cho mật khẩu văn bản thuần như admin)
                if (password.equals(storedPassword)) {
                    passwordMatches = true;
                    System.out.println("Password matched (plain text)");
                } else {
                    // Sau đó thử so sánh đã mã hóa (cho mật khẩu đã mã hóa)
                    String hashedPassword = API.getMd5(password);
                    if (hashedPassword.equals(storedPassword)) {
                        passwordMatches = true;
                        System.out.println("Password matched (hashed)");
                    }
                }
                
                if (passwordMatches) {
                    System.out.println("User found in database!");
                    User user = new User(rs);
                    rs.close();
                    sttm.close();
                    con.close();
                    return user;
                } else {
                    System.out.println("Password does not match");
                }
            } else {
                System.out.println("No user found with email/phone: " + emailphone);
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("SQL Exception: " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    @Override
    public User findUser(String emailphone) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return null;
        }
        
        try {
            String sql;
            if(emailphone.contains("@")) {
                sql = "select * from users where email=?";
            } else {
                sql = "select * from users where phone=?";
            }
            
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, emailphone);
            ResultSet rs = sttm.executeQuery();
            
            if(rs.next()) {
                User user = new User(rs);
                rs.close();
                sttm.close();
                con.close();
                return user;
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    @Override
    public void insertUser(String name, String email, String phone, String password) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return;
        }
        
        try {
            String sql = "insert into users(name, email, phone, password, role) values(?,?,?,?,?)";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, name);
            sttm.setString(2, email);
            sttm.setString(3, phone);
            sttm.setString(4, password);
            sttm.setString(5, "user");
            
            System.out.println("SQL: " + sql);
            System.out.println("Parameters: name=" + name + ", email=" + email + ", phone=" + phone + ", password=" + password + ", role=user");
            
            sttm.executeUpdate();
            sttm.close();
            con.close();
            System.out.println("User inserted successfully: " + name + ", " + email);
        } catch (SQLException ex) {
            System.out.println("SQL Exception in insertUser: " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public User findUserByEmail(String email) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return null;
        }
        
        try {
            String sql = "select * from users where email=?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, email);
            ResultSet rs = sttm.executeQuery();
            
            if(rs.next()) {
                User user = new User(rs);
                rs.close();
                sttm.close();
                con.close();
                return user;
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    @Override
    public User findUserByPhone(String phone) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return null;
        }
        
        try {
            String sql = "select * from users where phone=?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, phone);
            ResultSet rs = sttm.executeQuery();
            
            if(rs.next()) {
                User user = new User(rs);
                rs.close();
                sttm.close();
                con.close();
                return user;
            }
            rs.close();
            sttm.close();
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    @Override
    public boolean createUser(User user) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return false;
        }
        
        try {
            String sql = "insert into users(name, email, phone, password, role) values(?,?,?,?,?)";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, user.getName());
            sttm.setString(2, user.getEmail());
            sttm.setString(3, user.getPhone());
            sttm.setString(4, user.getPassword());
            sttm.setString(5, user.getRole());
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            System.out.println("User created successfully: " + user.getName() + ", " + user.getEmail());
            return result > 0;
        } catch (SQLException ex) {
            System.out.println("SQL Exception in createUser: " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    @Override
    public boolean updatePassword(int userId, String newPassword) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return false;
        }
        
        try {
            String sql = "UPDATE users SET password = ? WHERE id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, newPassword);
            sttm.setInt(2, userId);
            
            System.out.println("SQL: " + sql);
            System.out.println("Parameters: userId=" + userId + ", newPassword=" + newPassword);
            
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            
            if (result > 0) {
                System.out.println("Password updated successfully for user ID: " + userId);
                return true;
            } else {
                System.out.println("No user found with ID: " + userId);
                return false;
            }
            
        } catch (SQLException ex) {
            System.out.println("SQL Exception in updatePassword: " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    @Override
    public List<User> getAllUsers() {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return null;
        }
        
        List<User> users = new ArrayList<>();
        
        try {
            // Truy vấn SQL để lấy tất cả người dùng, sắp xếp theo ID
            String sql = "SELECT * FROM users ORDER BY id";
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            
            // Duyệt qua kết quả và tạo danh sách User
            while (rs.next()) {
                User user = new User(rs);
                users.add(user);
            }
            
            rs.close();
            sttm.close();
            con.close();
            
            System.out.println("Loaded " + users.size() + " users from database");
            return users;
            
        } catch (SQLException ex) {
            System.out.println("SQL Exception in getAllUsers: " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    @Override
    public boolean updateUser(User user) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return false;
        }
        
        try {
            // Truy vấn SQL để cập nhật thông tin người dùng
            String sql = "UPDATE users SET name = ?, email = ?, phone = ?, role = ? WHERE id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, user.getName());
            sttm.setString(2, user.getEmail());
            sttm.setString(3, user.getPhone());
            sttm.setString(4, user.getRole());
            sttm.setInt(5, user.getId());
            
            System.out.println("SQL: " + sql);
            System.out.println("Parameters: name=" + user.getName() + ", email=" + user.getEmail() + 
                             ", phone=" + user.getPhone() + ", role=" + user.getRole() + ", id=" + user.getId());
            
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            
            if (result > 0) {
                System.out.println("User updated successfully: " + user.getName());
                return true;
            } else {
                System.out.println("No user found with ID: " + user.getId());
                return false;
            }
            
        } catch (SQLException ex) {
            System.out.println("SQL Exception in updateUser: " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    @Override
    public boolean deleteUser(int userId) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Database connection is null");
            return false;
        }
        
        try {
            // Truy vấn SQL để xóa người dùng theo ID
            String sql = "DELETE FROM users WHERE id = ?";
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, userId);
            
            System.out.println("SQL: " + sql);
            System.out.println("Parameters: userId=" + userId);
            
            int result = sttm.executeUpdate();
            sttm.close();
            con.close();
            
            if (result > 0) {
                System.out.println("User deleted successfully with ID: " + userId);
                return true;
            } else {
                System.out.println("No user found with ID: " + userId);
                return false;
            }
            
        } catch (SQLException ex) {
            System.out.println("SQL Exception in deleteUser: " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
