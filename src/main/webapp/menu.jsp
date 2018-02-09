<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Baiduspider" content="noarchive">
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="微信工具·微信辅助开发·微信自定义菜单编辑器是菜网酷开发的用于编辑微信公众号，企业号应用自定义菜单的工具，可直接获取现有菜单编辑并在线发布。">
<meta name="keywords"
	content="微信工具·微信,微信公众号菜单编辑工具,微信自定义菜单,微信自定义菜单编辑工具,微信自定义菜单在线生成发布,微信自定义菜单发布,WeChat Debugger">
<meta name="baidu-site-verification" content="fVhujlAX5A" />
<title>微信自定义菜单编辑工具</title>
<link
	href="resources/menu/css.css?v=WT-MXlgMuKJEz0AaMo5tvRCXFJ6NuUIodYM-g7ad67g1"
	rel="stylesheet" />
<script
	src="resources/menu/modernizr?v=wBEWDufH_8Md-Pbioxomt90vm6tJN2Pyy9u9zHtWsPo1"></script>
<script
	src="resources/menu/jquery?v=KY9BHUWoPLAubCgqCoIrGsFA9UXyHgahbA1q4c5slgI1"></script>
<link href="resources/menu/menu.css" rel="stylesheet" />
</head>
<body>
	<link href="resources/menu/loading.css" rel="stylesheet" />
	<div class="mask" id="loadingDiv">
		<div class="centerAll">
			<div class="spinner" style="margin: 0px;">
				<div class="bounce1"></div>
				<div class="bounce2"></div>
				<div class="bounce3"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.extend({
				LoadingShow : function() {
					$("#loadingDiv").show();
				},
				LoadingHide : function() {
					(function(e) {
						$(e).children().fadeOut(function() {
							$(e).fadeOut();
						});
					})($("#loadingDiv"));
				}
			});
		});
	</script>

	<div class="container body-content">
		<div class="row">
			<h3>微信自定义菜单编辑工具</h3>
			<hr />
			
			<ol class="breadcrumb">
				<li class="active">微信工具</li>
				<li class="active">微信自定义菜单编辑工具</li>
			</ol>
			<div class="panel panel-default" id="divMain" >
				<div class="panel-heading" style="min-height: 55px;display:none;" style="">
					<div class="container-fluid" style="margin-bottom: -15px;">
						<form onsubmit="return false;">
							<div class="form-group col-xs-2">
								<select class="form-control" id="selType" data-bind="value:Type">
									<option value="1">微信公众号</option>
									<option value="2">微信企业号</option>
								</select>
							</div>
							<div class="form-group col-xs-3">
								<select class="form-control" id="selTokenType"
									data-bind="value:TokenType">
									<option value="1">输入AccessToken</option>
									<option value="2">获取AccessToken</option>
								</select>
							</div>
							<div class="form-group col-xs-2" data-bind="visible:(Type()==2)"
								style="display: none;">
								<input type="text" class="form-control" placeholder="请输入AgentId"
									data-bind="value:AgentId">
							</div>

							<div class="form-group col-xs-5"
								data-bind="visible:(TokenType()==1)" style="display: none;">
								<input type="text" class="form-control"
									placeholder="请输入AccessToken" data-bind="value:AccessToken">
							</div>
							<div class="form-group col-xs-2"
								data-bind="visible:(TokenType()==2 && Type()==2)"
								style="display: none;">
								<input type="text" class="form-control"
									placeholder="请输入套件CorpId" data-bind="value:CorpId">
							</div>
							<div class="form-group col-xs-2"
								data-bind="visible:(TokenType()==2 && Type()==2)"
								style="display: none;">
								<input type="text" class="form-control" placeholder="请输入永久授权码"
									data-bind="value:PermanentCode">
							</div>
							<div class="form-group col-xs-2"
								data-bind="visible:(TokenType()==2 && Type()==2)"
								style="display: none;">
								<input type="text" class="form-control" placeholder="请输入SuiteId"
									data-bind="value:SuiteId">
							</div>
							<div class="form-group col-xs-2"
								data-bind="visible:(TokenType()==2 && Type()==2)"
								style="display: none;">
								<input type="text" class="form-control"
									placeholder="请输入SuiteSecret" data-bind="value:SuiteSecret">
							</div>
							<div class="form-group  col-xs-2"
								data-bind="visible:(TokenType()==2 && Type()==2)"
								style="display: none;">
								<input type="text" class="form-control"
									placeholder="请输入SuiteTicket" data-bind="value:SuiteTicket">
							</div>

							<div class="form-group col-xs-3"
								data-bind="visible:(TokenType()==2 && Type()==1)"
								style="display: none;">
								<input type="text" class="form-control" placeholder="请输入AppId"
									data-bind="value:AppId">
							</div>
							<div class="form-group  col-xs-3"
								data-bind="visible:(TokenType()==2 && Type()==1)"
								style="display: none;">
								<input type="text" class="form-control"
									placeholder="请输入AppSecret" data-bind="value:AppSecret">
							</div>
						</form>
					</div>
				</div>

				<div class="panel-body" data-bind="with:Menus" id="divMenu"
					style="display: none;">
					<div style="height: 200px;" data-bind="foreach:newArray(3)">
						<div class="list-group col-xs-4 clearFill bn">
							<!--ko if:($parent.button.length>0 && $parent.button[$index()]!=undefined && $parent.button[$index()].sub_button!=undefined ) -->
							<!--ko foreach:newArray((4-$parent.button[$index()].sub_button.length)) -->
							<div class="list-group-item bn"></div>
							<!--/ko-->
							<!--ko if:$parent.button[$index()].sub_button.length<5 -->
							<div class="list-group-item"
								data-bind="click:function (){$root.AddMenu($index())}">
								<i class="fa fa-plus"></i>
							</div>
							<!--/ko-->
							<!--ko foreach:($parent.button[$index()].sub_button) -->
							<div class="list-group-item"
								data-bind="text:name,attr:{'bottonIndex':$parent.value,'subbottonIndex':$index()},click:function (){$root.EditMenu($data,$parent.value,$index())}"></div>
							<!--/ko-->
							<!--/ko -->
							<!--ko if: $parent.button[$index()]!=undefined && $parent.button[$index()].sub_button==undefined -->
							<div class="list-group-item bn"></div>
							<div class="list-group-item bn"></div>
							<div class="list-group-item bn"></div>
							<div class="list-group-item bn"></div>
							<div class="list-group-item"
								data-bind="click:function (){$root.AddMenu($index())}">
								<i class="fa fa-plus"></i>
							</div>
							<!--/ko-->
							<!--ko if: $parent.button[$index()]==undefined -->
							<div class="list-group-item bn"></div>
							<div class="list-group-item bn"></div>
							<div class="list-group-item bn"></div>
							<div class="list-group-item bn"></div>
							<div class="list-group-item bn"></div>
							<!--/ko-->
						</div>
					</div>
					<!--ko foreach:$data.button -->
					<div class="col-xs-4 list-group-item list-group-item-danger"
						data-bind="text:name,attr:{'bottonindex':$index()},click:function (){$root.EditMenu($data,$index(),-1)}"></div>
					<!--/ko-->
					<!--ko if:button.length < 3 -->
					<div class="col-xs-4 list-group-item"
						data-bind="click:function (){$root.AddMenu();}">
						<i class="fa fa-plus"></i>
					</div>
					<!--/ko-->
					<div class="clearfix"></div>

					<div class="col-xs-12"
						style="border: 1px solid #EEEEEE; padding-top: 15px; margin-top: 15px;"
						data-bind="with:$root.Menu,visible:($root.Menu()!=undefined)">
						<form id="MenuForm" onsubmit="return false;">
							<div class="form-group col-xs-5">
								<div class="input-group">
									<input type="text" class="form-control" name="name"
										data-placement="top" data-toggle="popover" placeholder="请输入名称"
										data-bind="value:name,event:{'keyup':$root.EventNameErrorMessage},attr:{'data-content':$root.NameErrorMessage}"
										id="txtMenuName"> <span class="input-group-addon"
										data-bind="click:$root.SelectEmoji"><i
										class="fa fa-smile-o" aria-hidden="true"></i></span>
									<div class="emojipar" id="selectEmojidiv"
										data-bind="click:$root.ClickEmojiDiv">
										<span class="caret"></span>
										<div class="title">
											Emoji选择 <span class="label label-info">bate</span>
										</div>
										<div class="emojilistbox">
											<ul class="emojilist" data-bind="foreach:$root.Emojis">
												<!--ko if:$data!='-'-->
												<li>
													<div data-bind="text:$data,click:$root.ClickEmoji"></div>
												</li>
												<!--/ko-->
											</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="form-group col-xs-4">
								<select class="form-control" id="selectMenuType"
									data-bind="event:{'change':$root.MenuTypeChange},value:type,disable:type=='menu'">
									<option value="menu" pl="" selected="selected">显示二级菜单</option>
									<option value="view" pl="请输入Url">跳转URL</option>
									<option value="click" pl="请输入Key">点击推事件</option>
									<option value="scancode_push" pl="请输入Key">扫码推事件</option>
									<option value="scancode_waitmsg" pl="请输入Key">扫码推事件且弹出“消息接收中”提示框</option>
									<option value="pic_sysphoto" pl="请输入Key">弹出系统拍照发图</option>
									<option value="pic_photo_or_album" pl="请输入Key">弹出拍照或者相册发图</option>
									<option value="pic_weixin" pl="请输入Key">弹出微信相册发图器</option>
									<option value="location_select" pl="请输入Key">弹出地理位置选择器</option>
									<option value="media_id" pl="请输入永久素材Id"
										data-bind="disable:($root.Type()==2)">下发消息（除文本消息）</option>
									<option value="view_limited" pl="请输入永久素材Id"
										data-bind="disable:($root.Type()==2)">下发图文消息</option>
									<option value="miniprogram" pl="请输入Url"
										data-bind="disable:($root.Type()==2)">打开小程序</option>
								</select>
							</div>
							<!--ko if:type!='menu'-->
							<div class="form-group col-xs-9">
								<input type="text" id="txtMenuButtonValue" name="value"
									class="form-control" placeholder="请输入Url" data-placement="top"
									data-toggle="popover"
									data-bind="value:value,event:{'keyup':$root.EventValueErrorMessage},attr:{'data-content':$root.ValueErrorMessage}">
							</div>
							<!--/ko-->
							<!--ko if:$root.EditMenuType()=='miniprogram'-->
							<div class="form-group col-xs-6">
								<input type="text" name="pagepath" class="form-control"
									placeholder="请输入小程序的页面路径" data-bind="value:pagepath">
							</div>
							<div class="form-group col-xs-3">
								<input type="text" name="appid" class="form-control"
									placeholder="请输入小程序的AppId" data-bind="value:appid">
							</div>
							<!--/ko-->
							<div class="form-group col-xs-12">
								<button type="submit" class="btn btn-primary"
									data-bind="click:$root.MenuSave">确定</button>
								<button type="submit" class="btn btn-danger"
									data-bind="visible:$root.isEditMenu,click:$root.DeleteMenu">删除</button>
								<button type="button" class="btn btn-default" title="上移"
									data-bind="visible:$root.isEditMenu(),disable:!$root.IsUp(),click:$root.Up">
									<i class="fa fa-chevron-circle-up" aria-hidden="true"></i>
								</button>
								<button type="button" class="btn btn-default" title="下移"
									data-bind="visible:$root.isEditMenu(),disable:!$root.IsDown(),click:$root.Down">
									<i class="fa fa-chevron-circle-down" aria-hidden="true"></i>
								</button>
								<button type="button" class="btn btn-default" title="左移"
									data-bind="visible:$root.isEditMenu(),disable:!$root.IsLeft(),click:$root.Left">
									<i class="fa fa-chevron-circle-left" aria-hidden="true"></i>
								</button>
								<button type="button" class="btn btn-default" title="右移"
									data-bind="visible:$root.isEditMenu(),disable:!$root.IsRight(),click:$root.Right">
									<i class="fa fa-chevron-circle-right" aria-hidden="true"></i>
								</button>
								<button type="button" class="btn btn-default" title="复制菜单"
									data-bind="visible:$root.isEditMenu(),click:$root.Copy">复制</button>
								<button type="button" class="btn btn-default" title="粘贴菜单"
									data-bind="visible:$root.IsPaste(),click:$root.Paste">粘贴</button>
								<button type="submit" class="btn btn-default"
									data-bind="click:$root.CancelMenuSave">关闭</button>
							</div>
						</form>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-footer" data-bind="with:Menus">
					<button id="btnSubmitMenu" type="button" class="btn btn-primary"
						data-bind="click:$root.SaveMenus" data-toggle="tooltip"
						data-placement="top" title="发布到微信">
						<i class="fa fa-upload" aria-hidden="true"></i> 发布
					</button>
					<button id="btnQueryMenu" type="button" class="btn btn-default"
						data-bind="click:function (){$root.EditMenus(true)}"
						data-toggle="tooltip" data-placement="top" title="查询公众号/企业号应用现有菜单">
						<i class="fa fa-download" aria-hidden="true"></i> 查询菜单
					</button>
					<button type="button" class="btn btn-default" data-toggle="modal"
						data-target="#InputJSONModel">
						<i class="fa fa-keyboard-o" aria-hidden="true"></i> 输入JSON菜单数据
					</button>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">实时JSON</div>
				<div class="panel-body">
					<pre id="jsonShow"
						style="padding: 0; border: none; background-color: #fff;"
						data-bind="html:JSON.stringify($root.NewMenu(),null,4)"></pre>
				</div>
			</div>

			<div class="alert alert-warning alert-dismissible fade in"
				role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<p>
					<a
						href="https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1433747234"
						target="_blank">公众号接口</a>、<a
						href="https://work.weixin.qq.com/api/doc#10649" target="_blank">企业号接口</a>返回码说明。
				</p>
				<p>遇到61004、40164等错误，请将程序部署ip加入到微信后台等白名单配置当中。</p>
			</div>

			<div class="alert alert-info alert-dismissible fade in" role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<p>1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
			</div>

			<div class="modal fade" id="InputJSONModel" tabindex="-1"
				role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">输入JSON格式菜单数据</h4>
						</div>
						<div class="modal-body">
							<form>
								<div class="form-group">
									<textarea class="form-control" rows="8"
										placeholder="格式参照下方实时JSON格式" data-bind="value:$root.InputMenu"></textarea>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary"
								data-bind="click:$root.ConfirmInputMenu">确定</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<script
		src="resources/menu/bootstrap?v=5UOkiMWkoyzmfiCs2bnNoBWQ43M0x3DUnFUW9HoLlQI1"></script>

	<script type="text/javascript">
		$(function() {
			//var autofooter = function () {
			//    var bh = $("body").height();
			//    var wh = $(window).height();
			//    if (bh < wh) {
			//        $("footer:last").addClass("fixedfooter");
			//    } else {
			//        $("footer:last").removeClass("fixedfooter");
			//    }
			//}
			//autofooter();

			//$(window).resize(function () {
			//    autofooter();
			//})

			if (!(window.top === window)) {
				window.top.location.replace(location.href);
			}
		});
	</script>

	<script src="resources/menu/jquery.validate.js"></script>
	<script src="resources/menu/jquery.validate.unobtrusive.js"></script>
	<script type="text/javascript">
		var token = "";
	</script>
	<script
		src="resources/menu/menu?v=kpqFHgt4ZBMU5xTdFC5jF8FK4oZhdXsr_pIyP_30viM1"></script>
</body>
</html>