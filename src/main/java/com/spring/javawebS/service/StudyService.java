package com.spring.javawebS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.KakaoAddressVO;
import com.spring.javawebS.vo.MemberVO;
import com.spring.javawebS.vo.QrCodeVO;
import com.spring.javawebS.vo.TransactionVO;
import com.spring.javawebS.vo.UserVO;

public interface StudyService {

	public List<EmailListVO> getEmail();

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public MemberVO getMemberMidSearch(String mid);

	public ArrayList<MemberVO> getMemberPartMidSearch(String mid);

	public int fileUpload(MultipartFile fName, String mid);

	public int setUserInput(UserVO vo);

	public ArrayList<UserVO> getUserList();

	public KakaoAddressVO getKakaoAddressName(String address);

	public void setKakaoAddress(KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public void setKakaoAddressDelete(String address);

	public String qrCreate(QrCodeVO vo, String realPath);

	public String qrCreate2(QrCodeVO vo, String realPath);

	public String qrCreate3(QrCodeVO vo, String realPath);

	public String qrCreate4(QrCodeVO vo, String realPath);

	public QrCodeVO getQrCodeSearch(String qrCode);

	public void setTransactionUserInput(TransactionVO vo);

	public void setTransactionUser2Input(TransactionVO vo);

	public void setTransactionUserTotalInput(TransactionVO vo);

	public List<TransactionVO> getTransactionList();



}
