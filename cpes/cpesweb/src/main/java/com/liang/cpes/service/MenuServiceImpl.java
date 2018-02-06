package com.liang.cpes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.cpes.bean.T_Menu;
import com.liang.cpes.dao.MenuDao;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuDao menuDao;
	
	
	public List<T_Menu> queryParentMenu() {
		return menuDao.queryParentMenu();
	}

	public List<T_Menu> queryChildMenu(Integer pid) {
		return menuDao.queryChildMenu(pid);
	}

	public List<T_Menu> queryAll() {
		return menuDao.queryAll();
	}

}
