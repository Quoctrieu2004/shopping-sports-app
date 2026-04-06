-- Script tạo database shopping_sports cho project Shopping2
-- Chạy script này trong phpMyAdmin để tạo database và dữ liệu

-- Tạo database shopping_sports
CREATE DATABASE IF NOT EXISTS shopping_sports;
USE shopping_sports;

-- Xóa bảng cũ nếu có để tạo lại
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- Tạo bảng categories
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tạo bảng users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user'
);

-- Tạo bảng products
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_category INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(500),
    price DECIMAL(10,2) NOT NULL,
    quantity INT DEFAULT 0,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_category) REFERENCES categories(id)
);

-- Thêm dữ liệu mẫu cho categories (thể thao và thể dục)
INSERT INTO categories (name) VALUES 
('Thể Thao'),
('Thể Dục'),
('Dụng Cụ'),
('Trang Phục');

-- Thêm dữ liệu mẫu cho users (password đã được hash MD5)
-- admin123 -> 0192023a7bbd73250516f069df18b500
-- user123 -> 6ad14ba9986e3615423dfca256d04e3f
INSERT INTO users (name, email, phone, password, role) VALUES 
('Admin Sports', 'admin@sports.com', '0123456789', '0192023a7bbd73250516f069df18b500', 'admin'),
('User Sports', 'user@sports.com', '0987654321', '6ad14ba9986e3615423dfca256d04e3f', 'user');

-- Thêm dữ liệu mẫu cho products (thể thao và thể dục)
-- Category 1: Thể Thao
INSERT INTO products (id_category, name, image, price, quantity, status) VALUES 
(1, 'Bóng đá chính hãng', 'adidas1.png', 500000, 20, TRUE),
(1, 'Bóng rổ Spalding', 'adidas2.png', 800000, 15, TRUE),
(1, 'Vợt tennis Wilson', 'adidas3.png', 1200000, 10, TRUE),
(1, 'Gậy golf Callaway', 'adidas4.png', 2500000, 8, TRUE),
(1, 'Bóng bàn Butterfly', 'adidas5.png', 600000, 25, TRUE);

-- Category 2: Thể Dục
INSERT INTO products (id_category, name, image, price, quantity, status) VALUES 
(2, 'Thảm yoga cao cấp', 'adidas6.png', 300000, 30, TRUE),
(2, 'Dây kháng lực', 'adidas7.png', 150000, 50, TRUE),
(2, 'Tạ tay 5kg', 'adidas8.png', 400000, 20, TRUE),
(2, 'Bóng tập bụng', 'adidas9.png', 200000, 35, TRUE),
(2, 'Dây nhảy thể dục', 'adidas10.png', 100000, 40, TRUE);

-- Category 3: Dụng Cụ
INSERT INTO products (id_category, name, image, price, quantity, status) VALUES 
(3, 'Máy chạy bộ điện', 'adidas11.png', 15000000, 5, TRUE),
(3, 'Xe đạp tập thể dục', 'adidas12.png', 8000000, 8, TRUE),
(3, 'Ghế tập tạ đa năng', 'adidas13.png', 5000000, 12, TRUE),
(3, 'Máy tập cơ bụng', 'adidas14.png', 3000000, 15, TRUE),
(3, 'Bàn bóng bàn', 'adidas15.png', 4000000, 6, TRUE);

-- Category 4: Trang Phục
INSERT INTO products (id_category, name, image, price, quantity, status) VALUES 
(4, 'Áo thể thao Nike', 'adidas16.png', 800000, 25, TRUE),
(4, 'Quần thể thao Adidas', 'adidas17.png', 600000, 30, TRUE),
(4, 'Giày chạy bộ', 'adidas18.png', 2000000, 18, TRUE),
(4, 'Bộ đồ tập yoga', 'adidas19.png', 500000, 22, TRUE),
(4, 'Áo khoác thể thao', 'adidas20.png', 1200000, 15, TRUE);

-- Kiểm tra dữ liệu
SELECT 'Categories:' as info;
SELECT * FROM categories;

SELECT 'Users:' as info;
SELECT * FROM users;

SELECT 'Products:' as info;
SELECT p.*, c.name as category_name 
FROM products p 
JOIN categories c ON p.id_category = c.id;

-- Thông tin đăng nhập test:
-- Admin: admin@sports.com / admin123
-- User: user@sports.com / user123
