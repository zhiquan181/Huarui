<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${admin==null}">
	<script language="javascript"type="text/javascript"> 
		alert("管理员登录会话已过期，请重新登录！"); 
		window.location.href="/Huarui/admin"; 
	</script>
</c:if>
<%
String path = request.getContextPath();
String systemSetPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/admin/config";
String saveAccount = request.getContextPath()+"/admin/saveaccount";
String showPatientPath = request.getContextPath()+"/admin/showpatientnon";
%>
<!DOCTYPE html>
<html>
<head>
	<title>华睿 - 无线体温数据监测系统 - 患者管理</title>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="shortcut icon" href="/Huarui/asset/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/Huarui/asset/css/font-awesome.min.css">
	<link rel="stylesheet" href="/Huarui/asset/css/patientnon.css"/>
	<script type="text/javascript" src="/Huarui/asset/js/global.js"></script>
	<script type="text/javascript" src="/Huarui/asset/js/jquery-1.8.3.min.js"></script>
</head>
<script>
	$(document).ready(function(){
		// 点击头像
		$(".header_right_img").click(function(){
			$(".header_right_img_ul").fadeToggle(200);
		});
		
		// 打开账号设置
		$(".header_right_img_ul_set").click(function(){
			$(".user_set_card").fadeIn(200);
		});
		
		// 关闭账号设置
		$(".fa_close_user_set").click(function(){
			$(".user_set_card").fadeOut(200);
		})
	});
