package com.liang.cpes.controller;

import java.util.HashMap;
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
import com.liang.cpes.bean.T_Cert;
import com.liang.cpes.common.BaseController;
import com.liang.cpes.service.CertService;

@Controller
@RequestMapping(value = "/cert")
public class CertController extends BaseController {

	@Autowired
	private CertService certService;

	@RequestMapping("/index")
	public String index() {
		return "cert/cert_index";
	}

	@ResponseBody
	@RequestMapping(value = "/pageQuery", method = RequestMethod.POST)
	public Object pageQuery(Integer pageno, Integer pagesize, String querytext) {
		start();

		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("start", (pageno - 1) * pagesize);
			paramMap.put("size", pagesize);
			paramMap.put("querytext", querytext);

			Page<T_Cert> certPage = certService.queryCertPage(paramMap);
			param("page", certPage);
			success(true);
		} catch (Exception e) {
			success(false);
			e.printStackTrace();
		}

		return end();
	}

	@RequestMapping(value = "/add")
	public String add() {
		return "cert/cert_add";
	}

	@ResponseBody
	@RequestMapping(value = "/addCert", method = RequestMethod.POST)
	public Object addCert(T_Cert cert) {
		start();

		try {
			int n = certService.insertCert(cert);
			if (n == 1) {
				success(true);
			} else {
				success(false);
			}
		} catch (Exception e) {
			success(false);
			e.printStackTrace();
		}

		return end();
	}

	@RequestMapping(value = "/to_edit/{id}")
	public String to_edit(@PathVariable("id") Integer id, Model model) {
		T_Cert cert = certService.queryCertById(id);
		model.addAttribute("cert", cert);
		return "cert/cert_edit";
	}

	@ResponseBody
	@RequestMapping(value = "/updateCert", method = RequestMethod.POST)
	public Object updateCert(T_Cert cert) {
		start();
		try {
			int n = certService.updateCert(cert);
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
	@RequestMapping(value = "/deleteCert", method = RequestMethod.POST)
	public Object deleteCert(Integer id) {
		start();

		try {
			int n = certService.deleteCert(id);
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
	@RequestMapping(value="/deleteCerts",method=RequestMethod.POST)
	public Object deleteCerts(Datas ds){
		start();
		try {
			certService.deleteCerts(ds);
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

}
