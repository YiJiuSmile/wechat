package wechattest;

import com.zd.wechat.util.HttpUtil;

public class test {
	public static void main(String[] args) {
		//for (int i = 0; i < 100; i++) {
			long s=System.currentTimeMillis();
			System.out.println("开始读取");
			String urlData = HttpUtil.get("http://qr04.cn/CU9cer");
	        int jump_urlS=urlData.indexOf("jump_url=\"")+"jump_url=\"".length();
	        String jump_url=urlData.substring(jump_urlS, urlData.lastIndexOf("\";"));
	        jump_url=HttpUtil.get(jump_url);
	        String xh=jump_url.substring(jump_url.indexOf("<p>")+3,jump_url.lastIndexOf("</p></span></div>"));
			long e=System.currentTimeMillis();
			System.out.println(e-s);
		//}
	}
}
