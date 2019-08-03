<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.formbox_account{width:auto;height:400px;background-color: none;position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;}
.formbox_account form{width: 350px;height:auto;display:inline-block;margin: auto;position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;}
.formbox_account form p{display: block;width:auto;height:40px;text-align: center;margin:15px auto 0 auto;clear: both;}
.formbox_account form p span{display: inline-block;float: left;text-align:left;width: 100px;height: 40px;line-height:40px;background-color: none;}
.formbox_account form p .input{display: inline-block;float: left;width: 250px;height: 40px;background-color: #fff;border: 1px solid #e5e5e5;border-radius: 3px;color: #383838;-webkit-transition: border-color ease-in-out 0.15s;-o-transition: border-color ease-in-out 0.15s;transition: border-color ease-in-out 0.15s;outline: none;padding: 0px 20px 0px 20px;}
</style>

<div class="formbox_account">
	<form>
		<p><span>科室名：</span><input type="text" class="input input_account" id="" readonly name="department" value="${manager.department}" maxlength="20" autocomplete="off"/></p>
		<p><span>负责人：</span><input type="text" class="input input_account" id="" readonly name="person" value="${manager.person}" maxlength="20" autocomplete="off"/></p>
		<p><span>账号：</span><input type="text" class="input input_account" id="" readonly name="account" value="${manager.account}" maxlength="20" autocomplete="off"/></p>
		<p><span>密码：</span><input type="text" class="input input_account" id="" readonly name="passwd" value="${manager.passwd}" maxlength="20" autocomplete="off"/></p>
		<p><span>手机号码：</span><input type="text" class="input input_account" id="" readonly name="phone" value="${manager.phone}" maxlength="11" autocomplete="off"/></p>
		<p><span>地点位置：</span><input type="text" class="input input_account" id="" readonly name="address" value="${manager.address}" maxlength="20" autocomplete="off"/></p>
		<p><span>科室状态：</span><input type="text" class="input input_account" id="" readonly name="status" value="${manager.status}" maxlength="20" autocomplete="off"/></p>
	</form>
</div>
