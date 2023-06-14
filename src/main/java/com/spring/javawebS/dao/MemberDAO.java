package com.spring.javawebS.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMidCheck(@Param("mid") String mid);


	public MemberVO getNickNameCheck(@Param("nickName") String nickName);


	public int setMemberJoinOk(@Param("vo") MemberVO vo);


	public void setMemberVisitProcess(@Param("vo") MemberVO vo);


	public void setMemberPwdUpdate(@Param("mid") String mid,@Param("pwd") String pwd);


	public MemberVO getEmailCheck(@Param("email") String email);

}
