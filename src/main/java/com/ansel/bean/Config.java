package com.ansel.bean;

import java.io.Serializable;

public class Config implements Serializable {
	private static final long serialVersionUID = 6551106323558516531L;
	private String key;
	private String value;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Config() {}
	
	public Config(String key, String value) {
		this.key = key;
		this.value = value;
	}
	
}
