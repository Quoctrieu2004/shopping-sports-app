package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.dao.Database;
import model.Product;

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProductStr = request.getParameter("id_product");
        
        if (idProductStr != null && !idProductStr.trim().isEmpty()) {
            try {
                int idProduct = Integer.parseInt(idProductStr);
                Product product = Database.getProductDao().findProduct(idProduct);
                
                if (product != null) {
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/views/product.jsp").forward(request, response);
                } else {
                    response.sendRedirect("home");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
