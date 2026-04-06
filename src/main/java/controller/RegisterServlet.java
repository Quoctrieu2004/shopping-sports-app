/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.dao.Database;
import data.dao.UserDao;
import data.utils.API;
import model.User;
import java.util.regex.Pattern;

/**
 *
 * @author ASUS
 */
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xóa các session attributes khi load trang register
        request.getSession().removeAttribute("err_email");
        request.getSession().removeAttribute("err_phone");
        request.getSession().removeAttribute("err_repassword");
        request.getSession().removeAttribute("exist_user");
        request.getSession().removeAttribute("error_register");
        request.getSession().removeAttribute("success_register");
        
        // Forward đến trang register.jsp
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String err_email="", err_phone="", err_repassword="";
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        // Khớp với name="repassword" trong _register.jsp
        String repassword = request.getParameter("repassword");

        System.out.println("=== RegisterServlet.doPost() ===");
        System.out.println("name=" + name + ", email=" + email + ", phone=" + phone);
        
        String Email_Regex = "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$";
        String Phone_Regex="^\\d{10}$";
        boolean err = false;
        
        if(!email.matches(Email_Regex)) {
            err_email="Email is invalid!";
            request.getSession().setAttribute("err_email", err_email);
            err = true;
            System.out.println("Validation: invalid email");
        } else {
            err_email="";
            request.getSession().removeAttribute("err_email");
        }
        
        if (!phone.matches(Phone_Regex)) {
            err_phone="Phone has 10 digits!";
            request.getSession().setAttribute("err_phone", err_phone);
            err = true;
            System.out.println("Validation: invalid phone");
        } else {
            err_phone="";
            request.getSession().removeAttribute("err_phone");
        }
        
        if(repassword == null || !repassword.equals(password)) {
            err_repassword="Not match password!";
            request.getSession().setAttribute("err_repassword", err_repassword);
            err = true;
            System.out.println("Validation: password not match");
        } else {
            err_repassword="";
            request.getSession().removeAttribute("err_repassword");
        }
        
        if (err) {
            System.out.println("Validation failed -> redirect register");
            response.sendRedirect("register");
            return;
        } else {
            System.out.println("Validation passed -> checking duplicates");
            if(Database.getUserDao().findUser(email)!=null || Database.getUserDao().findUser(phone)!=null){
                System.out.println("Duplicate user by email or phone");
                request.getSession().setAttribute("exist_user", "User has existed in Database!");
                response.sendRedirect("register");
                return;
            } else{
                System.out.println("Inserting user into DB...");
                String hashedPassword = API.getMd5(password);
                System.out.println("Original password: " + password);
                System.out.println("Hashed password: " + hashedPassword);
                System.out.println("Hash length: " + hashedPassword.length());
                
                Database.getUserDao().insertUser(name, email, phone, hashedPassword);
                System.out.println("Insert done -> loading user back by email");
                User user= Database.getUserDao().findUser(email);
                request.getSession().setAttribute("user", user);
                request.getSession().removeAttribute("exist_user");
                response.sendRedirect("home");
                return;
            }
        }
    }
    
}
