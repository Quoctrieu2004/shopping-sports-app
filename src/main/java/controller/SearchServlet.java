package controller;

import data.dao.Database;
import data.utils.API;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;
import model.Product;
import model.User;

public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("=== SearchServlet.doGet() called ===");

            String searchQuery = request.getParameter("q");
            System.out.println("Search query: " + searchQuery);

            if (searchQuery == null || searchQuery.trim().isEmpty()) {
                response.sendRedirect("home");
                return;
            }//searchR lưu danh sách P bằng cách gọi hàm searchP, từ khóa tìm kiếm từ người dùng
//searchResults sẽ chứa danh sách sản phẩm tìm được
            List<Category> listCategory = Database.getCategoryDao().findAll();
      // luu ds sp Tên (key) của attribute chính là danh sách sản phẩm
            request.setAttribute("listCategory", listCategory); 
            
            List<Product> searchResults = searchProducts(searchQuery);
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("resultCount", searchResults.size());
            
            
            User user = (User) request.getSession().getAttribute("user"); // lay doi tuong User tu session
            if (user != null) {
                String splitname = API.getName(user.getName());
                request.getSession().setAttribute("splitname", splitname);
            } // // luu tukhoa timkiem Tên att để lưu từ khóa từ khóa mà người dùng đã nhập
// // luu sl kq tim duoc Tên att để lưu số lượng trả về số phần tử trong danh sách
            request.setAttribute("title", "Kết quả tìm kiếm: " + searchQuery);
            request.getRequestDispatcher("./views/search-results.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in SearchServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
//Hàm searchP trả lại kết quả từ database bằng cách gọi tới hàm searchBN,chính là searchQuery từ bước 1
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    
    private List<Product> searchProducts(String query) {
        //  Làm cầu nối giữa Servlet và DAO
        return Database.getProductDao().searchByName(query);
    }
}