</script>
<body>
	<div class="main">
		<jsp:include page="/WEB-INF/pages/admin/global_header.jsp"/>

		<div class="user_set_card">
			<i class="fa fa_close_user_set fa-close" title="关闭"></i>
			<div class="account_formbox">
				<jsp:include page="/WEB-INF/pages/admin/account.jsp"/>
			</div>
		</div>
			
		<section class="container">
			
			<div class="content patient_content">
				<div class="content_box">
					<div class="content_box_nav">
						<span class="span1">患者管理</span>
												
						<a href="/Huarui/admin/patient" class="patientnon">全部患者列表</a>
					</div>
					<hr/>
					<div class="content_box_body">
						<div class="div1">
							<p>
								<span class="content_box_body_id1">患者ID</span>
								<span class="content_box_body_name1">姓名</span>
								<span class="content_box_body_phone1">手机号</span>
								<span class="content_box_body_age1">年龄</span>
								<span class="content_box_body_sex1">性别</span>
								<span class="content_box_body_identify1">身份证</span>
								<span class="content_box_body_dept1">所属科室</span>
								<span class="content_box_body_status1">状态</span>
								<span class="content_box_body_createat1">入院时间</span>
								<span class="content_box_body_endtime1">出院时间</span>
								<span class="content_box_body_device1">设备ID</span>
							</p>
						</div>
						<div class="div2" style="width:100%;height:600px;">
						</div>
						
						<script type="text/javascript">
							$(function(){
								$("body .content_box_body p:even").css("background","#fff");
								$("body .content_box_body p:odd").css("background","rgb(249,250,252)");
							})
						</script>
					</div>
					<div class="pagination" id="pagination"></div>
					<!-- js 分页 -->
					<!-- css 分页 -->
					<style type="text/css">
						.div3{width:100%;height:80px;position: relative;background-color: none;}
						.div3 div{width:auto;height:80px;position: relative;left: 50%;transform: translate(-50%);display:inline-block;padding:15px 0px 0px 0px;}
						.div3 div a{width:auto;padding:0 15px;margin:0 8px 0 0;float:left;cursor:Default;text-decoration:none;height:35px;color:rgb(61,168,245);display:inline-block;border:1px solid rgb(61,168,245);border-radius:2px;font-size:14px;text-align:center;line-height:34px;
						transition: ease background-color .3s;-moz-transition: ease background-color .3s;/* Firefox 4 */-webkit-transition: ease background-color .3s;/* Safari 和 Chrome */-o-transition: ease background-color .3s;/* Opera */}
						.div3 div a:hover{background-color: rgb(61,168,245);color:#fff;}
						#FirstPage,#LastPage{cursor:pointer;}
					</style>
					<div class="div3">
						<div>
							<a id="FirstPage" href="javascript:void(0)">首页</a>
							<a id="AprevPage" href="javascript:void(0)"><span id="prevPage">上一页</span></a>
							<a id="currentPage" href="javascript:void(0)"></a>
							<a id="AnextPage" href="javascript:void(0)"><span id="nextPage">下一页</span></a>
							<a id="LastPage" href="javascript:void(0)">尾页</span></a>
							<a id="totalPage" href="javascript:void(0)"></a>
							<a id="totalSize" href="javascript:void(0)"></a>
						</div>
					</div>
					
					<script type="text/javascript" src="/Huarui/asset/js/jquery-1.8.3.min.js"></script>
					<script type="text/javascript" src="/Huarui/asset/js/md5.js" charset="utf-8"></script>
					<script type="text/javascript" src="/Huarui/asset/js/jquery.pagination.js"></script>
					<script type="text/javascript">
					    jQuery.noConflict();
					    jQuery(function () {			        
					        //进入页面，当currentPage未定义时，执行函数
					        //过渡显示
					        loadData(1);
					        
					        //loadData函数
					        function loadData(indexPage) {
					            jQuery.ajax({
					                url: "<%=showPatientPath%>",
					                type: "POST",
					                data: {
					                    "indexPage":indexPage
					                },
					                dataType: "json",
					                success: function (data) {
					                	//过渡隐藏
					                	console.log(data);
					                    jQuery("body .content_box_body .div2").html('');
					                    datas(data);
					                    
					                }
					            });
					        };
					        
							//datas函数
					        function datas(data) {
					            jQuery.each(data.patients, function (i, dom) {		            	
					            	//状态
					            	diy_status = dom.status;
					            	diy_endtime = dom.endtime;
					            	
					            	if(diy_status == 1){
					            		diy_status_str = '入院中';
					            		color_str = 'status_ok';
					            		diy_endtime = '-';
					            	}
					            	else{
					            		diy_status_str = '已出院';
					            		color_str = 'status_no';
					            	}
					            	
					                jQuery("body .content_box_body .div2").append("<p>\n" +
										"<input type='hidden' class='dom_id' value='"+dom.id+"'/>" +
										"<input type='hidden' class='dom_pass' value='"+dom.password+"'/>" +
										"<span class='content_box_body_id2'>" + dom.id + "</span>\n" +
					                    "<span class='content_box_body_name2'>" + dom.truename + "</span>\n" +
					                    "<span class='content_box_body_phone2'>" + dom.phone + "</span>\n" +
					                    "<span class='content_box_body_age2'>" + dom.age + "</span>\n" +
					                    "<span class='content_box_body_sex2'>" + dom.sex + "</span>\n" +
					                    "<span class='content_box_body_identify2'>" + dom.identify + "</span>\n" +
					                    "<span class='content_box_body_dept2'>" + dom.department + "</span>\n" +
					                    "<span class='content_box_body_status2 "+color_str+"'>" + diy_status_str + "</span>\n" +
					                    "<span class='content_box_body_createat2'>" + dom.createat + "</span>\n" +
					                    "<span class='content_box_body_endtime2'>" + diy_endtime + "</span>\n" +
					                    "<span class='content_box_body_device2'>" + dom.deviceid + "</span>\n" +
					                    "</p>");
					            });
					            
					            //在回调里面写，重新绑定特效
					            jQuery("body .content_box_body p:even").css("background","#fff");
					            jQuery("body .content_box_body p:odd").css("background","rgb(249,250,252)");
					            jQuery(".status_ok").css("color","rgb(90,207,0)");
					            jQuery(".status_no").css("color","red");
					            
					          	//当前页 页码存放在input hidden中
					            jQuery("body .content_box_body .div2").append("<input type='hidden' class='currentPage' value='"+data.pager.currentPage+"'/>");
					            //全部页 页码存放在input hidden中
					            jQuery("body .content_box_body .div2").append("<input type='hidden' class='totalPage' value='"+data.pager.totalPage+"'/>");
					          	
					          	//判断上一页、下一页无数据时不可点击的样式
					          	if(!data.pager.hasPrevious){
					          		$('#AprevPage').css("cursor","not-allowed");
					          	}else{
					          		$('#AprevPage').css("cursor","pointer");
					          	}
					          	if(!data.pager.hasNext){
					          		$('#AnextPage').css("cursor","not-allowed");
					          	}else{
					          		$('#AnextPage').css("cursor","pointer");
					          	}
					            
					          	//当前页
					            jQuery('#currentPage').text(data.pager.currentPage);
					          	
								//总共页
					            jQuery('#totalPage').text("共"+data.pager.totalPage+"页");
								
								//总共数
					            jQuery('#totalSize').text("共"+data.pager.totalSize+"条记录");
								
					        }
					        
							//检索用户
					        jQuery("#search").click(function () {
					        	searchPatient=jQuery("#searchPatient").val();
					            loadData(1);
					        });
							
					        //首页，必须放在外面
					        $('#FirstPage').click(function(){
					        	loadData(1);
					        });
					        
							//上一页，必须放在外面
					        $('#AprevPage').click(function(){
						    	var currentPage = jQuery(".currentPage").val();
						    	var prevPage = --currentPage;
						    	if(prevPage>0){
						    		console.log(prevPage);
							    	loadData(prevPage);
						    	}
						    	else{
						    		console.log(prevPage);
						    	}
						    });
					        
					        //下一页，必须放在外面
						    $('#AnextPage').click(function(){
						    	var currentPage = jQuery(".currentPage").val();
						    	var nextPage = ++currentPage;
						    	var totalPage = jQuery(".totalPage").val();
						    	if(1<=nextPage && nextPage<=totalPage){
						    		console.log(nextPage);
							    	loadData(nextPage);
						    	}
						    	else{
						    		console.log(nextPage);
						    	}
						    });
					        
						    //尾页，必须放在外面
					        $('#LastPage').click(function(){
					        	var LastPage = jQuery(".totalPage").val();
					        	loadData(LastPage);
					        });
		
						});
		        	</script>
					<!-- / js 分页 -->
				</div>
			</div>
		</section>

	</div>
</body>