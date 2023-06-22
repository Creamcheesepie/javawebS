package com.spring.javawebS;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.common.ARIAUtil;
import com.spring.javawebS.common.SecurityUtil;
import com.spring.javawebS.service.StudyService;
import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.KakaoAddressVO;
import com.spring.javawebS.vo.MailVO;
import com.spring.javawebS.vo.MemberVO;
import com.spring.javawebS.vo.UserVO;

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
	public String mailFormGet(Model model) {
		List<EmailListVO> vos = service.getEmail();
		
		model.addAttribute("vos",vos);
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
	
	@RequestMapping(value = "/ajax/ajaxForm",method = RequestMethod.GET)
	public String ajaxFormGet() {
		return "study/ajax/ajaxForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1",method = RequestMethod.POST,produces = "application/text; charset=utf-8")
	public String aJaxTest1Post(int idx) {
		idx = (int)(Math.random()*idx)+1;
		return idx+" : 행복하십쇼!";
	}
	
	//일반 배열값의 전달
	@RequestMapping(value = "/ajax/ajaxTest2_1",method = RequestMethod.GET)
	public String ajaxTest2_1FormGet() {
		return "study/ajax/ajaxTest2_1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_1",method = RequestMethod.POST)
	public String[] ajaxTest2_1FormPost(String dodo) {
		/*
		 String[] strArray = new String[100];
		 service.getCityStringArray(dodo);
		 */

		return service.getCityStringArray(dodo);
	}
	
	//객체 배열(arrayList)값의 전달
	@RequestMapping(value = "/ajax/ajaxTest2_2",method = RequestMethod.GET)
	public String ajaxTest2_2FormGet() {
		return "study/ajax/ajaxTest2_2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest2_2FormPost(String dodo){
		
		return service.getCityArrayList(dodo);
	}
	
	//Map(HashMap<k,v>값의 전달
	@RequestMapping(value = "/ajax/ajaxTest2_3",method = RequestMethod.GET)
	public String ajaxTest2_3FormGet() {
		return "study/ajax/ajaxTest2_3";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest2_3FormPost(String dodo){
		ArrayList<String> vos = new ArrayList<String>();
		vos = service.getCityArrayList(dodo);
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("city", vos);

		return map;
	}
	
	//DB를 이용한 값의 전달 폼
	@RequestMapping(value = "/ajax/ajaxTest3",method = RequestMethod.GET)
	public String ajaxTest3FormGet() {
		return "study/ajax/ajaxTest3";
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_1",method = RequestMethod.POST)
	public MemberVO ajaxTest3_1FormGet(String mid) {
		
		
		return service.getMemberMidSearch(mid);
	}
	
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_2",method = RequestMethod.POST)
	public ArrayList<MemberVO> ajaxTest3_2FormGet(String mid) {
		
		
		return service.getMemberPartMidSearch(mid);
	}
	
	/*
	 * @RequestMapping(value = "/fileUpload/fileUploadform", method =
	 * RequestMethod.GET) public String fileUploadGet() { return
	 * "study/fileupload/fileUploadform"; }
	 */
	
	
	@RequestMapping(value = "/fileUpload/fileUploadform", method =  RequestMethod.GET)
	public String fileUploadGet(HttpServletRequest request, Model model) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study");
		
		String[] files = new File(realPath).list();
		
		/*
		 * for(String file : files) { System.out.println("file : " + file); }
		 */
		model.addAttribute("files",files);
		model.addAttribute("filesCnt",files.length);
		
		return "study/fileupload/fileUploadform";
	}
	
	@RequestMapping(value = "/fileUpload/fileUploadform", method =  RequestMethod.POST)
	public String fileUploadPost(MultipartFile fName,String mid) {
		//System.out.println(fName);
		//System.out.println(mid);
		
		int res = service.fileUpload(fName,mid);
		
		if(res == 1) return "redirect:/message/fileUploadOk";
		else return "redirect:/message/fileUploadNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/fileUpload/fileDelete", method =  RequestMethod.POST)
	public String fileDeletePost(
			@RequestParam(name="file", defaultValue = "",required = false) String fName,
			HttpServletRequest request
			) {
		String res = "0";
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
		File file = new File(realPath+fName);
		if(file.exists()) {
			file.delete();
			res = "1";
		}
		

		return res;
	}
	
	
	@RequestMapping(value = "/fileUpload/fileDownAction", method =  RequestMethod.GET)
	public void fileDownActionGet(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		String fName = request.getParameter("file");
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
		
		File file = new File(realPath+fName);
		
		String fileName = new String(fName.getBytes("utf-8"),"8859_1");
		
		response.setHeader("content-Disposition","attachment:filename="+fileName);
		
		FileInputStream fis = new FileInputStream(file);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] buffer = new byte[2048];
		int data = 0;
		while((data=fis.read(buffer,0,buffer.length)) !=-1) {
			sos.write(buffer,0,data);
		}
		sos.flush();
		sos.close();
		fis.close();

		
	}
	
	@RequestMapping(value = "/validator/validatorForm",method = RequestMethod.GET)
	public String validatorFormGet() {
		return "study/validator/validatorForm";
	}
	
	
	//validator를 이용한 유효성 검사
	@RequestMapping(value = "/validator/validatorForm",method = RequestMethod.POST)
	public String validatorFormPost(
			@Validated UserVO vo, BindingResult bindingResult
			) {
		System.out.println("vo: " +vo);
		
		System.out.println("error:" + bindingResult.hasErrors());
		
		if(bindingResult.hasErrors()) {
			List<ObjectError> list = bindingResult.getAllErrors();
			System.out.println("-----------------------------");
			for(ObjectError e : list) { 
				System.out.println("메세지 : " + e.getDefaultMessage());
			}
			return  "redirect:/message/validatorNo";
		}
		

		int res= service.setUserInput(vo);
		
		if(res==1)return "redirect:/message/userInputOk";
		else return  "redirect:/message/userInputNo";
	}
	
	@RequestMapping(value = "/validator/validatorList" , method=RequestMethod.GET)
	public String userListGet(Model model ) {
		
		ArrayList<UserVO> vos = service.getUserList();
		
		model.addAttribute("vos", vos);
		
		return "study/validator/validatorList";
	}
	
	//카카오 지도 form 보기
	@RequestMapping(value = "/kakaomap/kakaomap" , method=RequestMethod.GET)
	public String kakaomapGet() {
		
		return "study/kakaomap/kakaomap";
	}
	
	//클릭한 위치에 마커 표시하기
	@RequestMapping(value = "/kakaomap/kakaomapEx1" , method=RequestMethod.GET)
	public String kakaomapEx1Get() {
		
		return "study/kakaomap/kakaomapEx1";
	}
	//표시된 마커를 DB에 저장하기
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaomapEx1" , method=RequestMethod.POST)
	public String kakaomapEx1Post(KakaoAddressVO vo
			) {
		System.out.println(vo);
		KakaoAddressVO searchVO = service.getKakaoAddressName(vo.getAddress());
		
		if(searchVO != null) return "0";
		
		service.setKakaoAddress(vo);
		
		return "1";
	}
	
	//DB에 저장된 지명 검색하기
	@RequestMapping(value = "/kakaomap/kakaomapEx2" , method=RequestMethod.GET)
	public String kakaomapEx2Get(Model model,
			@RequestParam(name="address",defaultValue="그린컴퓨터",required=false)String address
	) {
		KakaoAddressVO vo = service.getKakaoAddressName(address);
		List<KakaoAddressVO> vos = service.getKakaoAddressList();
		
		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		return "study/kakaomap/kakaomapEx2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaoAddressDelete" , method=RequestMethod.POST)
	public String kakaoAddressDelete2Get(Model model,
			@RequestParam(name="address",defaultValue="그린컴퓨터",required=false)String address
	) {
		service.setKakaoAddressDelete(address);
		
		return "";
	}
	
		//카카오 데이터베이스에 들어있는 지명으로 검색하고 내 DB에 저장하기
	@RequestMapping(value = "/kakaomap/kakaomapEx3" , method=RequestMethod.GET)
	public String kakaomapEx3Get() {
		
		
		return "study/kakaomap/kakaomapEx3";
	}
	
	//카카오 데이터베이스에 들어있는 지명으로 검색하고 내 DB에 저장하기
	@RequestMapping(value = "/kakaomap/kakaomapEx4" , method=RequestMethod.GET)
	public String kakaomapEx4Get() {
		
		
		return "study/kakaomap/kakaomapEx4";
	}
	
	@RequestMapping(value = "/kakaomap/kakaomapEx4" , method=RequestMethod.POST)
	public String kakaomapEx4Post(String SearchStr,Model model) {
		model.addAttribute("searchStr", SearchStr);
		
		return "study/kakaomap/kakaomapEx4";
	}
	
	
		@RequestMapping(value = "/kakaomap/kakaomapStaticEx1" , method=RequestMethod.GET)
	public String kakaomapStaticEx1Get(Model model,
			@RequestParam(name="searchStr",defaultValue="청주시청",required = false)String searchStr
			) {
		model.addAttribute("searchStr", searchStr);
		
		return "study/kakaomap/kakaomapStaticEx1";
	}
		
		@RequestMapping(value = "/kakaomap/kakaomapStaticEx1Search" , method=RequestMethod.GET)
		public String kakaomapStaticEx1SearchGet(Model model,
				@RequestParam(name="searchStr",defaultValue="청주시청",required = false)String searchStr
				) {
			model.addAttribute("searchStr", searchStr);
			
			return "study/kakaomap/kakaomapStaticEx1";
		}
	
		
		
		
		@RequestMapping(value = "/kakaomap/kakaomapStaticEx2" , method=RequestMethod.GET)
		public String kakaomapStaticEx2Get(Model model,
				@RequestParam(name="searchStr",defaultValue="청주시청",required = false)String searchStr,
				@RequestParam(name="speed",defaultValue="18",required = false)int speed
				) {
			System.out.println(speed);
			//시속을 분속으로 변환
			int mspeed = speed*1000/60;
			model.addAttribute("searchStr", searchStr);
			model.addAttribute("speed", speed);
			model.addAttribute("mspeed", mspeed);
			return "study/kakaomap/kakaomapStaticEx2";
		}
		
	
}
