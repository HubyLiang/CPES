package com.liang.cpes.service;

import java.util.List;

import com.liang.cpes.bean.T_Permission;
import com.liang.cpes.bean.T_User;

public interface PermissionService {

	List<T_Permission> queryAll();

	T_Permission queryPermissionById(Integer id);

	int insertPermission(T_Permission permission);

	int updatePermission(T_Permission permission);

	int deletePermission(Integer id);

	List<Integer> queryAssignPermissions(Integer roleid);

	List<T_Permission> queryUserPermissions(T_User user);

}
