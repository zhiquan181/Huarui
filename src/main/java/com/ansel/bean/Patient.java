package com.ansel.bean;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Timestamp;

public class Patient implements Serializable {
	private static final long serialVersionUID = 6551106323558516531L;
	private int id;
	private String truename;
	private String phone;
	private int age;
	private String sex;
	private String identify;
	private String department;
	private int status;
	private Timestamp createat;
	private Timestamp endtime;
	private int deviceid;
	private int deviceidcp;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}

	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getIdentify() {
		return identify;
	}
	public void setIdentify(String identify) {
		this.identify = identify;
	}

	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}

	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	public Timestamp getCreateat() {
		return createat;
	}
	public void setCreateat(Timestamp createat) {
		this.createat = createat;
	}

	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	public Timestamp getEndtime() {
		return endtime;
	}
	public void setEndtime(Timestamp endtime) {
		this.endtime = endtime;
	}

	public int getDeviceid() {
		return deviceid;
	}
	public void setDeviceid(int deviceid) {
		this.deviceid = deviceid;
	}

	public int getDeviceidcp() {
		return deviceidcp;
	}
	public void setDeviceidcp(int deviceidcp) {
		this.deviceidcp = deviceidcp;
	}

	public Patient(int id,String truename, String phone, int age, String sex, String identify, String department, int status, int deviceid, int deviceidcp) {
		this.id = id;
		this.truename = truename;
		this.phone = phone;
		this.age = age;
		this.sex = sex;
		this.identify = identify;
		this.department = department;
		this.deviceid = deviceid;
		this.deviceidcp = deviceidcp;
	}
	
	public Patient(int id, String truename, String phone, int age, String sex, String identify, String department, int status, Timestamp createat, Timestamp endtime, int deviceid, int deviceidcp) {
		this.id = id;
		this.truename = truename;
		this.phone = phone;
		this.age = age;
		this.sex = sex;
		this.identify = identify;
		this.department = department;
		this.createat = createat;
		this.endtime = endtime;
		this.deviceid = deviceid;
		this.deviceidcp = deviceidcp;
	}
}
