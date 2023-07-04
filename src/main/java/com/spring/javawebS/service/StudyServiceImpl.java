package com.spring.javawebS.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javawebS.dao.StudyDAO;
import com.spring.javawebS.vo.EmailListVO;
import com.spring.javawebS.vo.KakaoAddressVO;
import com.spring.javawebS.vo.MemberVO;
import com.spring.javawebS.vo.QrCodeVO;
import com.spring.javawebS.vo.TransactionVO;
import com.spring.javawebS.vo.UserVO;

@Service
public class StudyServiceImpl implements StudyService {
	@Autowired
	StudyDAO studyDAO;

	@Override
	public List<EmailListVO> getEmail() {
		
		return studyDAO.getEmail();
	}

	@Override
	public String[] getCityStringArray(String dodo) {
		String[] strArray = new String[100];
		
		if(dodo.equals("서울")) {
			strArray[0] = "강남구";
			strArray[1] = "서초구";
			strArray[2] = "마포구";
			strArray[3] = "영등포구";
			strArray[4] = "성동구";
		}
		else if(dodo.equals("경기")) {
			strArray[0] = "고양시";
			strArray[1] ="광주시";
		}
		else if(dodo.equals("충북")) {
			strArray[0] = "청주시";
			strArray[1] ="옥천군";
			strArray[2] ="단양군";
			strArray[3] = "음성군";
			strArray[4] ="증평군";

		}
		else if(dodo.equals("경북")) {
			strArray[0] ="봉화군";
			strArray[1] ="구미시";
			strArray[2] ="영주시";
			strArray[3] ="칠곡군";
		}
	
		
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		
		if(dodo.equals("서울")) {
			vos.add("강남구");
			vos.add("강남구");
			vos.add("서초구");
			vos.add("마포구");
			vos.add("영등포구");
			vos.add("성동구");
		}
		else if(dodo.equals("경기")) {
			vos.add("고양시");
			vos.add("광주시");
		}
		else if(dodo.equals("충북")) {
			vos.add("청주시");
			vos.add("옥천군");
			vos.add("단양군");
			vos.add("음성군");
			vos.add("증평군");
		}
		else if(dodo.equals("경북")) {
			vos.add("봉화군");
			vos.add("구미시");
			vos.add("영주시");
			vos.add("칠곡군");
		}
		
		
		return vos;
	}

	@Override
	public MemberVO getMemberMidSearch(String mid) {
		
		return studyDAO.getMemberMidSearch(mid);
	}

	@Override
	public ArrayList<MemberVO> getMemberPartMidSearch(String mid) {
		
		return studyDAO.getMemberPartMidSearch(mid);
	}

	@Override
	public int fileUpload(MultipartFile fName, String mid) {
		int res = 0;
		//String ofName = fName.getOriginalFilename();
		//System.out.println(ofName);
		
		//메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장처리한다.
		String ofName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		
		
		String sfName = mid+"_"+uid.toString().substring(0, 4)+"_"+ofName;
		
		try {
			writeFile(fName,sfName);
			res=1;
		} catch (IOException e) {e.printStackTrace();}
		
			
		
		return res;
	}

	public void writeFile(MultipartFile fName, String ofName) throws IOException {
		 HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		byte[] data = fName.getBytes();
		//String realpath =request.getRealPath("/resources/data/study/");
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
		
		FileOutputStream fos = new FileOutputStream(realpath+ofName);
		fos.write(data);
		fos.close();
	}

	@Override
	public int setUserInput(UserVO vo) {
		return studyDAO.setUserInput(vo);
	}

	@Override
	public ArrayList<UserVO> getUserList() {
		
		return studyDAO.getUserList();
	}

	@Override
	public KakaoAddressVO getKakaoAddressName(String address) {
		
		return studyDAO.getKakaoAddressName(address);
	}

	@Override
	public void setKakaoAddress(KakaoAddressVO vo) {
		studyDAO.setKakaoAddress(vo);
		
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		
		return studyDAO.getKakaoAddressList();
	}

	@Override
	public void setKakaoAddressDelete(String address) {
		studyDAO.setKakaoAddressDelete(address);
		
	}

