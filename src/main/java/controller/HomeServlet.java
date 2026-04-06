        /*
         * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
         * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
         */
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
        /**
         *
         * @author lab
         */
        public class HomeServlet extends HttpServlet {

            /**
             * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
             * methods.
             *
             * @param request servlet request
             * @param response servlet response
             * @throws ServletException if a servlet-specific error occurs
             * @throws IOException if an I/O error occurs
             */
            protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    /* TODO output your page here. You may use following sample code. */
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Servlet HomeServlet</title>");            
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
                    out.println("</body>");
                    out.println("</html>");
                }
            }

            // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
            /**
             * Handles the HTTP <code>GET</code> method.
             *
             * @param request servlet request
             * @param response servlet response
             * @throws ServletException if a servlet-specific error occurs
             * @throws IOException if an I/O error occurs
             */
            @Override
            protected void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
        //        processRequest(request, response);
                try {
                    // Chatbot AJAX endpoints
                    String action = request.getParameter("action");
                    if ("getAllProducts".equals(action)) {
                        getAllProductsJSON(request, response);
                        return;
                    } else if ("getProductsByCategory".equals(action)) {
                        String categoryId = request.getParameter("category");
                        getProductsByCategoryJSON(request, response, categoryId);
                        return;
                    } else if ("getProductStatus".equals(action)) {
                        String productId = request.getParameter("id");
                        getProductStatusJSON(request, response, productId);
                        return;
                    }
                    System.out.println("=== HomeServlet.doGet() called ===");
                    
                    System.out.println("Loading categories...");
                    List<Category> listCategory = Database.getCategoryDao().findAll();
                    System.out.println("Categories loaded: " + (listCategory != null ? listCategory.size() : "NULL") + " categories");
                    
                    // Debug: Hiển thị thông tin categories
                    if (listCategory != null) {
                        for (Category cat : listCategory) {
                            System.out.println("Category: ID=" + cat.getId() + ", Name=" + cat.getName());
                        }
                    }
                    
                    request.setAttribute("listCategory", listCategory);

                    String id_category = request.getParameter("id_category");
                    System.out.println("Category ID parameter: " + id_category);
                    List<Product> listProduct;
                    
                    if (id_category != null && !id_category.trim().isEmpty()) {
                        // Filter products by category
                        System.out.println("Loading products by category: " + id_category);
                        listProduct = Database.getProductDao().findByCategory(Integer.parseInt(id_category));
                        request.setAttribute("id_category", id_category);

                        // Split into new and old products (newest first by id desc)
                        java.util.List<Product> newProducts = new java.util.ArrayList<>();
                        java.util.List<Product> oldProducts = new java.util.ArrayList<>();
                        int splitIndex = Math.min(8, listProduct.size());
                        for (int i = 0; i < listProduct.size(); i++) {
                            if (i < splitIndex) newProducts.add(listProduct.get(i)); else oldProducts.add(listProduct.get(i));
                        }
                        request.setAttribute("newProducts", newProducts);
                        request.setAttribute("oldProducts", oldProducts);
                    } else {
                        // Home: show newest products across all categories
                        System.out.println("Loading all products...");
                        listProduct = Database.getProductDao().findAll();
                        java.util.List<Product> newestProducts = new java.util.ArrayList<>();
                        int limit = Math.min(12, listProduct.size());
                        for (int i = 0; i < limit; i++) {
                            newestProducts.add(listProduct.get(i));
                        }
                        request.setAttribute("newestProducts", newestProducts);
                    }
                    
                    System.out.println("Products loaded: " + (listProduct != null ? listProduct.size() : "NULL") + " products");
                    
                    // Debug: Hiển thị thông tin products
                    if (listProduct != null) {
                        for (Product prod : listProduct) {
                            System.out.println("Product: ID=" + prod.getId() + ", Name=" + prod.getName() + ", Image=" + prod.getImage() + ", Category=" + prod.getId_category());
                        }
                    }
                    
                    request.setAttribute("listProduct", listProduct);
                    User user = (User) request.getSession().getAttribute("user");
                    if (user != null) {
                        String splitname = API.getName(user.getName());
                        request.getSession().setAttribute("splitname", splitname);
                    }
                    request.setAttribute("title", "Home Page");
                    System.out.println("Forwarding to home.jsp...");
                    request.getRequestDispatcher("/views/home.jsp").forward(request, response);
                } catch (Exception e) {
                    System.out.println("Error in HomeServlet: " + e.getMessage());
                    e.printStackTrace();
                    // If database fails, show simple message
                    response.setContentType("text/html;charset=UTF-8");
                    try (PrintWriter out = response.getWriter()) {
                        out.println("<!DOCTYPE html>");
                        out.println("<html>");
                        out.println("<head>");
                        out.println("<title>Test Page</title>");            
                        out.println("</head>");
                        out.println("<body>");
                        out.println("<h1>Servlet is working!</h1>");
                        out.println("<p>Context Path: " + request.getContextPath() + "</p>");
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                        out.println("</body>");
                        out.println("</html>");
                    }
                }
            }
            /**
             * Handles the HTTP <code>POST</code> method.
             *
             * @param request servlet request
             * @param response servlet response
             * @throws ServletException if a servlet-specific error occurs
             * @throws IOException if an I/O error occurs
             */
            @Override
            protected void doPost(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
                processRequest(request, response);
            }
            /**
             * Returns a short description of the servlet.
             *
             * @return a String containing servlet description
             */
            @Override
            public String getServletInfo() {
                return "Short description";
            }// </editor-fold>

            private void getAllProductsJSON(HttpServletRequest request, HttpServletResponse response) throws IOException {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try {
                    List<Product> allProducts = Database.getProductDao().findAll();
                    StringBuilder json = new StringBuilder();
                    json.append("{\"products\":[");
                    for (int i = 0; i < allProducts.size(); i++) {
                        Product p = allProducts.get(i);
                        json.append("{");
                        json.append("\"id\":\"").append(p.getId()).append("\",");
                        json.append("\"name\":\"").append(p.getName().replace("\"", "\\\"")).append("\",");
                        json.append("\"image\":\"").append(p.getImage()).append("\",");
                        json.append("\"price\":\"").append(p.getPrice()).append("\",");
                        json.append("\"category\":\"").append(getCategoryName(p.getId_category())).append("\",");
                        json.append("\"categoryId\":\"").append(p.getId_category()).append("\"");
                        json.append("}");
                        if (i < allProducts.size() - 1) json.append(",");
                    }
                    json.append("]}");
                    PrintWriter out = response.getWriter();
                    out.print(json.toString());
                    out.flush();
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    PrintWriter out = response.getWriter();
                    out.print("{\"error\": \"Failed to fetch products\"}");
                    out.flush();
                }
            }

            private void getProductsByCategoryJSON(HttpServletRequest request, HttpServletResponse response, String categoryId) throws IOException {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try {
                    int catId = Integer.parseInt(categoryId);
                    List<Product> categoryProducts = Database.getProductDao().findByCategory(catId);
                    StringBuilder json = new StringBuilder();
                    json.append("{\"products\":[");
                    for (int i = 0; i < categoryProducts.size(); i++) {
                        Product p = categoryProducts.get(i);
                        json.append("{");
                        json.append("\"id\":\"").append(p.getId()).append("\",");
                        json.append("\"name\":\"").append(p.getName().replace("\"", "\\\"")).append("\",");
                        json.append("\"image\":\"").append(p.getImage()).append("\",");
                        json.append("\"price\":\"").append(p.getPrice()).append("\",");
                        json.append("\"category\":\"").append(getCategoryName(p.getId_category())).append("\",");
                        json.append("\"categoryId\":\"").append(p.getId_category()).append("\"");
                        json.append("}");
                        if (i < categoryProducts.size() - 1) json.append(",");
                    }
                    json.append("]}");
                    PrintWriter out = response.getWriter();
                    out.print(json.toString());
                    out.flush();
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    PrintWriter out = response.getWriter();
                    out.print("{\"error\": \"Failed to fetch products by category\"}");
                    out.flush();
                }
            }

            private void getProductStatusJSON(HttpServletRequest request, HttpServletResponse response, String productId) throws IOException {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try {
                    int prodId = Integer.parseInt(productId);
                    Product product = Database.getProductDao().findProduct(prodId);
                    boolean status = product != null && product.isStatus();
                    String jsonString = "{\"status\":" + status + "}";
                    PrintWriter out = response.getWriter();
                    out.print(jsonString);
                    out.flush();
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    PrintWriter out = response.getWriter();
                    out.print("{\"error\": \"Failed to fetch product status\"}");
                    out.flush();
                }
            }

            private String getCategoryName(int categoryId) {
                try {
                    List<Category> categories = Database.getCategoryDao().findAll();
                    for (Category cat : categories) {
                        if (cat.getId() == categoryId) {
                            return cat.getName();
                        }
                    }
                } catch (Exception e) {
                    System.out.println("Error getting category name: " + e.getMessage());
                }
                return "Unknown";
            }

        }
