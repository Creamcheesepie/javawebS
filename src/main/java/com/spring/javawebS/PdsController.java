package com.spring.javawebS;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javawebS.pagination.PageProcess;
import com.spring.javawebS.pagination.PageVO;
import com.spring.javawebS.service.PdsService;
import com.spring.javawebS.vo.PdsVO;

@Controller
@RequestMapping("/pds")
public class PdsController {
	@Autowired
	PdsService pdsService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	
	@RequestMapping(value = "/pdsList",method = RequestMethod.GET)
	public String pdsListGet(Model model,
			@RequestParam(name="pag", defaultValue="1",required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5",required=false) int pageSize,
			@RequestParam(name="part", defaultValue="",required=false) String part
			) {
		if(part.equals("")) part="전체";
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "pds", part, "");
		
		List<PdsVO> vos = pdsService.getPdsList(pageVO.getStartIndexNo(),pageSize,part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "pds/pdsList";
	}
	
	@RequestMapping(value = "/pdsInput",method = RequestMethod.GET)
	public String pdsInputGet(Model model,String part
			) {
		
		model.addAttribute("part", part);
		return "pds/pdsInput";
	}
	
	
	@RequestMapping(value = "/pdsInput",method = RequestMethod.POST)
	public String pdsInputPost(PdsVO vo, MultipartHttpServletRequest file   
			) {
		String pwd= passwordEncoder.encode(vo.getPwd()) ;
		vo.setPwd(pwd);
		System.out.println(vo);
		System.out.println(file);
		System.out.println(file.getFileNames());
		pdsService.setPdsInput(vo,file);
		
		
		
		return "pds/pdsList";
	}
	
	//전체파일 다운로드 하기
	@RequestMapping(value = "/pdsTotalDown",method = RequestMethod.GET)
	public String pdsTotalDownGet( HttpServletRequest request, int idx) throws IOException {
		//파일 다운로드 횟수 증가
		
		//여러개의 파일을 다운로드 할 경우 하나의 파일(zip)로 합쳐 다운로드한다. 압축될 파일명은 'title.zip'으로 다운로드 받는다.
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		PdsVO vo = pdsService.getPdsIdxSearch(idx);
		System.out.println(vo);
		String[] fNames = vo.getFName().split("/");
		String[] fsNames = vo.getFSName().split("/");
		
		String zipPath = realpath+"temp/";
		String zipName = vo.getTitle()+".zip";
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(zipPath+zipName));
		
		byte[] buffer = new byte[2048];
		
		for(int i=0;i<fsNames.length;i++) {
			fis = new FileInputStream(realpath+fsNames[i]);
			fos = new FileOutputStream(zipPath+fNames[i]);
			File moveAndRename = new File(zipPath + fNames[i]);
			
			//fos에 파일을 쓰기 작업
			int data;
			while((data = fis.read(buffer,0,buffer.length))!= -1) {
				fos.write(buffer, 0, data);
			}
			fos.flush();
			fos.close();
			fis.close();
			//zipfile에 fos를 넣어준다.
			
		 fis = new FileInputStream(moveAndRename);
		 zout.putNextEntry(new ZipEntry(fNames[i]));
		 while((data = fis.read(buffer,0,buffer.length))!= -1) {
			 zout.write(buffer,0,data);
		 }
		 zout.flush();
		 zout.closeEntry();
		 
		}
		zout.close();
		
		
		
		
		return "";
	}
	
	
	
	
}
