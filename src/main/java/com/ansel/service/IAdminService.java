package com.ansel.service;

import java.util.List;

import com.ansel.bean.Auser;
import com.ansel.bean.Config;
import com.ansel.bean.Dept;

public interface IAdminService {
	
	// 验证管理员
	public Auser checkAuser(String account,String password);
	// 验证科室管理员
	public Dept checkDept(String account,String password);
	// 显示系统设置信息
	public List displayConfig();
	// 保存系统设置信息
	public int saveInfo(String config_title, String config_name, String config_contact, String config_address);
	// 保存管理员账号密码
	public int saveAccount(int id, String account, String password);
	
	// 获得患者总数
	public int getTotalPatient(String searchPatient);
	// 获得患者对象列表
	public List getPatientPaging(String searchPatient, int currentPage, int pagesize);
	// 获得不存在已有科室的患者总数
	public int getTotalPatientNon();
	// 获得不存在已有科室的患者对象列表
	public List getPatientPagingNon(int currentPage, int pagesize);
	// 修改所属科室的同时修改属于该科室患者的科室
	public int updatePatients(String old_department, String new_department);

	// 添加所属科室
	public int insertDept(Dept dept);
	// 查询是否已存在账号
	public List<Dept> queryaccount(String account_str);
	// 修改所属科室
	public int updateDept(String old_department, String new_department, String person, String phone, String address);
	// 修改开启或关闭科属
	public int updateStatus(String xdepart, String xstatus);
	// 显示所属科室信息
	public List<Dept> displayDept();


	// 修改管理员
	public int updateAuser(String update_dept, String update_account, String update_passwd);
	// 获得管理员总数
	public int getTotalDeptAuser(String searchAuser);
	// 获得管理员对象列表
	public List getDeptAuserPaging(String searchAuser, int currentPage, int pagesize);
	

	
	


	


}
