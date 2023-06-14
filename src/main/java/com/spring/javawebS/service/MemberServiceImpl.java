package com.spring.javawebS.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawebS.dao.MemberDAO;
import com.spring.javawebS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMidCheck(String mid) {
		return memberDAO.getMidCheck(mid);
	}

	@Override
	public MemberVO getNickNameCheck(String nickName) {
		
		return memberDAO.getNickNameCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		//업로드된 사진을 서버 파일시스템에 저장처리한다.
		
		
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public void setMemberVisitProcess(MemberVO vo) {
		memberDAO.setMemberVisitProcess(vo);
		
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid,pwd);
		
	}

	@Override
	public MemberVO getEmailCheck(String email) {
		
		return memberDAO.getEmailCheck(email);
	}


	

}
