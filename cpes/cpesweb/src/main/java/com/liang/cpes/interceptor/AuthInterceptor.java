package com.liang.cpes.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.liang.cpes.bean.T_Permission;
import com.liang.cpes.bean.T_User;
import com.liang.cpes.util.Const;
import com.liang.cpes.util.StringUtil;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		 // 用户请求的uri地址
        String uri = request.getRequestURI();
        System.out.println(uri);
        // 地址白名单，否则会login重定向次数过多。
        List<String> writeURIList = new ArrayList<String>();
        writeURIList.add(request.getContextPath()+"/index.htm");
        writeURIList.add(request.getContextPath()+"/doLogin.do");
        writeURIList.add(request.getContextPath()+"/tologin.htm");
        writeURIList.add(request.getContextPath()+"/memberLogin.do");
        writeURIList.add(request.getContextPath()+"/logout.do");
        writeURIList.add(request.getContextPath()+"/userLogin.do");
        writeURIList.add(request.getContextPath()+"/toregist.htm");
        writeURIList.add(request.getContextPath()+"/indexPage.htm");
	    writeURIList.add(request.getContextPath()+"/member/regist.do");
	    writeURIList.add(request.getContextPath()+"/member/checkLoginAcct.do");
	   
        HttpSession session = request.getSession();
        if (!writeURIList.contains(uri)) {
            // 对用户操作进行拦截，检验其是否在登陆状态
            T_User user = (T_User) session.getAttribute(Const.LOGIN_USER);
            if (user == null) {
                response.sendRedirect(request.getContextPath()+"/tologin.htm");
                return false;
            }
        }
        // 对不同的角色的权限进行拦截
        // 获取所有的权限路径
        List<String> allAuthURIs = (List<String>) session.getServletContext().getAttribute("AUTH_URI");
        if (allAuthURIs.contains(uri)) {
            // 获取当前用户的权限路径
            List<T_Permission> permissions = (List<T_Permission>) session.getAttribute(Const.USER_MENU);
            if (permissions != null) {
                List<String> authURIs = new ArrayList<String>();
                for (T_Permission permission : permissions) {
                    if (StringUtil.isNotEmpty(permission.getUrl())) {
                        authURIs.add(permission.getUrl());
                    }
                    for (T_Permission childPermission : permission.getChildren()) {
                        if (StringUtil.isNotEmpty(childPermission.getUrl())) {
                            authURIs.add(childPermission.getUrl());
                        }
                    }
                }
                if (!authURIs.contains(uri)) {
                    request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
                    return false;
                }
            }
        }
        return true;
    }
		
}
