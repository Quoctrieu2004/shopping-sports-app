/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;

import model.User;
import java.util.List;

/**
 *
 * @author ASUS
 */
public interface UserDao {
        public User findUser(String emailphone, String password );
        public User findUser(String emailphone);
        public void insertUser(String name, String email, String phone, String password);
        
      
        public User findUserByEmail(String email);
        public User findUserByPhone(String phone);
        public boolean createUser(User user);
        public boolean updatePassword(int userId, String newPassword);
        public List<User> getAllUsers();
        public boolean updateUser(User user);
        public boolean deleteUser(int userId);
}
