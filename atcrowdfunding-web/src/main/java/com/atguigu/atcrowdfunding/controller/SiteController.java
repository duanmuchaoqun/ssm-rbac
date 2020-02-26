package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Result;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.service.PermissionService;
import com.atguigu.atcrowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/site")
public class SiteController {

    @Autowired
    private UserService userService;

    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/index")
    public String index(){
        return "site/index";
    }

    @RequestMapping("/login")
    public String login(){
        return "site/login";
    }

    @ResponseBody
    @RequestMapping("/doLogin")
    public Result doLogin(User user, HttpServletRequest request) {

        User dbUser = null;
        try {
            dbUser = userService.getForLogin(user);
            if(dbUser != null){
                //session存储
                HttpSession session = request.getSession();
                session.setAttribute("user",dbUser);
                //获取用户权限菜单
                List<Permission> ps = permissionService.getPermissionByUser(dbUser);
                Permission root = null;
                Map<Integer,Permission> permissionMap = new HashMap<>();
                for (Permission p : ps) {
                    permissionMap.put(p.getId(),p);
                }
                for (Permission p : ps) {
                    Permission child = p;
                    if(child.getPid() == 0){
                        root = child;
                    }else{
                        Permission parent = permissionMap.get(child.getPid());
                        parent.getChildren().add(child);
                    }
                }
                session.setAttribute("rootPermission",root);
                return Result.returnVal(200,"请求成功");
            } else {
                return Result.returnVal(201,"请求成功").add("errorMsg","用户名或者密码错误");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.returnVal(201,"请求成功").add("errorMsg",e.getMessage());
        }
    }



}
