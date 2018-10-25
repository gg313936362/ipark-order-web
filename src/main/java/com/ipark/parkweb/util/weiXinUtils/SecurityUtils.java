package com.ipark.parkweb.util.weiXinUtils;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.SecureRandom;

/**  
* @Author zg 
* @Date 2015年8月29日
* @Comments
*/
public class SecurityUtils {
	private static Logger logger = LogManager.getLogger(SecurityUtils.class);
	private static final String ENCODEING = "UTF-8";
	private static final String ALGORITHM = "AES";//加密算法

	private static final String CIPHER_ALGORITHM = "AES/ECB/PKCS5Padding";//算法/工作模式/填充方式 
	
	/**
	 * 加密
	 * @param plaintext 明文
	 * @param secureKey 16位长度的密钥
	 * @return
	 */
	public static String encrypt(String plaintext, String secureKey) throws Exception{
		SecretKeySpec sks = getSecretKeySpec(secureKey);
		Cipher encryptCipher = getCipher(Cipher.ENCRYPT_MODE, sks);
		byte[] result = encryptCipher.doFinal(plaintext.getBytes(ENCODEING));
		return  Base64.encodeBase64String(result);
	}
	
	/**
	 * 加密
	 * @param bytes 
	 * @param secureKey 16位长度的密钥
	 * @return
	 */
	public static String encryptBytes(byte[] bytes, String secureKey) throws Exception{
		SecretKeySpec sks = getSecretKeySpec(secureKey);
		Cipher encryptCipher = getCipher(Cipher.ENCRYPT_MODE, sks);
		byte[] result = encryptCipher.doFinal(bytes);
		return  Base64.encodeBase64String(result);
	}
	
	/**
	 * 解密
	 * @param ciphertext 密文
	 * @return secureKey 16位长度的密钥
	 * @throws Exception
	 */
	public static String decrypt(String ciphertext, String secureKey) throws Exception {
		SecretKeySpec sks = getSecretKeySpec(secureKey);
		Cipher decryptCiphe = getCipher(Cipher.DECRYPT_MODE, sks);//initDecryptCipher(secureKey);
		byte[] result =  decryptCiphe.doFinal(Base64.decodeBase64(ciphertext));
		return new String(result, ENCODEING);
	}
	
	/**
	 * SHA1
	 * @param plaintext
	 * @return
	 */
	public static String sha1Hex(String plaintext){
		
		return DigestUtils.sha1Hex(plaintext);
	}
	
	/**
	 * 
	 * @author zg
	 * @version v1.0 (2015年9月6日 下午6:57:35)
	 * @param cipherMode “Cipher.ENCRYPT_MODE”或“Cipher.DECRYPT_MODE”
	 * @param sks
	 * @return
	 * @throws Exception
	 */
	private static Cipher getCipher(int cipherMode, SecretKeySpec sks) throws Exception{
		Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
		cipher.init(cipherMode, sks);
		return cipher;
	}
	
	/**
	 * 
	 * @author zg
	 * @version v1.0 (2015年9月7日 下午2:49:25)
	 * @param secureKey 固定16位长度的密钥
	 * @return
	 * @throws Exception
	 */
	private static SecretKeySpec getSecretKeySpec(String secureKey) throws Exception{
		if(secureKey == null || secureKey.trim().equals("") || secureKey.length() != 16){
			throw new Exception("密钥不能为空或密钥长度不对");
		}
		byte[] raw = secureKey.getBytes(ENCODEING);
		SecretKeySpec skeySpec = new SecretKeySpec(raw, ALGORITHM);
		return skeySpec;
	}
	
	public static String encrypt1(String plaintext, String keyRandomSeed) throws Exception{
		SecretKeySpec sks = getSecretKeySpecByRandomSeed(keyRandomSeed);
		Cipher encryptCipher = getCipher(Cipher.ENCRYPT_MODE, sks);
		byte[] result = encryptCipher.doFinal(plaintext.getBytes(ENCODEING));
		return  Base64.encodeBase64String(result);
	}
	
	public static String decrypt1(String ciphertext, String keyRandomSeed) throws Exception {
		SecretKeySpec sks = getSecretKeySpecByRandomSeed(keyRandomSeed);
		Cipher decryptCiphe = getCipher(Cipher.DECRYPT_MODE, sks);//initDecryptCipher(secureKey);
		byte[] result =  decryptCiphe.doFinal(Base64.decodeBase64(ciphertext));
		return new String(result, ENCODEING);
	}
	
	private static SecretKeySpec getSecretKeySpecByRandomSeed(String randomSeed){
		SecretKeySpec sks = null;
		try {
			KeyGenerator kgen = KeyGenerator.getInstance(ALGORITHM);
			//安全随机数生成器 
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");//使用默认的SHA1PRNG算法
			secureRandom.setSeed(randomSeed.getBytes(ENCODEING));
			kgen.init(128, secureRandom); 
			SecretKey secretKey = kgen.generateKey();
			byte[] secretKeyEncoded = secretKey.getEncoded();
			sks = new SecretKeySpec(secretKeyEncoded, ALGORITHM);
		} catch (Exception e) {
			logger.error("",e);
		}
		return sks;
	}
	
	/*public static String encodePwd(String text) throws Exception{
		
		byte[] key = CIPHER_ALGORITHM.getBytes();
		SecretKey secretKey = new SecretKeySpec(key, "HmacSHA224");
		Mac mac = null;
		Security.addProvider(new BouncyCastleProvider());
		mac = (mac == null) ? Mac.getInstance(secretKey.getAlgorithm()) : mac;
		mac.init(secretKey);
		byte[] codedText = mac.doFinal(text.getBytes(ENCODEING));
		return new String(Hex.encode(codedText),ENCODEING);
	}*/
	
	public static void main(String[] args) throws Exception {
		String str = "郑刚ABC";
		/*String secureKey = "faefawf/www.http/sjiowlss";
		String codedStr = encrypt(str, secureKey);
		
		System.out.println(codedStr);
		String decodeStr = decrypt(codedStr, secureKey);
		System.out.println(decodeStr);*/
		
		//String codeStr = "RcvICjFrEGwxN/GLwxzy0tVFwNq3oVmL/dexmVqTd+HKA1DQ5uY4FfJYaOUllyPSfWTJ/DDmubFEvle8w2zqZUe5zTptjbEvJi3tK8psyLnUMncHi9yUw0350a37IctvgNSDgn+huS90MvbKM5w93poBKkqDWzW85Ptpnaz9IGQ=";
	
		//System.out.println(decrypt(codeStr, "com.ipark.annotation.EncryptResponse"));
		
		/*System.out.println(DigestUtils.sha1Hex(str));
		System.out.println(DigestUtils.sha256Hex(str));
		System.out.println(DigestUtils.md5Hex(str));*/
		//String codeStr = encrypt("123", "123");//encrypt("www.gowhere.so", "114fa5f104c42DFBC94FC99192B898D81E02AA76C023/user/login");//encrypt("www.gowhere.so", "1234567890123456");
		//System.out.println(codeStr);
		//System.out.println(decrypt(codeStr, "1234567890123456"));
		//System.out.println(decrypt("2UaRPVNh9lmWW/1nTeIvNw==", "123"));
		//System.out.println(Encrypt("123", "123"));
		
		System.out.println(sha1Hex("123"));
	}

}
 