package com.spring.javawebS;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javawebS.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value = "/memberLogin" , method = RequestMethod.GET)
	public String loginGet(
			HttpServletRequest request,
			Model model
			) {
		Cookie[] cookies =request.getCookies();
		
		if(cookies!=null) {
			for(int i = 0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("id", cookies[i].getValue());
					break;
				}
			}
		}
		
		
		return "member/memberLogin";
	}
	
	
	
}
