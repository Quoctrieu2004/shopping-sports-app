package data.utils;

import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Utility class để cập nhật password từ plain text sang MD5 hash
 * @author ASUS
 */
public class PasswordUpdater {
    
    /**
     * Cập nhật tất cả password trong database từ plain text sang MD5 hash
     * Chỉ cập nhật những password chưa được mã hóa (không phải 32 ký tự hex)
     */
    public static void updateAllPasswords() {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            System.out.println("Không thể kết nối database!");
            return;
        }
        
        try {
            // Tìm tất cả user có password chưa được mã hóa (không phải 32 ký tự hex)
            String selectSql = "SELECT id, password FROM users WHERE LENGTH(password) != 32 OR password NOT REGEXP '^[a-fA-F0-9]{32}$'";
            PreparedStatement selectStmt = con.prepareStatement(selectSql);
            ResultSet rs = selectStmt.executeQuery();
            
            int updatedCount = 0;
            while (rs.next()) {
                int userId = rs.getInt("id");
                String plainPassword = rs.getString("password");
                
                // Mã hóa password
                String hashedPassword = API.getMd5(plainPassword);
                
                // Cập nhật password đã mã hóa
                String updateSql = "UPDATE users SET password = ? WHERE id = ?";
                PreparedStatement updateStmt = con.prepareStatement(updateSql);
                updateStmt.setString(1, hashedPassword);
                updateStmt.setInt(2, userId);
                
                int result = updateStmt.executeUpdate();
                if (result > 0) {
                    System.out.println("Đã cập nhật password cho user ID " + userId + 
                                     " từ '" + plainPassword + "' sang '" + hashedPassword + "'");
                    updatedCount++;
                }
                
                updateStmt.close();
            }
            
            rs.close();
            selectStmt.close();
            con.close();
            
            System.out.println("Hoàn thành! Đã cập nhật " + updatedCount + " password.");
            
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL khi cập nhật password: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
    
    /**
     * Cập nhật password cho một user cụ thể
     */
    public static void updateUserPassword(int userId, String newPlainPassword) {
        Connection con = MySQLDriver.getConnection();
        if (con == null) {
            System.out.println("Không thể kết nối database!");
            return;
        }
        
        try {
            String hashedPassword = API.getMd5(newPlainPassword);
            String updateSql = "UPDATE users SET password = ? WHERE id = ?";
            PreparedStatement updateStmt = con.prepareStatement(updateSql);
            updateStmt.setString(1, hashedPassword);
            updateStmt.setInt(2, userId);
            
            int result = updateStmt.executeUpdate();
            if (result > 0) {
                System.out.println("Đã cập nhật password cho user ID " + userId + 
                                 " thành '" + hashedPassword + "'");
            } else {
                System.out.println("Không tìm thấy user với ID " + userId);
            }
            
            updateStmt.close();
            con.close();
            
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL khi cập nhật password: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
    
    /**
     * Kiểm tra xem password có được mã hóa chưa
     */
    public static boolean isPasswordHashed(String password) {
        return password != null && password.length() == 32 && password.matches("^[a-fA-F0-9]{32}$");
    }
}
