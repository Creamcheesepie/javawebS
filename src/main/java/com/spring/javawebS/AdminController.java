package com.spring.javawebS;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.javawebS.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@RequestMapping("/adminPage")
	public String adminPageGet() {
		return "admin/adminPage";
	}
	
	@RequestMapping("/member")
	public String adminMemberGet() {
		return "admin/
	}
	
	
}
