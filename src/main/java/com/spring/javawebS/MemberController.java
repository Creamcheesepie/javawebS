package com.spring.javawebS;

import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawebS.service.MemberService;
import com.spring.javawebS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	JavaMailSender mailSender;
	
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
		
		if(vo != null && vo.getUserDel().equals("no") && bCryptPasswordEncoder.matches(pwd, vo.getPwd())) {
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
	
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		session.invalidate();
		return "redirect:/message/memberLogout";
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
	
	
	
	@RequestMapping(value = "/login/memberMain" , method = RequestMethod.GET)
	public String memberMainGet() {
		return "member/memberMain";
	}
	
	@RequestMapping(value = "/memberPwdFind" , method = RequestMethod.GET)
	public String memberPwdFindGet() {
		return "member/memberPwdFind";
	}
	
	@RequestMapping(value = "/memberPwdFind" , method = RequestMethod.POST)
	public String memberPwdFindPost(String mid, String toMail,HttpServletRequest request) throws MessagingException {
		MemberVO vo = memberService.getMidCheck(mid);
		
		if(vo != null) {
			if(vo.getEmail().equals(toMail)) {	
				//회원정보가 동일할 경우 임시 비밀번호를 발급한다.
				UUID uid = UUID.randomUUID();
				String pwd = uid.toString().substring(0, 8);
				
				//회원이 임시 비밀번호를 변경처리할 수 있게 임시 세션 1개를 생성해준다.
				HttpSession session = request.getSession();
				session.setAttribute("sTempPwd", "ok");
				
				
				memberService.setMemberPwdUpdate(mid,bCryptPasswordEncoder.encode(pwd));
				
				//저장된 임시 비밀번호를 메일로 전송처리한다
				String content = pwd;
				int res = mailSend(mid, toMail, content);
				
				if(res == 1) return "redirect:/message/memberTempPwdOk";
				else return "redirect:/message/memberTempPwdNo";
				
			}
			else {
				return "redirect:/message/wrongMail";
			}
		}
		else {
			return "redirect:/message/wrongMid";
		}

	}

	private int mailSend(String mid, String toMail, String content) throws MessagingException {
		
		
		String title=mid+"계정의 임시 비밀번호를 보냅니다.";
		
		String tempPwd = content;
		
		//메일 전송을 위한 객체(2개) : MimeMessage() , MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
		
		//메일 보관함에 회원이 보내온 메세지들의 정보를 모두 저장시키고 작업하자.
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬 수 있도록 한다.
		content ="<br><hr><h3>임시 비밀번호입니다.</h3><hr>";
		content +="<p>귀하의 "+mid+"계정의 임시 비밀번호는  "+tempPwd+" 입니다</p>";
		content +="<p>방문하기 : <a href='http://localhost:9090/javawebS'>방문하기</a>";
		content +="<hr>";
		
		messageHelper.setText(content,true);
		
		
		
		//메일 전송하기
		mailSender.send(message);
		
		
		return 1;
	}

	@RequestMapping(value = "/memberPwdUpdate" , method = RequestMethod.GET)
	public String memberPwdUpdateGet() {
		return "member/memberPwdUpdate";
	}
	
	@RequestMapping(value = "/memberPwdUpdate" , method = RequestMethod.POST)
	public String memberPwdUpdatePost(String mid, String pwd,HttpSession session) {
		memberService.setMemberPwdUpdate(mid, bCryptPasswordEncoder.encode(pwd));
		
		session.invalidate();
		
		return "redirect:/message/memberPwdUpdateOk";
	}
	
	//아이디 찾기
	@RequestMapping(value = "/memberMidFind" , method = RequestMethod.GET)
	public String memberMidFindGet() {
		return "member/memberMidFind";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberMidFind" , method = RequestMethod.POST,produces = "application/text;charset=utf-8")
	public String memberMidFindPost(String email,String name) {
		MemberVO vo = memberService.getEmailCheck(email);
		
		String tempMid = vo.getMid();
		String outMid = "";
		
		if(vo != null) {
			if(vo.getName().equals(name)) {
				outMid="입력하신 성함과 이메일로 가입된 아이디는 : ";
				char[] arr = tempMid.toCharArray();
				for(int i =0; i<arr.length;i++) {
					if(i%3==0) {
						arr[i] ='*';
					}
					outMid += arr[i];
				} 
				outMid+=" 입니다.";
			}
			else {
				outMid="입력하신 이메일과 성명이 일치하지 않습니다. 다시 확인해주세요";
			}
		}
		else {
			outMid = "입력하신 이메일로 가입된 계정이 없습니다. 다시 확인해 주세요.";
		}
		

		
		return outMid;
	}
	
	@RequestMapping(value = "/memberList", method=RequestMethod.GET)
	public String memberListGet(Model model) {
		List<MemberVO> vos = memberService.getMemberList();
		model.addAttribute("vos",vos);
		return "member/memberList";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/memberDetailInfo", method=RequestMethod.POST)
	public MemberVO memberDetailInfoPost(int idx) {
		MemberVO vo = memberService.getMemberDetailInfo(idx);
		return vo;
	}
	



	
	
	
	
}
