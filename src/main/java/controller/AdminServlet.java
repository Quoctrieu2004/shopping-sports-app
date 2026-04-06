package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.Product;
import model.Category;
import data.dao.Database;
import java.util.List;
// doGet: chỉ dùng để kiểm tra quyền và render trang Admin (nạp dữ liệu + forward admin.jsp).
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       //Ghi đè phương thức xử lý HTTP GET.
        User user = (User) request.getSession().getAttribute("user");//Lấy object user đang đăng nhập từ session; ép kiểu về User
        // Kiểm tra xem user có phải là admin không
        //Chỉ cho phép vào trang admin khi có user và role = "admin"
        if (user != null && "admin".equals(user.getRole())) {
            try {
                // Tải dữ liệu cho admin dashboard
                loadAdminData(request); //Gọi hàm nạp dữ liệu Users/Products/Categories
                request.getRequestDispatcher("/views/admin.jsp").forward(request, response); // lấy dtuong trỏ tới
            } catch (Exception e) {
                System.out.println("Error loading admin data: " + e.getMessage());
                e.printStackTrace();
                // Vẫn hiển thị trang admin ngay cả khi tải dữ liệu thất bại
                request.getRequestDispatcher("/views/admin.jsp").forward(request, response);
            }
        } else {
            // Nếu không phải admin thì chuyển về trang login
            response.sendRedirect("login");
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        // Xử lý các hành động khác nhau dựa trên parameter action
        if ("addProduct".equals(action)) { // nếu action giống addP thì chạy dưới 
        } else if ("updateProduct".equals(action)) {
        } else if ("deleteProduct".equals(action)) {
        } else if ("addCategory".equals(action)) {
        } else if ("updateCategory".equals(action)) {
        } else if ("deleteCategory".equals(action)) {
        } else if ("updateUser".equals(action)) {
        } else if ("deleteUser".equals(action)) {
        } else {
            // Mặc định chuyển về phương thức GET
            doGet(request, response);
        }
    }
    // Phương thức tải dữ liệu cho admin dashboard
    private void loadAdminData(HttpServletRequest request) {
        try {
            System.out.println("=== Loading Admin Data ===");
            
            // Tải số lượng và dữ liệu người dùng
            List<User> allUsers = Database.getUserDao().getAllUsers();
            int userCount = allUsers != null ? allUsers.size() : 0;
            request.setAttribute("totalUsers", userCount);
            request.setAttribute("allUsers", allUsers);
            System.out.println("Users loaded: " + userCount);
   // gọi DAO qua “cổng” Database  lấy ProductDao  gọi findAllWithCategoryName() để lấy List<Product> có thêm tên danh mục.
            // Tải số lượng và dữ liệu danh mục
            List<Category> allCategories = Database.getCategoryDao().findAll();
            int categoryCount = allCategories != null ? allCategories.size() : 0;
            request.setAttribute("totalCategories", categoryCount);
            request.setAttribute("allCategories", allCategories);
            System.out.println("Categories loaded: " + categoryCount);
            List<Product> allProducts = Database.getProductDao().findAllWithCategoryName();
            int productCount = allProducts != null ? allProducts.size() : 0;
            request.setAttribute("totalProducts", productCount);
            request.setAttribute("allProducts", allProducts);
            System.out.println("Products loaded: " + productCount);  // in ra sl theo dõi
            System.out.println("=== Admin Data Loading Complete ===");
        } catch (Exception e) {
            System.out.println("Error in loadAdminData: " + e.getMessage());
            e.printStackTrace();
            // Đặt giá trị mặc định nếu tải thất bại
            request.setAttribute("totalUsers", 0);
            request.setAttribute("totalCategories", 0);
            request.setAttribute("totalProducts", 0);
        }   
    } 
    // Xử lý thêm sản phẩm mới
    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try { //lấy  từ reqest      Tên sản phẩm phải được nhập, không để trống, không chỉ gõ mỗi khoảng trắng.
            String productName = request.getParameter("productName"); // lấy req từ mấy cái ni
            String categoryId = request.getParameter("productCategory");
            String price = request.getParameter("productPrice");
            String quantity = request.getParameter("productQuantity");
            String description = request.getParameter("productDescription");
            String image = request.getParameter("productImage");
            // lấy ttin sp từ form
            if (productName != null && !productName.trim().isEmpty() && 
                categoryId != null && !categoryId.trim().isEmpty() &&
                price != null && !price.trim().isEmpty() &&
                quantity != null && !quantity.trim().isEmpty()) {
                Product product = new Product(          //ép categoryId từ String → int , bỏ khoảng trắng thừa
                    Integer.parseInt(categoryId),   
                    productName.trim(),
                    image != null ? image.trim() : "",
                    Double.parseDouble(price),
                    Integer.parseInt(quantity),
                    true // status = true mặc định
                ); //nếu image khác null thì trim, nếu null thì để rỗng
                // Success truyền tới hàm ProductD rồi trong hàm Prod thực hiện hàm addProduct
                boolean success = Database.getProductDao().addProduct(product);
                if (success) {
                    request.getSession().setAttribute("adminMessage", "Product added successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to add product!");
                }
            } else { // thiếu dữ liệu
                request.getSession().setAttribute("adminError", "Please fill all required fields!");
            }
        } catch (Exception e) {
            System.out.println("Error adding product: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error adding product: " + e.getMessage());
        }
        response.sendRedirect("admin?section=add-product");
    }
    // Xử lý cập nhật sản phẩm
    //đọc tất cả input form (kiểu String).
    private void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //    ảnh: nếu null để rỗng
            String productId = request.getParameter("productId"); // lấy req từ mấy cái ni
            String productName = request.getParameter("productName");
            String categoryId = request.getParameter("productCategory");
            String price = request.getParameter("productPrice");
            String quantity = request.getParameter("productQuantity");
            String image = request.getParameter("productImage");
            String status = request.getParameter("productStatus"); 
            if (productId != null && !productId.trim().isEmpty()) {  
                //  ép string -> int, tên sản phẩm (xóa khoảng trắng thừa)
                Product product = new Product(
                    Integer.parseInt(productId),
                    Integer.parseInt(categoryId),
                    productName.trim(),        
                    image != null ? image.trim() : "",
                    Double.parseDouble(price),
                    Integer.parseInt(quantity),
                    "1".equals(status)  // status =1 :true
                );       //bắt buộc có productId để biết record nào cần update
                boolean success = Database.getProductDao().updateProduct(product);
                if (success) {
                    request.getSession().setAttribute("adminMessage", "Product updated successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to update product!");
                }  // // Success truyền tới hàm ProductD rồi trong hàm Prod thực hiện hàm addProduct
            } // Gọi phương thức updateProduct trong DAO để chạy SQL UPDATE
        } catch (Exception e) {
            System.out.println("Error updating product: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error updating product: " + e.getMessage());
        }
        response.sendRedirect("admin?section=products");
    }
    // Xử lý xóa sản phẩm
    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productId = request.getParameter("productId"); 
            if (productId != null && !productId.trim().isEmpty()) {      
                boolean success = Database.getProductDao().deleteProduct(Integer.parseInt(productId));
                if (success) {
                    request.getSession().setAttribute("adminMessage", "Product deleted successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to delete product!");
                }// // Success truyền tới hàm ProductD rồi trong hàm Prod thực hiện hàm addProduct
            } //lấy productId từ request (tham số truyền lên)    chỉ xử lý khi productId có giá trị,
        } catch (Exception e) {   //gọi DAO để xóa sản phẩm trong DB theo productId
            //Nếu xóa thành công → lưu thông báo vào session
            System.out.println("Error deleting product: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error deleting product: " + e.getMessage());
        }
        response.sendRedirect("admin?section=products");
    } // sau khi xử lý xong, luôn chuyển hướng về trang quản lý sản phẩm.
    // Xử lý thêm danh mục mới
    private void handleAddCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String categoryName = request.getParameter("categoryName");
            
            if (categoryName != null && !categoryName.trim().isEmpty()) {
                // Tạo danh mục mới
                Category category = new Category(0, categoryName.trim());
                
                // Thêm danh mục vào database
                boolean success = Database.getCategoryDao().addCategory(category);
                
                if (success) {
                    request.getSession().setAttribute("adminMessage", "Category added successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to add category!");
                }
            } else {
                request.getSession().setAttribute("adminError", "Please enter category name!");
            }
            
        } catch (Exception e) {
            System.out.println("Error adding category: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error adding category: " + e.getMessage());
        }
        
        response.sendRedirect("admin?section=categories");
    }
    
    // Xử lý cập nhật danh mục
    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String categoryId = request.getParameter("categoryId");
            String categoryName = request.getParameter("categoryName");
            
            if (categoryId != null && !categoryId.trim().isEmpty() &&
                categoryName != null && !categoryName.trim().isEmpty()) {
                
                // Cập nhật danh mục trong database
                Category category = new Category(Integer.parseInt(categoryId), categoryName.trim());
                boolean success = Database.getCategoryDao().updateCategory(category);
                
                if (success) {
                    request.getSession().setAttribute("adminMessage", "Category updated successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to update category!");
                }
            } else {
                request.getSession().setAttribute("adminError", "Please fill all required fields!");
            }
            
        } catch (Exception e) {
            System.out.println("Error updating category: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error updating category: " + e.getMessage());
        }
        
        response.sendRedirect("admin?section=categories");
    }
    
    // Xử lý xóa danh mục
    private void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String categoryId = request.getParameter("categoryId");
            
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                // Xóa danh mục khỏi database
                boolean success = Database.getCategoryDao().deleteCategory(Integer.parseInt(categoryId));
                
                if (success) {
                    request.getSession().setAttribute("adminMessage", "Category deleted successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to delete category!");
                }
            }
            
        } catch (Exception e) {
            System.out.println("Error deleting category: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error deleting category: " + e.getMessage());
        }
        
        response.sendRedirect("admin?section=categories");
    }
    
    // Xử lý cập nhật thông tin người dùng
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy thông tin người dùng từ form
            String userId = request.getParameter("userId");
            String userName = request.getParameter("userName");
            String userEmail = request.getParameter("userEmail");
            String userPhone = request.getParameter("userPhone");
            String userRole = request.getParameter("userRole");
            
            if (userId != null && !userId.trim().isEmpty() &&
                userName != null && !userName.trim().isEmpty() &&
                userEmail != null && !userEmail.trim().isEmpty() &&
                userPhone != null && !userPhone.trim().isEmpty() &&
                userRole != null && !userRole.trim().isEmpty()) {
                
                // Tạo đối tượng User để cập nhật
                User user = new User();
                user.setId(Integer.parseInt(userId));
                user.setName(userName.trim());
                user.setEmail(userEmail.trim());
                user.setPhone(userPhone.trim());
                user.setRole(userRole.trim());
                
                // Cập nhật người dùng trong database
                boolean success = Database.getUserDao().updateUser(user);
                
                if (success) {
                    request.getSession().setAttribute("adminMessage", "User updated successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to update user!");
                }
            } else {
                request.getSession().setAttribute("adminError", "Please fill all required fields!");
            }
            
        } catch (Exception e) {
            System.out.println("Error updating user: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error updating user: " + e.getMessage());
        }
        
        response.sendRedirect("admin?section=users");
    }
    
    // Xử lý xóa người dùng
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userId = request.getParameter("userId");
            
            if (userId != null && !userId.trim().isEmpty()) {
                // Xóa người dùng khỏi database
                boolean success = Database.getUserDao().deleteUser(Integer.parseInt(userId));
                
                if (success) {
                    request.getSession().setAttribute("adminMessage", "User deleted successfully!");
                } else {
                    request.getSession().setAttribute("adminError", "Failed to delete user!");
                }
            }
            
        } catch (Exception e) {
            System.out.println("Error deleting user: " + e.getMessage());
            request.getSession().setAttribute("adminError", "Error deleting user: " + e.getMessage());
        }
        
        response.sendRedirect("admin?section=users");
    }
}
