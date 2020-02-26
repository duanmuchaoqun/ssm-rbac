package com.atguigu.atcrowdfunding.dao;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface PermissionMapper {

    @Select("select * from t_permission where pid = #{id}")
    List<Permission> getChildPermissions(int id);

    void saveRolePermission(Map<String, Object> map);

    void deleteRolePermission(Integer roleId);

    @Select("select permissions_id from t_role_permission where role_id = #{roleId}")
    List<Integer> getPermissionIdsByRoleId(Integer roleId);

    @Select("select * from t_permission")
    List<Permission> getPermissionList();


    List<Permission> getPermissionByUser(User dbUser);
}
