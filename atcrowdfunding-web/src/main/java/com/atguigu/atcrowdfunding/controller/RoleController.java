package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Result;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    private Integer pageSize = 10;

    @RequestMapping("/index")
    public String roles(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum, Role role, Model model){
        PageHelper.startPage(pageNum,pageSize);
        List<Role> roles = roleService.getRoleList(role);
        PageInfo<Role> pageInfo = new PageInfo<>(roles, 5);
        model.addAttribute("pageInfo",pageInfo);
        return "role/index";
    }


    @RequestMapping("/assign")
    public String assignRole(Integer id, Model model){
        List<Integer> userRoleIds = roleService.getUserRoleIdList(id);
        List<Role> roles = roleService.getRoleList(null);
        // 未选中角色
        ArrayList<Role> unAssignRole = new ArrayList<>();
        //已选中角色
        ArrayList<Role> assignRole = new ArrayList<>();
        for (Role role : roles) {
            if(!userRoleIds.contains(role.getId())){
                unAssignRole.add(role);
            } else {
                assignRole.add(role);
            }
        }
        model.addAttribute("unAssignRole",unAssignRole);
        model.addAttribute("assignRole",assignRole);
        return "role/assign";
    }

    @ResponseBody
    @RequestMapping("/doAssignRole")
    public Result doAssignRole(Integer userId, Integer[] unAssignRoleIds){
        if(userId == null){
            return Result.returnVal(201,"缺少用户id");
        }
        if(unAssignRoleIds == null){
            return Result.returnVal(201,"请选择分配角色");
        }
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("roleIds",unAssignRoleIds);
        roleService.saveUserRole(map);
        return Result.returnVal(200,"分配成功");
    }

    @ResponseBody
    @RequestMapping("/doUnAssignRole")
    public Result doUnAssignRole(Integer userId,Integer[] assignRoleIds){
        if(userId == null){
            return Result.returnVal(201,"缺少用户id");
        }
        if(assignRoleIds == null){
            return Result.returnVal(201,"请选择分配角色");
        }
        Map<String, Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("roleIds",assignRoleIds);
        roleService.deleteUserRole(map);
        return Result.returnVal(200,"分配成功");
    }



    @RequestMapping("/addRoles")
    public String addRoles(){
        return "role/add";
    }

    @RequestMapping("/edit")
    public String editRoles(Integer id,Model model){
        Role role = roleService.getRoleById(id);
        model.addAttribute("role",role);
        return "role/edit";
    }

    @ResponseBody
    @RequestMapping("saveRole")
    public Result saveRole(Role role){
        roleService.saveRole(role);
        return Result.returnVal(200,"请求成功");
    }

    @ResponseBody
    @RequestMapping("updateRole")
    public Result updateRole(Role role){
        roleService.updateRole(role);
        return Result.returnVal(200,"请求成功");
    }
}
