package com.spring.javawebS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.KakaoAddressVO;
import com.spring.javawebS.vo.MemberVO;
import com.spring.javawebS.vo.QrCodeVO;
import com.spring.javawebS.vo.UserVO;

public interface StudyDAO {

	public List<EmailListVO> getEmail();

	public MemberVO getMemberMidSearch(@Param("mid") String mid);

	public ArrayList<MemberVO> getMemberPartMidSearch(@Param("mid") String mid);

	public int setUserInput(@Param("vo") UserVO vo);

	public ArrayList<UserVO> getUserList();

	public KakaoAddressVO getKakaoAddressName(@Param("address") String address);

	public void setKakaoAddress(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public void setKakaoAddressDelete(@Param("address") String address);

	public QrCodeVO getQrCodeSearch(@Param("qrCode")String qrCode);

	public void setQrCodeInput(@Param("vo") QrCodeVO vo);
	

}
