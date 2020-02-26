package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.dao.PermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    public List<Permission> getChildPermissions(int id) {
        List<Permission> list = permissionMapper.getChildPermissions(id);
        return list;
    }

    public void saveRolePermission(Map<String, Object> map) {
        permissionMapper.saveRolePermission(map);
    }

    public void deleteRolePermission(Integer roleId) {
        permissionMapper.deleteRolePermission(roleId);
    }

    public List<Integer> getPermissionIdsByRoleId(Integer roleId) {
        return permissionMapper.getPermissionIdsByRoleId(roleId);
    }

    public List<Permission> getPermissionList() {
        return permissionMapper.getPermissionList();
    }

    public List<Permission> getPermissionByUser(User dbUser) {
        return permissionMapper.getPermissionByUser(dbUser);
    }
}
