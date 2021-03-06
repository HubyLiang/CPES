package com.liang.cpes.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.cpes.bean.T_Cert;
import com.liang.cpes.bean.T_Member;
import com.liang.cpes.bean.T_Ticket;
import com.liang.cpes.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	public T_Member queryMember4Login(T_Member member) {
		return memberDao.queryMember4Login(member);
	}

	public void updateMemberAccttype(T_Member loginMember) {
		memberDao.updateMemberAccttype(loginMember);
	}

	public T_Ticket queryTicketByMemberId(Integer id) {
		return memberDao.queryTicketByMemberId(id);
	}

	public void insertTicket(T_Ticket t) {
		memberDao.insertTicket(t);
	}

	public void updateTicketProcessStep(T_Ticket t) {
		memberDao.updateTicketProcessStep(t);
	}

	public void updateMemberBasicInfo(T_Member loginMember) {
		memberDao.updateMemberBasicInfo(loginMember);
		
	}

	public void insertMemberCert(Map<String, Object> paramMap) {
		memberDao.insertMemberCert(paramMap);
		
	}

	public void updateMemberEmail(T_Member loginMember) {
		memberDao.updateMemberEmail(loginMember);
	}

	public void updateTicket(T_Ticket t) {
		memberDao.updateTicket(t);
	}

	public T_Ticket queryTicketByPiid(String piid) {
		return memberDao.queryTicketByPiid(piid);
	}

	public T_Member queryMemberById(int memberid) {
		return memberDao.queryMemberById(memberid);
	}

	public List<T_Cert> queryCertsByMemberId(Integer memberid) {
		return memberDao.queryCertsByMemberId(memberid);
	}

	public void updateMemberStatus(Integer memberid) {
		memberDao.updateMemberStatus(memberid);
	}

	public void updateTicketAuthStatus(T_Ticket t_Ticket) {
		memberDao.updateTicketAuthStatus(t_Ticket);
	}

	public int regist(T_Member member) {
		return memberDao.regist(member);
	}

	public T_Member checkLoginAcct(String loginacct) {
		return memberDao.checkLoginAcct(loginacct);
	}
}
