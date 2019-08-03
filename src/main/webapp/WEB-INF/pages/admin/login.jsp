<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${manager!=null}">
	<script language="javascript"type="text/javascript">  
		window.location.href="/Huarui/admin/manager"; 
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<title>实时无线体温监测系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<meta http-equiv="Pragma" content="no-cache"> 
<meta http-equiv="Cache-Control" content="no-cache"> 
<meta http-equiv="Expires" content="0">
<link rel="shortcut icon" href="/Huarui/asset/images/favicon.ico" type="image/x-icon" />
<link href="/Huarui/asset/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Huarui/asset/js/global.js"></script>
<script src="/Huarui/asset/js/jquery-1.8.3.min.js"></script>
</head>
<body>
	<div class="login_box">
		<div class="login_img"></div>
		<div class="login">
			<div class="login_name">
				<p>实时无线体温监测系统</p>
			</div>
			<form method="post" action="/Huarui/admin/login">
				<input id="account" name="account" type="text" placeholder="账号" maxlength="16" autocomplete="off">
				<input id="password" name="password" type="password" placeholder="密码" maxlength="16" autocomplete="off"/>
				<p>
				<input class="magic-radio r1" type="radio" name="radio" value="2"/><label class="label_a">超级管理员</label>
				<input class="magic-radio r2" type="radio" name="radio" value="1" checked="checked"/><label  class="label_b">科室管理员</label>
				</p>
				<input type="submit" onclick="return validate()" value="登录">
			</form>
			<script type="text/javascript">
				$(".label_a").click(function () {
					$('.r1').click();
				});
				$(".label_b").click(function () {
					$('.r2').click();
				});
			
				function validate(){
					var regu1 = /^[0-9a-zA-Z]*$/g;
			    	var re1 = new RegExp(regu1);
			    	var account = $('#account').val();
			    	var account_target = re1.test(account);
			    	
			    	var regu2 = /^[0-9a-zA-Z]*$/g;// 验证密码 
			    	var re2 = new RegExp(regu2);
			    	var password = $('#password').val();
			    	var password_target = re2.test(password);
			    	
			    	if(account==null || account==''|| !account_target){
						alert('请输入账号，只允许输入字母或数字！');
						$("#account").focus();
						return false;
					}
			    	else if(password==null || password==''||!password_target){
			    		alert('请输入密码，只允许输入字母或数字！');
						$("#password").focus();
						return false;					
			    	}
			    	else{
			    		return true;
			    	}
				}
			</script>
		</div>
	</div>
	
	<div class="copyright">广东华睿远航医疗科技有限公司 版权所有©2018-2019 技术支持电话：000-00000000</div>
</body>
</html>
