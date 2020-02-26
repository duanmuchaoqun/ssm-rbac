package com.atguigu.atcrowdfunding.bean;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.util.Date;

public class User {

    private Integer id;

    public User() {
    }

    public User(Integer id, String username, String account, String password, String email, Date createTime, Date updateTime) {
        this.id = id;
        this.username = username;
        this.account = account;
        this.password = password;
        this.email = email;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    @NotBlank
    @Pattern(regexp = "^[a-zA-Z0-9_-]{5,16}$",message = "用户名称5-16位英文字母、数字、下划线的组合！")
    private String username;

    @NotBlank
    @Pattern(regexp = "^[a-zA-Z0-9_-]{5,16}$",message = "登陆账号为5-16位英文字母、数字、下划线的组合！")
    private String account;

    private String password;

    @NotBlank
    @Email
    private String email;

    private Date createTime;

    private Date updateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
