package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.bean.UserRole;
import com.atguigu.atcrowdfunding.dao.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {


    @Autowired
    private UserMapper userMapper;


    public List<User> getAll() {
       List<User> list= userMapper.getAll();
       return list;
    }

    public User getForLogin(User user) throws Exception {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        md5.update(user.getPassword().getBytes());
        String md5Psd = new BigInteger(1, md5.digest()).toString(16);
        user.setPassword(md5Psd);
        return userMapper.getForLogin(user);

    }

    public List<User> getUserList(User user) {
        return userMapper.getUserList(user);
    }

    public void saveUser(User user) {
        userMapper.saveUser(user);
    }

    public User getUserById(Integer id) {
        return userMapper.getUserById(id);
    }

    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    public void deleteUser(Integer id) {
        userMapper.deleteById(id);
    }

    public void deleteBatch(ArrayList<Integer> ids) {
        userMapper.deleteBatch(ids);
    }


}
