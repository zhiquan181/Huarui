<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.formbox_config{width:auto;height:280px;background-color: none;position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;}
.formbox_config form{width: 350px;height:auto;display:inline-block;margin: auto;position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;}
.formbox_config form p{display: block;width:auto;height:40px;text-align: center;margin:15px auto 0 auto;clear: both;}
.formbox_config form p span{display: inline-block;float: left;text-align:left;width: 100px;height: 40px;line-height:40px;background-color: none;}
.formbox_config form p .input{display: inline-block;float: left;width: 250px;height: 40px;background-color: #fff;border: 1px solid #e5e5e5;border-radius: 3px;color: #383838;-webkit-transition: border-color ease-in-out 0.15s;-o-transition: border-color ease-in-out 0.15s;transition: border-color ease-in-out 0.15s;outline: none;padding: 0px 20px 0px 20px;}
.formbox_config form p .submit{width: 350px;height:40px;background-color: rgb(145,206,249);color:#fff;font-size: 14px;outline: none;border: none;cursor: pointer;transition: ease background-color .3s;-moz-transition: ease background-color .3s;/* Firefox 4 */-webkit-transition: ease background-color .3s;/* Safari 和 Chrome */-o-transition: ease background-color .3s;/* Opera */}
.formbox_config form p .submit:hover{background-color: rgb(61,168,245);}
.fa_textc{font-size:17px;position: absolute;top:0;right:40px;padding:6px;color: #909090;cursor:pointer;transition: ease background-color .5s;-moz-transition: ease background-color .5s;/* Firefox 4 */-webkit-transition: ease background-color .5s;/* Safari 和 Chrome */-o-transition: ease background-color .5s;/* Opera */}
.fa_textc:hover{color:rgb(61,168,245);}
</style>
<%
String saveInfo = request.getContextPath()+"/admin/saveinfo";
%>

<div class="formbox_config">
	<form>
		<p><span>系统标题：</span><input type="text" class="input input_config" id="u_title" readonly name="config_title" value="${list[0].value}" maxlength="30" autocomplete="off"/></p>
		<p><span>医院名称：</span><input type="text" class="input input_config" id="u_name" readonly name="config_name" value="${list[1].value}" maxlength="30" autocomplete="off"/></p>
		<p><span>联系电话：</span><input type="text" class="input input_config" id="u_contact" readonly name="config_contact" value="${list[2].value}" maxlength="11" autocomplete="off"/></p>
		<p><span>医院地址：</span><input type="text" class="input input_config" id="u_address" readonly name="config_address" value="${list[3].value}" maxlength="30" autocomplete="off"/></p>
		<p><input type="button" id="saveConfig" class="submit" value="保存"/></p>
	</form>
</div>

<div>
	<i class="fa fa_textc fa-file-text" title="编辑"></i>
</div>
<script>
	$(".fa_textc").click(function(){
		$('.input_config').removeAttr("readonly");
	});
	
	$("#saveConfig").click(function () {
    	var configs = {
    		title : $("#u_title").val(),
    		name : $("#u_name").val(),
    		contact : $("#u_contact").val(),
    		address : $("#u_address").val()
    	};
    	
    	console.log(configs);
    	
    	if(config_validate(configs)){
	    	$.ajax({
	            url: "<%=saveInfo%>",
	            type: "POST",
	            dataType: "json",
	            contentType:"application/json;charset=UTF-8",
	            data: JSON.stringify(configs),
	            success: function(data) {// 成功
	 				//alert(data.status);
	 				if(data.status == "fail"){
	 					alert("保存失败，请重新保存！");
	 				}
	 				else if(data.status == "success"){
	 					alert("保存成功！");
	 					location=location;
	 				}
	 				else{}
	            }
	        });
    	}
    	
    	function config_validate(configs){
    		var regu1 = /^[\u0391-\uFFE5A-Za-z0-9]+$/;// 只能输入中文 英文 数字 - 验证系统标题
	    	var re1 = new RegExp(regu1);
	    	var target1 = re1.test(configs.title);
    		
    		var regu2 = /^[\u0391-\uFFE5A-Za-z0-9]+$/;// 只能输入中文 英文 数字 - 验证医院名称
	    	var re2 = new RegExp(regu2);
	    	var target2 = re2.test(configs.name);
	    	
	    	var regu3 =/^[1][3,4,5,7,8,9][0-9]{9}$/;// 只能输入数字 - 验证联系电话
	    	var re3 = new RegExp(regu3);
	    	var target3 = re3.test(configs.contact);
	    	
	    	var regu4 = /^[\u0391-\uFFE5A-Za-z0-9]+$/;// 只能输入中文 英文 数字 - 验证医院地址
	    	var re4 = new RegExp(regu4);
	    	var target4 = re4.test(configs.address);
	    	
	    	if(configs.title==null || configs.title==''|| !target1){
	    		alert('该系统标题为英文或者数字组合！');
				$("#u_title").focus();
				return false;
	    	}
	    	else if(configs.name==null || configs.name==''|| !target2){
	    		alert('该医院名称为英文或者数字组合！');
				$("#u_name").focus();
				return false;
	    	}
	    	else if(configs.contact==null || configs.contact==''|| !target3){
	    		alert('请输入合法的管理员手机号！');
				$("#u_contact").focus();
				return false;
	    	}
	    	else if(configs.address==null || configs.address==''|| !target4){
	    		alert('该医院地址为英文或者数字组合！');
				$("#u_address").focus();
				return false;
	    	}
	    	else{
	    		return true;
	    	}
	    }
    	
    });
</script>