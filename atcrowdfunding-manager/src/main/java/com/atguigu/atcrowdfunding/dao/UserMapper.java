package com.atguigu.atcrowdfunding.dao;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import org.apache.ibatis.annotations.Select;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface UserMapper {


    @Select("select * from t_user")
    List<User> getAll();

    @Select("select * from t_user where account = #{account } and password = #{password }")
    User getForLogin(User user);

    List<User> getUserList(User user);

    void saveUser(User user);

    @Select("select * from t_user where id = #{id}")
    User getUserById(Integer id);

    void updateUser(User user);

    void deleteById(Integer id);

    void deleteBatch(ArrayList<Integer> ids);
}
