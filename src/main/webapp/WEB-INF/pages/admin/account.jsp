<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.formbox_account{width:auto;height:200px;background-color: none;position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;}
.formbox_account form{width: 350px;height:auto;display:inline-block;margin: auto;position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;}
.formbox_account form p{display: block;width:auto;height:40px;text-align: center;margin:15px auto 0 auto;clear: both;}
.formbox_account form p span{display: inline-block;float: left;text-align:left;width: 100px;height: 40px;line-height:40px;background-color: none;}
.formbox_account form p .input{display: inline-block;float: left;width: 250px;height: 40px;background-color: #fff;border: 1px solid #e5e5e5;border-radius: 3px;color: #383838;-webkit-transition: border-color ease-in-out 0.15s;-o-transition: border-color ease-in-out 0.15s;transition: border-color ease-in-out 0.15s;outline: none;padding: 0px 20px 0px 20px;}
.formbox_account form p .submit{width: 350px;height:40px;background-color: rgb(145,206,249);color:#fff;font-size: 14px;outline: none;border: none;cursor: pointer;transition: ease background-color .3s;-moz-transition: ease background-color .3s;/* Firefox 4 */-webkit-transition: ease background-color .3s;/* Safari 和 Chrome */-o-transition: ease background-color .3s;/* Opera */}
.formbox_account form p .submit:hover{background-color: rgb(61,168,245);}
.fa_texta{font-size:17px;position: absolute;top:0;right:40px;padding:6px;color: #909090;cursor:pointer;transition: ease background-color .5s;-moz-transition: ease background-color .5s;/* Firefox 4 */-webkit-transition: ease background-color .5s;/* Safari 和 Chrome */-o-transition: ease background-color .5s;/* Opera */}
.fa_texta:hover{color:rgb(61,168,245);}
</style>
<%
String saveAccount = request.getContextPath()+"/admin/saveaccount";
%>

<div class="formbox_account">
	<form>
		<input type="hidden" id="u_id" name="id" value="${admin.id}" maxlength="10" autocomplete="off">
		<p><span>系统账号：</span><input type="text" class="input input_account" id="u_account" readonly name="account" value="${admin.account}" maxlength="10" autocomplete="off"/></p>
		<p><span>系统密码：</span><input type="text" class="input input_account" id="u_password" readonly name="password" value="${admin.password}" maxlength="20" autocomplete="off"/></p>
		<p><input type="button" id="saveAccount" class="submit" value="保存" /></p>
	</form>
</div>

<div>
	<i class="fa fa_texta fa-file-text" title="编辑"></i>
</div>
<script>
	$(".fa_texta").click(function(){
		$('.input_account').removeAttr("readonly");
	});
	
	$("#saveAccount").click(function () {
    	var accounts = {
    		id : $("#u_id").val(),
    		account : $("#u_account").val(),
    		passwd : $("#u_password").val()
    	};
    	
    	console.log(accounts);
    	
    	if(account_validate(accounts)){
	    	$.ajax({
	            url: "<%=saveAccount%>",
	            type: "POST",
	            dataType: "json",
	            contentType:"application/json;charset=UTF-8",
	            data: JSON.stringify(accounts),
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
    	
    	function account_validate(accounts){
    		var regu3 = /^[A-Za-z0-9]+$/;// 只能输入英文 数字 - 验证账号
	    	var re3 = new RegExp(regu3);
	    	var target3 = re3.test(accounts.account);
	    	
	    	var regu4 = /^[A-Za-z0-9]+$/;// 只能输入英文 数字 - 验证密码
	    	var re4 = new RegExp(regu4);
	    	var target4 = re4.test(accounts.passwd);
	    	
	    	if(accounts.account==null || accounts.account==''|| !target3){
	    		alert('该管理员账号必须为英文或者数字组合！');
				$("#u_account").focus();
				return false;
	    	}
	    	else if(accounts.passwd==null || accounts.passwd==''|| !target4){
	    		alert('该管理员密码必须为英文或者数字组合！');
				$("#u_password").focus();
				return false;
	    	}
	    	else{
	    		return true;
	    	}
	    }
    	
    });

</script>