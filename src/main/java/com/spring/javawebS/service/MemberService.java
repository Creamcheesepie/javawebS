package com.spring.javawebS.service;

import com.spring.javawebS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMidCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);
	
}
