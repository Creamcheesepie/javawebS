package com.spring.javawebS.service;

import java.util.List;

import com.spring.javawebS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMidCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public void setMemberPwdUpdate(String mid, String pwd);

	public MemberVO getEmailCheck(String email);

	public List<MemberVO> getMemberList();

	public MemberVO getMemberDetailInfo(int idx);
	
}
