<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String systemSetPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/admin/config";
String saveAccount = request.getContextPath()+"/admin/saveaccount";
String updateAuserPath = request.getContextPath()+"/admin/updateauser";
String showAuserPath = request.getContextPath()+"/admin/showauser";
String auserPath = request.getContextPath()+"/admin/auser";
%>
<script>
	$(document).ready(function(){
		// 点击头像
		$(".header_right_img").click(function(){
			$(".header_right_img_ul").fadeToggle(200);
		});
		
		// 打开账号设置
		$(".header_right_img_ul_set").click(function(){
			$(".user_set_card").fadeIn(200);
			$(".user_edit_card").css("display","none");
		});
	
		// 关闭账号设置
		$(".fa_close_user_set").click(function(){
			$(".user_set_card").fadeOut(200);
		})
	});
</script>

<div class="user_set_card">
	<i class="fa fa_close_user_set fa-close" title="关闭"></i>
	<div class="account_formbox">
		<jsp:include page="/WEB-INF/pages/admin/account.jsp"/>
	</div>
</div>

<section class="container">

	<div class="content auser_content">
		<div class="content_box">
			<div class="content_box_nav">
				<span>系统用户</span>
				
				<div class="content_box_nav_search">
					<input class="content_box_nav_search_input" type="text" name="searchAuser" id="searchAuser" placeholder="管理员检索" maxlength="20">
					<input class="content_box_nav_search_submit" type="button" id="search" value="搜索"/>
				</div>
			</div>
			<hr/>
			<div class="content_box_body">
				<div class="div1">
					<p>
						<span class="content_box_body_dept1">所属科室</span>
						<span class="content_box_body_person1">负责人</span>
						<span class="content_box_body_account1">账号</span>
						<span class="content_box_body_passwd1">密码</span>
						<span class="content_box_body_phone1">手机</span>
						<span class="content_box_body_address1">地址</span>
						<span class="content_box_body_status1">状态</span>
						<span class="content_box_body_oprate1">操作</span>
					</p>
				</div>
				<div class="div2" style="width:100%;height:600px;"></div>
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
			        var searchAuser='';
			        
			        //进入页面，当currentPage未定义时，执行函数
			        //过渡显示
			        loadData(1);
			        
			        //loadData函数
			        function loadData(indexPage) {
			            jQuery.ajax({
			                url: "<%=showAuserPath%>",
			                type: "POST",
			                data: {
			                    "searchAuser":searchAuser,
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
			            jQuery.each(data.ausers, function (i, dom) {
			            	//md5加密密码
			            	md5_password = dom.passwd;
			            	str_md5_password = new String(md5_password);
			            	var md5_password = b64_md5(str_md5_password);
			            	
			            	//状态
			            	diy_status = dom.status;
			            	if(diy_status == 1){
			            		diy_status_str = '已启用';
			            		color_str = 'status_ok';
			            	}
			            	else{
			            		diy_status_str = '未启用';
			            		color_str = 'status_no';
			            	}
			            	
			                jQuery("body .content_box_body .div2").append("<p>\n" +
								"<span class='content_box_body_dept2'>" + dom.department + "</span>\n" +
			                    "<span class='content_box_body_person2'>" + dom.person + "</span>\n" +
			                    "<span class='content_box_body_account2'>" + dom.account + "</span>\n" +
			                    "<span class='content_box_body_passwd2'>" + md5_password + "</span>\n" +
			                    "<span class='content_box_body_phone2'>" + dom.phone + "</span>\n" +
			                    "<span class='content_box_body_address2'>" + dom.address + "</span>\n" +
			                    "<span class='content_box_body_status2 "+color_str+"'>" + diy_status_str + "</span>\n" +
			                    "<span class='content_box_body_oprate2'>" + "<a class='content_box_update'><i class='fa fa-link edit_user' title='编辑'></i></a>" + "</span>\n" +
			                    "<input type='hidden' class='dom_passwd' value='"+dom.passwd+"'/>" +
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
						
						//for each复制用户到编辑表单
			            jQuery('.content_box_body p').each(function(e) {
					    	console.log(this);
							var p = jQuery(this);//这里的this指向 p
							p.find('.edit_user').each(function(){
							    var edit_user = jQuery(this); // 这里this指向 edit_user
							    var user_dept = p.find('.content_box_body_dept2').text();
							    var user_account = p.find('.content_box_body_account2').text();
							    var user_passwd = p.find('.dom_passwd').val();
							    edit_user.on("click",function(){
							    	jQuery(".user_edit_card").fadeIn(200);
							    	$(".user_set_card").css("display","none");
							    	$("#edit_dept").val(user_dept);
							    	$("#edit_account").val(user_account);
							    	$("#edit_passwd").val(user_passwd);
							    });
							})
						});
			        }
			        
					//检索用户
			        jQuery("#search").click(function () {
			        	searchAuser=jQuery("#searchAuser").val();
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
			
			<div class="user_edit_card">
				<i class="fa fa_close_user_edit fa-close" title="关闭"></i>
				<form id="formEditUser" method="post">
					<p><span>科室名：</span><input type="text" id="edit_dept" class="input" name="department" value="" autocomplete="off" readonly/></p>
					<p><span>账号：</span><input type="text" id="edit_account" class="input" name="accpunt" maxlength="10" placeholder="账号"/></p>
					<p><span>密码：</span><input type="text" id="edit_passwd" class="input" name="passwd" maxlength="20" placeholder="密码"/></p>
					<p><input type="button" id="submitUpdateAuser" class="submit" value="完成"/></p>
				</form>
				<script type="text/javascript">
				    $("#submitUpdateAuser").click(function () {
				    	var update_ausers = {
				    		department : $("#edit_dept").val(),
				    		account : $("#edit_account").val(),
				    		passwd : $("#edit_passwd").val()
				    	};
				    	
				    	console.log(update_ausers);
				    	
				    	if(edit_validate(update_ausers)){
					    	$.ajax({
					            url: "<%=updateAuserPath%>",
					            type: "POST",
					            dataType: "json",
					            contentType:"application/json;charset=UTF-8",
					            data: JSON.stringify(update_ausers),
					            success: function(data) {// 成功
					 				//alert(data.status);
					 				if(data.status == "fail"){
					 					alert("修改失败，请重新再试！");
					 					window.location.href="<%=auserPath%>"; 
					 				}
					 				else if(data.status == "exist"){
					 					alert(update_ausers.account+" 已被注册，请输入其他账号！");
					 				}
					 				else if(data.status == "success"){
					 					alert("修改成功！");
					 					window.location.href="<%=auserPath%>";
					 				}
					 				else{}
					            }
					        });
				    	}
				    	
				    	function edit_validate(update_ausers){
				    		var regu3 = /^[A-Za-z0-9]+$/;// 只能输入英文 数字 - 验证账号
					    	var re3 = new RegExp(regu3);
					    	var target3 = re3.test(update_ausers.account);
					    	
					    	var regu4 = /^[A-Za-z0-9]+$/;// 只能输入英文 数字 - 验证密码
					    	var re4 = new RegExp(regu4);
					    	var target4 = re4.test(update_ausers.passwd);
					    	
					    	if(update_ausers.account==null || update_ausers.account==''|| !target3){
					    		alert('该管理员账号必须为英文或者数字组合！');
								$("#account1").focus();
								return false;
					    	}
					    	else if(update_ausers.passwd==null || update_ausers.passwd==''|| !target4){
					    		alert('该管理员密码必须为英文或者数字组合！');
								$("#passwd1").focus();
								return false;
					    	}
					    	else{
					    		return true;
					    	}
					    }
				    	
				    });
				    
				    
			</script>
			</div>
			<script type="text/javascript">
				// 关闭科室添加卡片
				$(".fa_close_user_edit").click(function(){
					$(".user_edit_card").fadeOut(200);
				})
			</script>
		</div>
	</div>
</section>