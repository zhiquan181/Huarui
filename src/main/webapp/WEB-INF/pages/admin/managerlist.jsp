<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	$(document).ready(function(){	
		// 点击头像
		$(".header_right_img").click(function(){
			$(".header_right_img_ul").fadeToggle(200);
		});
		
		// 打开科室信息
		$(".header_right_img_ul_set").click(function(){
			$(".user_set_card").fadeToggle(200);
			$(".system_set_card").css("display","none");
		});
	
		// 关闭科室信息
		$(".fa_close_user_set").click(function(){
			$(".user_set_card").fadeOut(200);
		})
	});
</script>

<div class="user_set_card">
	<i class="fa fa_close_user_set fa-close" title="关闭"></i>
	<div class="account_formbox">
		<jsp:include page="/WEB-INF/pages/admin/manager_account.jsp"/>
	</div>
</div>
<script>
	// 关闭科室信息卡片
	$(".fa_close_user_set").click(function(){
		$(".user_set_card").fadeOut(200);
	})
</script>

<section class="container">
	<div class="content">
		<div class="content_box">
    		<div>
    			<p id="div_p"></p>
    		</div>
		</div>
	</div>
</section>

<script type="text/javascript">
    // 创建 WS
    var websocket = null;
    
	// 判断当前浏览器是否支持WS
	if ('WebSocket' in window) {
	    websocket = new WebSocket("ws://localhost:8081/Huarui/websocket");
	}
	else {
	    alert('当前浏览器 Not support websocket')
	}
    
    // 错误回调
    websocket.onerror = function () {
    	 console.log("WebSocket连接发生错误");
    };
    
    //websocket 打开连接
    websocket.onopen = function(){
        console.log('开启 WebSocket连接 -- OK');
        sayMsg();//前端连接之后发送'1'到后端WS
    };
    
    //websocket 解析数据
    websocket.onmessage = function(e){
    	//console.log('客户端 get message: ',e.data);
        $("#div_p").replaceWith("<p id='div_p'>"+
        		e.data
        +"</p>");
        
        setTimeout(function(){sayMsg()},3000);//每5s发一次
    };
    
    //websocket 关闭行为
    websocket.onclose = function(){
        console.log('关闭  websocket 连接 -- OK');
    };

    function sayMsg() {
        websocket.send('1');
    }
</script>