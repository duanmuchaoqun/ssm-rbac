package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.dao.RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoleService {

    @Autowired
    private RoleMapper roleMapper;

    public List<Role> getRoleList(Role role) {
        return roleMapper.getRoleList(role);
    }

    public Role getRoleById(Integer id) {
        return roleMapper.getRoleById(id);
    }

    public void saveUserRole(Map<String, Object> map) {
        roleMapper.saveUserRole(map);
    }

    public List<Integer> getUserRoleIdList(Integer id) {
        return roleMapper.getUserRoleIdList(id);
    }

    public void deleteUserRole(Map<String, Object> map) {
        roleMapper.deleteUserRole(map);
    }

    public void saveRole(Role role) {
        roleMapper.saveRole(role);
    }

    public void updateRole(Role role) {
        roleMapper.updateRole(role);
    }
}
