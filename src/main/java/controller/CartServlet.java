package controller;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import data.dao.Database;
import model.Product;
import model.User;
import java.util.HashMap;
import java.util.Map;
import java.math.BigDecimal;
import java.math.RoundingMode;
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            System.out.println("=== CartServlet.doGet() called ===");
            String action = request.getParameter("action");
            System.out.println("Action parameter: " + action);
            
            HttpSession session = request.getSession();
            System.out.println("Session ID: " + session.getId());
            
            // Require login before allowing cart access
            User user = (User) session.getAttribute("user");
            if (user == null) {
                System.out.println("User not logged in. Redirecting to login from cart.");
                response.sendRedirect("login");
                return;
            }
            
            // Khởi tạo giỏ hàng nếu chưa có
            @SuppressWarnings("unchecked")
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
                session.setAttribute("cart", cart);
                System.out.println("Created new cart: " + cart);
            } else {
                System.out.println("Existing cart: " + cart);
            }

            // Clear cart action (supports both action=clear and clear=OK)
            if ("clear".equalsIgnoreCase(action) || request.getParameter("clear") != null) {
                System.out.println("Processing CLEAR action...");
                session.removeAttribute("cart");
                session.setAttribute("cart_message", "Giỏ hàng đã được làm trống.");
                response.sendRedirect("cart?action=view");
                return;
            }
            
            if ("add".equals(action)) {
                System.out.println("Processing ADD action...");
                // Thêm sản phẩm vào giỏ hàng
                String idProductStr = request.getParameter("id_product");
                if (idProductStr != null && !idProductStr.trim().isEmpty()) {
                    try {
                        int idProduct = Integer.parseInt(idProductStr);
                        
                        // Lấy thông tin sản phẩm từ database
                        Product product = Database.getProductDao().findProduct(idProduct);
                        if (product != null) {
                            // Thêm vào giỏ hàng
                            cart.put(idProduct, cart.getOrDefault(idProduct, 0) + 1);
                            session.setAttribute("cart", cart);
                            
                            // Thông báo thành công
                            session.setAttribute("cart_message", "Đã thêm " + product.getName() + " vào giỏ hàng!");
                            
                            System.out.println("Added product to cart: " + product.getName() + " (ID: " + idProduct + ")");
                            System.out.println("Cart contents: " + cart);
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid product ID: " + idProductStr);
                    }
                }
                // Redirect về trang trước đó
                System.out.println("Redirecting to home...");
                response.sendRedirect("home");
            } else if ("view".equals(action) || action == null) {
                System.out.println("Processing VIEW action...");
                
                // Chuẩn bị danh sách sản phẩm với thông tin đầy đủ
                if (cart != null && !cart.isEmpty()) {
                    java.util.List<model.Product> cartProducts = new java.util.ArrayList<>();
                    BigDecimal subtotal = BigDecimal.ZERO;
                       //Truy vấn để lấy thông tin sản phẩm trong giỏ hàng:
                    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                        int productId = entry.getKey();
                        int quantity = entry.getValue();
                   // truy vấn
                        Product product = Database.getProductDao().findProduct(productId);
                        if (product != null) {
                            System.out.println("Cart Product: ID=" + product.getId() + 
                                             ", Name=" + product.getName() + 
                                             ", Image=" + product.getImage() + 
                                             ", Price=" + product.getPrice());
                            cartProducts.add(product);
                            // Tính giá
                            BigDecimal line = BigDecimal.valueOf(product.getPrice())
                                    .multiply(BigDecimal.valueOf(quantity));
                            subtotal = subtotal.add(line);
                        }
                    }
                    
                    // Tính VAT 10% và tổng cộng với định dạng 2 chữ số thập phân
                    BigDecimal vat = subtotal.multiply(new BigDecimal("0.10"))
                                             .setScale(2, RoundingMode.HALF_UP);
                    BigDecimal total = subtotal.add(vat).setScale(2, RoundingMode.HALF_UP);

                    request.setAttribute("cartProducts", cartProducts);
                    request.setAttribute("subtotal", subtotal.setScale(2, RoundingMode.HALF_UP));
                    request.setAttribute("vat", vat);
                    request.setAttribute("total", total);
                }
                
                // Xem giỏ hàng
                System.out.println("Forwarding to /inc/_cart.jsp...");
                request.getRequestDispatcher("/inc/_cart.jsp").forward(request, response);
                
            } else if ("remove".equals(action)) {
                System.out.println("Processing REMOVE action...");
                // Xóa sản phẩm khỏi giỏ hàng
                String idProductStr = request.getParameter("id_product");
                if (idProductStr != null && !idProductStr.trim().isEmpty()) {
                    try {
                        int idProduct = Integer.parseInt(idProductStr);
                        if (cart.containsKey(idProduct)) {
                            Product productToRemove = Database.getProductDao().findProduct(idProduct);
                            cart.remove(idProduct);
                            session.setAttribute("cart", cart);
                            session.setAttribute("cart_message", "Đã xóa " + (productToRemove != null ? productToRemove.getName() : "sản phẩm") + " khỏi giỏ hàng.");
                            System.out.println("Removed product " + idProduct + " from cart. Current cart: " + cart);
                        } else {
                            session.setAttribute("error_message", "Sản phẩm không có trong giỏ hàng.");
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid product ID: " + idProductStr);
                    }
                }
                response.sendRedirect("cart?action=view");
                
            } else if ("update".equals(action)) {
                System.out.println("Processing UPDATE action...");
                // Cập nhật số lượng
                String idProductStr = request.getParameter("id_product");
                String quantityStr = request.getParameter("quantity");
                if (idProductStr != null && quantityStr != null) {
                    try {
                        int idProduct = Integer.parseInt(idProductStr);
                        int quantity = Integer.parseInt(quantityStr);
                        if (cart.containsKey(idProduct)) {
                            if (quantity > 0) {
                                cart.put(idProduct, quantity);
                                session.setAttribute("cart_message", "Đã cập nhật số lượng sản phẩm.");
                            } else {
                                cart.remove(idProduct); // Xóa nếu số lượng là 0
                                session.setAttribute("cart_message", "Đã xóa sản phẩm khỏi giỏ hàng.");
                            }
                            System.out.println("Updated product " + idProduct + " quantity to " + quantity + ". Current cart: " + cart);
                        } else {
                            session.setAttribute("error_message", "Sản phẩm không có trong giỏ hàng để cập nhật.");
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid product ID or quantity");
                    }
                }
                response.sendRedirect("cart?action=view");
            }
            
        } catch (Exception e) {
            System.out.println("Error in CartServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Hiển thị lỗi cho user
            response.setContentType("text/html;charset=UTF-8");
            try (java.io.PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Cart Error</title>");            
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Error in Cart</h1>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                out.println("<p><a href='home'>Back to Home</a></p>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
