package com.atguigu.atcrowdfunding.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptionUtils {

    private static EncryptionUtils instance = new EncryptionUtils();

    private EncryptionUtils() {

    }

    public static EncryptionUtils getInstance(){
        return instance;
    }

    /**
     * md5加密
     * @param string
     * @return
     * @throws NoSuchAlgorithmException
     */
    public String md5(String string) throws NoSuchAlgorithmException {
        MessageDigest md5  = MessageDigest.getInstance("MD5");
        md5.update(string.getBytes());
        return new BigInteger(1, md5.digest()).toString(16);
    }
}
