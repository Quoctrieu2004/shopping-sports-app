package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.dao.Database;
import data.utils.API;
import model.User;

/**
 * Servlet để xử lý chức năng quên mật khẩu
 * @author ASUS
 */
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Hiển thị form quên mật khẩu
        request.setAttribute("title", "Forgot Password");
        request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        System.out.println("=== ForgotPasswordServlet.doPost() ===");
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);
        
        // Kiểm tra user có tồn tại không
        User user = null;
        if (email != null && !email.trim().isEmpty()) {
            user = Database.getUserDao().findUser(email);
        } else if (phone != null && !phone.trim().isEmpty()) {
            user = Database.getUserDao().findUser(phone);
        }
        
        if (user == null) {
            request.getSession().setAttribute("error_forgot", "User not found with provided email/phone!");
            response.sendRedirect("forgot-password");
            return;
        }
        
        // Kiểm tra password mới
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.getSession().setAttribute("error_forgot", "New password is required!");
            response.sendRedirect("forgot-password");
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.getSession().setAttribute("error_forgot", "Passwords do not match!");
            response.sendRedirect("forgot-password");
            return;
        }
        
        // Cập nhật password mới
        try {
            String hashedNewPassword = API.getMd5(newPassword);
            System.out.println("Updating password for user: " + user.getName());
            System.out.println("New password hash: " + hashedNewPassword);
            
            // Cập nhật password trong database
            Database.getUserDao().updatePassword(user.getId(), hashedNewPassword);
            
            request.getSession().setAttribute("success_forgot", "Password updated successfully! You can now login with your new password.");
            response.sendRedirect("login");
            
        } catch (Exception e) {
            System.out.println("Error updating password: " + e.getMessage());
            request.getSession().setAttribute("error_forgot", "Error updating password: " + e.getMessage());
            response.sendRedirect("forgot-password");
        }
    }
}
