package com.ansel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ansel.bean.Auser;
import com.ansel.bean.Dept;

public interface IAdminDao {
	// 验证管理员
	Auser checkAuser(@Param("account") String account,@Param("password") String password);
	// 验证科室管理员
	Dept checkDept(@Param("account") String account,@Param("password") String password);
	// 显示系统设置信息
	List displayConfig();
	// 保存系统设置信息
	int saveInfo( @Param("config_title") String config_title, @Param("config_name") String config_name, @Param("config_contact") String config_contact, @Param("config_address") String config_address);
	// 保存管理员账号密码
	int saveAccount(@Param("id") int id, @Param("account") String account, @Param("password") String password);
	
	// 获得患者总数
	int getTotalPatient(@Param("searchPatient")String searchPatient);
	// 获得患者对象列表
	List getPatientPaging(@Param("searchPatient")String searchPatient,@Param("startrow") int startrow,@Param("pagesize") int pagesize);
	// 获得不存在已有科室的患者总数
	int getTotalPatientNon();
	// 获得不存在已有科室的患者对象列表
	List getPatientPagingNon(@Param("startrow") int startrow,@Param("pagesize") int pagesize);
	// 修改所属科室的同时修改属于该科室患者的科室
	void updatePatients(@Param("old_department") String old_department,@Param("new_department") String new_department);
	
	
	// 添加所属科室
	int insertDept(Dept dept);
	// 查询是否已存在账号
	List<Dept> queryaccount(@Param("account_str") String account_str);
	// 更改所属科室
	void updateDept(@Param("old_department") String old_department,@Param("new_department") String new_department,@Param("person") String person,@Param("phone") String phone,@Param("address") String address);
	// 修改开启或关闭科属
	void updateStatus(@Param("xdepart") String xdepart, @Param("xstatus") String xstatus);
	// 显示所属科室信息
	List<Dept> displayDept();


	// 修改管理员
	int updateAuser(@Param("update_dept") String update_dept, @Param("update_account") String update_account, @Param("update_passwd") String update_passwd);
	// 获得管理员总数
	int getTotalDeptAuser(@Param("searchAuser")String searchAuser);
	// 获得管理员对象列表
	List getDeptAuserPaging(@Param("searchAuser")String searchAuser,@Param("startrow") int startrow,@Param("pagesize") int pagesize);
	

}