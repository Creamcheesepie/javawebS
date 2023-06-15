package com.spring.javawebS.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.swing.Spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.common.JavawebProvide;
import com.spring.javawebS.dao.MemberDAO;
import com.spring.javawebS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMidCheck(String mid) {
		return memberDAO.getMidCheck(mid);
	}

	@Override
	public MemberVO getNickNameCheck(String nickName) {
		
		return memberDAO.getNickNameCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo,MultipartFile fName) {
		int res = 0;
		//업로드된 사진을 서버 파일시스템에 저장한다.
		String ofName = fName.getOriginalFilename();
		if(ofName.equals("")) vo.setPhoto("noimage.jps");
		else {
			JavawebProvide jp = new JavawebProvide();
			jp.fileUpload(fName, "member");
		}
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public void setMemberVisitProcess(MemberVO vo) {
		memberDAO.setMemberVisitProcess(vo);
		
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid,pwd);
		
	}

	@Override
	public MemberVO getEmailCheck(String email) {
		
		return memberDAO.getEmailCheck(email);
	}

	@Override
	public List<MemberVO> getMemberList() {
		
		return memberDAO.getMemberList();
	}

	@Override
	public MemberVO getMemberDetailInfo(int idx) {
		
		return memberDAO.getMemberDetailInfo(idx);
	}

	@Override
	public List<MemberVO> getMemberSearch(String keyWord, String searchStr) {
		
		return memberDAO.getMemberSearch(keyWord,searchStr);
	}

	
	
	public void writeFile(MultipartFile fName, String ofName) throws IOException {
		 HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		byte[] data = fName.getBytes();
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
		
		FileOutputStream fos = new FileOutputStream(realpath+ofName);
		fos.write(data);
		fos.close();
	}

	@Override
	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo) {
		int res = 0;
		try {
			JavawebProvide jp = new JavawebProvide();
			String ofName = fName.getOriginalFilename();
			
			if(!fName.equals("")) {
				UUID uid = UUID.randomUUID();
				String sfName = uid.toString().substring(0, 4)+"_"+ofName;
				jp.writeFile(fName, sfName, "member");
				
				//기존에 존재하는 파일은 삭제처리한다.
				if(!vo.getPhoto().equals("noimage.jpg")) {
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
					String realpath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
					File file = new File(realpath + vo.getPhoto());
					file.delete();
				}
			vo.setPhoto(sfName); //기존 존재하는 파일의 내역을 지우고, 새로 업로드 시킨 파일명을 set 시켜준다.
		}
		res=1;
	} catch (IOException e) {
	}
	memberDAO.setMemberUpdateOk(vo);

		
		
		
		return res;
	}

	@Override
	public void setMemberDelete(String mid) {
		memberDAO.setMemberDelete(mid);
		
	}
	
	

}
