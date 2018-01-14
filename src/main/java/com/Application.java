package com;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.soecode.wxtools.exception.WxErrorException;


//@ComponentScan(basePackages={"com.zd.wechat"})
//@Configuration
//@EnableAutoConfiguration
@SpringBootApplication
public class Application {
	public static void main(String[] args)
			throws JsonGenerationException, JsonMappingException, IOException, WxErrorException {
		SpringApplication.run(Application.class);

//		IService iService = new WxService();
//
//		String menuJson = "";
//
//		WxMenuResult result = iService.getMenu();
//		menuJson = result.toJson();
//
//		result = WxMenuResult.fromJson(menuJson);
//
//		iService.createMenu(result.getMenu(), false);
	}
}
