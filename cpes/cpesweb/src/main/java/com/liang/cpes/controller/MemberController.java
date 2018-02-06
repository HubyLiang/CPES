package com.liang.cpes.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.liang.cpes.bean.T_Cert;
import com.liang.cpes.bean.T_Member;
import com.liang.cpes.bean.T_Ticket;
import com.liang.cpes.common.BaseController;
import com.liang.cpes.service.CertService;
import com.liang.cpes.service.MemberService;
import com.liang.cpes.util.Const;
import com.liang.cpes.util.StringUtil;

@Controller
@RequestMapping(value = "/member")
public class MemberController extends BaseController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private CertService certService;
	
	@Autowired
	private RepositoryService repositoryService;
	
	@Autowired
	private RuntimeService runtimeService;
	
	@Autowired
	private TaskService taskService;

	@ResponseBody
	@RequestMapping(value = "/updateMemberAccttype", method = RequestMethod.POST)
	public Object updateMemberAccttype(HttpSession session, T_Member member) {
		start();

		try {
			T_Member loginMember = (T_Member) session.getAttribute(Const.LOGIN_MEMBER);
			loginMember.setAccttype(member.getAccttype());
			memberService.updateMemberAccttype(loginMember);
			T_Ticket t = memberService.queryTicketByMemberId(loginMember.getId());
			t.setProcessstep("accttype");
			memberService.updateTicketProcessStep(t);
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}

		return end();
	}
	
	@RequestMapping(value = "/apply")
	public String apply(HttpSession session, T_Member member, Model model) {

		T_Member loginMember = (T_Member) session.getAttribute(Const.LOGIN_MEMBER);
		// 查询流程审批单,如果不存在,则创建

		T_Ticket t = memberService.queryTicketByMemberId(loginMember.getId());
		if (t == null) {
			// 创建流程审批单
			t = new T_Ticket();
			t.setMemberid(loginMember.getId());
			t.setAuthstatus("0");
			memberService.insertTicket(t);
		}

		if (StringUtil.isEmpty(t.getProcessstep())) {
			return "member/member_cert";
		} else if ("accttype".equals(t.getProcessstep())) {
			return "member/member_basicinfo";
		} else if ("basicinfo".equals(t.getProcessstep())) {
			// 查询账户所需的资质类型
			List<T_Cert> certs = certService.queryCertsByMemberAccttype(loginMember.getAccttype());
			model.addAttribute("certs", certs);

			return "member/member_certupload";
		} else if ("certupload".equals(t.getProcessstep())) {
			return "member/member_checkemail";
		} else if ("checkemail".equals(t.getProcessstep())) {
			return "member/member_confirm";
		} else if ("confirm".equals(t.getProcessstep())) {
			model.addAttribute("msg", "实名认证申请正在审批中，请等待...");
			return "member/member_index";
		}
		return "";
	}

	@ResponseBody
	@RequestMapping("/updateMemberBasicInfo")
	public Object updateMemberBasicInfo( T_Member member, HttpSession session ) {
		start();
		
		try {
			T_Member loginMember = (T_Member)session.getAttribute(Const.LOGIN_MEMBER);
			//member.setId(loginMember.getId());
			loginMember.setRealname(member.getRealname());
			loginMember.setCardno(member.getCardno());
			loginMember.setTel(member.getTel());
			memberService.updateMemberBasicInfo(loginMember);
			T_Ticket t = memberService.queryTicketByMemberId(loginMember.getId());
			t.setProcessstep("basicinfo");
			memberService.updateTicketProcessStep(t);
			success(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@ResponseBody
	@RequestMapping(value = "/uploadCertFile", method = RequestMethod.POST)
	public Object uploadCertFile(HttpServletRequest req) {
		start();
		try {
			HttpSession session = req.getSession();
			T_Member member = (T_Member) session.getAttribute(Const.LOGIN_MEMBER);
			// 文件上传
			MultipartHttpServletRequest request = (MultipartHttpServletRequest) req;
			Iterator<String> fileNames = request.getFileNames();
			while (fileNames.hasNext()) {
				String name = fileNames.next();
				Integer certid = Integer.parseInt(name.split("-")[1]);
				MultipartFile file = request.getFile(name);
				// 获取图形文件，保存文件
				String fileName = UUID.randomUUID().toString();
				String fn = file.getOriginalFilename();
				fileName = fileName + fn.substring(fn.lastIndexOf("."));
				String dir = session.getServletContext().getRealPath("upload/certimg");
				String path = dir + File.separator + fileName;
				
//				InputStream in = file.getInputStream();
//				FileOutputStream out = new FileOutputStream(new File(path));
//				int i =0;
//				while((i = in.read()) != -1){
//					out.write(i);
//				}
//				in.close();
//				out.close();
				
				file.transferTo(new File(path));
				//保存会员资质数据
				Map<String,Object> paramMap = new HashMap<String,Object>();
				paramMap.put("memberid", member.getId());
				paramMap.put("certid", certid);
				paramMap.put("iconpath", fileName);
				memberService.insertMemberCert(paramMap);
			}
			T_Ticket ticket = memberService.queryTicketByMemberId(member.getId());
			ticket.setProcessstep("certupload");
			memberService.updateTicketProcessStep(ticket);
			
			success(true);
		} catch (Exception e) {
			success(false);
			e.printStackTrace();
		}

		return end();
	}
	

	@ResponseBody
	@RequestMapping(value="/startProcess",method=RequestMethod.POST)
	public Object startProcess(T_Member member, HttpSession session){
		start();
		try {
			T_Member loginMember = (T_Member)session.getAttribute(Const.LOGIN_MEMBER);
			if ( !member.getEmail().equals(loginMember.getEmail()) ) {
				loginMember.setEmail(member.getEmail());
				memberService.updateMemberEmail(loginMember);
			}
			// 启动审批流程, 系统自动发送认证邮件
			// 获取实名认证的流程定义
			ProcessDefinitionQuery query =
				repositoryService.createProcessDefinitionQuery();
			ProcessDefinition pd = 
				query.processDefinitionKey("cpes").latestVersion().singleResult();
			
			Map<String, Object> varMap = new HashMap<String, Object>();
			varMap.put("useremail", loginMember.getEmail());
			
			String s = "asdlkjasdlkjsadsgjdslkhf32lkjkjfsalkjdfdslkj3";
			String authcode = "";
			for ( int i = 0; i < 4; i++ ) {
				Random r = new Random();
				int index = r.nextInt(s.length());
				authcode = authcode + s.charAt(index); 
			}
			
			varMap.put("authcode", authcode);
			varMap.put("userid", loginMember.getLoginacct());

//			ProcessInstance pi = runtimeService.startProcessInstanceById(pd.getId(), varMap);
			T_Ticket t = memberService.queryTicketByMemberId(loginMember.getId());
			t.setProcessstep("checkemail");
//			t.setPiid(pi.getId());
			t.setAuthcode(authcode);
			memberService.updateTicket(t);
			success(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/doApply")
	public Object doApply( String authcode, HttpSession session ) {
		start();
		
		try {
			T_Member loginMember = (T_Member)session.getAttribute(Const.LOGIN_MEMBER);
			// 获取流程审批单
			T_Ticket t = memberService.queryTicketByMemberId(loginMember.getId());
			
			// 判断认证码是否正确
			if ( authcode.equals(t.getAuthcode()) ) {
				// 让审批流程继续执行
				// 完成当前会员的验证任务
//				TaskQuery query = taskService.createTaskQuery();
//				List<Task> ts = query.taskAssignee(loginMember.getLoginacct()).list();
//				for ( Task task : ts ) {
//					taskService.complete(task.getId());
//				}
				t.setProcessstep("confirm");
				memberService.updateTicketProcessStep(t);
				success(true);
			} else {
				error("认证码不正确，请重新输入");
				success(false);
			}
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}


}
