package com.liang.cpes.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.liang.cpes.bean.T_Member;
import com.liang.cpes.bean.T_Menu;
import com.liang.cpes.bean.T_Permission;
import com.liang.cpes.bean.T_User;
import com.liang.cpes.common.BaseController;
import com.liang.cpes.service.MemberService;
import com.liang.cpes.service.MenuService;
import com.liang.cpes.service.PermissionService;
import com.liang.cpes.service.UserService;
import com.liang.cpes.util.Const;

@Controller
public class ForwardController extends BaseController {

	@Autowired
	private UserService userService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/index")
	public String index() {
		return "login";
	}
	
	@RequestMapping(value="/memberindex")
	public String member(){
		return "member/member_index";
	}

	@RequestMapping(value="/tologin")
	public String toLoginPage(){
		return "login";
	}
	
	@RequestMapping("/toregist")
	public String toRegist(){
		return "member/member_regist";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public Object memberLogin(HttpSession session, T_Member member) {
		start();

		try {
			T_Member dbMember = memberService.queryMember4Login(member);
			if (dbMember == null) {
				String errorMsg = "会员账号或密码不正确，请重新登陆";
				error(errorMsg);
				success(false);
			} else {
				// pageContext, request, session, application(ServletContext)
				// page, response, exception, config(ServletConfig)
				// out
				session.setAttribute(Const.LOGIN_MEMBER, dbMember);
				success(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/indexPage.htm";
	}
	
	@RequestMapping(value="/indexPage")
	public String indexPage(){
		return "index";
	}

	@ResponseBody
	@RequestMapping(value = "/userLogin", method = RequestMethod.POST)
	public Object userLogin(T_User user, HttpSession session) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			T_User dbUser = userService.checkLoginacctAndPassword(user);
			if (dbUser == null) {
				String errMsg = "用户名或密码错误";
				resultMap.put("errMsg", errMsg);
				resultMap.put("success", false);
			} else {
				resultMap.put("success", true);
				session.setAttribute(Const.LOGIN_USER, dbUser);
			}
		} catch (Exception e) {
			resultMap.put("success", false);
			e.printStackTrace();
		}
		return resultMap;
	}

	/*
	 * @RequestMapping(value = "/main_low") public String menu_load_low(ModelMap
	 * map) {
	 * 
	 * List<T_Menu> parentMenu = menuService.queryParentMenu(); for (T_Menu
	 * parent : parentMenu) { List<T_Menu> child =
	 * menuService.queryChildMenu(parent.getId()); parent.setChildMenus(child);
	 * } map.put("menus", parentMenu);
	 * 
	 * return "main"; }
	 */

	/*
	 * @RequestMapping(value="/main") public String main(HttpSession session){
	 * 
	 * //查询所有菜单信息 List<T_Menu> childMenus = menuService.queryAll(); List<T_Menu>
	 * roots = new ArrayList<T_Menu>();
	 * 
	 * Map<Integer,T_Menu> menuMap = new HashMap<Integer, T_Menu>();
	 * //将所有菜单以键值对的形式放入到menuMap中 for (T_Menu t_Menu : childMenus) {
	 * menuMap.put(t_Menu.getId(), t_Menu); } int i = 0; for (T_Menu t_Menu :
	 * childMenus) { if(t_Menu.getPid() == 0){ roots.add(t_Menu); }else{
	 * //根据子菜单的pid从menuMap中取出对应的父菜单 T_Menu parent =
	 * menuMap.get(t_Menu.getPid()); parent.getChildMenus().add(t_Menu); } }
	 * session.setAttribute("menus", roots); return "main"; }
	 */

	@RequestMapping(value = "/main")
	public String main(HttpSession session) {

		T_User user = (T_User) session.getAttribute("loginUser");

		T_Permission root = null;

		List<T_Permission> permissions = permissionService.queryUserPermissions(user);
		Map<Integer, Object> permissionMap = new HashMap<Integer, Object>();

		for (T_Permission t_Permission : permissions) {
			permissionMap.put(t_Permission.getId(), t_Permission);
		}

		for (T_Permission child : permissions) {
			if (child.getPid() == 0) {
				root = child;
			} else {
				T_Permission parent = (T_Permission) permissionMap.get(child.getPid());
				parent.getChildren().add(child);
			}
		}

		session.setAttribute("menus", root.getChildren());
		return "main";
	}

}
