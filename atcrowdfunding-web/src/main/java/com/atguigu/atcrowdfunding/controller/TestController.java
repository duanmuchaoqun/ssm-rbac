package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/test")
public class TestController {

    @Autowired
    private UserService userService;

    @RequestMapping("/index")
    public String index(){
        return "site/index";
    }


    @ResponseBody
    @RequestMapping("/json")
    public Object json(){
        HashMap<String, Object> map = new HashMap<>();
        map.put("code",200);
        map.put("message","success");
        return map;
    }


    @ResponseBody
    @RequestMapping("/getAll")
    public Object getAll(){
        List<User> list = userService.getAll();
        HashMap<String, Object> map = new HashMap<>();
        map.put("list",list);
        return map;
    }

}
