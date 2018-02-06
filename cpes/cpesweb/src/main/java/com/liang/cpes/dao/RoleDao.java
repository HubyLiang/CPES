package com.liang.cpes.dao;

import java.util.List;
import java.util.Map;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.T_Role;

public interface RoleDao {

	List<T_Role> queryRole4Page(Map<String, Object> paramMap);

	int queryRoleCount4Page(Map<String, Object> paramMap);

	int insertRole(T_Role role);

	T_Role queryRoleById(Integer id);

	int updateRole(T_Role role);

	void deleteRoleById(Integer id);

	void deleteRoles(Datas ds);

	List<T_Role> queryAllRoles();

	void deleteAllPermissions(Integer roleid);

	void insertRolePermission(Map<String, Object> paramMap);

}
