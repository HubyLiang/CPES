package com.liang.cpes.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_Role;
import com.liang.cpes.dao.RoleDao;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDao roleDao;

	public Page<T_Role> queryRole4Page(Map<String, Object> paramMap) {
		Page<T_Role> page = new Page<T_Role>();
		
		List<T_Role> roles = roleDao.queryRole4Page(paramMap);
		int count = roleDao.queryRoleCount4Page(paramMap);
		
		page.setDatas(roles);
		page.setTotalsize(count);
		
		return page;
	}

	public int insertRole(T_Role role) {
		return roleDao.insertRole(role);
	}

	public T_Role queryRoleById(Integer id) {
		return roleDao.queryRoleById(id);
	}

	public int updateRole(T_Role role) {
		return roleDao.updateRole(role);
	}

	public void deleteRoleById(Integer id) {
		roleDao.deleteRoleById(id);
	}

	public void deleteRoles(Datas ds) {
		roleDao.deleteRoles(ds);
	}

	public List<T_Role> queryAllRoles() {
		return roleDao.queryAllRoles();
	}

	public void insertRolePermissions(Integer roleid, Datas ds) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("roleid", roleid);
		
		roleDao.deleteAllPermissions(roleid);
		
		List<Integer> ids = ds.getIds();
		for (Integer id : ids) {
			paramMap.put("permissionid", id);
			roleDao.insertRolePermission(paramMap);
		}
	}

}
