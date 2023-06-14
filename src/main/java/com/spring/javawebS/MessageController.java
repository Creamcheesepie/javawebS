package com.spring.javawebS;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/message")
public class MessageController {
	
	@RequestMapping(value="/{msgFlag}" , method = RequestMethod.GET)
	public String boardListGet(@PathVariable String msgFlag,Model model) {
		
		if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록 작성완료!");
			model.addAttribute("url","/guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "방명록 작성실패");
			model.addAttribute("url","/guest/guestInput");
		}
		else if(msgFlag.equals("guestAdminOk")) {
			model.addAttribute("msg", "관리자 인증 성공");
			model.addAttribute("url","/guest/guestList");
		}
		else if(msgFlag.equals("guestAdminNo")) {
			model.addAttribute("msg", "관리자 인증 실패");
			model.addAttribute("url","/guest/adminLogin");
		}
		else if(msgFlag.equals("guestAdminLogout")) {
			model.addAttribute("msg", "관리자 로그아웃");
			model.addAttribute("url","/guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("msg", "방명록 삭제 완료");
			model.addAttribute("url","/guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteNo")) {
			model.addAttribute("msg", "방명록 삭제 실패");
			model.addAttribute("url","/guest/guestList");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일 전송 완료");
			model.addAttribute("url","/study/mail/mailForm");
		}
		else if(msgFlag.equals("midCheckNo")) {
			model.addAttribute("msg", "아이디 중복입니다.");
			model.addAttribute("url","/member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "닉네임 중복입니다.");
			model.addAttribute("url","/member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입 성공");
			model.addAttribute("url","/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 실패.");
			model.addAttribute("url","/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", "로그인 성공");
			model.addAttribute("url","/member/login/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패.");
			model.addAttribute("url","/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", "로그아웃 되었습니다.");
			model.addAttribute("url","/member/memberLogin");
		}
		else if(msgFlag.equals("/message/unSafeLoad")) {
			model.addAttribute("msg", "잘못된 접근입니다. 확인해주세요.");
			model.addAttribute("url","/");
		}
		else if(msgFlag.equals("/message/noLoginLoad")) {
			model.addAttribute("msg", "로그인 해주십시오");
			model.addAttribute("url","/member/memberLogin");
		}
		else if(msgFlag.equals("/message/noLevel2")) {
			model.addAttribute("msg", "정회원 이상만 사용가능합니다. 확인해주세요");
			model.addAttribute("url","/member/login/memberMain");
		}
		else if(msgFlag.equals("/message/noLevel1")) {
			model.addAttribute("msg", "우수회원 이상만 사용가능합니다. 확인해주세요");
			model.addAttribute("url","/member/login/memberMain");
		}
		else if(msgFlag.equals("/message/wrongMid")) {
			model.addAttribute("msg", "입력하신 아이디가 틀렸습니다. 다시 확인해 주세요.");
			model.addAttribute("url","/member/memberPwdFind");
		}
		else if(msgFlag.equals("/message/wrongMail")) {
			model.addAttribute("msg", "입력하신 이메일이 틀렸습니다. 다시 확인해 주세요.");
			model.addAttribute("url","/member/memberPwdFind");
		}
		else if(msgFlag.equals("/message/memberTempPwdOk")) {
			model.addAttribute("msg", "임시비밀번호가 발급되었습니다");
			model.addAttribute("url","/member/memberLogin");
		}
		else if(msgFlag.equals("/message/memberTempPwdNo")) {
			model.addAttribute("msg", "임시 비밀번호 발급에 실패하였습니다.");
			model.addAttribute("url","/member/memberPwdFind");
		}
		else if(msgFlag.equals("/message/memberPwdUpdateOk")) {
			model.addAttribute("msg", "비밀번호가 변경되었습니다. 변경된 비밀번호로 로그인 해주십시오.");
			model.addAttribute("url","/member/memberLogin");
		}
		

		
		return "include/message";
	}
	

}
