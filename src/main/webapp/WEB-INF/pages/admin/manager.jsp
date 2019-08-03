<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${manager==null}">
	<script language="javascript"type="text/javascript"> 
		alert("管理员登录会话已过期，请重新登录！"); 
		window.location.href="/Huarui/admin"; 
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<title>华睿 - ${manager.department} - 体温数据</title>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="shortcut icon" href="/Huarui/asset/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/Huarui/asset/css/font-awesome.min.css">
	<link rel="stylesheet" href="/Huarui/asset/css/managerlist.css"/>
	<script type="text/javascript" src="/Huarui/asset/js/global.js"></script>
	<script type="text/javascript" src="/Huarui/asset/js/jquery-1.8.3.min.js"></script>
</head>
<body>
	<div class="main">
		<jsp:include page="/WEB-INF/pages/admin/global_m_header.jsp"/>
		<jsp:include page="/WEB-INF/pages/admin/managerlist.jsp"/>
	</div>
</body>
</html>