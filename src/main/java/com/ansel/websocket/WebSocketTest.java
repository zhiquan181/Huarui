package com.ansel.websocket;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;
import javax.annotation.Resource;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import com.ansel.service.IAdminService;

/**
 * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 * 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 * @ServerEndpoint("/websocket")
 */

@ServerEndpoint("/websocket")
public class WebSocketTest {
	//静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
	private static int onlineCount = 0;
	//concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
	private static CopyOnWriteArraySet<WebSocketTest> webSocketSet = new CopyOnWriteArraySet<WebSocketTest>();
	//与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;
	
//	MyWsThread mywsthread=new MyWsThread();
//	Thread thread=new Thread(mywsthread);

	/**
	 * 连接建立成功调用的方法
	 * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
	 */
	@OnOpen
	public void onOpen(Session session){
		this.session = session;
		webSocketSet.add(this);     //加入set中
		addOnlineCount();           //在线数加1
		System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
//		thread.start();
	}

	/**
	 * 连接关闭调用的方法
	 */
	@OnClose
	public void onClose(){
		webSocketSet.remove(this);  //从set中删除
		subOnlineCount();           //在线数减1
		System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
	}

	/**
	 * 收到客户端消息后调用的方法
	 * @param message 客户端发送过来的消息
	 * @param session 可选的参数
	 */
	@OnMessage
	public void onMessage(String message, Session session) {
		System.out.print("front client:" + message);
		//群发消息
		for(WebSocketTest item: webSocketSet){

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mvc", "root", "");
				String sql = "select * from device";
				Statement statement = null;
				statement = connection.createStatement();
				ResultSet rs = statement.executeQuery(sql);
				// System.out.println("--"+resultSet.next()+"--");//集合为空则返回false，注意此处已使用一次resultSet.next()

				StringBuffer sb = new StringBuffer();
				while (rs.next()) {
					if (rs.getInt(4) > 0) {
						if(rs.getDouble(2)<37.0) {
							sb.append("<span class='device'>");
							sb.append("<i>" + rs.getString(1) + "</i>");
							sb.append("<u class='ugreen'>" + rs.getString(2) + "℃</u>");
							sb.append("<s>" + rs.getString(3) + "</s>");
							sb.append("<a class='aorange' title='点击查看详情' href='/Huarui/admin/devicedetail?deviceid="+rs.getString(1)+"'></a>");
							sb.append("</span>");
						}else if(rs.getDouble(2) > 37.0&&rs.getDouble(2)<38.5){
							sb.append("<span class='device'>");
							sb.append("<i>" + rs.getString(1) + "</i>");
							sb.append("<u class='uyellow'>" + rs.getString(2) + "℃</u>");
							sb.append("<s>" + rs.getString(3) + "</s>");
							sb.append("<a class='aorange' title='点击查看详情' href='/Huarui/admin/devicedetail?deviceid="+rs.getString(1)+"'></a>");
							sb.append("</span>");
						}else if(rs.getDouble(2)>38.5) {
							sb.append("<span class='device'>");
							sb.append("<i>" + rs.getString(1) + "</i>");
							sb.append("<u class='ured'>" + rs.getString(2) + "℃</u>");
							sb.append("<s>" + rs.getString(3) + "</s>");
							sb.append("<a class='aorange' title='点击查看详情' href='/Huarui/admin/devicedetail?deviceid="+rs.getString(1)+"'></a>");
							sb.append("</span>");
						}
						
					} else {
						if(rs.getDouble(2)<37.0) {
							sb.append("<span class='device'>");
							sb.append("<i>" + rs.getString(1) + "</i>");
							sb.append("<u class='ugreen'>" + rs.getString(2) + "℃</u>");
							sb.append("<s>" + rs.getString(3) + "</s>");
							sb.append("<a class='agray' title='点击绑定患者' href=''>" + rs.getInt(4) + "</a>");
							sb.append("</span>");
						}else if(rs.getDouble(2) > 37.0&&rs.getDouble(2)<38.5){
							sb.append("<span class='device'>");
							sb.append("<i>" + rs.getString(1) + "</i>");
							sb.append("<u class='uyellow'>" + rs.getString(2) + "℃</u>");
							sb.append("<s>" + rs.getString(3) + "</s>");
							sb.append("<a class='agray' title='点击绑定患者' href=''>" + rs.getInt(4) + "</a>");
							sb.append("</span>");
						}else if(rs.getDouble(2)>38.5) {
							sb.append("<span class='device'>");
							sb.append("<i>" + rs.getString(1) + "</i>");
							sb.append("<u class='ured'>" + rs.getString(2) + "℃</u>");
							sb.append("<s>" + rs.getString(3) + "</s>");
							sb.append("<a class='agray' title='点击绑定患者' href=''>" + rs.getInt(4) + "</a>");
							sb.append("</span>");
						}
						
					}
				}
				System.out.println("--" + sb);
				String str = new String(sb);
				item.sendMessage(str);

				rs.close();
				statement.close();
				connection.close();
			}catch (Exception e) {
				continue;
			}
		}
	}

	/**
	 * 发生错误时调用
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error){
		System.out.println("发生错误");
		error.printStackTrace();
	}

	/**
	 * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
	 * @param message
	 * @throws IOException
	 */
	public void sendMessage(String message) throws IOException{
		this.session.getBasicRemote().sendText(message);
		//this.session.getAsyncRemote().sendText(message);
	}

	//获取在线数
	public static synchronized int getOnlineCount() {
		return onlineCount;
	}

	//在线数++
	public static synchronized void addOnlineCount() {
		WebSocketTest.onlineCount++;
	}

	//在线数--
	public static synchronized void subOnlineCount() {
		WebSocketTest.onlineCount--;
	}
	
	
	
}
