package com.ansel.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.ansel.bean.Auser;
import com.ansel.bean.Config;
import com.ansel.bean.Dept;
import com.ansel.bean.Point;
import com.ansel.service.IAdminService;
import com.ansel.util.PagerAuser;
import com.ansel.util.PagerPatient;
import com.github.pagehelper.PageInfo;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@Controller
public class Admin {

	@Resource
	private IAdminService adminService;
	
	/*
	 * 作     用：跳转到后台登录页面
	 * 控制器：admin/dologin
	 * 方法名：dologin
	 */
	@RequestMapping(value = "admin/dologin")
	public ModelAndView dologin() {		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/login");
		return mv;
	}

	/*
	 * 作     用：后台管理员登录
	 * 控制器：admin/login
	 * 方法名：login
	 */
	@RequestMapping(value = "admin/login",method = RequestMethod.POST)
	public ModelAndView login(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView();
		String account = String.valueOf(request.getParameter("account"));
		String password = String.valueOf(request.getParameter("password"));
		String radio = String.valueOf(request.getParameter("radio"));
		System.out.println("Infomation："+account+" "+password+" "+radio);
		if(radio.equals("2")) {
			Auser auser = this.adminService.checkAuser(account,password);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if (auser != null) {
				// session.setAttribute()与request.getSession().setAttribute()
				session.setAttribute("admin",auser);
				mv.setViewName("redirect:system");
			} else {
				// 该用户不存在，跳转到后台登录页面
				out.println("<script language='javascript'>");
				out.println("alert('该用户不存在！')");
				out.println("</script>");
				out.flush();
				mv.setViewName("admin/login");
			}
		}
		else if(radio.equals("1")) {
			Dept manager = this.adminService.checkDept(account,password);
			response.setContentType("text/html; charset=UTF-8");
			if (manager != null) {
				// session.setAttribute()与request.getSession().setAttribute()
				session.setAttribute("manager",manager);
				mv.setViewName("redirect:manager");
			} else {
				// 该用户不存在，跳转到后台登录页面
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript'>");
				out.println("alert('该用户不存在！')");
				out.println("</script>");
				out.flush();
				mv.setViewName("admin/login");
			}
		}
		else {
			// 该用户不存在，跳转到后台登录页面
			PrintWriter out = response.getWriter();
			out.println("<script language='javascript'>");
			out.println("alert('该用户不存在！')");
			out.println("</script>");
			out.flush();
			mv.setViewName("admin/login");
		}
		
		return mv;
	}
	
	/*
	 * 作     用：后台管理员登录成功，跳转后台主页
	 * 控制器：admin/system
	 * 方法名：system
	 */
	@RequestMapping(value = "admin/system")
	public ModelAndView system(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		List<Config> list = this.adminService.displayConfig();
		// request.setAttribute()仅在该url下可以获取到值
		request.setAttribute("list",list);
		mv.setViewName("admin/system");
		return mv;
	}
	
	/*
	 * 作     用：科室管理员登录成功，跳转科室后台主页
	 * 控制器：admin/manager
	 * 方法名：manager
	 */
	@RequestMapping(value = "admin/manager")
	public ModelAndView manager(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/manager");
		return mv;
	}
	
	/*
	 * 作     用：后台管理员注销登录，跳转后台登录页面
	 * 控制器：admin/loginout
	 * 方法名：loginout
	 */
	@RequestMapping(value = "admin/loginout")
	public ModelAndView loginout(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		request.getSession().removeAttribute("admin");
		mv.setViewName("admin/login");
		return mv;
	}
	
	/*
	 * 作     用：科室管理员注销登录，跳转后台登录页面
	 * 控制器：admin/mloginout
	 * 方法名：mloginout
	 */
	@RequestMapping(value = "admin/mloginout")
	public ModelAndView mloginout(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		request.getSession().removeAttribute("manager");
		mv.setViewName("admin/login");
		return mv;
	}
	
	/*
	 * 作     用：释放所有session对象，跳转后台登录页面
	 * 控制器：admin/clear
	 * 方法名：clear
	 */
	/*@RequestMapping(value = "admin/clear")
	public ModelAndView clear(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		request.getSession().invalidate();
		mv.setViewName("admin/login");
		return mv;
	}*/
	
