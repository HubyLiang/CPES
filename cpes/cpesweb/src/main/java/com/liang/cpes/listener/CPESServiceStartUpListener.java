package com.liang.cpes.listener;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.liang.cpes.bean.T_Permission;
import com.liang.cpes.service.PermissionService;
import com.liang.cpes.util.StringUtil;

public class CPESServiceStartUpListener extends ContextLoaderListener{

	@Override
	public void contextInitialized(ServletContextEvent event) {
		super.contextInitialized(event);
		
		//获取web应用对象
		ServletContext application = event.getServletContext();
		
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		
		PermissionService permissionService = context.getBean(PermissionService.class);
		
		List<T_Permission> permissions = permissionService.queryAll();
		List<String> authURIs = new ArrayList<String>();
		for (T_Permission permission : permissions) {
			if (StringUtil.isNotEmpty(permission.getUrl())) {
                authURIs.add(permission.getUrl());
            }
		}
		application.setAttribute("AUTH_URI", authURIs);
	}
}
