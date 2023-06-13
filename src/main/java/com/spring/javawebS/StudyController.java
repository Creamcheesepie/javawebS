package com.spring.javawebS;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javawebS.common.ARIAUtil;
import com.spring.javawebS.common.SecurityUtil;
import com.spring.javawebS.service.StudyService;
import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.MailVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	@Autowired
	StudyService service;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value =  "/password/sha256", method = RequestMethod.GET)
	public String sha256Get() {
		return"study/password/sha256";
	}
	
	//암호화 연습(sha256)
	@ResponseBody
	@RequestMapping(value = "/password/sha256", method = RequestMethod.POST ,produces = "application/text; charset=utf8")
	public String sha256Post(String pwd) {
		SecurityUtil security = new SecurityUtil();
		String encPwd = security.encryptSHA256(pwd);
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	//암호화 연습(ARIA)
	@RequestMapping(value = "/password/aria", method = RequestMethod.GET)
	public String ariaGet(String pwd) {

		return "study/password/aria";
	}
	
	@ResponseBody
	@RequestMapping(value = "/password/aria", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String ariaPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		String encPwd = "";
		String decPwd = "";
		
		encPwd = ARIAUtil.ariaEncrypt(pwd);
		decPwd = ARIAUtil.ariaDecrypt(encPwd);
		
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd + " / 복호화된 비밀번호 : " + decPwd;
		
		return pwd;
	}
	
	//암호화 연습(bCryptPasswordEncoder)
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.GET)
	public String bCryptPasswordGet(String pwd) {
		
		return "study/password/bCryptPassword";
	}
	
	@ResponseBody
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String bCryptPasswordPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		String encPwd = "";
		encPwd = passwordEncoder.encode(pwd); 
		
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd ;
		
		return pwd;
	}
	
	//이메일 연습
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.GET)
	public String mailFormGet() {
		
		return "study/mail/mailForm";
	}
	
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.POST)
	public String mailFormPost(MailVO vo,HttpServletRequest request) throws MessagingException {
		
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		//메일 전송을 위한 객체(2개) : MimeMessage() , MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
		
		//메일 보관함에 회원이 보내온 메세지들의 정보를 모두 저장시키고 작업하자.
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬 수 있도록 한다.
		content = content.replace("\n", "<br>");
		content +="<br><hr><h3>메일 연습차 보냅니다.</h3><hr>";
		content +="<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content +="<p>방문하기 : <a href='http://localhost:9090/javawebS'>방문하기</a>";
		content +="<hr>";
		
		messageHelper.setText(content,true);
		
		//본문에 첨부된 이미지 파일의 경로를 지정해준다. 그 후 다시 보관함에 담아준다.
		FileSystemResource file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\main.jpg");
		
		messageHelper.addInline("main.jpg", file);
		
		//첨부파일(서버의 파일 시스템에 존재하는 파일을 보내기)
		file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\chicago.jpg");
		messageHelper.addAttachment("chicago.jpg", file);
		file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\main.zip");
		messageHelper.addAttachment("main.zip", file);
		//파일시스템에 설계한 파일이 저장된 실제경로(realpath)
		
		
//	file = new FileSystemResource(request.getRealPath("/resources/images/paris.jpg"));
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/paris.jpg"));
		messageHelper.addAttachment("paris.jpg", file);
		
		
		//메일 전송하기
		mailSender.send(message);
		
		
		return "redirect:/message/mailSendOk";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mail/mailList", method = RequestMethod.POST)
	public List<EmailListVO> mailListGet(Model model) {
		
		List<EmailListVO> vos = service.getEmail();
		
		System.out.println(vos);
		return vos;
	}
	
	
	@RequestMapping(value = "/uuid/uuidForm",method = RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuid";
	}
	
	@ResponseBody
	@RequestMapping(value = "/uuid/uuidForm",method = RequestMethod.POST)
	public String uuidFormPost() {
		
		UUID uuid = UUID.randomUUID();
		
		
		return uuid.toString();
	}
	
	
}
