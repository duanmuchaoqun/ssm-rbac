package com.atguigu.atcrowdfunding.web;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ServerStartupListener implements ServletContextListener{

    //web应用初始化之后会被监听到
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //将web应用路径保存到application范围中
        ServletContext application = sce.getServletContext();
        String path = application.getContextPath();
        application.setAttribute("APP_PATH",path);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }

}
