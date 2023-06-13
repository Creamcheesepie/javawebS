package com.spring.javawebS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawebS.dao.StudyDAO;
import com.spring.javawebS.vo.EmailListVO;

@Service
public class StudyServiceImpl implements StudyService {
	@Autowired
	StudyDAO studyDAO;

	@Override
	public List<EmailListVO> getEmail() {
		
		return studyDAO.getEmail();
	}
	
	
}
