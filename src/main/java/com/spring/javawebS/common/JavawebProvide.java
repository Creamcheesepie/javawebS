package com.spring.javawebS.common;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

public class JavawebProvide {
	
	
	public int fileUpload(MultipartFile fName,String pathUrl) {
		int res = 0;
		//업로드된 사진을 서버 파일시스템에 저장한다.
		String ofName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String sfName = uid.toString().substring(0, 4)+"_"+ofName;

		try {
			writeFile(fName,sfName,pathUrl);
			res=1;
		} catch (IOException e) {e.printStackTrace();}

		return res;
	}
	
	
	
	public void writeFile(MultipartFile fName, String sfName,String tFolder) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		byte[] data = fName.getBytes();
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/"+tFolder+"/");
		
		FileOutputStream fos = new FileOutputStream(realpath+sfName);
		fos.write(data);
		fos.close();
	}
	
	public int fileUploadWithUUID(MultipartFile fName,String pathUrl) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		int res = 0;
		//업로드된 사진을 서버 파일시스템에 저장한다.
		String ofName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String sfName = uid.toString().substring(0, 4)+"_"+ofName;

		try {
			byte[] data = fName.getBytes();
			String realpath = request.getSession().getServletContext().getRealPath("/resources/data/"+pathUrl+"/");
			
			FileOutputStream fos = new FileOutputStream(realpath+sfName);
			fos.write(data);
			fos.close();
			res=1;
		} catch (IOException e) {e.printStackTrace();}
		
		return res;
	}
	
}
