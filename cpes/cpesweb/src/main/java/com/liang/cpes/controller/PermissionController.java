package com.liang.cpes.controller;

import java.util.ArrayList;
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

import com.liang.cpes.bean.T_Permission;
import com.liang.cpes.common.BaseController;
import com.liang.cpes.service.PermissionService;

@Controller
@RequestMapping("/permission")
public class PermissionController extends BaseController {

	@Autowired
	private PermissionService permissionService;

	@RequestMapping(value = "/index")
	public String index() {
		return "permission/permission_index";
	}

	@RequestMapping("/add")
	public String add() {
		return "permission/permission_add";
	}

	@ResponseBody
	@RequestMapping(value = "/addPermission", method = RequestMethod.POST)
	public Object addPermission(T_Permission permission) {
		start();
		try {
			int n = permissionService.insertPermission(permission);
			if (n == 1) {
				success(true);
			} else {
				success(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

	@RequestMapping("/edit")
	public String edit(Integer id, Model model) {
		T_Permission permission = permissionService.queryPermissionById(id);
		model.addAttribute("permission", permission);
		return "permission/permission_update";
	}

	@ResponseBody
	@RequestMapping(value = "/updatePermission", method = RequestMethod.POST)
	public Object updatePermission(T_Permission permission) {
		start();
		try {
			int n = permissionService.updatePermission(permission);
			if (n == 1) {
				success(true);
			} else {
				success(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

	@ResponseBody
	@RequestMapping(value = "/deletePermission", method = RequestMethod.POST)
	public Object deletePermission(Integer id) {
		start();

		try {
			int n = permissionService.deletePermission(id);
			if (n == 1) {
				success(true);
			} else {
				success(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

	@ResponseBody
	@RequestMapping(value = "/load", method = RequestMethod.POST)
	public Object load() {
		List<T_Permission> roots = new ArrayList<T_Permission>();

		List<T_Permission> permissions = permissionService.queryAll();
		Map<Integer, T_Permission> permissionMap = new HashMap<Integer, T_Permission>();

		for (T_Permission t_Permission : permissions) {
			permissionMap.put(t_Permission.getId(), t_Permission);
		}

		for (T_Permission t_Permission : permissions) {
			T_Permission child = t_Permission;
			if (child.getPid() == 0) {
				roots.add(t_Permission);
			} else {
				T_Permission parent = permissionMap.get(child.getPid());
				parent.getChildren().add(child);
			}
		}
		return roots;
	}

	@ResponseBody
	@RequestMapping(value = "/loadAssign", method = RequestMethod.POST)
	public Object loadAssign(Integer roleid) {
		List<T_Permission> roots = new ArrayList<T_Permission>();

		List<T_Permission> permissions = permissionService.queryAll();
		Map<Integer, T_Permission> permissionMap = new HashMap<Integer, T_Permission>();

		// 将已经分配的许可信息进行勾选
		// 获取当前角色已经分配的许可信息
		List<Integer> permissoinids = permissionService.queryAssignPermissions(roleid);

		for (T_Permission p : permissions) {
			if (permissoinids.contains(p.getId())) {
				p.setChecked(true);
			}
			permissionMap.put(p.getId(), p);
		}

		for (T_Permission p : permissions) {
			T_Permission childPermission = p;
			if (p.getPid() == 0) {
				roots.add(p);
			} else {
				T_Permission parentPermission = permissionMap.get(p.getPid());
				parentPermission.getChildren().add(childPermission);
			}
		}

		return roots;
	}

}
