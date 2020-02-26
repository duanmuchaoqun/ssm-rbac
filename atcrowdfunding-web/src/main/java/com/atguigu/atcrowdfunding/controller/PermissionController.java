package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Result;
import com.atguigu.atcrowdfunding.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    /**
     * 递归算法
     * @param parent
     */
    private void getChildPermissions(Permission parent){
        List<Permission> childPermissions = permissionService.getChildPermissions(parent.getId());
        for (Permission permission : childPermissions) {
            getChildPermissions(permission);
        }
        parent.setChildren(childPermissions);
    }

    @RequestMapping("/index")
    public String index(){
        return "permission/index";
    }

    @ResponseBody
    @RequestMapping("/getPermissions")
    public List<Permission> getPermissions(){
        List<Permission> ps = permissionService.getPermissionList();
        ArrayList<Permission> list = new ArrayList<>();

        // 存储数据
        Map<Integer, Permission> map = new HashMap<>();
        for (Permission p : ps) {
            map.put(p.getId(),p);
        }
        for (Permission p : ps) {
            if(p.getPid() == 0){
                list.add(p);
            } else {
                Permission parent = map.get(p.getPid());
                parent.getChildren().add(p);
            }
        }
        return  list;
    }

    @ResponseBody
    @RequestMapping("/getAssignPermissions")
    public List<Permission> getAssignPermissions(Integer roleId){

        List<Permission> permissions = new ArrayList<>();
        // 获取所有的权限id
        List<Permission> ps = permissionService.getPermissionList();
        //获取当前角色已经分配的角色
        List<Integer> permissionids = permissionService.getPermissionIdsByRoleId(roleId);

        Map<Integer, Permission> permissionMap = new HashMap<>();
        for (Permission p : ps) {
            if(permissionids.contains(p.getId())){
                p.setChecked(true);
            } else {
                p.setChecked(false);
            }
            permissionMap.put(p.getId(), p);
        }
        for ( Permission p : ps ) {
            Permission child = p;
            if ( child.getPid() == 0 ) {
                permissions.add(p);
            } else {
                Permission parent = permissionMap.get(child.getPid());
                parent.getChildren().add(child);
            }
        }

        return  permissions;
    }

    @RequestMapping("/assignPermission")
    public String assignPermission(Integer id){
        return "permission/assignPermission";
    }

    @ResponseBody
    @RequestMapping("/doAssign")
    public Result doAssign(Integer roleId,Integer[] permissionIds){
        //清理原数据
        permissionService.deleteRolePermission(roleId);
        Map<String, Object> map = new HashMap<>();
        map.put("roleId",roleId);
        map.put("permissionIds",permissionIds);
        permissionService.saveRolePermission(map);
        return Result.returnVal(200, "请求成功");
    }

}
