<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String systemSetPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/admin/config";
String saveAccount = request.getContextPath()+"/admin/saveaccount";
%>
<script>
	$(document).ready(function(){
		// 系统设置
		$(".a4_system_ul_set").click(function(){
			$(".system_set_card").fadeToggle(200);
			$(".user_set_card").css("display","none");
		});
	
		// 点击头像
		$(".header_right_img").click(function(){
			$(".header_right_img_ul").fadeToggle(200);
		});
		
		// 打开账号设置
		$(".header_right_img_ul_set").click(function(){
			$(".user_set_card").fadeToggle(200);
			$(".system_set_card").css("display","none");
		});
	
		// 关闭账号设置
		$(".fa_close_user_set").click(function(){
			$(".user_set_card").fadeOut(200);
		})
	});
</script>

<div class="system_set_card">
	<i class="fa fa_close_system fa-close" title="关闭"></i>
	<jsp:include page="/WEB-INF/pages/admin/config.jsp"/>
</div>
<script>
	// 关闭系统设置卡片
	$(".fa_close_system").click(function(){
		$(".system_set_card").fadeOut(200);
	})
</script>
	
<div class="user_set_card">
	<i class="fa fa_close_user_set fa-close" title="关闭"></i>
	<div class="account_formbox">
		<jsp:include page="/WEB-INF/pages/admin/account.jsp"/>
	</div>
</div>
<script>
	// 关闭账号设置卡片
	$(".fa_close_user_set").click(function(){
		$(".user_set_card").fadeOut(200);
	})
</script>

<section class="container">
	<div class="content">
		<div class="content_box">
			<div>
				<div id="showDate"></div>
				<script type="text/javascript">
				window.onload=function(){
					 
					//定时器每秒调用一次fnDate()
					setInterval(function(){
						fnDate();
					},1000);
					}
					 
					//js 获取当前时间
					function fnDate(){
						var oDiv=document.getElementById("showDate");
						var date=new Date();
						var year=date.getFullYear();//当前年份
						var month=date.getMonth();//当前月份
						var data=date.getDate();//天
						var hours=date.getHours();//小时
						var minute=date.getMinutes();//分
						var second=date.getSeconds();//秒
						var time=year+" - "+fnW((month+1))+" - "+fnW(data)+"  "+fnW(hours)+" : "+fnW(minute)+" : "+fnW(second);
						oDiv.innerHTML=time;
					}
					//补位 当某个字段不是两位数时补0
					function fnW(str){
						var num;
						str>=10?num=str:num="0"+str;
						return num;
					}
				</script>
				<div class="content_box_div">
					<a class="content_box_div_a1" href="/Huarui/admin/dept"><i class="fa fa-hospital-o"></i><span>科室管理</span></a>
					<a class="content_box_div_a2" href="/Huarui/admin/patient"><i class="fa fa-heartbeat"></i><span>患者管理</span></a>
					<a class="content_box_div_a3" href="/Huarui/admin/auser"><i class="fa fa-user-md"></i><span>系统用户</span></a>
					<a class="content_box_div_a4 a4_system_ul_set" href="javascript:void(0)"><i class="fa fa-cog"></i><span>系统设置</span></a>
				</div>
			</div>
		</div>
	</div>
</section>