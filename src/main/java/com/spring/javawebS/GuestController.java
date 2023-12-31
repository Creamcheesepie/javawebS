package com.spring.javawebS;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javawebS.pagination.PageProcess;
import com.spring.javawebS.pagination.PageVO;
import com.spring.javawebS.service.GuestService;
import com.spring.javawebS.vo.GuestVO;

@Controller
@RequestMapping("/guest")
public class GuestController {
	
	
	@Autowired
	GuestService guestService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/guestList" , method = RequestMethod.GET)
	public String guestListGet(
			@RequestParam(name="pag",defaultValue="1",required = false) int pag,
			@RequestParam(name="pageSize",defaultValue="1",required = false) int pageSize,
			Model model) {
		//페이지 처리
		/*
		int totRecCnt = guestService.totRecCnt();
		int totPage = (totRecCnt%pageSize)==0?totRecCnt/pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag-1)/blockSize;
		int lastBlock =(totPage-1)/blockSize;
		
		
		List<GuestVO> vos= guestService.getGuestList(startIndexNo,pageSize);
		model.addAttribute("vos",vos);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("totalPage",totPage);
		model.addAttribute("curScrStartNo",curScrStartNo);
		model.addAttribute("totRecCnt",totRecCnt);
		model.addAttribute("curBlock",curBlock);
		model.addAttribute("lastBlock",lastBlock);
		model.addAttribute("blockSize",blockSize);
		*/
		
		
		PageVO  pageVO = pageProcess.totRecCnt(pag , pageSize,"guest","","");
		List<GuestVO> vos = guestService.getGuestList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO", pageVO);
		return "guest/guestList";
	}
	
	@RequestMapping(value = "/guestInput" , method = RequestMethod.GET)
	public String guestInputGet() {
		return "guest/guestInput";
	}
		
	@RequestMapping(value = "/guestInput" , method = RequestMethod.POST)
	public String guestInputPost(GuestVO vo ,Model model) {
		int res = guestService.setGeustInput(vo);
		
		if(res==1) {
			return "redirect:/message/guestInputOk";
		}
		else {
			return "redirect:/message/guestInputNo";
		}
	}
	
	@RequestMapping(value = "/adminLogin" , method = RequestMethod.GET)
	public String adminLoginGet() {
		return "guest/adminLogin";
	}
	
	@RequestMapping(value = "/adminLogin" , method = RequestMethod.POST)
	public String adminLoginPost(
			HttpServletRequest request,
			@RequestParam(name="mid",defaultValue="",required = false) String mid,
			@RequestParam(name="pwd",defaultValue="",required = false) String pwd
			) {
		//간단한 처리는 컨트롤러에서 해결해도 된다.하지만 여기서는 서비스 연습하기~
		int res = guestService.getAdminCheck(mid,pwd);
		
		if(res == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("sAdmin", "adminOk");
			return "redirect:/message/guestAdminOk";
		}
		else {
			return "redirect:/message/guestAdminNo";
			
		}
		
	}
	
	@RequestMapping(value = "/adminLogout" , method = RequestMethod.GET)
	public String adminLogoutGet(HttpSession session) {
		session.invalidate();
	
		return "redirect:/message/guestAdminLogout";
		
	}	
	
	//방명록 글 삭제하기
	@RequestMapping(value = "/guestDelete" , method = RequestMethod.GET)
	public String guestDeleteGet(
			@RequestParam(name="idx",defaultValue="0",required = false)int idx
			) {
		int res = guestService.setGeustDelete(idx);
		
		if(res==1) {
			return "redirect:/message/guestDeleteOk";
		}
		else {
			return "redirect:/message/guestDeleteNo";
		}
		
		
		
	}

}
