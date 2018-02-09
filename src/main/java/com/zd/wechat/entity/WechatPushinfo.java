package com.zd.wechat.entity;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;


public class WechatPushinfo {

	private String action;
	private long customerId;
	private Message message;
	private String messageType;
	private String program;
	private String systemType;

	public void setAction(String action) {
		this.action = action;
	}

	public String getAction() {
		return action;
	}

	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}

	public long getCustomerId() {
		return customerId;
	}

	public void setMessage(Message message) {
		this.message = message;
	}

	public Message getMessage() {
		return message;
	}

	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}

	public String getMessageType() {
		return messageType;
	}

	public void setProgram(String program) {
		this.program = program;
	}

	public String getProgram() {
		return program;
	}

	public void setSystemType(String systemType) {
		this.systemType = systemType;
	}

	public String getSystemType() {
		return systemType;
	}

	public class Message {

		private String employeeStrId;
		private String first;
		private String openId;
		private String remark;
		private String schedule;
		private Date time;
		private String url;

		public void setEmployeeStrId(String employeeStrId) {
			this.employeeStrId = employeeStrId;
		}

		public String getEmployeeStrId() {
			return employeeStrId;
		}

		public void setFirst(String first) {
			this.first = first;
		}

		public String getFirst() {
			return first;
		}

		public void setOpenId(String openId) {
			this.openId = openId;
		}

		public String getOpenId() {
			return openId;
		}

		public void setRemark(String remark) {
			this.remark = remark;
		}

		public String getRemark() {
			return remark;
		}

		public void setSchedule(String schedule) {
			this.schedule = schedule;
		}

		public String getSchedule() {
			return schedule;
		}

		public void setTime(Date time) {
			this.time = time;
		}

		public Date getTime() {
			return time;
		}

		public void setUrl(String url) {
			this.url = url;
		}

		public String getUrl() {
			return url;
		}

	}
	
	public static WechatPushinfo fromJson(String json) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
		return mapper.readValue(json, WechatPushinfo.class);
	}
}