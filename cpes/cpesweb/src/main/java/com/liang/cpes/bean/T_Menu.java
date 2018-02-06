package com.liang.cpes.bean;

import java.util.ArrayList;
import java.util.List;

public class T_Menu {

	private Integer id;
	private String name;
	private String url;
	private Integer pid;
	private List<T_Menu> childMenus = new ArrayList<T_Menu>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public List<T_Menu> getChildMenus() {
		return childMenus;
	}

	public void setChildMenus(List<T_Menu> childMenus) {
		this.childMenus = childMenus;
	}
}
