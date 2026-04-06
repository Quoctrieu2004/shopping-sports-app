package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Product {
    private int id;
    private int id_category;
    private String image;
    private String name;
    private double price;
    private int quantity;
    private boolean status;
    private String categoryName; // Added field for category name

    public Product (ResultSet rs) throws SQLException {
        this.id = rs.getInt("id");
        this.id_category = rs.getInt("id_category");
        this.name = rs.getString("name");
        this.image = rs.getString("image");
        this.price = rs.getDouble("price");
        this.quantity = rs.getInt("quantity");
        this.status = rs.getBoolean("status");
        // Note: categoryName is not set in constructor as it comes from JOIN query
    }
    
    // Constructor for creating new product from form data
    public Product(int id_category, String name, String image, double price, int quantity, boolean status) {
        this.id_category = id_category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
    }
    
    // Constructor for updating existing product
    public Product(int id, int id_category, String name, String image, double price, int quantity, boolean status) {
        this.id = id;
        this.id_category = id_category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public int getId_category() {
        return id_category;
    }

    public String getImage() {
        return image;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public boolean isStatus() {
        return status;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public void setId_category(int id_category) {
        this.id_category = id_category;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
