package com.spring.javawebS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
			@RequestParam(name="pageSize", defaultValue="1",required=false) int pageSize,
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
	
	
	
	
}
