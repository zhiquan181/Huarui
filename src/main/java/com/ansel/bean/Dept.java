package com.ansel.bean;

import java.io.Serializable;

public class Dept implements Serializable {
	private static final long serialVersionUID = 6551106323558516531L;
	private String department;
	private String person;
	private String account;
	private String passwd;
	private String phone;
	private String address;
	private int status;

	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}

	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}

	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	public Dept() {}
	
	public Dept(String department,String person,String account,String passwd,String phone,String address,int status) {
		this.department = department;
		this.person = person;
		this.account = account;
		this.passwd = passwd;
		this.phone = phone;
		this.address = address;
		this.status = status;
	}
}
