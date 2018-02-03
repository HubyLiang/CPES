package com.liang.cpes.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_Role;
import com.liang.cpes.common.BaseController;
import com.liang.cpes.service.RoleService;

@Controller
@RequestMapping(value="/role")
public class RoleController extends BaseController {

	@Autowired
	private RoleService roleService;
	
	@RequestMapping(value="/index")
	public String index(){
		return "role/role_index";
	}
	
	@ResponseBody
	@RequestMapping(value="/pageQuery" ,method=RequestMethod.POST)
	public Object pageQuery(String querytext,Integer pageno, Integer pagesize){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("querytext", querytext);
			paramMap.put("start", (pageno - 1) * pagesize);
			paramMap.put("size", pagesize);
			
			Page<T_Role> page =  roleService.queryRole4Page(paramMap);
			resultMap.put("page",page);
			resultMap.put("success", true);
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public Object add(T_Role role){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int n = roleService.insertRole(role);
			if(n ==1){
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
	
	@RequestMapping(value="/to_edit/{id}")
	public String to_edit(@PathVariable(value="id") Integer id,Model model){
		T_Role role = roleService.queryRoleById(id);
		model.addAttribute("role", role);
		return "role/role_edit";
	}
	
	@ResponseBody
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public Object updateRole(T_Role role){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try { 
			int n = roleService.updateRole(role);
			if(n==1){
				resultMap.put("success", true);
			}else{
				resultMap.put("success", false);
			}
		} catch (Exception e) {
			resultMap.put("success",false);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteRole",method=RequestMethod.POST)
	public Object deleteRole(Integer id){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			roleService.deleteRoleById(id);
			resultMap.put("success",true);
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteRoles",method=RequestMethod.POST)
	public Object deleteRoles(Datas ds){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			roleService.deleteRoles(ds);
			resultMap.put("success",true);
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@RequestMapping(value="/assign/{id}")
	public String assign(@PathVariable("id") Integer id,Model model){
		T_Role role = roleService.queryRoleById(id);
		model.addAttribute("role", role);
		return "role/role_permission_assign";
	}
	
	@ResponseBody
	@RequestMapping(value="/assignPermission",method=RequestMethod.POST)
	public Object assignPermission(Integer roleid, Datas ds){
		start();
		
		try {
			roleService.insertRolePermissions(roleid, ds);
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
}
