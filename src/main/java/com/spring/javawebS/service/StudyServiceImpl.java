package com.spring.javawebS.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.dao.StudyDAO;
import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.MemberVO;

@Service
public class StudyServiceImpl implements StudyService {
	@Autowired
	StudyDAO studyDAO;

	@Override
	public List<EmailListVO> getEmail() {
		
		return studyDAO.getEmail();
	}

	@Override
	public String[] getCityStringArray(String dodo) {
		String[] strArray = new String[100];
		
		if(dodo.equals("서울")) {
			strArray[0] = "강남구";
			strArray[1] = "서초구";
			strArray[2] = "마포구";
			strArray[3] = "영등포구";
			strArray[4] = "성동구";
		}
		else if(dodo.equals("경기")) {
			strArray[0] = "고양시";
			strArray[1] ="광주시";
		}
		else if(dodo.equals("충북")) {
			strArray[0] = "청주시";
			strArray[1] ="옥천군";
			strArray[2] ="단양군";
			strArray[3] = "음성군";
			strArray[4] ="증평군";

		}
		else if(dodo.equals("경북")) {
			strArray[0] ="봉화군";
			strArray[1] ="구미시";
			strArray[2] ="영주시";
			strArray[3] ="칠곡군";
		}
	
		
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		
		if(dodo.equals("서울")) {
			vos.add("강남구");
			vos.add("강남구");
			vos.add("서초구");
			vos.add("마포구");
			vos.add("영등포구");
			vos.add("성동구");
		}
		else if(dodo.equals("경기")) {
			vos.add("고양시");
			vos.add("광주시");
		}
		else if(dodo.equals("충북")) {
			vos.add("청주시");
			vos.add("옥천군");
			vos.add("단양군");
			vos.add("음성군");
			vos.add("증평군");
		}
		else if(dodo.equals("경북")) {
			vos.add("봉화군");
			vos.add("구미시");
			vos.add("영주시");
			vos.add("칠곡군");
		}
		
		
		return vos;
	}

	@Override
	public MemberVO getMemberMidSearch(String mid) {
		
		return studyDAO.getMemberMidSearch(mid);
	}

	@Override
	public ArrayList<MemberVO> getMemberPartMidSearch(String mid) {
		
		return studyDAO.getMemberPartMidSearch(mid);
	}

	@Override
	public int fileUpload(MultipartFile fName, String mid) {
		int res = 0;
		//String ofName = fName.getOriginalFilename();
		//System.out.println(ofName);
		
		//메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장처리한다.
		String ofName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		
		
		String sfName = mid+"_"+uid.toString().substring(0, 4)+"_"+ofName;
		
		try {
			writeFile(fName,sfName);
			res=1;
		} catch (IOException e) {e.printStackTrace();}
		
			
		
		return res;
	}

	public void writeFile(MultipartFile fName, String ofName) throws IOException {
		 HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		byte[] data = fName.getBytes();
		//String realpath =request.getRealPath("/resources/data/study/");
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
		
		FileOutputStream fos = new FileOutputStream(realpath+ofName);
		fos.write(data);
		fos.close();
	}
	
	
	
	
	
	
}
