package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.utils.PasswordUpdater;

/**
 * Servlet để cập nhật password từ plain text sang MD5 hash
 * Chỉ dùng để chạy một lần để cập nhật database cũ
 * @author ASUS
 */
public class PasswordUpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Chạy cập nhật password
            PasswordUpdater.updateAllPasswords();
            
            // Hiển thị kết quả
            response.getWriter().println("<!DOCTYPE html>");
            response.getWriter().println("<html>");
            response.getWriter().println("<head>");
            response.getWriter().println("<title>Password Update Complete</title>");
            response.getWriter().println("<meta charset='UTF-8'>");
            response.getWriter().println("</head>");
            response.getWriter().println("<body>");
            response.getWriter().println("<h1>Password Update Complete!</h1>");
            response.getWriter().println("<p>All passwords have been updated from plain text to MD5 hash.</p>");
            response.getWriter().println("<p><a href='home'>Go to Home</a></p>");
            response.getWriter().println("</body>");
            response.getWriter().println("</html>");
            
        } catch (Exception e) {
            response.getWriter().println("<!DOCTYPE html>");
            response.getWriter().println("<html>");
            response.getWriter().println("<head>");
            response.getWriter().println("<title>Password Update Error</title>");
            response.getWriter().println("<meta charset='UTF-8'>");
            response.getWriter().println("</head>");
            response.getWriter().println("<body>");
            response.getWriter().println("<h1>Password Update Error!</h1>");
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
            response.getWriter().println("<p><a href='home'>Go to Home</a></p>");
            response.getWriter().println("</body>");
            response.getWriter().println("</html>");
            
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
