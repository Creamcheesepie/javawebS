package com.spring.javawebS;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
	
	//에러 연습 폼....
	
	@RequestMapping(value="/errorMain",method = RequestMethod.GET)
	public String errorMainGet() {
		
		return "errorPage/errorMain";
	}
	
	@RequestMapping(value="/error1",method = RequestMethod.GET)
	public String error1Get() {
		
		return "errorPage/error1";
	}
	
	@RequestMapping(value="/error404",method = RequestMethod.GET)
	public String error404Get() {
		
		return "errorPage/error404";
	}
	

	@RequestMapping(value="/error500",method = RequestMethod.GET)
	public String error500Get() {
		
		return "errorPage/error500";
	}
	
	@RequestMapping(value="/error500Check",method = RequestMethod.GET)
	public String error500CheckGet(HttpSession session) {
		String errorMaker = (String) session.getAttribute("dfhkahfiusa");
		if (errorMaker.equals("mamadfsadguisdf")) {
			System.out.println("adfhuiadhsi");
		}
		return "";
	}
	
	
}
