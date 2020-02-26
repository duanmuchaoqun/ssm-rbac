package com.atguigu.atcrowdfunding.test;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.service.UserService;

import com.atguigu.atcrowdfunding.utils.EncryptionUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.security.NoSuchAlgorithmException;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:spring/applicationContext.xml"})
public class UserTest {

    @Autowired
    private UserService userService;

    private EncryptionUtils encryptionUtils = EncryptionUtils.getInstance();

    @Test
    public void testDeleteById(){
//        userService.deleteById(9);
    }

    @Test
    public void testCreateData() {
//        Date date = new Date();
//        for (int i = 5; i < 90; i++) {
//            User user = new User(null, "test" + i, "test" + i, encryptionUtils.md5("12345"), "test" + i + "@.atguigu.com", date, date);
//            userService.saveUser(user);
//        }
    }

//    @Test
//    public void testGetRoleById(){
//        Role role = userService.getRoleById(1);
//        System.out.println("role = " + role);
//    }
}
