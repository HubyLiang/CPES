package com.liang.cpes.bean;

import java.util.List;

public class Datas {
	private List<T_User> users;
	private List<Integer> ids;
	private List<String> dfIds;

	public List<T_User> getUsers() {
		return users;
	}

	public void setUsers(List<T_User> users) {
		this.users = users;
	}

	public List<Integer> getIds() {
		return ids;
	}

	public void setIds(List<Integer> ids) {
		this.ids = ids;
	}

	public List<String> getDfIds() {
		return dfIds;
	}

	public void setDfIds(List<String> dfIds) {
		this.dfIds = dfIds;
	}

}