	/*
	 * 作     用：输入/Huarui/admin地址
	 * 控制器：admin
	 * 方法名：admin
	 */
	@RequestMapping(value = "admin")
	public ModelAndView admin() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/login");
		return mv;
	}
		
	/*
	 * 作     用：后台管理员保存管理员账号密码
	 * 控制器：admin/saveaccount
	 * 方法名：saveaccount
	 */
	@ResponseBody
	@RequestMapping(value = "admin/saveaccount",method = RequestMethod.POST)
	public JSONObject saveaccount(@RequestBody String request_str,HttpSession session) throws IOException {
		//使用fastjson解析前端传过来的json数据
		//String转json
		JSONObject jsonObject = JSONObject.parseObject(request_str);
		//json转map
		Map<String,Object> map = (Map<String,Object>)jsonObject;
		//打印map {"passwd":"admin888","id":"101","account":"admin000"}
		//System.out.println(map);
		//entry遍历map
		//for (Map.Entry<String, Object> entry : map.entrySet()) { 
		//  System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue()); 
		//}
		//赋值
		int id = Integer.parseInt((String) map.get("id"));
		//当object为null 时，String.valueOf（object）的值是字符串”null”，而不是null！因此不使用String.valueOf()
		String account = (String)map.get("account");
		String password = (String)map.get("passwd");
		//System.out.println("infomation: "+id+" "+account+" "+password);
		int status = this.adminService.saveAccount(id,account,password);
		if(status>0) {
			Auser auser = this.adminService.checkAuser(account,password);
			if (auser != null) {
				session.setAttribute("admin",auser);
				jsonObject.put("status", "success");
			}else {
				jsonObject.put("status", "fail");
			}
		}
		else {
			jsonObject.put("status", "fail");
		}
		return jsonObject;
	}
	
	/*-------------------------------------------------------------------功能开始-------------------------------------------------------------------*/

	
	/*
	 * 作     用：后台管理员点击科室管理，跳转科室列表页面，显示科室
	 * 控制器：admin/dept
	 * 方法名：dept
	 */
	@RequestMapping(value = "admin/dept")
	public ModelAndView dept(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		List<Dept> list = this.adminService.displayDept();
		request.setAttribute("list",list);
		mv.setViewName("admin/dept");
		return mv;
	}
	
	
	/*
	 * 作     用：后台管理员添加所属科室 - ajax
	 * 控制器：admin/insertdept
	 * 方法名：insertdept
	 */
	@ResponseBody
	@RequestMapping(value = "admin/insertdept",method = RequestMethod.POST)
	public JSONObject insertdept(@RequestBody String request_department) throws IOException {
		//System.out.println(request_department);//{"address":"A区2楼","passwd":"zhiquan1231231231231","phone":"13414503051","person":"蔡智全","department":"妇科区","account":"zhiquan"}
		
		String[] departments = request_department.split(":");
		String department_arr = departments[5];//"妇科区","account"
		String person_arr = departments[4];//"蔡智全","department"
		String account_arr = departments[6];//"zhiquan"}
		String passwd_arr = departments[2];//"zhiquan1231231231231","phone"
		String phone_arr = departments[3];//"13414503051","person"
		String address_arr = departments[1];//"A区2楼","passwd"
		
		String department[] = department_arr.split(",");
		String person[] = person_arr.split(",");
		String account = account_arr;
		String passwd[] = passwd_arr.split(",");
		String phone[] = phone_arr.split(",");
		String address[] = address_arr.split(",");
		
		String department_str = department[0].replace("\"", "");
		String person_str = person[0].replace("\"", "");
		String account_str = account.replace("\"", "").replace("}", "");
		String passwd_str = passwd[0].replace("\"", "");
		String phone_str = phone[0].replace("\"", "");
		String address_str = address[0].replace("\"", "");
		//System.out.println(department_str+" "+person_str+" "+account_str+" "+passwd_str+" "+phone_str+" "+address_str);//妇科区 蔡智全 zhiquan zhiquan1231231231231 13414503051 A区2楼
		
		List<Dept> list = this.adminService.queryaccount(account_str);// 查询是否已存在账号
		//System.out.println(list);
		JSONObject jsonObject = new JSONObject();
		if(null == list || list.size() ==0) {
			Dept dept = new Dept(department_str,person_str,account_str,passwd_str,phone_str,address_str,1);
			int status = this.adminService.insertDept(dept);
			//System.out.println(status);
			if(status<=0) {
				jsonObject.put("status", "fail");
			}
			else {
				jsonObject.put("status", "success");
			}
		}else {
			jsonObject.put("status", "exist");
		}
		//System.out.println(jsonObject);
		return jsonObject;
	}
	
	
	/*
	 * 作     用：后台管理员修改所属科室 - ajax
	 * 控制器：admin/updatedept
	 * 方法名：updatedept
	 */
	@ResponseBody
	@RequestMapping(value = "admin/updatedept",method = RequestMethod.POST)
	public JSONObject updatedept(@RequestBody String request_department) throws IOException {
		//System.out.println(request_department);//{"address":"C区2楼","phone":"13567867586","person":"卡哇伊","old_department":"内科一区","new_department":"内科1区"}
		
		String[] departments = request_department.split(":");
		String old_department_arr = departments[4];//"内科一区","new_department"
		String new_department_arr = departments[5];//"内科1区"}
		String person_arr = departments[3];//"卡哇伊","old_department"
		String phone_arr = departments[2];//"13567867586","person"
		String address_arr = departments[1];//"C区2楼","phone"
		//System.out.println(old_department_arr+" "+new_department_arr+" "+person_arr+" "+phone_arr+" "+address_arr);
		
		String old_department[] = old_department_arr.split(",");
		String new_department = new_department_arr;
		String person[] = person_arr.split(",");
		String phone[] = phone_arr.split(",");
		String address[] = address_arr.split(",");
		
		String old_department_str = old_department[0].replace("\"", "");
		String new_department_str = new_department.replace("\"", "").replace("}", "");
		String person_str = person[0].replace("\"", "");
		String phone_str = phone[0].replace("\"", "");
		String address_str = address[0].replace("\"", "");
		//System.out.println(old_department_str+" "+new_department_str+" "+person_str+" "+phone_str+" "+address_str);
		
		int status = this.adminService.updateDept(old_department_str,new_department_str,person_str,phone_str,address_str);
		JSONObject jsonObject = new JSONObject();
		if(status>0) {
			int patients = this.adminService.updatePatients(old_department_str,new_department_str);
			if(patients>0) {
				//System.out.println(status+" "+patients);
				jsonObject.put("status", "success");
			}else {
				jsonObject.put("status", "fail1");
			}
		}
		else {
			jsonObject.put("status", "fail2");
		}
		// System.out.println(jsonObject);
		return jsonObject;
	}
	
	
	/*
	 * 作     用：后台管理员开启或关闭科属 - ajax
	 * 控制器：admin/updatestatus
	 * 方法名：updatestatus
	 */
	@ResponseBody
	@RequestMapping(value = "admin/updatestatus",method = RequestMethod.POST)
	public JSONObject updatestatus(@RequestBody String request_status) throws IOException {
		//System.out.println(request_status);//{"xstatus":0,"xdepart":"神经内科四区"}
		String[] departments = request_status.split(":");
		String xdepart_str = departments[2];//"神经内科四区"}
		String xstatus_str = departments[1].split(",")[0];//0,"xdepart"
		String xdepart = xdepart_str.replace("\"", "").replace("}", "");//神经内科四区
		String xstatus = xstatus_str.replace("\"", "");
		//System.out.println(xdepart+" "+xstatus);
		int status = this.adminService.updateStatus(xdepart,xstatus);
		//System.out.println(status);
		JSONObject jsonObject = new JSONObject();
		if(status<=0) {
			jsonObject.put("status", "fail");
		}
		else {
			jsonObject.put("status", "success");
		}
		// System.out.println(jsonObject);
		return jsonObject;
	}

	
	/*
	 * 作     用：后台管理员点击患者管理，跳转患者列表页面
	 * 控制器：admin/patient
	 * 方法名：patient
	 */
	@RequestMapping(value = "admin/patient")
	public ModelAndView patient() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/patient");
		return mv;
	}
	
	
	/*
	 * 作     用：后台管理员点击显示不存在已有科室的患者列表，跳转该页面
	 * 控制器：admin/patientnon
	 * 方法名：patientnon
	 */
	@RequestMapping(value = "admin/patientnon")
	public ModelAndView patientnon() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/patientnon");
		return mv;
	}
	
	
	// 无刷新异步加载显示患者列表 - ajax
    @RequestMapping(value = "admin/showpatient")
    @ResponseBody
    public void showpatient(@RequestParam(value = "searchPatient", required = false) String searchPatient,@RequestParam(value = "indexPage", required = false) Integer indexPage,HttpServletRequest request, HttpServletResponse response) {
    	System.out.println("搜索："+searchPatient);
    	//System.out.println("当前页："+indexPage);
    	//处理当前页小于等于0
    	if(indexPage<=0){indexPage=1;}
    	
        response.setCharacterEncoding("UTF-8");
        
        int currentPage = indexPage==null?1:indexPage;
        int totalSize = this.adminService.getTotalPatient(searchPatient);
        if(totalSize<=0){totalSize=0;}
        
        PagerPatient pager = new PagerPatient(currentPage,totalSize);
        int pagesize = pager.getPageSize();
        System.out.println("当前页："+currentPage+" 页面记录数："+pagesize+" 总数："+totalSize);
        List patients = this.adminService.getPatientPaging(searchPatient, currentPage, pagesize);
        System.out.println("结果集："+patients);

        //System.out.println(patients);
        //System.out.println(pager);
        
        //将多个集合放入MAP集合
        Map map = new HashMap();
        map.put("patients",patients);
        map.put("pager",pager);
        //System.out.println(map);
        
        String data = JSON.toJSONString(map);
        try {
            response.getWriter().write(data);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    
    // 无刷新异步加载显示不存在已有科室的患者列表 - ajax
    @RequestMapping(value = "admin/showpatientnon")
    @ResponseBody
    public void patientnon(@RequestParam(value = "indexPage", required = false) Integer indexPage,HttpServletRequest request, HttpServletResponse response) {
    	//System.out.println("当前页："+indexPage);
    	//处理当前页小于等于0
    	if(indexPage<=0){indexPage=1;}
    	
        response.setCharacterEncoding("UTF-8");
        
        int currentPage = indexPage==null?1:indexPage;
        //System.out.println("ok");
        int totalSize = this.adminService.getTotalPatientNon();
        
        PagerPatient pager = new PagerPatient(currentPage,totalSize);
        int pagesize = pager.getPageSize();
        List patients = this.adminService.getPatientPagingNon(currentPage, pagesize);

        //System.out.println(patients);
        //System.out.println(pager);
        
        //将多个集合放入MAP集合
        Map map = new HashMap();
        map.put("patients",patients);
        map.put("pager",pager);
        //System.out.println(map);
        
        String data = JSON.toJSONString(map);
        try {
            response.getWriter().write(data);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    
    /*
	 * 作     用：后台管理员点击系统用户，跳转系统用户列表页面
	 * 控制器：admin/auser
	 * 方法名：auser
	 */
	@RequestMapping(value = "admin/auser")
	public ModelAndView auser(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		//List<Dept> list = this.adminService.displayDept();
		//request.setAttribute("list",list);
		mv.setViewName("admin/auser");
		return mv;
	}
	
	
	// 无刷新异步加载显示管理员列表 - ajax
    @RequestMapping(value = "admin/showauser")
    @ResponseBody
    public void showauser(@RequestParam(value = "searchAuser", required = false) String searchAuser,@RequestParam(value = "indexPage", required = false) Integer indexPage,HttpServletRequest request, HttpServletResponse response) {
    	//System.out.println("搜索："+searchAuser);
    	//System.out.println("当前页："+indexPage);
    	//处理当前页小于等于0
    	if(indexPage<=0){indexPage=1;}
    	
        response.setCharacterEncoding("UTF-8");
        
        int currentPage = indexPage==null?1:indexPage;
        int totalSize = this.adminService.getTotalDeptAuser(searchAuser);
        
        PagerAuser pager = new PagerAuser(currentPage,totalSize);
        int pagesize = pager.getPageSize();
        List ausers = this.adminService.getDeptAuserPaging(searchAuser, currentPage, pagesize);

        //System.out.println(ausers);
        //System.out.println(pager);
        
        //将多个集合放入MAP集合
        Map map = new HashMap();
        map.put("ausers",ausers);
        map.put("pager",pager);
        //System.out.println(map);
        
        String data = JSON.toJSONString(map);
        try {
            response.getWriter().write(data);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
    
	/*
	 * 作     用：修改后台管理员 - ajax
	 * 控制器：admin/updateauser
	 * 方法名：updateauser
	 */
	@ResponseBody
	@RequestMapping(value = "admin/updateauser",method = RequestMethod.POST)
	public JSONObject updateauser(@RequestBody String request_auser) throws IOException {
		//System.out.println(request_auser);//{"passwd":"huarui01","department":"保健科","account":"huarui01"}
		
		String[] request_auser_str = request_auser.replace("{\"", "").replace("\"}", "").replace("\",", "").replace("\":", "").split("\"");
		//System.out.println(request_auser_str);//passwd"huarui01"department"保健科"account"huarui01
		
		String update_dept = request_auser_str[3];
		String update_account = request_auser_str[5];
		String update_passwd = request_auser_str[1];
		//System.out.println(update_dept+" "+update_account+" "+update_passwd);
		
		List<Dept> list = this.adminService.queryaccount(update_account);// 查询是否已存在账号
		//System.out.println(list);
		JSONObject jsonObject = new JSONObject();
		if(list.size() == 0) {
			int status = this.adminService.updateAuser(update_dept,update_account,update_passwd);
			if(status<=0) {
				jsonObject.put("status", "fail");
			}
			else {
				jsonObject.put("status", "success");
			}
		}
		else{
			jsonObject.put("status", "exist");
		}
		//System.out.println(jsonObject);
		return jsonObject;
	}


	/*
	 * 作     用：后台管理员保存系统信息
	 * 控制器：admin/saveinfo
	 * 方法名：saveinfo
	 */
	@ResponseBody
	@RequestMapping(value = "admin/saveinfo",method = RequestMethod.POST)
	public JSONObject saveinfo(@RequestBody String request_str,HttpSession session) throws IOException {
		//使用fastjson解析前端传过来的json数据
		//String转json
		JSONObject jsonObject = JSONObject.parseObject(request_str);
		//json转map
		Map<String,Object> map = (Map<String,Object>)jsonObject;
		//赋值
		//当object为null 时，String.valueOf（object）的值是字符串”null”，而不是null！因此不使用String.valueOf()
		String config_title = String.valueOf(map.get("title"));
		String config_name = String.valueOf(map.get("name"));
		String config_contact = String.valueOf(map.get("contact"));
		String config_address = String.valueOf(map.get("address"));
		int status = this.adminService.saveInfo(config_title,config_name,config_contact,config_address);
		if(status>0) {
			jsonObject.put("status", "success");
		}
		else {
			jsonObject.put("status", "fail");
		}
		return jsonObject;
	}
	
	
	
	
	/*
	 * 作     用：跳转设备详情页面
	 * 控制器：admin/devicedetail
	 * 方法名：devicedetail
	 */
	@RequestMapping(value = "admin/devicedetail")
	public ModelAndView devicedetail() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/devicedetail");
		return mv;
	}
	
	
	// 无刷新异步加载显示管理员列表 - ajax
    @RequestMapping(value = "admin/devicejsonp")
    @ResponseBody
    public void getdevicejsonp(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
//        String encoding = "UTF-8";
//        Map<String, Object> map = new HashMap();
//        List<Point> list = new ArrayList<Point>();
//        Point p = new Point();
//        p.setTimestamp("1564672919391");
//        p.setTemperature("36.52");
//        list.add(p);
//        map.put("0", list);
//        return map;

//        
//        File file = new File("F:\\device\\RC0123456789.txt");
//        Long filelength = file.length();  
//        byte[] filecontent = new byte[filelength.intValue()];
//        try {  
//            FileInputStream in = new FileInputStream(file);
//            in.read(filecontent);  
//            in.close(); 
//        } catch (IOException e) {
//        	
//        }
//        String s = null;
//        try {  
//        	s = new String(filecontent,encoding);
//        	s = "["+s+"]";
//        } catch (IOException e) {
//        	s = "";
//        }
//        
//        
//        try {
//            response.getWriter().write(s);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return s;
        
        
        
        
        
 
        

          StringBuffer sb = new StringBuffer();
          sb.append("[");
          
          sb.append("["+"1564672919391"+","+"25.00"+"],");
          sb.append("["+"1564672953687"+","+" 5.61"+"],");
          sb.append("["+"1564672986528"+","+"11.10"+"],");
          sb.append("["+"1564673019283"+","+"16.47"+"],");
          sb.append("["+"1564713764171"+","+"25.00"+"],");
          sb.append("["+"1564713798333"+","+" 5.38"+"],");
          sb.append("["+"1564713831208"+","+"10.62"+"],");
          sb.append("["+"1564713864013"+","+"15.82"+"],");
          sb.append("["+"1564713896782"+","+"21.02"+"],");
          sb.append("["+"1564713929652"+","+"26.22"+"],");
          sb.append("["+"1564713962459"+","+"26.03"+"],");
          sb.append("["+"1564715211511"+","+"40.35"+"],");
          sb.append("["+"1564715215266"+","+"40.54"+"],");
          sb.append("["+"1564715219093"+","+"38.46"+"],");
          sb.append("["+"1564715222983"+","+"38.17"+"],");
          sb.append("["+"1564715226815"+","+"38.19"+"],");
          sb.append("["+"1564715230660"+","+"38.00"+"],");
          sb.append("["+"1564715272883"+","+"38.03"+"],");
          sb.append("["+"1564715276761"+","+"38.00"+"],");
          sb.append("["+"1564715280609"+","+"38.03"+"],");
          sb.append("["+"1564715284461"+","+"38.03"+"],");
          sb.append("["+"1564715288243"+","+"38.10"+"],");
          sb.append("["+"1564715292088"+","+"38.10"+"],");
          sb.append("["+"1564715295933"+","+"38.03"+"],");
          sb.append("["+"1564715299920"+","+"37.98"+"],");
          sb.append("["+"1564715303654"+","+"37.98"+"],");
          sb.append("["+"1564715391637"+","+"25.00"+"],");
          sb.append("["+"1564715395476"+","+" 6.79"+"],");
          sb.append("["+"1564715422382"+","+" 7.30"+"],");
          sb.append("["+"1564715426221"+","+" 7.45"+"],");
          sb.append("["+"1564715430059"+","+" 7.53"+"],");
          sb.append("["+"1564715495374"+","+" 6.24"+"],");
          sb.append("["+"1564715499247"+","+" 6.24"+"],");
          sb.append("["+"1564715503031"+","+" 5.97"+"],");
          sb.append("["+"1564715506914"+","+" 5.94"+"],");
          sb.append("["+"1564715510736"+","+" 5.88"+"],");
          sb.append("["+"1564736890476"+","+"34.61"+"],");
          sb.append("["+"1564736894297"+","+"34.76"+"],");
          sb.append("["+"1564736898154"+","+"34.92"+"],");
          sb.append("["+"1564736901982"+","+"35.01"+"],");
          sb.append("["+"1564736905822"+","+"35.09"+"],");
          sb.append("["+"1564736909682"+","+"35.16"+"],");
          sb.append("["+"1564736913511"+","+"35.25"+"],");
          sb.append("["+"1564736917407"+","+"35.46"+"],");
          sb.append("["+"1564736921198"+","+"35.63"+"],");
          sb.append("["+"1564736925060"+","+"35.70"+"],");
          sb.append("["+"1564736928831"+","+"35.79"+"],");
          sb.append("["+"1564736932726"+","+"35.91"+"],");
          sb.append("["+"1564736936565"+","+"36.00"+"],");
          sb.append("["+"1564737044136"+","+"39.08"+"],");
          sb.append("["+"1564737048005"+","+"39.16"+"],");
          sb.append("["+"1564737051843"+","+"39.21"+"],");
          sb.append("["+"1564737055703"+","+"39.33"+"],");
          sb.append("["+"1564737059524"+","+"39.45"+"],");
          sb.append("["+"1564737063358"+","+"39.59"+"],");
          sb.append("["+"1564737094115"+","+"39.93"+"],");
          sb.append("["+"1564737097953"+","+"40.05"+"],");
          sb.append("["+"1564737101791"+","+"40.15"+"],");
          sb.append("["+"1564737140238"+","+"40.59"+"],");
          sb.append("["+"1564737144063"+","+"40.57"+"],");
          sb.append("["+"1564737147885"+","+"40.42"+"],");
          sb.append("["+"1564737151764"+","+"40.32"+"],");
          sb.append("["+"1564737155603"+","+"40.30"+"],");
          sb.append("["+"1564737159441"+","+"40.32"+"],");
          sb.append("["+"1564737163284"+","+"40.40"+"],");
          sb.append("["+"1564737167119"+","+"40.52"+"],");
          sb.append("["+"1564737170980"+","+"40.69"+"],");
          sb.append("["+"1564737174819"+","+"40.86"+"],");
          sb.append("["+"1564737178631"+","+"40.98"+"]");

          sb.append("]");
          
          try {
  			response.getWriter().write(sb.toString());
  		} catch (IOException e) {
  			
  		}
    }
    
    
    
}
