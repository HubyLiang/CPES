package com.liang.cpes.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.liang.cpes.bean.AcctCert;
import com.liang.cpes.bean.T_Cert;
import com.liang.cpes.common.BaseController;
import com.liang.cpes.service.CertService;

@Controller
@RequestMapping(value = "/certtype")
public class CerttypeController extends BaseController {

	@Autowired
	private CertService certService;

	@RequestMapping("/index")
	public String index(Model model) {
		// 查询所有资质数据
		List<T_Cert> certs = certService.queryAllCert();
		model.addAttribute("certs", certs);
		// 查询账户和资质的关系数据
		List<AcctCert> accCerts = certService.queryAccCerts();
		model.addAttribute("acctCerts", accCerts);
		return "certtype/certtype_index";
	}

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public Object insert(Integer certid, String acctype) {
		start();
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("certid", certid);
			paramMap.put("acctype", acctype);
			certService.insertAccCert(paramMap);
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Object delete(Integer certid, String acctype) {
		start();
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("certid", certid);
			paramMap.put("acctype", acctype);
			certService.deleteAccCert(paramMap);
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

}
