package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.utils.API;

/**
 * Servlet để tìm password gốc từ hash MD5
 * @author ASUS
 */
public class PasswordReverseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Hash cần tìm
            String targetHash = "79a05176048cfa33e7fd67ac2bc463fb";
            
            response.getWriter().println("<!DOCTYPE html>");
            response.getWriter().println("<html>");
            response.getWriter().println("<head>");
            response.getWriter().println("<title>Password Reverse Lookup</title>");
            response.getWriter().println("<meta charset='UTF-8'>");
            response.getWriter().println("</head>");
            response.getWriter().println("<body>");
            response.getWriter().println("<h1>Password Reverse Lookup</h1>");
            response.getWriter().println("<p><strong>Target Hash:</strong> " + targetHash + "</p>");
            
            // Test một số password phổ biến
            String[] commonPasswords = {
                "123", "1234", "12345", "123456", "password", "admin", "user", "test",
                "abc123", "qwerty", "letmein", "welcome", "login", "pass", "secret",
                "Trieu2004", "Tai123", "quoctrieu", "tanphat", "admin123", "user123"
            };
            
            response.getWriter().println("<h2>Testing Common Passwords:</h2>");
            response.getWriter().println("<table border='1' style='border-collapse: collapse; width: 100%;'>");
            response.getWriter().println("<tr><th>Password</th><th>MD5 Hash</th><th>Match?</th></tr>");
            
            boolean found = false;
            for (String password : commonPasswords) {
                String hash = API.getMd5(password);
                boolean isMatch = hash.equals(targetHash);
                if (isMatch) {
                    found = true;
                }
                
                String rowStyle = isMatch ? "background-color: #90EE90;" : "";
                response.getWriter().println("<tr style='" + rowStyle + "'>");
                response.getWriter().println("<td>" + password + "</td>");
                response.getWriter().println("<td>" + hash + "</td>");
                response.getWriter().println("<td>" + (isMatch ? "✅ MATCH!" : "❌") + "</td>");
                response.getWriter().println("</tr>");
            }
            
            response.getWriter().println("</table>");
            
            if (found) {
                response.getWriter().println("<h2 style='color: green;'>✅ Password Found!</h2>");
            } else {
                response.getWriter().println("<h2 style='color: red;'>❌ Password Not Found in Common List</h2>");
            }
            
            response.getWriter().println("<br>");
            response.getWriter().println("<p><a href='home'>Go to Home</a></p>");
            response.getWriter().println("</body>");
            response.getWriter().println("</html>");
            
        } catch (Exception e) {
            response.getWriter().println("<!DOCTYPE html>");
            response.getWriter().println("<html>");
            response.getWriter().println("<head>");
            response.getWriter().println("<title>Error</title>");
            response.getWriter().println("<meta charset='UTF-8'>");
            response.getWriter().println("</head>");
            response.getWriter().println("<body>");
            response.getWriter().println("<h1>Error!</h1>");
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


