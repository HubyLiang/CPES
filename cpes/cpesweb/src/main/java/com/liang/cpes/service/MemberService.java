package com.liang.cpes.service;

import java.util.List;
import java.util.Map;

import com.liang.cpes.bean.T_Cert;
import com.liang.cpes.bean.T_Member;
import com.liang.cpes.bean.T_Ticket;

public interface MemberService {

	T_Member queryMember4Login(T_Member member);

	void updateMemberAccttype(T_Member loginMember);

	T_Ticket queryTicketByMemberId(Integer id);

	void insertTicket(T_Ticket t);

	void updateTicketProcessStep(T_Ticket t);

	void updateMemberBasicInfo(T_Member loginMember);

	void insertMemberCert(Map<String, Object> paramMap);

	void updateMemberEmail(T_Member loginMember);

	void updateTicket(T_Ticket t);

	T_Ticket queryTicketByPiid(String piid);

	T_Member queryMemberById(int memberid);

	List<T_Cert> queryCertsByMemberId(Integer memberid);

	void updateMemberStatus(Integer memberid);

	void updateTicketAuthStatus(T_Ticket t_Ticket);

	int regist(T_Member member);

	T_Member checkLoginAcct(String loginacct);

}
