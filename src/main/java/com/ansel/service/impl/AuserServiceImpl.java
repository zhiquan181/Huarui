package com.ansel.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ansel.bean.Auser;
import com.ansel.bean.Dept;
import com.ansel.dao.IAdminDao;
import com.ansel.service.IAdminService;
import com.github.pagehelper.PageHelper;

@Service("adminService")
public class AuserServiceImpl implements IAdminService {
	@Resource
	private IAdminDao adminDao;
	
	
	// 验证管理员
	@Override
	public Auser checkAuser(String account,String password) {
		try {
			return this.adminDao.checkAuser(account,password);
		} catch (Exception e) {
			return null;
		}
	}
	// 验证科室管理员
	@Override
	public Dept checkDept(String account,String password) {
		try {
			return this.adminDao.checkDept(account,password);
		} catch (Exception e) {
			return null;
		}
	}
	// 显示系统设置信息
	@Override
	public List displayConfig() {
		return this.adminDao.displayConfig();
	}
	// 保存系统设置信息
	@Override
	public int saveInfo(String config_title, String config_name, String config_contact, String config_address) {
		return this.adminDao.saveInfo(config_title,config_name,config_contact,config_address);
	}
	// 保存管理员账号密码
	@Override
	public int saveAccount(int id, String account, String password) {
		return this.adminDao.saveAccount(id,account,password);
	}
	
	
	// 获得患者总数
	@Override
	public int getTotalPatient(String searchPatient) {
		try {
			return this.adminDao.getTotalPatient(searchPatient);
		} catch (Exception e) {
			return 0;
		}
	}
	// 获得患者对象列表
	@Override
	public List getPatientPaging(String searchPatient, int currentPage, int pagesize) {
		int startrow = (currentPage-1)*pagesize;
		System.out.println("读取坐标："+startrow);
		return this.adminDao.getPatientPaging(searchPatient,startrow,pagesize);
	}
	// 获得不存在已有科室的患者总数
	@Override
	public int getTotalPatientNon() {
		return this.adminDao.getTotalPatientNon();
	}
	// 获得不存在已有科室的患者对象列表
	@Override
	public List getPatientPagingNon(int currentPage, int pagesize) {
		int startrow = (currentPage-1)*pagesize;
		return this.adminDao.getPatientPagingNon(startrow,pagesize);
	}
	// 修改所属科室的同时修改属于该科室患者的科室
	public int updatePatients(String old_department, String new_department) {
		try {
			this.adminDao.updatePatients(old_department,new_department);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}

	
	// 添加所属科室
	@Override
	public int insertDept(Dept dept) {
		try {
			this.adminDao.insertDept(dept);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	// 查询是否已存在账号
	@Override
	public List<Dept> queryaccount(String account_str) {
		try {
			//System.out.println("ok");
			return this.adminDao.queryaccount(account_str);
		} catch (Exception e) {
			//System.out.println("no");
			return null;
		}
	}
	// 更改所属科室
	@Override
	public int updateDept(String old_department, String new_department, String person, String phone, String address) {
		try {
			this.adminDao.updateDept(old_department,new_department,person,phone,address);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	// 修改开启或关闭科属
	@Override
	public int updateStatus(String xdepart, String xstatus) {
		try {
			this.adminDao.updateStatus(xdepart,xstatus);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	// 显示所属科室信息
	@Override
	public List<Dept> displayDept() {
		// TODO Auto-generated method stub
		return adminDao.displayDept();
	}
	
	
	// 修改管理员
	@Override
	public int updateAuser(String update_dept, String update_account, String update_passwd) {
		try {
			this.adminDao.updateAuser(update_dept,update_account,update_passwd);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	// 获得管理员总数
	@Override
	public int getTotalDeptAuser(String searchAuser) {
		return this.adminDao.getTotalDeptAuser(searchAuser);
	}
	// 获得管理员对象列表
	@Override
	public List getDeptAuserPaging(String searchAuser, int currentPage, int pagesize) {
		int startrow = (currentPage-1)*pagesize;
		return this.adminDao.getDeptAuserPaging(searchAuser,startrow,pagesize);
	}
	
	




}