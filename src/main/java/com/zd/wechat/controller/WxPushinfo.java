package com.zd.wechat.controller;

import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Service;

import com.rabbitmq.client.AMQP;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.Consumer;
import com.rabbitmq.client.DefaultConsumer;
import com.rabbitmq.client.Envelope;
import com.zd.wechat.entity.WechatPushinfo;
import com.zd.wechat.util.BeanUtil;

//rabbit消息推送
@Service
public class WxPushinfo implements ApplicationRunner {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final static String EXCHANGE_NAME = "yc.mq.school.topic";

	@Override
	public void run(ApplicationArguments var1) {
		try {
			Properties prop = PropertiesLoaderUtils.loadAllProperties("rabbit.properties");
			ConnectionFactory factory = new ConnectionFactory();
			factory.setHost(prop.getProperty("rabbit.host"));
			factory.setUsername(prop.getProperty("rabbit.userName"));
			factory.setPassword(prop.getProperty("rabbit.password"));
			Connection connection = factory.newConnection();
			Channel channel = connection.createChannel();

			// 路由关键字
			String routingKeys = "yc.mq.school.eventnotify.*";
			// 绑定路由
			String mqname = "yc.test.mg";
			channel.queueDeclare(mqname, false, false, true, null);
			channel.queueBind(mqname, EXCHANGE_NAME, routingKeys);
			
			if (logger.isDebugEnabled()) {
				logger.debug("消息推送模块初始化成功");
			}

			Consumer consumer = new DefaultConsumer(channel) {
				@Override
				public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties,
						byte[] body) throws IOException {
					String message = new String(body, "UTF-8");
					System.out
							.println("ReceiveLogsTopic1 Received '" + envelope.getRoutingKey() + "':'" + message + "'");
					WechatPushinfo temp = WechatPushinfo.fromJson(message);
					System.out.println(BeanUtil.toStringNotEmpty(temp));
				}
			};
			channel.basicConsume(mqname, true, consumer);
		} catch (Exception e) {
			logger.error("消息推送模块初始化失败:", e);
		}

	}

}
