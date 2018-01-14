package com.zd.wechat.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.soecode.wxtools.api.IService;
import com.soecode.wxtools.api.WxConfig;
import com.soecode.wxtools.api.WxConsts;
import com.soecode.wxtools.api.WxMessageRouter;
import com.soecode.wxtools.bean.TemplateSender;
import com.soecode.wxtools.bean.WxJsapiConfig;
import com.soecode.wxtools.bean.WxUserList.WxUser;
import com.soecode.wxtools.bean.WxUserList.WxUser.WxUserGet;
import com.soecode.wxtools.bean.WxXmlMessage;
import com.soecode.wxtools.bean.WxXmlOutMessage;
import com.soecode.wxtools.bean.result.TemplateSenderResult;
import com.soecode.wxtools.bean.result.WxOAuth2AccessTokenResult;
import com.soecode.wxtools.exception.WxErrorException;
import com.soecode.wxtools.util.xml.XStreamTransformer;
import com.zd.wechat.entity.WechatUser;
import com.zd.wechat.handler.WxMsgHandler;
import com.zd.wechat.repository.WechatUserRepository;

@Controller
@RequestMapping("/wxApi")
public class WxApi implements ApplicationRunner {

	private Map<String, String> variables = new HashMap<String, String>();

	/**
	 * 程序启动自动加载变量 如果不需要自动加载无需实现ApplicationRunner
	 */
	@Override
	public void run(ApplicationArguments var1) throws Exception {
		String schoolName = jdbcTemplate.queryForObject("SELECT SCHOOL_NAME FROM dbo.BASE_T_SCHOOL", String.class);
		variables.put("SCHOOL_NAME", schoolName);
	}

	@Autowired
	private IService iService;

	@Autowired
	private WechatUserRepository wechatUserRepository;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private WxMsgHandler wxMsgHandler;

	// 微信公众号服务器配置认证
	@RequestMapping(value = "auth", method = RequestMethod.GET)
	public void auth(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		String echostr = request.getParameter("echostr");
		if (iService.checkSignature(signature, timestamp, nonce, echostr)) {
			out.print(echostr);
		}
	}

