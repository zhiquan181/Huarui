package com.ansel.bean;

import java.util.Date;

public class Device {
	private String deviceid;
	private String temperature;
	private Date datestr;
	private int status;
	
	public String getDeviceid() {
		return deviceid;
	}
	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}
	public String getTemperature() {
		return temperature;
	}
	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}
	public Date getDatestr() {
		return datestr;
	}
	public void setDatestr(Date datestr) {
		this.datestr = datestr;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
