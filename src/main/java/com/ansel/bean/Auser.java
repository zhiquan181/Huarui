package com.ansel.bean;

import java.io.Serializable;

public class Auser implements Serializable {
	private static final long serialVersionUID = 6551106323558516531L;
	private int id;
	private String account;
	private String password;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Auser() {}

}
