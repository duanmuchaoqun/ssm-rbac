package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Result;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.service.UserService;
import com.atguigu.atcrowdfunding.utils.EncryptionUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.NoSuchAlgorithmException;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    private EncryptionUtils encryptionUtils = EncryptionUtils.getInstance();

    private Integer pageSize = 10;

    /**
     * @param pageNum
     * @param user
     * @param model
     * @return String
     */
    @RequestMapping("/index")
    public String index(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum, User user, Model model) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> list = userService.getUserList(user);
        PageInfo<User> pageInfo = new PageInfo<>(list, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "user/index";
    }

    @RequestMapping("/add")
    public String add() {
        return "user/add";
    }

    @ResponseBody
    @RequestMapping("/saveUser")
    public Result saveUser(User user) {
        Date date = new Date();
        user.setCreateTime(date);
        user.setUpdateTime(date);
        String password = "123456";
        try {
            String md5 = encryptionUtils.md5(password);
            user.setPassword(md5);
            userService.saveUser(user);
            return Result.returnVal(200, "请求成功");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return Result.returnVal(201, "请求失败," + e.getMessage());
        }
    }

    @RequestMapping("/edit")
    public String edit(@RequestParam("id") Integer id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "user/edit";
    }

    @ResponseBody
    @RequestMapping("/updateUser")
    public Result updateUser(User user) {
        User dbUser = userService.getUserById(user.getId());
        if (dbUser == null) {
            return Result.returnVal(201, "用户不存在");
        } else {
            Date date = new Date();
            user.setUpdateTime(date);
            userService.updateUser(user);
            return Result.returnVal(200, "请求成功");
        }
    }

    @ResponseBody
    @RequestMapping("/deleteUser")
    public Result deleteUser(@RequestParam(value = "ids") String ids) {
        if (ids == null) {
            return Result.returnVal(201, "缺少重要数据");
        }
        //批量删除
        if(ids.contains("-")){
            String[] strIds = ids.split("-");
            ArrayList<Integer> del_ids = new ArrayList<>();
            for (String strId : strIds) {
                int id = Integer.parseInt(strId);
                del_ids.add(id);
            }
            userService.deleteBatch(del_ids);
            return Result.returnVal(200, "删除成功");
        }else{
            Integer id = Integer.parseInt(ids);
            userService.deleteUser(id);
            return Result.returnVal(200, "删除成功");
        }
    }


}
