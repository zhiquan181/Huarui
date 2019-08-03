package com.ansel.websocket;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.Connection;

public class Server {
    private static final int PORT = 8080;

    public static void main(String[] args) throws IOException {
        ServerSocket server = new ServerSocket();
        // 是否复用未完全关闭的地址端口
        server.setReuseAddress(true);
        // 等效Socket#setReceiveBufferSize
        server.setReceiveBufferSize(64 * 1024 * 1024);
        // 设置serverSocket#accept超时时间
       // server.setSoTimeout(2000);
        // 设置性能参数：短链接，延迟，带宽的相对重要性
        server.setPerformancePreferences(1, 1, 1);
        // 绑定到本地端口上
        server.bind(new InetSocketAddress(Inet4Address.getLocalHost(), PORT), 50);
        System.out.println("服务器start～");
        System.out.println("服务器信息：" + server.getInetAddress() + ":" + server.getLocalPort()+"\n");

        // 等待客户端连接
        for (; ; ) {
            // 得到客户端
            Socket client = server.accept();
            // 客户端构建异步线程
            ClientHandler clientHandler = new ClientHandler(client);
            // 启动线程
            clientHandler.start();
        }

    }

    /**
     * 客户端消息处理
     */
    private static class ClientHandler extends Thread {
        private Socket socket;

        ClientHandler(Socket socket) {
            this.socket = socket;
        }
        
        @Override
        public void run() {
            System.out.println("新客户端连接：" + socket.getInetAddress() + ":" + socket.getPort());
            try {
                // 得到套接字流
                OutputStream outputStream = socket.getOutputStream();
                InputStream inputStream = socket.getInputStream();
                byte[] buffer = new byte[256];
                int readCount = inputStream.read(buffer);
                ByteBuffer byteBuffer = ByteBuffer.wrap(buffer, 0, readCount);
                // int
                int i = byteBuffer.getInt();
                // String
                int pos = byteBuffer.position();
                String str = new String(buffer, pos, readCount - pos);
                //System.out.println(socket.getInetAddress() + ":" + socket.getPort()+" 收到数量：" + readCount + " 数据：" + i + " " + str + "\n");
                ///192.168.1.100:21782 收到数量：23 数据：1413827920 +RC0123456789+27.23
                String deviceId = str.substring(1,13);
                String temperature = str.substring(14,19);
                System.out.println("--"+deviceId+"--"+temperature+"--"+deviceId.isEmpty()+"--"+temperature.isEmpty());
                
//                if(!deviceId.isEmpty()&&!temperature.isEmpty()) {
                	//Mysql Conn
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mvc","root","");
                        //System.out.println("--连接mysql数据库成功--");
                        String sql = "select * from device where deviceid = '"+deviceId+"'";
                        System.out.println("--select--"+sql);//--select--select * from device where deviceid = 'RC0123456789'
                        Statement statement = null;
                        statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery(sql);
                        //System.out.println("--"+resultSet.next()+"--");//集合为空则返回false，注意此处已使用一次resultSet.next()
                        if(resultSet.next()) {
                        	//update
                        	String sqlUpdate = "update device set temperature = '"+temperature+"' where deviceid = '"+deviceId+"'";
                        	System.out.println("--update--"+sqlUpdate);//--update--update device set temperature = '27.07' where deviceid = 'RC0123456789'
                        	statement.executeUpdate(sqlUpdate);
                        }else {
                        	//insert
                        	Date date = new Date();
                        	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss.SSS");
                        	String createat = sdf.format(date);
                        	System.out.println(createat);
                        	String sqlInsert = "insert into device(deviceid,temperature)values('"+deviceId+"','"+temperature+"')";
//                        	String sqlInsert = "insert into device(deviceid,temperature,createat,status)values('"+deviceId+"','"+temperature+"','"+createat+"','0')";
                        	System.out.println("--insert--"+sqlInsert);//--insert--insert into device(deviceid,temperature)values('RC0123456888','24.46')
                        	statement.executeUpdate(sqlInsert);
                        }
                        resultSet.close();
                        statement.close();
                        connection.close();
                    }catch (Exception e) {
    					// TODO: handle exception
                    	System.out.println("连接Mysql异常");
    				}
//                }
                
                
                
                // 这里可以测试socketimeout异常 ，  即 在客户端设置 socket.setSoTimeout(5000);
                //而服务端一直没有回写数据，在客户端就会抛出 java.net.SocketTimeoutException: Read timed out
                //outputStream.write(buffer, 0, readCount);
                //outputStream.close();
                //inputStream.close();

                //Thread.sleep(8000);
            } catch (Exception e) {
                System.out.println("连接异常断开");
            } finally {
                System.out.println("连接关闭");
                try {
                    socket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("客户端已退出：" + socket.getInetAddress() + " P:" + socket.getPort()+"\n");
        }
    }
}