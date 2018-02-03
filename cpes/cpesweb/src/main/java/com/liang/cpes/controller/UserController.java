package com.liang.cpes.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_Role;
import com.liang.cpes.bean.T_User;
import com.liang.cpes.service.RoleService;
import com.liang.cpes.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/index")
	public String pageQueryUser() {
		return "user/users_list";
	}

	@ResponseBody
	@RequestMapping(value = "pageQuery", method = RequestMethod.POST)
	public Object pageQuery(String querytext, Integer pageno, Integer pagesize) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("querytext", querytext);
			paramMap.put("start", (pageno - 1) * pagesize);
			paramMap.put("size", pagesize);

			Page<T_User> page = userService.queryUser4Page(paramMap);
			resultMap.put("page", page);
			resultMap.put("success", true);
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
		}
		return resultMap;
	}

	@RequestMapping("/to_add")
	public String toUserAddPage() {
		return "user/user_add";
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Object UserAdd(T_User user) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int n = userService.insertUser(user);
			if (n == 1) {
				resultMap.put("success", true);
			} else {
				resultMap.put("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
		}

		return resultMap;
	}

	@RequestMapping("/to_edit/{id}")
	public String toEditUser(@PathVariable(value = "id") Integer id, Model model) {
		T_User user = userService.queryUserById(id);
		model.addAttribute("user", user);
		return "user/user_edit";
	}

	@ResponseBody
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public Object updateUser(T_User user) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int n = userService.updateUserById(user);
			if(n == 1){
				resultMap.put("success", true);
			}else{
				resultMap.put("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="deleteUser",method=RequestMethod.POST)
	public Object deleteUser(Integer id){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int n = userService.deleteUserById(id);
			if(n == 1){
				resultMap.put("success", true);
			}else{
				resultMap.put("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="deleteUsers",method=RequestMethod.POST)
	public Object deleteUsers(Datas datas){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			userService.deleteUsers(datas);
			resultMap.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@RequestMapping(value="/assign/{id}")
	public String toAssign(@PathVariable("id") Integer id,Model model){
		T_User user = userService.queryUserById(id);
		model.addAttribute("user", user);
		
		//查询所有的角色信息
		List<T_Role> roles = roleService.queryAllRoles();
		//未分配的角色信息
		List<T_Role> unassignRoles = new ArrayList<T_Role>();
		//已分配的角色信息
		List<T_Role> assignRoles = new ArrayList<T_Role>();
		// 查询当前用户已经分配的数据
		List<Integer> roleIds = userService.queryAssignRolesByUserId(id);
		
		for (T_Role role : roles) {
			if(roleIds.contains(role.getId())){
				assignRoles.add(role);
			}else{
				unassignRoles.add(role);
			}
		}
		model.addAttribute("unassignRoles", unassignRoles);
		model.addAttribute("assignRoles", assignRoles);
		
		return "user/user_role_assign";
	}
	
	@ResponseBody
	@RequestMapping(value="/unassignRole",method=RequestMethod.POST)
	public Object unassignRole(Integer userid,Datas ds){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			userService.deleteUserRoles(userid,ds);
			resultMap.put("success", true);
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/assignRole",method=RequestMethod.POST)
	public Object assignRole(Integer userid,Datas ds){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			userService.insertUserRoles(userid,ds);
			resultMap.put("success", true);
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
		}
		return resultMap;
	}

}
