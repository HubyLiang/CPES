package com.liang.cpes.service;

import java.util.List;

import com.liang.cpes.bean.T_Menu;

public interface MenuService {

	List<T_Menu> queryParentMenu();

	List<T_Menu> queryChildMenu(Integer pid);

	List<T_Menu> queryAll();

}
