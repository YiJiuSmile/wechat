<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="js/jqueryWeui1.1.2/lib/jquery-2.1.4.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>扫一扫</title>
</head>
<body>
</body>
<script type="text/javascript">
	$(function() {
		var jsApiList=new Array();
		//jsApiList.push("checkJsApi");
		jsApiList.push("scanQRCode");
		$.ajax({
			url : '/wxApi/getJsApi',
			type : "post",
			data:{
				jsApiList:jsApiList
			},
			dataType : "json",
			async : false,
			success : function(config) {
				wx.config({
					debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。  
					appId : config.appid, // 必填，公众号的唯一标识  
					timestamp : config.timestamp, // 必填，生成签名的时间戳  
					nonceStr : config.noncestr, // 必填，生成签名的随机串  
					signature : config.signature,// 必填，签名，见附录1  
					jsApiList : jsApiList
				// 必填，需要使用的JS接口列表，所有JS接口列表见附录2  
				});
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
			}
		})
	})

	wx.error(function(res) {
		alert("出错了：" + res.errMsg);
	});

	wx.ready(function() {
		//扫描二维码  
			wx.scanQRCode({
				needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，  
				scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有  
				success : function(res) {
					var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果  
					alert("扫描成功::扫描码=" + result);
				}
			});
	});//end_ready
</script>
</html>