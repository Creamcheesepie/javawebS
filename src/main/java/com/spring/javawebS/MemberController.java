package com.spring.javawebS;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawebS.pagination.PageProcess;
import com.spring.javawebS.service.MemberService;
import com.spring.javawebS.vo.MemberVO;

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
	
	@RequestMapping(value = "/memberLogin" , method = RequestMethod.POST)
	public String loginPost(
			HttpServletRequest request,
			@RequestParam(name="mid",defaultValue="",required=false) String mid,
			@RequestParam(name="pwd",defaultValue="",required=false) String pwd,
			@RequestParam(name="idSave",defaultValue="",required=false) String idSave,
			HttpSession session,
			HttpServletResponse response
			) {
		MemberVO vo = memberService.getMidCheck(mid);
		
		if(vo != null&& vo.getUserDel().equals("NO")&& bCryptPasswordEncoder.matches(pwd, vo.getPwd())) {
			//회원이 인증처리된 경우? strLevel, Session에 저장, 쿠키저장, 방문자수, 방문포인트 증가...
			String strLevel = "";
			if(vo.getLevel() ==0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sLevel", vo.getLevel() );
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sMid", vo.getMid() );
			session.setAttribute("sNickName", vo.getNickName());
			
			if(idSave.equals("on")) {
				Cookie cookie = new Cookie("cMid",mid);
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length;i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			//로그인한 사용자의 오늘 방문수와 방문포인트를 누적한다.
			memberService.setMemberVisitProcess(vo);
			return "redirect:/message/memberLoginOk";
			
			
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
		
	}
	
	@RequestMapping(value = "/memberJoin" , method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	
	@RequestMapping(value = "/memberJoinOk" , method = RequestMethod.POST)
	public String memberJoinOkPost(MemberVO vo) {
		
	//중복체크
	if(memberService.getMidCheck(vo.getMid())!=null) return "redirect:/message/midCheckNo";
	if(memberService.getNickNameCheck(vo.getNickName())!=null) return "redirect:/message/nickCheckNo";
	
	//비밀번호 암호화
	vo.setPwd(bCryptPasswordEncoder.encode(vo.getPwd()));
	
	//사진파일이 업로드 되었따면 사진파일을 서버 파일시스템에 저장시켜준다.
	
	//체크가 완료되었다면 vo에 담긴자료를 DB에 저장한다.
	int res = memberService.setMemberJoinOk(vo);
	if(res==1) return "redirect:/message/memberJoinNo";
	else return "redirect:/message/memberJoinOk";
	
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck" , method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		System.out.println(mid);
		MemberVO vo = memberService.getMidCheck(mid);
		System.out.println(vo);
		
		if(vo != null ) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck" , method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		MemberVO vo = memberService.getNickNameCheck(nickName);
		
		if(vo != null ) return "1";
		else return "0";
	}
	
	
	
	
	@RequestMapping(value = "/memberMain" , method = RequestMethod.GET)
	public String memberMainGet() {
		return "member/memberMain";
	}
	
	
	
	
	
}
