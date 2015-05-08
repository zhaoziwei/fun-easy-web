<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>系统登录</title>
<style type="text/css">
body {
	background-color: #bee1f5;
	background-image: url("style/images/body_repeat.png");
	background-repeat: repeat-x;
	background-position: center 0;
}

.login {
	background-repeat: no-repeat;
	background-position: center 0;
	padding-top: 50%;
	background-image: url("style/images/body_bg_.png");
}

.login {
	*zoom: 2;
	min-width: 980px;
}
</style>
<jsp:include page="inc.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="style/css/reset.css?v=2014.03.21">
<link type="text/css" rel="stylesheet" href="style/css/login.css?v=2014.03.21">
<script src='jslib/jquery.md5.js' type='text/javascript' charset='utf-8'></script>
<script type="text/javascript">
	/**
	 cookie 记住用户
	 */
	function SetLastUser(usr) {
		var id = window.location.host;
		var expdate = new Date();
		//当前时间加上两周的时间
		expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
		SetCookie(id, usr, expdate);
	}
	function GetLastUser() {
		var id = window.location.host;
		var usr = GetCookie(id);
		if (usr != null) {
			$("#userName").val(usr);
		}
	}
	function GetCookie(name) {
		var arg = name + "=";
		var alen = arg.length;
		var clen = document.cookie.length;
		var i = 0;
		while (i < clen) {
			var j = i + alen;
			if (document.cookie.substring(i, j) == arg)
				return getCookieVal(j);
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0)
				break;
		}
		return null;
	}
	function SetCookie(name, value, expires) {
		var argv = SetCookie.arguments;
		//本例中length = 3
		var argc = SetCookie.arguments.length;
		var expires = (argc > 2) ? argv[2] : null;
		var path = (argc > 3) ? argv[3] : null;
		var domain = (argc > 4) ? argv[4] : null;
		var secure = (argc > 5) ? argv[5] : false;
		document.cookie = name + "=" + escape(value) + ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) + ((path == null) ? "" : ("; path=" + path)) + ((domain == null) ? "" : ("; domain=" + domain)) + ((secure == true) ? "; secure" : "");
	}
	function ResetCookie() {
		var usr = $("#userName").val();
		var expdate = new Date();
		SetCookie(usr, null, expdate);
	}
	function getCookieVal(offset) {
		var endstr = document.cookie.indexOf(";", offset);
		if (endstr == -1)
			endstr = document.cookie.length;
		return unescape(document.cookie.substring(offset, endstr));
	}
	function CheckIsNullOrEmpty(s) {
		return ((s == undefined || s == null || s == "") ? true : false);
	}
	function LoginSubmit() {
		
		if (CheckIsNullOrEmpty($("#userName").val())) {
			alert("用户名不能为空！");
			return;
		}
		if (CheckIsNullOrEmpty($("#password").val())) {
			alert("密码不能为空！");
			return;
		}
		if (CheckIsNullOrEmpty($("#checkCode").val())) {
			alert("验证码不能为空！");
			return;
		}
		
		$("#password").val($.md5($("#password").val()));
		$.post(sy.contextPath + '/base/syuser!doNotNeedSessionAndSecurity_login.sy', $('form').serialize(), function(result) {
			if (result.success) {
				if ($("#isRemember").is(":checked"))
					SetLastUser($("#userName").val());
				location.replace(sy.contextPath + '/index.jsp');
			} else {
				$("#password").val("");
				$("#checkCode").val("");
				LoadImgValidateCode();
				alert(result.msg);
			}
		}, 'json');
	}
	function LoadImgValidateCode() {
		$("#img-validatecode").attr("src", sy.contextPath + '/base/syuser!doNotNeedSessionAndSecurity_loginCheckCode.sy' + '?nocache=' + new Date().getTime());
	}
	window.onload = function() {
		LoadImgValidateCode();
		GetLastUser();
		$("form").submit(function(e) {
			LoginSubmit();
			return false;
		});
	};
</script>
</head>
<body class="lang-cn login-bg">
	<div class="login">
		<div class="main">
			<form name="loginForm" id="login" class="form">
				<div class="panel panel-login clearfix">
					<div class="panel-heading">
						<h1 class="title">办公用品管理系统登录</h1>
					</div>
					<div class="panel-body">
						<div class="form-group form-group-login">
							<ul class="list-unstyled">
								<li class="form-item form-item-username"><label class="form-label form-label-icon" for="userName">用户名：</label>
									<div class="form-element">
										<input class="input-text" type="text" id="userName" name="data.loginname" placeholder="用户名" required />
									</div></li>
								<li class="form-item form-item-password"><label class="form-label form-label-icon" for="password">密码：</label>
									<div class="form-element">
										<input class="input-text" type="password" id="password" name="data.pwd" placeholder="密码" required />
									</div></li>
								<li class="form-item form-item-checkcode"><label class="form-label assist" for="checkCode">验证码：</label>
									<div class="form-element">
										<input class="input-text" type="text" id="checkCode" name="checkCode" placeholder="验证码" required /> <img id="img-validatecode" class="img-checkcode" alt="点击换一张" onclick="LoadImgValidateCode();" width="90" height="40" /> <a class="see-another" href="javascript:void(0)" onClick="LoadImgValidateCode()">看不清换一张</a>
									</div></li>
								<li class="form-item form-item-remember"><label class="form-label assist" for="remember">是否记住账号：</label>
									<div class="form-element">
										<label for="isRemember"><input type="checkbox" class="input-checkbox" name="isRemember" id="isRemember" /><span class="checkbox-text">记住账号</span></label>
									</div></li>
							</ul>
						</div>
					</div>
					<div class="panel-footer">
						<button type="submit" class="btn btn-success">
							<span><span>登 录</span></span>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>