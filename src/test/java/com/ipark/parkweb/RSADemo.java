package com.ipark.parkweb;

import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.commons.codec.binary.Base64;

public class RSADemo {
    public static void main(String[] args) throws Exception {
        //加密明文 {"ecifNo":"300123456"}

        //私钥加密密文
        String info = "bjOs9i81vkgSUGJ8AqAmeXPxFYrRyf/aozY/dubzIqDhPtN9n5xy05T4moYXfIFt2Ul/GUA42qbgV//MNxOLnOYQ1wBo49bNc1DO8WjzRYFULVsQyFWwYm5SFr28zIvm5QZrCU/z4mlzmBHOAgLLBux2bvE9fJA3GF/rMRP5I=";
        //公钥字符串
        String publicKeyString = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDivfMMBHgvKJgB7RqVvv-0sLIEF5eEUu-z440Yarc8GBjoa9dHsUohRb1tgyGF6vgw0jVxOruW1nhywRGXWLR8ZdV3TlPPqpSDhoEvLfFf8SwgYcoP1y4QGWq3wvI37wyHQGUe7ibF_HyUsoqbYQYgJffA7SWkTD7E9Qnl_7V96QIDAQAB";
        //公钥解密
        String encryData = decryptString(publicKeyString,info);
        System.out.println("解密后数据："+encryData);
    }

    /**
     * 解密
     *
     * @param publicKeyString
     *            公钥串
     * @param cipherString
     *            密文数据
     * @return
     * @throws Exception
     *             解密过程中的异常信息
     */
    public static String decryptString(String publicKeyString,String cipherString){
        try {
            RSAPublicKey publicKey=getPublicKey(publicKeyString);
            return new String(decryptWithPublicKey(publicKey, Base64.decodeBase64(cipherString.getBytes())));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 从字符串中获得公钥
     *
     * @param publicKeyStr 公钥字符串
     * @return 当前公钥对象s
     * @throws Exception
     */
    public static RSAPublicKey getPublicKey(String publicKeyStr) throws Exception {
        try {
            byte[] buffer = Base64.decodeBase64(publicKeyStr.getBytes());
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(buffer);
            return (RSAPublicKey) keyFactory.generatePublic(keySpec);
        } catch (NoSuchAlgorithmException e) {
            throw new Exception("无此算法");
        } catch (InvalidKeySpecException e) {
            throw new Exception("公钥非法");
        } catch (NullPointerException e) {
            throw new Exception("公钥数据为空");
        }
    }

    /**
     * 解密过程
     *
     * @param publicKey
     *            公钥
     * @param cipherData
     *            密文数据
     * @return 明文
     * @throws Exception
     *             解密过程中的异常信息
     */
    public static byte[] decryptWithPublicKey(RSAPublicKey publicKey, byte[] cipherData) throws Exception {
        if (publicKey == null) {
            throw new Exception("解密公钥为空, 请设置");
        }
        Cipher cipher = null;
        try {


            cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.DECRYPT_MODE, publicKey);
            byte[] output = cipher.doFinal(cipherData);
            return output;
        } catch (NoSuchAlgorithmException e) {
            throw new Exception("无此解密算法");
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
            return null;
        } catch (InvalidKeyException e) {
            throw new Exception("解密公钥非法,请检查");
        } catch (IllegalBlockSizeException e) {
            throw new Exception("密文长度非法");
        } catch (BadPaddingException e) {
            throw new Exception("密文数据已损坏");
        }
    }
}