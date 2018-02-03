package com.liang.cpes.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_User;
import com.liang.cpes.dao.UserDao;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	public T_User checkLoginacctAndPassword(T_User user) {
		return userDao.checkLoginacctAndPassword(user);
	}

	public Page<T_User> queryUser4Page(Map<String, Object>  paramMap) {
	    Page<T_User> page = new Page<T_User>();

	    List<T_User> users = userDao.queryUser4Page(paramMap);
	    int count = userDao.queryUserCount4Page(paramMap);

	    page.setTotalsize(count);
	    page.setDatas(users);

	    return page;
	}

	public int insertUser(T_User user) {
		return userDao.insertUser(user);
	}

	public T_User queryUserById(Integer id) {
		T_User user =  userDao.queryUserById(id);
		return user;
	}

	public int updateUserById(T_User user) {
		int n = userDao.updateUserById(user);
		return n;
	}

	public int deleteUserById(Integer id) {
		return userDao.deleteUserById(id);
	}

	public void deleteUsers(Datas datas) {
		userDao.deleteUsers(datas);
	}

	public List<Integer> queryAssignRolesByUserId(Integer id) {
		return userDao.queryAssignRolesByUserId(id);
	}

	public void deleteUserRoles(Integer userid, Datas ds) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userid", userid);
		paramMap.put("roleids", ds.getIds());
		userDao.deleteUserRoles(paramMap);
	}

	public void insertUserRoles(Integer userid, Datas ds) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userid", userid);
		for ( Integer roleid : ds.getIds() ) {
			paramMap.put("roleid", roleid);
			userDao.insertUserRole(paramMap);
		}
	}
	
}
