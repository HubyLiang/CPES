package com.liang.cpes.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_Cert;
import com.liang.cpes.common.BaseController;

@Controller
@RequestMapping(value = "/process")
public class ProcessController extends BaseController {

	@Autowired
	private RepositoryService repositoryService;

	@RequestMapping(value = "/index")
	public String index() {
		return "process/process_index";
	}

	@ResponseBody
	@RequestMapping(value = "/pageQuery", method = RequestMethod.POST)
	public Object pageQuery(Integer pageno, Integer pagesize) {
		start();
		try {
			Page<Map<String, Object>> pdpage = new Page<Map<String, Object>>();
			ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
			List<ProcessDefinition> pds = query.listPage((pageno - 1) * pagesize, pagesize);

			List<Map<String, Object>> pdMaps = new ArrayList<Map<String, Object>>();
			for (ProcessDefinition pd : pds) {
				Map<String, Object> pdMap = new HashMap<String, Object>();
				pdMap.put("id", pd.getId());
				pdMap.put("name", pd.getName());
				pdMap.put("key", pd.getKey());
				pdMap.put("version", pd.getVersion());

				pdMaps.add(pdMap);
			}

			int totalsize = (int) query.count();
			pdpage.setDatas(pdMaps);
			pdpage.setTotalsize(totalsize);

			param("page", pdpage);
			success(true);
		} catch (Exception e) {
			success(false);
			e.printStackTrace();
		}

		return end();
	}

	@ResponseBody
	@RequestMapping(value = "/deployProdDef", method = RequestMethod.POST)
	public Object deployProdDef(HttpServletRequest req) {
		start();

		try {
			MultipartHttpServletRequest request = (MultipartHttpServletRequest) req;
			MultipartFile file = request.getFile("procDefFile");
			repositoryService.createDeployment().addInputStream(file.getOriginalFilename(), file.getInputStream())
					.deploy();
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

	@ResponseBody
	@RequestMapping(value = "/deleteProcess", method = RequestMethod.POST)
	public Object deleteProcess(String id) {
		start();
		try {

			// 查询流程定义对象
			ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
			ProcessDefinition pd = query.processDefinitionId(id).singleResult();

			// 通过流程定义ID查询部署ID

			// 删除流程定义(框架没有提供删除流程定义的方法，可以通过级联删除部署对象实现)
			repositoryService.deleteDeployment(pd.getDeploymentId(), true);

			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteProcesses",method=RequestMethod.POST)
	public Object deleteProcesses(Datas ds){
		start();
		
		try {
			// 查询流程定义对象
			ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
			
			for (String id : ds.getDfIds()) {
				ProcessDefinition pd = query.processDefinitionId(id).singleResult();
				repositoryService.deleteDeployment(pd.getDeploymentId(), true);
			}
			success(true);
		} catch (Exception e) {
			success(false);
			e.printStackTrace();
		}
		return end();
	}
	
	@RequestMapping("/show/{id}")
	public String show( @PathVariable("id")String id, Model model ) {
		model.addAttribute("procDefid", id);
		return "process/process_show";
	}
	
	@RequestMapping("/loadImg")
	public void loadImg( String id, HttpServletResponse resp ) throws Exception {
		
		// 查询流程定义对象
		ProcessDefinitionQuery query =
			repositoryService.createProcessDefinitionQuery();
		ProcessDefinition pd = query.processDefinitionId(id).singleResult();
		// 获取流程定义图形
		InputStream in = repositoryService.getResourceAsStream(pd.getDeploymentId(), pd.getDiagramResourceName());
		
		// 将获取的图形通过响应对象输出到浏览器中
		OutputStream out = resp.getOutputStream();
		
		int i = -1;
		while ( (i = in.read()) != -1 ) {
			out.write(i);
		}
		in.close();
	}
}
