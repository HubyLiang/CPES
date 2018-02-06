package com.liang.cpes.dao;

import java.util.Map;

import com.liang.cpes.bean.T_Member;
import com.liang.cpes.bean.T_Ticket;

public interface MemberDao {

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

}
