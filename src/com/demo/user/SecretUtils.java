package com.demo.user;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
 
public class SecretUtils {
	
	
	 /** 
     * 进行MD5加密 
     *  
     * @param info 
     *            要加密的信息 
     * @return String 加密后的字符串 
     */  
    public static String encryptToMD5(String info) {  
        byte[] digesta = null;  
        try {  
            // 得到一个md5的消息摘要  
            MessageDigest alga = MessageDigest.getInstance("MD5");  
            // 添加要进行计算摘要的信息  
            alga.update(info.getBytes());  
            // 得到该摘要  
            digesta = alga.digest();  
        } catch (NoSuchAlgorithmException e) {  
            e.printStackTrace();  
        }  
        // 将摘要转为字符串  
        String rs = byte2hex(digesta);  
        return rs;  
    }  
	
	
    /** 
     * 将二进制转化为16进制字符串 
     *  
     * @param b 
     *            二进制字节数组 
     * @return String 
     */  
    public static String byte2hex(byte[] b) {  
        String hs = "";  
        String stmp = "";  
        for (int n = 0; n < b.length; n++) {  
            stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));  
            if (stmp.length() == 1) {  
                hs = hs + "0" + stmp;  
            } else {  
                hs = hs + stmp;  
            }  
        }  
        return hs.toUpperCase();  
    }  
    /** 
     * 十六进制字符串转化为2进制 
     *  
     * @param hex 
     * @return 
     */  
    public static byte[] hex2byte(String hex) {  
        byte[] ret = new byte[8];  
        byte[] tmp = hex.getBytes();  
        for (int i = 0; i < 8; i++) {  
            ret[i] = uniteBytes(tmp[i * 2], tmp[i * 2 + 1]);  
        }  
        return ret;  
    }  
	
    
    /** 
     * 将两个ASCII字符合成一个字节； 如："EF"--> 0xEF 
     *  
     * @param src0 
     *            byte 
     * @param src1 
     *            byte 
     * @return byte 
     */  
    public static byte uniteBytes(byte src0, byte src1) {  
        byte _b0 = Byte.decode("0x" + new String(new byte[] { src0 }))  
                .byteValue();  
        _b0 = (byte) (_b0 << 4);  
        byte _b1 = Byte.decode("0x" + new String(new byte[] { src1 }))  
                .byteValue();  
        byte ret = (byte) (_b0 ^ _b1);  
        return ret;  
    }  
    
	//定义加密算法，有DES、DESede(即3DES)、Blowfish
    private static final String Algorithm = "DESede";    
    private static final String PASSWORD_CRYPT_KEY = "QWERTYUIOKMNJjjlsjdioueworjwerjw123123980l";
    
    
    /**
     * 加密方法
     * @param src 源数据的字节数组
     * @return 
     */
    public static byte[] encryptMode(byte[] src) {
        try {
             SecretKey deskey = new SecretKeySpec(build3DesKey(PASSWORD_CRYPT_KEY), Algorithm);    //生成密钥
             Cipher c1 = Cipher.getInstance(Algorithm);    //实例化负责加密/解密的Cipher工具类
             c1.init(Cipher.ENCRYPT_MODE, deskey);    //初始化为加密模式
             return c1.doFinal(src);
         } catch (java.security.NoSuchAlgorithmException e1) {
             e1.printStackTrace();
         } catch (javax.crypto.NoSuchPaddingException e2) {
             e2.printStackTrace();
         } catch (java.lang.Exception e3) {
             e3.printStackTrace();
         }
         return null;
     }
    
    
    /**
     * 解密函数
     * @param src 密文的字节数组
     * @return
     */
    public static byte[] decryptMode(byte[] src) {      
        try {
            SecretKey deskey = new SecretKeySpec(build3DesKey(PASSWORD_CRYPT_KEY), Algorithm);
            Cipher c1 = Cipher.getInstance(Algorithm);
            c1.init(Cipher.DECRYPT_MODE, deskey);    //初始化为解密模式
            return c1.doFinal(src);
        } catch (java.security.NoSuchAlgorithmException e1) {
            e1.printStackTrace();
        } catch (javax.crypto.NoSuchPaddingException e2) {
            e2.printStackTrace();
        } catch (java.lang.Exception e3) {
            e3.printStackTrace();
        }
        return null;
     }
    
    
    /*
     * 根据字符串生成密钥字节数组 
     * @param keyStr 密钥字符串
     * @return 
     * @throws UnsupportedEncodingException
     */
    public static byte[] build3DesKey(String keyStr) throws UnsupportedEncodingException{
        byte[] key = new byte[24];    //声明一个24位的字节数组，默认里面都是0
        byte[] temp = keyStr.getBytes("UTF-8");    //将字符串转成字节数组
        
        /*
         * 执行数组拷贝
         * System.arraycopy(源数组，从源数组哪里开始拷贝，目标数组，拷贝多少位)
         */
        if(key.length > temp.length){
            //如果temp不够24位，则拷贝temp数组整个长度的内容到key数组中
            System.arraycopy(temp, 0, key, 0, temp.length);
        }else{
            //如果temp大于24位，则拷贝temp数组24个长度的内容到key数组中
            System.arraycopy(temp, 0, key, 0, key.length);
        }
        return key;
    } 
    
    public static void main(String[] args) {
        String msg = "3DES加密解密案例";
        System.out.println("【加密前】：" + msg);
        
        //加密
        byte[] secretArr = SecretUtils.encryptMode(msg.getBytes());    
        System.out.println("【加密后】：" + new String(secretArr));
        
        //解密
        byte[] myMsgArr = SecretUtils.decryptMode(secretArr);  
        System.out.println("【解密后】：" + new String(myMsgArr));
    }
}
