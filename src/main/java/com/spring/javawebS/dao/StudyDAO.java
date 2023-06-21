package com.spring.javawebS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.MemberVO;
import com.spring.javawebS.vo.UserVO;

public interface StudyDAO {

	List<EmailListVO> getEmail();

	MemberVO getMemberMidSearch(@Param("mid") String mid);

	ArrayList<MemberVO> getMemberPartMidSearch(@Param("mid") String mid);

	int setUserInput(@Param("vo") UserVO vo);

	ArrayList<UserVO> getUserList();
	

}
