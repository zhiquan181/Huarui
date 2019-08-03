package com.ansel.socketshort;

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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
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
                System.out.println(socket.getInetAddress() + ":" + socket.getPort()+" 收到数量：" + readCount + " 数据：" + i + " " + str + "\n");
                ///192.168.1.100:21782 收到数量：23 数据：1413827920 +RC0123456789+27.23
//                if(str.length()>0) {
                	String deviceId = str.substring(1,13);
                	String temperature = str.substring(14,19);
                	System.out.println("--"+deviceId+"--"+temperature+"--");
                	//Mysql Conn
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mvc","root","");
                        System.out.println("--连接mysql成功--");
                        String sql = "select deviceid from device where deviceid = ?";
                        System.out.println("--select--"+sql);//--select--select * from device where deviceid = 'RC0123456789'
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1,deviceId);
                        ResultSet rs = ps.executeQuery();
                        //System.out.println("--"+rs.next()+"--");//集合为空则返回false，注意此处已使用一次resultSet.next()
                        if(rs.next()) {
                        	//update
                        	String sql1 = "update device set temperature=?,datestr=? where deviceid=?";
                        	System.out.println("--update--"+sql1);
                        	ps = conn.prepareStatement(sql1);
                        	ps.setString(1,temperature);
                        	ps.setTimestamp(2,new Timestamp(new Date().getTime()));
                        	ps.setString(3,deviceId);
                        	ps.executeUpdate();
                        }else {
                        	//insert
                        	String sql2 = "insert into device(deviceid,temperature,datestr,status)values(?,?,?,?)";
                        	System.out.println("--insert--"+sql2);
                        	ps = conn.prepareStatement(sql2);
                        	ps.setString(1,deviceId);
                        	ps.setString(2,temperature);
                        	ps.setTimestamp(3,new Timestamp(new Date().getTime()));
                        	ps.setInt(4,0);
                        	ps.executeUpdate();
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                        
                        //txt
                        try{
                        	File file =new File("F:\\device\\"+deviceId+".txt");
                        	if(!file.exists()){file.createNewFile();}
                        	FileWriter fw = new FileWriter(file.getAbsoluteFile(),true);
                        	BufferedWriter bw = new BufferedWriter(fw);
                        	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        	//System.out.println(sdf.format(new Date()));//2019-08-01 12:06:53
                        	//bw.write(deviceId+";"+temperature+";"+sdf.format(new Date())+"\r\n");
                        	long time = (new Date().getTime());
                        	bw.write("["+time+","+temperature+"],\r\n");
                        	bw.close();
                        	fw.close();
                        }catch (Exception e) {
                        	System.out.println("--写入失败--");
							// TODO: handle exception
						}
                        
                    }catch (Exception e) {
    					// TODO: handle exception
                    	System.out.println("--连接Mysql异常--");
    				}
//                }
                
                // 这里可以测试socketimeout异常 ，  即 在客户端设置 socket.setSoTimeout(5000);
                //而服务端一直没有回写数据，在客户端就会抛出 java.net.SocketTimeoutException: Read timed out
                //outputStream.write(buffer, 0, readCount);
                //outputStream.close();
                //inputStream.close();

                //Thread.sleep(8000);
            } catch (Exception e) {
                System.out.println("连接无数据");
            } finally {
                System.out.println("连接关闭");
                try {
                    socket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            System.out.println("客户端已退出：" + socket.getInetAddress() + ":" + socket.getPort()+"\n");
        }
    }
}