<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="js/jqueryWeui1.1.2/lib/jquery-2.1.4.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title></title>
</head>
<body>
<input type="button" value="扫一扫" id="scanQRCode"  
        style="width: 3rem; height: 3rem;" />  
    <input type="text" id="sousuoid" placeholder="请输入商品关键字" name="ssnr">  
</body>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : '/wxApi/getJsApi',
			type : "post",
			dataType : "json",
			async : false,
			success : function(config) {
				wx.config({
					debug : true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。  
					appId : config.appid, // 必填，公众号的唯一标识  
					timestamp : config.timestamp, // 必填，生成签名的时间戳  
					nonceStr : config.noncestr, // 必填，生成签名的随机串  
					signature : config.signature,// 必填，签名，见附录1  
					jsApiList : [ 'checkJsApi', 'scanQRCode' ] 
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
		wx.checkJsApi({
			jsApiList : [ 'scanQRCode' ],
			success : function(res) {
			}
		});

		//扫描二维码  
		document.querySelector('#scanQRCode').onclick = function() {
			wx.scanQRCode({
				needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，  
				scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有  
				success : function(res) {
					var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果  
					alert("扫描成功::扫描码=" + result);
					document.getElementById("wm_id").value = result;//将扫描的结果赋予到jsp对应值上  
					alert("扫描成功::扫描码=" + result);
				}
			});
		};//end_document_scanQRCode  

	});//end_ready
</script>
</html>