	@Override
	public String qrCreate(QrCodeVO vo, String realPath) {
		// 날짜_아이디_성명_이메일주소_랜덤번호2자리
		String qrCodeName ="";
		String qrCodeName2 ="";
		SimpleDateFormat sdp = new SimpleDateFormat("yyyyMMddhhmmss");
		UUID uid = UUID.randomUUID();
		String strUid = uid.toString().substring(0, 2);
		qrCodeName = sdp.format(new Date())+"_"+vo.getMid()+"_"+vo.getName()+"_"+vo.getEmail()+"_"+strUid;
		qrCodeName2 = sdp.format(new Date())+"\n"+vo.getMid()+"\n"+vo.getName()+"\n"+vo.getEmail()+"\n"+strUid;
		
		try {
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			//String name= new String(vo.getName().getBytes("UTF-8"), "ISO-8859-1");
			String name= new String(qrCodeName	.getBytes("UTF-8"), "ISO-8859-1");
			qrCodeName2 = new String(qrCodeName2.getBytes("UTF-8"),"ISO-8859-1");
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; //QR코드으 글자색 검정
			int qrCodeBackColor = 0xFFFFFFFF; //QR코드의 배경색 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter(); //QR코드 객체 생성
			
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName2, BarcodeFormat.QR_CODE , 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor);
			
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
			
			//ImageIO객체를 이영하면 byte 배열단위로 변환없이 바로 파일을 write할 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath+qrCodeName+".png"));
			
		} catch (IOException e) {
			System.out.println("IO오류 :" + e.getMessage());
		} catch (WriterException e) {
			System.out.println("라이터오류 :" + e.getMessage());
		}
		
		return qrCodeName;
	}

	@Override
	public String qrCreate2(QrCodeVO vo, String realPath) {
		// 사이트 주소
		String qrCodeName ="";
		qrCodeName = vo.getMoveUrl();
	
		try {
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			qrCodeName = new String(qrCodeName.getBytes("UTF-8"),"ISO-8859-1");
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; //QR코드으 글자색 검정
			int qrCodeBackColor = 0xFFFFFFFF; //QR코드의 배경색 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter(); //QR코드 객체 생성
			
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName, BarcodeFormat.QR_CODE , 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor);
			
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
			
			//ImageIO객체를 이영하면 byte 배열단위로 변환없이 바로 파일을 write할 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath+qrCodeName+".png"));
			
		} catch (IOException e) {
			System.out.println("IO오류 :" + e.getStackTrace());
		} catch (WriterException e) {
			System.out.println("라이터오류 :" + e.getMessage());
		}
		
		return qrCodeName;	
	}
	
	
	@Override
	public String qrCreate3(QrCodeVO vo, String realPath) {
		// 영화 예매
		
		
		String qrCodeName ="";
		qrCodeName = vo.getMovieTemp();
		System.out.println(qrCodeName);
		try {
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; //QR코드으 글자색 검정
			int qrCodeBackColor = 0xFFFFFFFF; //QR코드의 배경색 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter(); //QR코드 객체 생성
			
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName, BarcodeFormat.QR_CODE , 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor);
			
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
			
			String sfName = qrCodeName.substring(0,qrCodeName.indexOf("_"));
			//ImageIO객체를 이영하면 byte 배열단위로 변환없이 바로 파일을 write할 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath+sfName+".png"));
			
		} catch (IOException e) {
			System.out.println("IO오류 :" + e.getStackTrace());
		} catch (WriterException e) {
			System.out.println("라이터오류 :" + e.getMessage());
		}
		
		return qrCodeName;	
	}

	
	@Override
	public String qrCreate4(QrCodeVO vo, String realPath) {
		// 영화 예매
		System.out.println(vo);
		
		String qrCodeName ="";
		qrCodeName = vo.getMovieTemp();
		System.out.println(qrCodeName);
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString().substring(0, 4);
			qrCodeName = sdf.format(new Date())+ "_"+strUid;
			
			String qrTemp = new String(vo.getMovieTemp().getBytes("UTF-8"), "ISO-8859-1");
			
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; //QR코드으 글자색 검정
			int qrCodeBackColor = 0xFFFFFFFF; //QR코드의 배경색 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter(); //QR코드 객체 생성
			
			BitMatrix bitMatrix = qrCodeWriter.encode(qrTemp, BarcodeFormat.QR_CODE , 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor);
			
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
			
		
			//ImageIO객체를 이영하면 byte 배열단위로 변환없이 바로 파일을 write할 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath+qrCodeName+".png"));
			
			//생성된 QR코드의 정보를 DB에 저장한다.
			vo.setQrCodeName(qrCodeName+".png");
			studyDAO.setQrCodeInput(vo);
			
		} catch (IOException e) {
			System.out.println("IO오류 :" + e.getStackTrace());
		} catch (WriterException e) {
			System.out.println("라이터오류 :" + e.getMessage());
		}
		
		return qrCodeName;	
	}

	@Override
	public QrCodeVO getQrCodeSearch(String qrCode) {
		
		return studyDAO.getQrCodeSearch(qrCode);
	}

	@Override
	public void setTransactionUserInput(TransactionVO vo) {
		studyDAO.setTransactionUserInput(vo);
	}

	@Override
	public void setTransactionUser2Input(TransactionVO vo) {
		studyDAO.setTransactionUser2Input(vo);
	}
	
	@Transactional
	@Override
	public void setTransactionUserTotalInput(TransactionVO vo) {
		studyDAO.setTransactionUserTotalInput(vo);
		
	}

	@Override
	public List<TransactionVO> getTransactionList() {
		
		return studyDAO.getTransactionList();
	}
	
	
	
	
	
}
