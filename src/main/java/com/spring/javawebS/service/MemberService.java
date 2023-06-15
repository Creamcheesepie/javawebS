package com.spring.javawebS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMidCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo, MultipartFile fName);

	public void setMemberVisitProcess(MemberVO vo);

	public void setMemberPwdUpdate(String mid, String pwd);

	public MemberVO getEmailCheck(String email);

	public List<MemberVO> getMemberList();

	public MemberVO getMemberDetailInfo(int idx);

	public List<MemberVO> getMemberSearch(String keyWord, String searchStr);

	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo);

	public void setMemberDelete(String mid);
	
}
