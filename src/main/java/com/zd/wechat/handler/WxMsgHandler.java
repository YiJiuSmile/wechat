package com.zd.wechat.handler;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soecode.wxtools.api.IService;
import com.soecode.wxtools.api.WxMessageHandler;
import com.soecode.wxtools.bean.WxXmlMessage;
import com.soecode.wxtools.bean.WxXmlOutMessage;
import com.soecode.wxtools.exception.WxErrorException;
import com.zd.wechat.entity.WechatUser;
import com.zd.wechat.repository.WechatUserRepository;
import com.zd.wechat.util.BeanUtil;

@Service
public class WxMsgHandler implements WxMessageHandler {

	@Autowired
	private WechatUserRepository wechatUserRepository;

	@Override
	public WxXmlOutMessage handle(WxXmlMessage wxMessage, Map context, IService iService) throws WxErrorException {
		// 必须以build()作为结尾，否则不生效。
		System.out.println(BeanUtil.toStringNotEmpty(wxMessage));
		String content = "";
		System.out.println(wxMessage.getEvent());
		switch (wxMessage.getEvent()) {
		case "subscribe":
			content = "你好,欢迎关注此微信";
			break;
		case "unsubscribe":
			content = "解除绑定";
			WechatUser wechatUser = wechatUserRepository.findOne(wxMessage.getFromUserName());
			if (wechatUser != null) {
				wechatUserRepository.delete(wechatUser);
			}
			break;
		}
		WxXmlOutMessage xmlOutMsg = WxXmlOutMessage.TEXT().content(content).toUser(wxMessage.getFromUserName())
				.fromUser(wxMessage.getToUserName()).build();
		return xmlOutMsg;
	}
}
