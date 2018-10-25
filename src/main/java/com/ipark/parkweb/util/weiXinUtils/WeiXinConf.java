package com.ipark.parkweb.util.weiXinUtils;

/**
 * ΢微信动态信息存储
 * @author wangcheng
 *
 */
public class WeiXinConf {

	private String accessToken;
	
	private long accessTokenTime;
	
	private String jsapiTicket;
	
	private long jsapiTicketTime;

	public String getJsapiTicket() {
		return jsapiTicket;
	}

	public void setJsapiTicket(String jsapiTicket) {
		this.jsapiTicket = jsapiTicket;
	}

	public Long getJsapiTicketTime() {
		return jsapiTicketTime;
	}

	public void setJsapiTicketTime(Long jsapiTicketTime) {
		this.jsapiTicketTime = jsapiTicketTime;
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public Long getAccessTokenTime() {
		return accessTokenTime;
	}

	public void setAccessTokenTime(Long accessTokenTime) {
		this.accessTokenTime = accessTokenTime;
	}

	
}
