package com.liang.cpes.service;

import java.util.List;
import java.util.Map;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_User;

public interface UserService {

	T_User checkLoginacctAndPassword(T_User user);

	Page<T_User> queryUser4Page(Map<String,Object> paramMap);

	int insertUser(T_User user);

	T_User queryUserById(Integer id);

	int updateUserById(T_User user);

	int deleteUserById(Integer id);

	void deleteUsers(Datas datas);

	List<Integer> queryAssignRolesByUserId(Integer id);

	void deleteUserRoles(Integer userid, Datas ds);

	void insertUserRoles(Integer userid, Datas ds);


}
