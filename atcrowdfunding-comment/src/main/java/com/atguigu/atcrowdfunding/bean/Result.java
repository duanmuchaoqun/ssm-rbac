package com.atguigu.atcrowdfunding.bean;

import java.util.HashMap;

public class Result {

    private Integer code;

    private String message;

    private HashMap<String,Object> data = new HashMap<>();

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public HashMap<String, Object> getData() {
        return data;
    }

    public void setData(HashMap<String, Object> data) {
        this.data = data;
    }

    public static Result returnVal(Integer code,String message){
        Result result = new Result();
        result.code = code;
        result.message = message;
        return result;
    }

    public  Result add(String key,Object value){
         this.getData().put(key,value);
         return this;
    }

}
