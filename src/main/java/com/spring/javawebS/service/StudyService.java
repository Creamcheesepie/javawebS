package com.spring.javawebS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.MemberVO;
import com.spring.javawebS.vo.UserVO;

public interface StudyService {

	public List<EmailListVO> getEmail();

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public MemberVO getMemberMidSearch(String mid);

	public ArrayList<MemberVO> getMemberPartMidSearch(String mid);

	public int fileUpload(MultipartFile fName, String mid);

	public int setUserInput(UserVO vo);

	public ArrayList<UserVO> getUserList();



}
