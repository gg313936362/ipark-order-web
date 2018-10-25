package com.ipark.parkweb.util;

/**
 * Created by wangcheng on 2017/2/22.
 */
public interface Constants {

    //接入平台类型
    public static  interface webSourcePlatType {
        public static final int WE_CHAT_PLAT = 1;//微信接入
        public static final int ALIPAY_PLAT = 2;//支付宝生活号接入
        public static final int WE_CHAT_MYSELF_OPENID_PLAT = 3;//微信公众号接入，我方生成openid
        public static final int SHBANK = 4;//上海银行接入
    }

    //临停支付方式
    public static  interface payWay {
        public static final int BALANCE_PAY = 3;//账户余额支付
        public static final int WECHAT_PAY = 4;//微信公众号支付
        public static final int ALI_PAY = 7;//支付宝网页支付
    }

    //包月支付方式
    public static  interface orderPayWay {
        public static final int BALANCE_PAY = 1;//账户余额支付
        public static final int WECHAT_PAY = 5;//微信公众号支付
        public static final int ALI_PAY = 6;//支付宝网页支付
    }
}
