<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/weui.min.css">
<link rel="stylesheet" href="js/jqueryWeui1.1.2/css/jquery-weui.min.css">
<script src="js/jqueryWeui1.1.2/lib/jquery-2.1.4.js"></script>
<script src="js/jqueryWeui1.1.2/js/jquery-weui.min.js"></script>
<title></title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
</head>
<body>
	<input type="hidden" name="code" id="code"
		value="<%=request.getParameter("code")%>" />
	<input type="hidden" name="state" id="state"
		value="<%=request.getParameter("state")%>" />
	<form action="binding.jsp" method="post" id="myForm">
		<input type="hidden" name="bindingType" id="bindingType" /> <input
			type="hidden" name="openid" id="openid" /> <input type="hidden"
			name="url" id="url" /><input type="hidden" name="schoolName"
			id="schoolName" /> <input type="hidden" name="userNumb"
			id="userNumb" />
	</form>
</body>
<script type="text/javascript">
	function getQueryStringByName(name) {
		var result = $("#state").val().match(
				new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
		if (result == null || result.length < 1) {
			return "";
		}
		return result[1];
	}
	$(function() {
		//微信跳转到这页会传一个CODE过来(CODE只能使用一次),用这个CODE换取OPENID
		$.ajax({
			url : '/wxApi/getOpenidByCode',
			type : "post",
			dataType : "json",
			data : "code=" + $("#code").val(),
			async : false,
			success : function(wxUser) {
				var url = getQueryStringByName("url");
				if (wxUser.binding) {
					if (url.indexOf("binding.jsp") != -1) {
						$("#bindingType").val("2");
						$("#url").val(url);
						$("#openid").val(wxUser.openid);
						$("#schoolName").val(wxUser.schoolName);
						$("#userNumb").val(wxUser.userNumb);
						$("#myForm").submit();
					} else {
						if (url.indexOf("?") != -1) {
							url += "&userid=" + wxUser.userId + "&userNumb="
									+ wxUser.userNumb;
						} else {
							url += "?userid=" + wxUser.userId + "&userNumb="
									+ wxUser.userNumb;
						}
						location = url;
					}
				} else {
					$("#bindingType").val("1");
					$("#url").val(url);
					$("#openid").val(wxUser.openid);
					$("#schoolName").val(wxUser.schoolName);
					$("#myForm").submit();
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
			}
		})
	})
</script>
</html>
