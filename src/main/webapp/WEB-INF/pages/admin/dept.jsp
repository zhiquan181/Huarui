<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${admin==null}">
	<script language="javascript"type="text/javascript"> 
		alert("管理员登录会话已过期，请重新登录！"); 
		window.location.href="/Huarui/admin"; 
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<title>华睿 - 无线体温数据监测系统 - 科室管理</title>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="shortcut icon" href="/Huarui/asset/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/Huarui/asset/css/font-awesome.min.css">
	<link rel="stylesheet" href="/Huarui/asset/css/deptlist.css"/>
	<script type="text/javascript" src="/Huarui/asset/js/global.js"></script>
	<script type="text/javascript" src="/Huarui/asset/js/jquery-1.8.3.min.js"></script>
</head>
<body>
	<div class="main">
		<jsp:include page="/WEB-INF/pages/admin/global_header.jsp"/>
		<jsp:include page="/WEB-INF/pages/admin/deptlist.jsp"/>
	</div>
</body>
</html>