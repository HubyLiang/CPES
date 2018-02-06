package com.liang.cpes.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_Member;
import com.liang.cpes.bean.T_Ticket;
import com.liang.cpes.common.BaseController;
import com.liang.cpes.service.MemberService;

@Controller
@RequestMapping("/auth")
public class AuthController extends BaseController {
	
	@Autowired
	private TaskService taskService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private RepositoryService repositoryService;
	
	@RequestMapping("/index")
	public String index() {
		return "auth/auth_index";
	}
	
	@ResponseBody
	@RequestMapping("/pageQuery")
	public Object pageQuery( Integer pageno, Integer pagesize ) {
		start();
		
		try {
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("start", (pageno-1)*pagesize);
			paramMap.put("size", pagesize);
			
			// 查询实名认证任务
			
			TaskQuery query = taskService.createTaskQuery();
			List<Task> tasks =
				query
				    .processDefinitionKey("cpes")
				    .taskCandidateGroup("authgroup")
				    .listPage((pageno-1)*pagesize, pagesize);
			
			int count =
				(int)query
				    .processDefinitionKey("cpes")
				    .taskCandidateGroup("authgroup")
				    .count();
			
			Page<Map<String, Object>> taskPage = new Page<Map<String, Object>>();
			List<Map<String, Object>> taskMaps = new ArrayList<Map<String, Object>>();
			
			for ( Task t : tasks ) {
				Map<String, Object> taskMap = new HashMap<String, Object>();
				taskMap.put("id", t.getId());
				// 根据流程实例ID查找流程审批单
				String piid = t.getProcessInstanceId();
				T_Ticket ticket = memberService.queryTicketByPiid(piid);
				// 通过流程审批单找到会员
				T_Member member = memberService.queryMemberById(ticket.getMemberid());
				// task ==> ProcessInstance ==> ticket ==> member
				
				taskMap.put("membername", member.getUsername());
				taskMap.put("memberid", member.getId());
				
				// 流程定义名称
				String pdid = t.getProcessDefinitionId();
				ProcessDefinition pd = repositoryService.getProcessDefinition(pdid);
				// task ==> ProcessDefinition
				
				taskMap.put("pdname", pd.getName());
				taskMap.put("name", t.getName());
				taskMaps.add(taskMap);
			}

			taskPage.setDatas(taskMaps);
			taskPage.setTotalsize(count);
			
			param("page", taskPage);
			success(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
}
