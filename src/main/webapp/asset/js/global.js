// 禁止鼠标右键
document.onkeydown=function(){
	if(event.ctrlKey){
		return false;
	}	
}

// 屏蔽ctrl按键
document.oncontextmenu=new Function("event.returnValue=false;");
document.onselectstart=new Function("event.returnValue=false;");