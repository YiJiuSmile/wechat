package com.zd.wechat.util;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.util.EntityUtils;

public class HttpUtil {

	static CloseableHttpClient httpClient;

	static {
		PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
		cm.setMaxTotal(500);
		cm.setDefaultMaxPerRoute(200);
		httpClient = HttpClients.custom().setConnectionManager(cm).build();
	}

	public static String get(String url) {
		CloseableHttpResponse response = null;
		String result = "";
		try {
			HttpGet httpGet = new HttpGet(url);
			response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, "utf-8");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != response)
					response.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public static String post(String url, String json) {
		CloseableHttpResponse response = null;
		String result = "";
		try {
			HttpPost httppost = new HttpPost(url);
			httppost.setHeader("Content-Type", "application/json-patch+json");
			StringEntity se = new StringEntity(json);
			httppost.setEntity(se);
			response = httpClient.execute(httppost);
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, "utf-8");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != response)
					response.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
