/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.dao.Database;
import data.utils.API;
import model.User;
/**
 *
 * @author ASUS
 */
public class LoginServlet extends HttpServlet {

    

       
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Login Page");
        request.getRequestDispatcher("./views/login.jsp").forward(request, response);

        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String emailphone = request.getParameter("emailphone");
        String password = request.getParameter("password");
        
        // Không mã hóa password vì trong database đang lưu plain text
        // String hashedPassword = API.getMd5(password);
   
        System.out.println("Login attempt - Email/Phone: " + emailphone);
        System.out.println("Login attempt - Password: " + password);
        
        User user = Database.getUserDao().findUser(emailphone, password);
        
        System.out.println("User found: " + (user != null));
        if (user != null) {
            System.out.println("User role: " + user.getRole());
        }
        
        if(user==null){
            request.getSession().setAttribute("error_login", "Your information is incorrect!");
            response.sendRedirect("login");
        } else {
            if(user.getRole().equals("admin")) {
                request.getSession().setAttribute("user", user);
                request.getSession().removeAttribute("error_login");
                response.sendRedirect("admin");
            } else {
                request.getSession().setAttribute("user", user);
                request.getSession().removeAttribute("error_login");
                
               
                String splitname = API.getName(user.getName());
                request.getSession().setAttribute("splitname", splitname);
                
                response.sendRedirect("home");
            }
        }
    }


}
