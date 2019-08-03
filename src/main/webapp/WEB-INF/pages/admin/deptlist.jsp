<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String systemSetPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/admin/config";
String insertDeptPath = request.getContextPath()+"/admin/insertdept";
String updateDeptPath = request.getContextPath()+"/admin/updatedept";
String updateStatusPath = request.getContextPath()+"/admin/updatestatus";
String deptPath = request.getContextPath()+"/admin/dept";
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
			$(".dept_add_card").css("display","none");
			$(".dept_edit_card").css("display","none");
		});
	
		// 关闭账号设置
		$(".fa_close_user_set").click(function(){
			$(".user_set_card").fadeOut(200);
		})
		
		/*
		*添加科室
		*/
		$(".dept_add").click(function(){
			$(".user_set_card").css("display","none");
			$(".dept_add_card").fadeIn(200);
			$(".dept_edit_card").css("display","none");
		});
	});
</script>

<div class="user_set_card">
	<i class="fa fa_close_user_set fa-close" title="关闭"></i>
	<div class="account_formbox">
		<jsp:include page="/WEB-INF/pages/admin/account.jsp"/>
	</div>
</div>

<link rel="stylesheet" href="/Huarui/asset/css/switchery.min.css"/>
<script type="text/javascript" src="/Huarui/asset/js/switchery.min.js"></script>
<section class="container">
	
	<div class="dept_add_card">
		<i class="fa fa_close_dept_add fa-close" title="关闭"></i>
		<form id="formAddDept" method="post">
			<p><span>科室名：</span><input type="text" id="department1" class="input" name="department" placeholder="请输入科室名" autocomplete="off" maxlength="20"/></p>
			<p><span>负责人：</span><input type="text" id="person1" class="input" name="person" placeholder="请输入该科室的负责人" autocomplete="off" maxlength="20"/></p>
			<p><span>账号：</span><input type="text" id="account1" class="input" name="account" placeholder="请输入该科室的登录账号" autocomplete="off" maxlength="20"/><b id="bbbbbb" style="display: none;">账号已存在</b></p>
			<p><span>密码：</span><input type="text" id="passwd1" class="input" name="passwd" placeholder="请输入该科室的登录密码" autocomplete="off" maxlength="20"/></p>
			<p><span>手机号码：</span><input type="text" id="phone1" class="input" name="phone" placeholder="请输入负责人的手机号码" autocomplete="off" maxlength="11"/></p>
			<p><span>地点位置：</span><input type="text" id="address1" class="input" name="address" placeholder="请输入该科室的地点位置" autocomplete="off" maxlength="20"/></p>
			<p><input type="button" id="submitAddDept" class="submit" value="完成"/></p>
		</form>
		<script type="text/javascript">
		    $("#submitAddDept").click(function () {
		    	var departments = {
		    		department : $("#department1").val(),
		    		person : $("#person1").val(),
		    		account : $("#account1").val(),
		    		passwd : $("#passwd1").val(),
		    		phone : $("#phone1").val(),
		    		address : $("#address1").val()
		    	};
		    	console.log(departments);
		    	if(validate(departments)){
			    	$.ajax({
			            url: "<%=insertDeptPath%>",
			            type: "POST",
			            dataType: "json",
			            contentType:"application/json;charset=UTF-8",
			            data: JSON.stringify(departments),
			            success: function(data) {// 成功
			 				//alert(data.status);
			 				if(data.status == "fail"){
			 					alert(departments.department+"已重复，请重新添加！");
			 				}
			 				else if(data.status == "exist"){
			 					alert(departments.account+"已被注册，请输入其他账号！");
			 				}
			 				else if(data.status == "success"){
			 					alert(departments.department+"添加成功！");
			 					window.location.href="<%=deptPath%>"; 
			 				}
			 				else{}
			            }
			        });
		    	}
		    });
		    
		    function validate(departments){
		    	var regu1 = /^[\u0391-\uFFE5A-Za-z0-9]+$/;// 只能输入中文 英文 数字 - 验证科室名
		    	var re1 = new RegExp(regu1);
		    	var target1 = re1.test(departments.department);
		    	
		    	var regu2 = /^[\u0391-\uFFE5]+$/;// 验证中文 - 验证管理员姓名
		    	var re2 = new RegExp(regu2);
		    	var target2 = re2.test(departments.person);
		    	
		    	var regu3 = /^[A-Za-z0-9]+$/;// 只能输入英文 数字 - 验证账号
		    	var re3 = new RegExp(regu3);
		    	var target3 = re3.test(departments.account);
		    	
		    	var regu4 = /^[A-Za-z0-9]+$/;// 只能输入英文 数字 - 验证密码
		    	var re4 = new RegExp(regu4);
		    	var target4 = re4.test(departments.passwd);
		    	
		    	var regu5 =/^[1][3,4,5,7,8,9][0-9]{9}$/;// 只能输入数字 - 验证手机号
		    	var re5 = new RegExp(regu5);
		    	var target5 = re5.test(departments.phone);
		    	
		    	var regu6 = /^[\u0391-\uFFE5A-Za-z0-9]+$/;// 只能输入中文 英文 数字 - 验证地址
		    	var re6 = new RegExp(regu6);
		    	var target6 = re6.test(departments.address);
		    	
		    	if(departments.department==null || departments.department==''|| !target1){
					alert('科室名必须为中文、英文或者数字组合！');
					$("#department1").focus();
					return false;
				}
		    	else if(departments.person==null || departments.person==''|| !target2){
		    		alert('管理员姓名必须为中文！');
					$("#person1").focus();
					return false;
		    	}
		    	else if(departments.account==null || departments.account==''|| !target3){
		    		alert('该管理员账号必须为英文或者数字组合！');
					$("#account1").focus();
					return false;
		    	}
		    	else if(departments.passwd==null || departments.passwd==''|| !target4){
		    		alert('该管理员密码必须为英文或者数字组合！');
					$("#passwd1").focus();
					return false;
		    	}
		    	else if(departments.phone==null || departments.phone==''|| !target5){
		    		alert('请输入合法的管理员手机号！');
					$("#phone1").focus();
					return false;
		    	}
		    	else if(departments.address==null || departments.address==''|| !target6){
		    		alert('该科室地址必须为中文、英文或者数字组合！');
					$("#address1").focus();
					return false;
		    	}
		    	else{
		    		return true;
		    	}
		    }
		</script>
	</div>
	<script type="text/javascript">
		// 关闭科室添加卡片
		$(".fa_close_dept_add").click(function(){
			$(".dept_add_card").fadeOut(200);
		})
	</script>
	
	<div class="dept_edit_card">
		<i class="fa fa_close_dept_edit fa-close" title="关闭"></i>
		<form id="formEditDept" method="post">
			<p><span>原科室名：</span><input type="text" id="old_department" class="input" name="old_department" value="" autocomplete="off" readonly/></p>
			<p><span>新科室名：</span><input type="text" id="new_department" class="input" name="new_department" placeholder="请输入新的科室名" autocomplete="off" maxlength="20"/></p>
			<p><span>负责人：</span><input type="text" id="person2" class="input" name="person2" placeholder="请输入该科室新的负责人" autocomplete="off" maxlength="20"/></p>
			<p><span>手机号码：</span><input type="text" id="phone2" class="input" name="phone2" placeholder="请输入该科室新的负责人的手机号码" autocomplete="off" maxlength="11"/></p>
			<p><span>地点位置：</span><input type="text" id="address2" class="input" name="address2" placeholder="请输入该科室的新的地点位置" autocomplete="off" maxlength="20"/></p>
			<p><input type="button" id="submitEditDept" class="submit" value="完成"/></p>
		</form>
		<div class="abc">
			<input type="checkbox" class="js-switch checkbox"/>
		</div>
		<script type="text/javascript">
			//ios checkbox begin
			var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
			elems.forEach(function(html) {
			  var switchery = new Switchery(html);
			});
			//$('.abc .checkbox').prop("checked", false); // 初始化为false
			//$('.abc .checkbox').attr("checked", false);
			console.log(elems);
			//ios checkbox end
		</script>
	</div>
	<script type="text/javascript">
		// 关闭科室编辑卡片
		$(".fa_close_dept_edit").click(function(){
			$(".dept_edit_card").fadeOut(200);
		})
	</script>
				
	<div class="content">
		<div class="content_box">
			<div class="content_box_nav">
				<span>科室管理</span><a href="javascript:void(0)" class="dept_add">新建科室</a>
			</div>
			<hr/>
			<div class="content_box_body">
				<div class="content_box_body_dept">
					<c:forEach var="a_dept_list"  items="${list}">
						<span class="dept_list_span">
							<i class="fa fa_text_dept_update fa-link edit_add" title="编辑"></i>
							<b>${a_dept_list.department}</b>
							<input type="hidden" id="person2" value="${a_dept_list.person}"/>
							<input type="hidden" id="phone2" value="${a_dept_list.phone}"/>
							<input type="hidden" id="address2" value="${a_dept_list.address}"/>
							<input type="hidden" id="status2" value="${a_dept_list.status}"/>
						</span>
					</c:forEach>
				</div>
				<script type="text/javascript">
					$(function(){
						$(".content_box_body span:even").css("background","#fff");
						$(".content_box_body span:odd").css("background","rgb(249,250,252)");
					});
					
					$('.dept_list_span').each(function(e) {
						var span = $(this);//这里的this指向 span
						span.find('.edit_add').each(function(){
						    var edit_add = $(this); // 这里this指向 edit_add
						    var b_tar = span.find('b');
						    var b_text = span.find('b').text();
						    var person2 = span.find('#person2').val();
						    var phone2 = span.find('#phone2').val();
						    var address2 = span.find('#address2').val();
						    var statusv = span.find('#status2').val();
						    if(statusv == 1){
						    	span.find(".fa-link").css("color","rgb(61,168,245)");
						    }
						    else{
						    }
						    edit_add.on("click",function(){
						    	$(".user_set_card").css("display","none");
								$(".dept_add_card").css("display","none");
								$(".dept_edit_card").fadeIn(200);
						    	$("#old_department").val(b_text);
						    	$("#new_department").val(b_text);
						    	$("#person2").val(person2);
						    	$("#phone2").val(phone2);
						    	$("#address2").val(address2);
						    	//console.log(statusv);
						    	if (statusv == 1) {
									$(".abc small").css("left","20px");
						    		$(".abc span").css("background-color","rgb(100, 189, 99)");
						    		$(".abc span").css("border-color","rgb(100, 189, 99)");
						    		$(".abc span").css("box-shadow","rgb(100, 189, 99) 0px 0px 0px 16px inset");
						    		$(".abc span").css("transition","border 0.4s ease 0s, box-shadow 0.4s ease 0s, background-color 1.2s ease 0s;");
						    		$('.abc .checkbox').prop("checked", true);
									//console.log($(".abc .checkbox"));
								}else{
									$(".abc small").css("left","0px");
									$(".abc span").css("background-color","rgb(255, 255, 255)");
						    		$(".abc span").css("border-color","rgb(223, 223, 223)");
						    		$(".abc span").css("box-shadow","rgb(223, 223, 223) 0px 0px 0px 0px inset");
						    		$(".abc span").css("transition","border 0.4s ease 0s, box-shadow 0.4s ease 0s");
						    		$('.abc .checkbox').prop("checked", false);
									//console.log($(".abc .checkbox"));
								}
						    });
						})
					});
					
					function validateEdit(departments){
						var regu1 = /^[\u0391-\uFFE5A-Za-z0-9]+$/;// 只能输入中文 英文 数字 - 验证科室名
				    	var re1 = new RegExp(regu1);
				    	var target1 = re1.test(departments.new_department);
				    	
				    	var regu2 = /^[\u0391-\uFFE5]+$/;// 验证中文 - 验证管理员姓名
				    	var re2 = new RegExp(regu2);
				    	var target2 = re2.test(departments.person);
				    	
				    	var regu5 =/^[1][3,4,5,7,8,9][0-9]{9}$/;// 只能输入数字 - 验证手机号
				    	var re5 = new RegExp(regu5);
				    	var target5 = re5.test(departments.phone);
				    	
				    	var regu6 = /^[\u0391-\uFFE5A-Za-z0-9]+$/;// 只能输入中文 英文 数字 - 验证地址
				    	var re6 = new RegExp(regu6);
				    	var target6 = re6.test(departments.address);
				    	
				    	if(departments.new_department==null || departments.new_department==''|| !target1){
							alert('科室名必须为中文、英文或者数字组合！');
							$("#new_department").focus();
							return false;
						}
				    	else if(departments.person==null || departments.person==''|| !target2){
				    		alert('管理员姓名必须为中文！');
							$("#person2").focus();
							return false;
				    	}
				    	else if(departments.phone==null || departments.phone==''|| !target5){
				    		alert('请输入合法的管理员手机号！');
							$("#phone2").focus();
							return false;
				    	}
				    	else if(departments.address==null || departments.address==''|| !target6){
				    		alert('该科室地址必须为中文、英文或者数字组合！');
							$("#address2").focus();
							return false;
				    	}
				    	else{
				    		return true;
				    	}
				    }
					
					$("#submitEditDept").click(function () {
				    	var departments = {
				    		old_department : $("#old_department").val(),
				    		new_department : $("#new_department").val(),
				    		person : $("#person2").val(),
				    		phone : $("#phone2").val(),
				    		address : $("#address2").val()
				    	};
				    	console.log(departments);
				    	if(validateEdit(departments)){
					    	$.ajax({
					            url: "<%=updateDeptPath%>",
					            type: "POST",
					            dataType: "json",
					            contentType:"application/json;charset=UTF-8",
					            data: JSON.stringify(departments),
					            success: function(data) {// 成功
					 				//alert(data.status);
					 				if(data.status == "fail2"){
					 					alert(departments.new_department+"已重复，请重新更改！");
					 				}
					 				else if(data.status == "fail1"){
					 					alert(departments.new_department+"修改成功，患者未能同步，请重新操作！");
					 					window.location.href="<%=deptPath%>";
					 				}
					 				else if(data.status == "success"){
					 					alert(departments.new_department+"修改成功，患者同步完成！");
					 					window.location.href="<%=deptPath%>";
					 				}
					 				else{}
					            }
					        });
				    	}
					});
					
					$(".abc .switchery").click(function () {
						$('.abc .checkbox').click();
					});
					
					$('.abc .checkbox').click(function () {
						var data1 = {
							xdepart : $("#old_department").val(),
							xstatus : 1,
						}

						var data2 = {
							xdepart : $("#old_department").val(),
							xstatus : 0,
						}
						
						if ($(this).prop("checked")) {
							var textrs = confirm("确定开启该科室？开启之后管理员可登录该科室的后台系统！");
							if(textrs == true){
								$(".abc small").css("left","0px");
								$(".abc span").css("background-color","rgb(255, 255, 255)");
					    		$(".abc span").css("border-color","rgb(223, 223, 223)");
					    		$(".abc span").css("box-shadow","rgb(223, 223, 223) 0px 0px 0px 0px inset");
					    		$(".abc span").css("transition","border 0.4s ease 0s, box-shadow 0.4s ease 0s");
								//console.log(data1);
								//console.log($(".abc .checkbox"));
								$('.abc .checkbox').prop("checked", false);
								
								$.ajax({
									url:'<%=updateStatusPath%>',
									type:'post',
									dataType:'json',
									contentType:"application/json;charset=UTF-8",
									data: JSON.stringify(data1),
									success:function(data){
										//console.log(data);
										//if(data.status == "success"){}
										setInterval("window.location='/Huarui/admin/dept'",500);
										
									}
								});
							}						
						} else {
							var textrs = confirm("确定关闭该科室？关闭之后管理员不可登录该科室的后台系统！");
							if(textrs == true){
								$(".abc small").css("left","20px");
					    		$(".abc span").css("background-color","rgb(100, 189, 99)");
					    		$(".abc span").css("border-color","rgb(100, 189, 99)");
					    		$(".abc span").css("box-shadow","rgb(100, 189, 99) 0px 0px 0px 16px inset");
					    		$(".abc span").css("transition","border 0.4s ease 0s, box-shadow 0.4s ease 0s, background-color 1.2s ease 0s;");
								//console.log(data2);
								//console.log($(".abc .checkbox"));
								$('.abc .checkbox').prop("checked", true);
								$.ajax({
									url:'<%=updateStatusPath%>',
									type:'post',
									dataType:'json',
									contentType:"application/json;charset=UTF-8",
									data: JSON.stringify(data2),
									success:function(data){
										//console.log(data);
										//if(data.status == "success"){}
										setInterval("window.location='/Huarui/admin/dept'",500);
									}
								});
							}
						}
					});
				</script>
			</div>
		</div>
	</div>
	
</section>