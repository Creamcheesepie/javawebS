package com.spring.javawebS.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javawebS.dao.PdsDAO;
import com.spring.javawebS.vo.PdsVO;

@Service
public class PdsServiceImpl implements PdsService {
	@Autowired
	PdsDAO pdsDAO;

	@Override
	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part) {
		
		return pdsDAO.getPdsList(startIndexNo,pageSize,part);
	}
	
	
	@Override
	public void setPdsInput(PdsVO vo, MultipartHttpServletRequest mFile) {
	
	
	int fileSizes = 0;	
		try {
			System.out.println("Test");
			List<MultipartFile> fileList = mFile.getFiles("file");
			String ofNames ="";
			String sfNames ="";
			for(MultipartFile file : fileList) {
				String ofName = file.getOriginalFilename();
				String sfName = saveFileName(ofName);
				System.out.println(sfName);
				//이름에 대한 처리가 끝나고 파일을 서버에 저장한다.
				writeFile(file,sfName);
				
				//여러개의 파일명 관리
				ofNames += ofName+"/";
				sfNames += sfName+"/";
				fileSizes += file.getSize();
			}
			vo.setFName(ofNames);
			vo.setFSName(sfNames);
			vo.setFSize(fileSizes);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		
		pdsDAO.setPdsInput(vo);
	}

	
	private void writeFile(MultipartFile file, String sfName) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		FileOutputStream fos = new FileOutputStream(realPath+sfName);
		fos.write(data);
		fos.close();
		
	}


	//파일명 중복방지를 위한 저장 파일명 처리
	private String saveFileName(String ofName) {
		String fName ="";
		
		Calendar cal = Calendar.getInstance();
		fName += cal.get(Calendar.YEAR);
		fName += cal.get(Calendar.MONTH);
		fName += cal.get(Calendar.DATE);
		fName += cal.get(Calendar.HOUR);
		fName += cal.get(Calendar.MINUTE);
		fName += cal.get(Calendar.SECOND);
		fName += cal.get(Calendar.MILLISECOND);
		fName += "_"+ofName;
		
		return fName;
	}
	
	
}
