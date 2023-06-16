package com.spring.javawebS;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = {"/","h"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/imageUpload")
	public void imageUplaodGet(MultipartFile upload, 
			HttpServletRequest request,HttpServletResponse response
			) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String ofName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		ofName= sdf.format(date)+"_"+ofName;
		
		//ckeditor에서 전송한 파일을 서퍼의 파일시스템에 실제로 저장처리한다.
		byte[] bytes = upload.getBytes();
		
		FileOutputStream fos = new FileOutputStream(new File(realPath+ofName));
		fos.write(bytes);
		
		//서버 파일시스템에 저장되어 있는 그림파일을 브라우저 편집화면(textarea)에 보여주는 처리
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/" + ofName;
		out.println("{\"orginalFilename\":\""+ofName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		
		out.flush();
		fos.close();
		
		
	}
	
	
}
