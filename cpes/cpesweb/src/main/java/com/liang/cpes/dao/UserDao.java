package com.liang.cpes.dao;

import java.util.List;
import java.util.Map;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.T_User;

public interface UserDao {

	T_User checkLoginacctAndPassword(T_User user);

	List<T_User> queryUser4Page(Map<String, Object> map);

	int queryUserCount4Page(Map<String, Object> map);

	int insertUser(T_User user);

	T_User queryUserById(Integer id);

	int updateUserById(T_User user);

	int deleteUserById(Integer id);

	void deleteUsers(Datas datas);

	List<Integer> queryAssignRolesByUserId(Integer id);

	void deleteUserRoles(Map<String, Object> paramMap);

	void insertUserRole(Map<String, Object> paramMap);

}
