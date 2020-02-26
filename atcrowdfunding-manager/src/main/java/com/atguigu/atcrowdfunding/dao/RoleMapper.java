package com.atguigu.atcrowdfunding.dao;

import com.atguigu.atcrowdfunding.bean.Role;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface RoleMapper {

    List<Role> getRoleList(Role role);

    @Select("select * from t_role where id=#{id}")
    Role getRoleById(Integer id);

    void saveUserRole(Map<String, Object> map);

    @Select("select role_id from t_user_role where user_id = #{id}")
    List<Integer> getUserRoleIdList(Integer id);

    void deleteUserRole(Map<String, Object> map);


    void saveRole(Role role);

    void updateRole(Role role);

}
