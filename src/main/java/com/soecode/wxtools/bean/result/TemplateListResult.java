package com.soecode.wxtools.bean.result;

import java.io.IOException;
import java.util.List;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.soecode.wxtools.bean.WxMenu;

/**
 * 获取自身的模板列表
 * @author antgan
 *
 */
public class TemplateListResult {

	private List<TemplateResult> template_list;

	public List<TemplateResult> getTemplate_list() {
		return template_list;
	}

	public void setTemplate_list(List<TemplateResult> template_list) {
		this.template_list = template_list;
	}
	

	/**
	 * json --> obj
	 * 
	 * @param json
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	public static TemplateListResult fromJson(String json) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		return mapper.readValue(json, TemplateListResult.class);
	}
	
	/**
	 * obj --> json
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	public String toJson() throws JsonGenerationException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(this);
	}

	@Override
	public String toString() {
		return "TemplateListResult [template_list=" + template_list + "]";
	}
	
	
}
