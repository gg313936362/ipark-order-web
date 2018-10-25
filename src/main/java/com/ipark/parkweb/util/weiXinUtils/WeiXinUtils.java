package com.ipark.parkweb.util.weiXinUtils;

/**
 * 微信公共方法
 * @author wangcheng
 *
 */
public class WeiXinUtils {

//    private static final Logger logger = LogManager.getLogger(WeiXinUtils.class);
//
//    private static final String ENCODEING = "UTF-8";
//
//    private static final String GET = "GET";
//
//    private static final String POST = "POST";
//
//	private static WeiXinConf weiXinConf = new WeiXinConf();
//
//	public final static String WEIXIN_APP_ID = SysConf.WEIXIN_APP_ID;
//
//	private final static String WEIXIN_APP_SECRET = SysConf.WEIXIN_APP_SECRET;
//
//    private final static ObjectMapper om = new ObjectMapper();
//
//    /**
//     * 微信发送客服信息
//     * @param openid
//     * @param content
//     */
//    public static void sendMessage(String openid, String content){
//        String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=";
//        try {
//            initAccessToken();//微信accessToken初始化
//            Map<String, Object> data = new HashMap<String, Object>();
//            data.put("touser", openid);
//            data.put("msgtype", "text");
//            Map<String, Object> text = new HashMap<String, Object>();
//            text.put("content", content);
//            data.put("text", text);
//            String result = send(url + weiXinConf.getAccessToken(), POST, om.writeValueAsString(data));
//        } catch (Exception e) {
//            logger.error("微信发送客服信息出错", e);
//        }
//    }
//
//    /**
//     * 获取openid
//     * @param code
//     * @return
//     */
//    public static String getOpenid(String code){
//        String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WEIXIN_APP_ID + "&secret="
//                + WEIXIN_APP_SECRET + "&code=" + code + "&grant_type=authorization_code";
//        try {
//            String result = send(url, GET, null);
//            Map resultMap = om.readValue(result, Map.class);
//            return (String) resultMap.get("openid");
//        } catch (Exception e) {
//            logger.error("微信openId获取出错", e);
//        }
//        return "";
//    }
//
//    /**
//     * 微信accessToken初始化
//     */
//    private static void initAccessToken(){
//        String accessTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="
//                + WEIXIN_APP_ID + "&secret=" + WEIXIN_APP_SECRET;
//        try {
//            long requestTime = System.currentTimeMillis();
//            if (requestTime >= weiXinConf.getAccessTokenTime()){//过期
//                String result = send(accessTokenUrl, GET, null);
//                Map tokenMap = om.readValue(result, Map.class);
//                weiXinConf.setAccessToken((String) tokenMap.get("access_token"));
//                int accessTokenTime = Integer.parseInt(tokenMap.get("expires_in").toString());
//                weiXinConf.setAccessTokenTime(requestTime + (accessTokenTime * 1000));
//            }
//        } catch (Exception e) {
//            logger.error("微信accessToken初始化出错", e);
//        }
//    }
//
//    /**
//     * 微信jsapi凭证初始化
//     */
//	private static void initJsapiTicket(){
//        String jsapiTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token=";
//		try {
//            initAccessToken();//微信accessToken初始化
//			long requestTime = System.currentTimeMillis();
//			String result = send(jsapiTicketUrl + weiXinConf.getAccessToken(), GET, null);
//	        Map tokenMap = om.readValue(result, Map.class);
//            weiXinConf.setJsapiTicket((String) tokenMap.get("ticket"));
//	        int jsapiTicketTime = Integer.parseInt(tokenMap.get("expires_in").toString());
//            weiXinConf.setJsapiTicketTime(requestTime + (jsapiTicketTime * 1000));
//		} catch (Exception e) {
//			logger.error("微信jsapi凭证初始化出错", e);
//		}
//	}
//
//    /**
//     * 微信jsapi生成凭证
//     * @param request
//     * @return
//     */
//	public static JsapiParam getSign(HttpServletRequest request){
//        JsapiParam jsapiParam = new JsapiParam();
//		long requestTime = System.currentTimeMillis();
//		if (requestTime >= weiXinConf.getJsapiTicketTime()){//过期
//            initJsapiTicket();
//		}
//        jsapiParam.setAppId(WEIXIN_APP_ID);
//        String noncestr = createNoncestr();
//        jsapiParam.setNonceStr(noncestr);
//        jsapiParam.setTimestamp(requestTime);
//		StringBuffer encryptString = new StringBuffer();
//		encryptString.append("jsapi_ticket=");
//		encryptString.append(weiXinConf.getJsapiTicket());
//		encryptString.append("&noncestr=");
//		encryptString.append(noncestr);
//		encryptString.append("&timestamp=");
//		encryptString.append(requestTime);
//		encryptString.append("&url=");
//        String url = SysConf.WX_ADDRESS + request.getServletPath();
//        if (request.getQueryString() != null){
//            url += "?" + request.getQueryString();
//        }
//        encryptString.append(url);
//        logger.info("jsapi生成签名原始字符串：" + encryptString.toString());
//        jsapiParam.setSignature(SHA1(encryptString.toString()));
//        logger.info("jsapi生成的签名：" + jsapiParam.getSignature());
//        return jsapiParam;
//	}
//
//    private static String createNoncestr(){
//        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//        StringBuffer noncestr = new StringBuffer("");
//        for (int i = 0; i < 16; i++){
//            noncestr.append(chars.charAt((int) (Math.random() * (chars.length()-1))));
//        }
//        return noncestr.toString();
//    }
//
//	private static String send(String reqUrl, String mothod, String content) throws Exception {
//        String resContent = null;
//
//        HttpURLConnection conn = null;
//        InputStream in = null;
//        BufferedReader reader = null;
//        try {
//            logger.info("向微信发送请求：" + reqUrl);
//            boolean postMethod = false;
//            if(POST.equals(mothod)){
//                postMethod = true;
//            }
//            URL url = new URL(reqUrl);
//            conn = (HttpURLConnection) url.openConnection();
//            conn.setConnectTimeout(10000);
//            conn.setReadTimeout(10000);
//            conn.setDoOutput(postMethod);
//            conn.setDoInput(true);
//            conn.setUseCaches(false);
//            conn.setInstanceFollowRedirects(false);//是否自动处理重定向
//            conn.setRequestMethod(mothod);
//            conn.setRequestProperty("connection", "Keep-Alive");
//            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");//传递参数使用 &链接的表单提交方式
//            conn.connect();
//            if (postMethod && StringUtils.hasText(content)){
//                logger.info("向微信发送post请求发送数据：" + content);
//                OutputStream out = conn.getOutputStream();
//                byte[] reqData = content.getBytes(ENCODEING);
//                out.write(reqData);
//                out.flush();
//                out.close();
//            }
//
//            int resCode = conn.getResponseCode();
//            if(resCode == 200){
//                in = conn.getInputStream();
//                reader = new BufferedReader(new InputStreamReader(in, ENCODEING));
//                resContent = reader.readLine();
//                logger.info("微信返回：" + resContent);
//            }else{
//                logger.error("微信服务器返回码" + resCode);
//            }
//        } catch (Exception e) {
//            logger.error("url:{},reqContent:{},method:{},", reqUrl, e);
//            throw e;
//        } finally{
//            if(reader != null){
//                reader.close();
//            }
//            if(in != null){
//                try {
//                    in.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//            if(conn != null){
//                conn.disconnect();
//            }
//        }
//        return resContent;
//    }
//
//	private static String SHA1(String decript) {
//        try {
//            MessageDigest digest = MessageDigest
//                    .getInstance("SHA-1");
//            digest.update(decript.getBytes());
//            byte messageDigest[] = digest.digest();
//            // Create Hex String
//            StringBuffer hexString = new StringBuffer();
//            //字节数组转换为十六进制数
//            for (int i = 0; i < messageDigest.length; i++) {
//                String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
//                if (shaHex.length() < 2) {
//                    hexString.append(0);
//                }
//                hexString.append(shaHex);
//            }
//            return hexString.toString();
//
//        } catch (NoSuchAlgorithmException e) {
//            e.printStackTrace();
//        }
//        return "";
//    }
}
