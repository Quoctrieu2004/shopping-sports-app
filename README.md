# Shopping Sports App - Admin & Features Overview

## 1. Tổng quan
Ứng dụng web bán đồ thể thao và thể dục, gồm trang người dùng và trang admin. Admin Dashboard dùng để quản lý người dùng, sản phẩm, danh mục và thống kê tổng quan.

**Vai trò của tôi:**  
- Phát triển Admin Dashboard, Forgot Password feature  
- Xử lý logic Java Servlet, JSP  
- Cấu hình database, quản lý users/products  

---

## 2. Admin Dashboard

**URL:** `/admin`  
**Tài khoản admin mẫu:** `admin.sports@gmail.com / 123`  

### Các chức năng chính
1. **Dashboard Overview:** Hiển thị tổng số users, products, categories, orders.  
2. **Users Management:**  
   - Xem danh sách, tìm kiếm users  
   - Chỉnh sửa/Xóa (hiện tại demo alert)  
3. **Products Management:**  
   - Xem danh sách, tìm kiếm products  
   - Thêm/Sửa/Xóa sản phẩm (demo alert cho edit/delete)  
4. **Categories Management:**  
   - Xem danh mục, thêm danh mục mới  
   - Edit/Delete (demo alert)  

### Giao diện & UX
- Responsive, hiển thị tốt trên mọi thiết bị  
- UI hiện đại, dùng Font Awesome icons  
- Các hiệu ứng chuyển động mượt mà  

---

## 3. Forgot Password Feature

- Cho phép người dùng reset password khi quên  
- **Workflow:**  
  1. Nhập email/phone → kiểm tra user tồn tại  
  2. Nhập password mới → hash MD5 trước khi lưu  
  3. Chuyển về trang login  
- Implementation: `ForgotPasswordServlet`, `UserDao` interface, `UserImpl`  
- Validation: password không rỗng, confirm match  

> Lưu ý: MD5 hiện tại để demo, nên nâng cấp sang bcrypt trong thực tế  

---

## 4. Database & Setup

**Database:** `shopping_sports`  
**Các bảng chính:**  
- `users` (tài khoản admin/user)  
- `products` (20 sản phẩm demo)  
- `categories` (Thể Thao, Thể Dục, Dụng Cụ, Trang Phục)  

### Các bước tạo database:
1. Mở phpMyAdmin → chạy script `create_shopping_sports_database.sql`  
2. Build project và deploy lên Tomcat  
3. Truy cập: `http://localhost:8080/Shopping2/home`  

### Test password hashing:
- Khi tạo tài khoản mới, password sẽ được hash MD5  
- Kiểm tra đăng nhập với password đã hash  

---

## 5. Cấu trúc project


## 📁 Cấu trúc file
```
Shopping2/
├── src/main/
│   ├── java/controller/
│   │   └── AdminServlet.java          # Xử lý logic admin
│   ├── java/model/
│   │   └── Product.java               # Model sản phẩm (đã cập nhật)
│   ├── java/data/dao/
│   │   └── ProductDao.java            # Interface DAO (đã cập nhật)
│   ├── java/data/impl/
│   │   └── ProductImpl.java           # Implementation DAO (đã cập nhật)
│   └── webapp/
│       ├── views/
│       │   └── admin.jsp              # Trang admin chính
│       └── WEB-INF/
│           └── web.xml                # Cấu hình servlet
```


---

## 6. Lưu ý & Future Enhancements

- Hiện tại chức năng edit/delete hiển thị alert  
- Upload hình ảnh thực tế chưa implement  
- Validation form cơ bản, cần bổ sung  
- Các tính năng sẽ phát triển: quản lý đơn hàng, thống kê chi tiết, export dữ liệu  

---

## 7. Hỗ trợ
Nếu gặp vấn đề khi deploy hoặc chạy project, kiểm tra:  
- Console log của Tomcat  
- Database connection  
- File assets/images tồn tại  
- Nếu cần, tạo issue trên repository  
