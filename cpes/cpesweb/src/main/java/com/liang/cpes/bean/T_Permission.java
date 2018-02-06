package com.liang.cpes.bean;

import java.util.ArrayList;
import java.util.List;

public class T_Permission {

	private int id;
	private String name;
	private String url;
	private int pid;
	private String icon;
	private List<T_Permission> children = new ArrayList<T_Permission>();
	private boolean open = true;
	private boolean checked = false;

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public List<T_Permission> getChildren() {
		return children;
	}

	public void setChildren(List<T_Permission> children) {
		this.children = children;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
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

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

}
