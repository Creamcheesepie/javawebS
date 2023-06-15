package com.spring.javawebS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMidCheck(@Param("mid") String mid);


	public MemberVO getNickNameCheck(@Param("nickName") String nickName);


	public int setMemberJoinOk(@Param("vo") MemberVO vo);


	public void setMemberVisitProcess(@Param("vo") MemberVO vo);


	public void setMemberPwdUpdate(@Param("mid") String mid,@Param("pwd") String pwd);


	public MemberVO getEmailCheck(@Param("email") String email);


	public List<MemberVO> getMemberList();


	public MemberVO getMemberDetailInfo(@Param("idx") int idx);


	public List<MemberVO> getMemberSearch(@Param("keyWord") String keyWord,@Param("searchStr") String searchStr);


	public void setMemberUpdateOk(@Param("vo") MemberVO vo);


	public void setMemberDelete(@Param("mid") String mid);

}
