package com.liang.cpes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.cpes.bean.T_Permission;
import com.liang.cpes.bean.T_User;
import com.liang.cpes.dao.PermissionDao;

@Service
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	private PermissionDao permissionDao;
	
	public List<T_Permission> queryAll() {
		return permissionDao.queryAll();
	}

	public T_Permission queryPermissionById(Integer id) {
		return permissionDao.queryPermissionById(id);
	}

	public int insertPermission(T_Permission permission) {
		return permissionDao.insertPermission(permission);
	}

	public int updatePermission(T_Permission permission) {
		return permissionDao.updatePermission(permission);
	}

	public int deletePermission(Integer id) {
		return permissionDao.deletePermission(id);
	}

	public List<Integer> queryAssignPermissions(Integer roleid) {
		return permissionDao.queryAssignPermissions(roleid);
	}

	public List<T_Permission> queryUserPermissions(T_User user) {
		return permissionDao.queryUserPermissions(user);
	}

}