	// 接受微信所有消息(点击按钮,关注等)
	@RequestMapping(value = "auth", method = RequestMethod.POST)
	public void msg(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		// 返回消息给微信服务器
		PrintWriter out = response.getWriter();
		// 获取encrypt_type 消息加解密方式标识
		String encrypt_type = request.getParameter("encrypt_type");
		// 创建一个路由器
		WxMessageRouter router = new WxMessageRouter(iService);
		try {
			// 判断消息加解密方式，如果是加密模式。encrypt_type==aes
			if (encrypt_type != null && "aes".equals(encrypt_type)) {
				// String signature = request.getParameter("signature");
				String timestamp = request.getParameter("timestamp");
				String nonce = request.getParameter("nonce");
				String msg_signature = request.getParameter("msg_signature");
				// 微信服务器推送过来的加密消息是XML格式。使用WxXmlMessage中的decryptMsg()解密得到明文。
				WxXmlMessage wx = WxXmlMessage.decryptMsg(request.getInputStream(), WxConfig.getInstance(), timestamp,
						nonce, msg_signature);
				// 添加规则；这里的规则是指所有消息都交给交给DemoHandler处理
				// 注意！！每一个规则，必须由end()或者next()结束。不然不会生效。
				// end()是指消息进入该规则后不再进入其他规则。 而next()是指消息进入了一个规则后，如果满足其他规则也能进入，处理。
				router.rule().handler(wxMsgHandler).end();
				// 把消息传递给路由器进行处理，得到最后一个handler处理的结果
				WxXmlOutMessage xmlOutMsg = router.route(wx);
				if (xmlOutMsg != null) {
					// 将要返回的消息加密，返回
					out.print(WxXmlOutMessage.encryptMsg(WxConfig.getInstance(), xmlOutMsg.toXml(), timestamp, nonce));// 返回给用户。
				}
				// 如果是明文模式，执行以下语句
			} else {
				// 微信服务器推送过来的是XML格式。
				WxXmlMessage wx = XStreamTransformer.fromXml(WxXmlMessage.class, request.getInputStream());
				// 添加规则；这里的规则是指所有消息都交给DemoHandler处理
				// 注意！！每一个规则，必须由end()或者next()结束。不然不会生效。
				// end()是指消息进入该规则后不再进入其他规则。 而next()是指消息进入了一个规则后，如果满足其他规则也能进入，处理。
				router.rule().handler(wxMsgHandler).end();
				// 把消息传递给路由器进行处理
				WxXmlOutMessage xmlOutMsg = router.route(wx);
				if (xmlOutMsg != null)
					out.print(xmlOutMsg.toXml());// 因为是明文，所以不用加密，直接返回给用户。
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}

	// 微信菜单跳转
	@RequestMapping("jumpTo")
	public void jumpTo(HttpServletRequest request, HttpServletResponse response) throws WxErrorException, IOException {
		// 进入这方法默认跳转到index.jsp,并把这方法获得所有的参数封装到state里
		// jumpTo?url=www.baidu.com --> index.jsp?state=?url=www.baidu.com
		String indexJspPath = "";
		indexJspPath = request.getScheme() + "://" + request.getServerName()
		// + ":" + request.getServerPort()
		// + request.getServletPath()
				+ "/index.jsp";
		String param = "";
		if (request.getQueryString() != null) {
			param = "?" + request.getQueryString();
		}
		// 把index.jsp构建成微信oauth2.0认证地址 微信认证后会重定向到index.jsp 这样就可以获得CODE
		String oauthUrl = iService.oauth2buildAuthorizationUrl(indexJspPath, WxConsts.OAUTH2_SCOPE_USER_INFO, param);
		response.sendRedirect(oauthUrl);
	}

	// 用CODE去换OPENID
	@RequestMapping("getOpenidByCode")
	public @ResponseBody WechatUser getOpenidByCode(HttpServletRequest request, HttpServletResponse response)
			throws WxErrorException {
		String code = request.getParameter("code");
		WxOAuth2AccessTokenResult result = iService.oauth2ToGetAccessToken(code);
		WechatUser wechatUser = wechatUserRepository.findOne(result.getOpenid());
		if (null == wechatUser) {
			wechatUser = new WechatUser();
			wechatUser.setBinding(false);
			wechatUser.setOpenid(result.getOpenid());
		}
		wechatUser.setSchoolName(variables.get("SCHOOL_NAME"));
		return wechatUser;
	}

	// 用户绑定解绑
	@RequestMapping("binding")
	public @ResponseBody WechatUser binding(HttpServletRequest request, HttpServletResponse response)
			throws WxErrorException {
		WechatUser wechatUser = new WechatUser();
		String userNumb = request.getParameter("userNmub");
		String userPwd = request.getParameter("userPwd");
		String sql = "SELECT COUNT(1) FROM dbo.SYS_T_USER WHERE ISDELETE=0 AND USER_NUMB='" + userNumb + "'";
		Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
		if (count == 0) {
			wechatUser.setBinding(false);
			wechatUser.setBindingResult("请检查帐号是否输入正确");
			return wechatUser;
		}
		userPwd = new Sha256Hash(userPwd).toHex();
		sql += " AND USER_PWD='" + userPwd + "'";
		count = jdbcTemplate.queryForObject(sql, Integer.class);
		if (count == 0) {
			wechatUser.setBinding(false);
			wechatUser.setBindingResult("请检查密码是否输入正确");
			return wechatUser;
		}

		sql = sql.replace("COUNT(1)", "USER_ID,XM");
		Map<String, Object> rows = jdbcTemplate.queryForList(sql).get(0);
		String userId = (String) rows.get("USER_ID");
		String userName = (String) rows.get("XM");

		String openid = request.getParameter("openid");
		WxUser user = iService.getUserInfoByOpenId(new WxUserGet(openid, WxConsts.LANG_CHINA));

		wechatUser.setOpenid(request.getParameter("openid"));
		wechatUser.setCity(user.getCity());
		wechatUser.setNickname(user.getNickname());
		wechatUser.setProvince(user.getProvince());
		wechatUser.setSex(user.getSex());
		wechatUser.setSubscribe(user.getSubscribe());
		wechatUser.setSubscribe_time(user.getSubscribe_time());
		wechatUser.setUserId(userId);
		wechatUser.setUserName(userName);
		wechatUser.setUserNumb(userNumb);

		String bindingType = request.getParameter("bindingType");
		if (bindingType.equals("1")) {
			wechatUserRepository.save(wechatUser);
			wechatUser.setBindingResult("绑定成功");
		} else {
			wechatUser = wechatUserRepository.findOne(wechatUser.getOpenid());
			wechatUserRepository.delete(wechatUser);
			wechatUser.setBindingResult("解绑成功");
		}
		return wechatUser;
	}

	@RequestMapping("templateSender")
	public void templateSender(HttpServletRequest request, HttpServletResponse response) throws IOException {
		TreeMap<String, TreeMap<String, String>> params = new TreeMap<String, TreeMap<String, String>>();
		// 根据具体模板参数组装
		params.put("first", item("first", "#000000"));
		params.put("keyword1", item("keyword1", "#000000"));
		params.put("keyword2", item("keyword1", "#000000"));
		params.put("remark", item("remark", "#000000"));
		TemplateSender sender = new TemplateSender();
		sender.setTouser("ogK2qxPKnDZ6wqfWUdiQ9gRiN1hM");
		sender.setTemplate_id("vALFSZG6KZonQ8ZEoHtMsC_x3c7nJY74Z0G9oYJR9VM");
		sender.setData(params);
		sender.setUrl("http://www.baidu.com");
		try {
			TemplateSenderResult result = iService.templateSend(sender);
			System.out.println(result.toString());
		} catch (WxErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.println("发送成功");
	}

	@RequestMapping("getJsApi")
	public @ResponseBody WxJsapiConfig getJsApi(HttpServletRequest request, HttpServletResponse response) {
		List<String> jsApiList = new ArrayList<String>();
		String jssdkUrl = request.getHeader("Referer");
		System.out.println(jssdkUrl);
		// 需要用到哪些JS SDK API 就设置哪些
		jsApiList.add("checkJsApi");// 拍照或从手机相册中选图接口
		jsApiList.add("scanQRCode");// 获取“分享到QQ空间”按钮点击状态及自定义分享内容接口
		try {
			// 把config返回到前端进行js调用即可。
			WxJsapiConfig config = iService.createJsapiConfig(jssdkUrl, jsApiList);
			return config;
		} catch (WxErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	public TreeMap<String, String> item(String value, String color) {
		TreeMap<String, String> params = new TreeMap<String, String>();
		params.put("value", value);
		params.put("color", color);
		return params;
	}

}
