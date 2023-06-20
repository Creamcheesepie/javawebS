package com.spring.javawebS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javawebS.dao.BoardDAO;
import com.spring.javawebS.vo.BoardGoodVO;
import com.spring.javawebS.vo.BoardReplyVO;
import com.spring.javawebS.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		
		return boardDAO.getBoardList(startIndexNo, pageSize);
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public void imgCheck(String content,String sector) {
		
	
		
		//content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 20;
		String index = "data/";
		String tempStr = content.substring(content.indexOf(index)+index.length());
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		
		System.out.println("새방식 : " + tempStr);
		System.out.println("이전방식 : " + nextImg);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String ofPath = realpath+"ckeditor/"+imgFile;
			String cfPath = realpath+"board/"+imgFile;
			
			fileCopyCheck(ofPath, cfPath); //ckeditor 폴더의 그림파일을 board 폴더 위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
			
			
		}
		
	}
	
	//파일을 복사처리한다.
	private void fileCopyCheck(String ofPath, String cfPath) {
		try {
			FileInputStream fis = new FileInputStream(new File(ofPath));
			FileOutputStream fos = new FileOutputStream(new File(cfPath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			
			while((cnt = fis.read(bytes))!=-1) {
				fos.write(bytes,0,cnt);
			}
			
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			System.out.println("파일찾기오류 : " + e.getMessage());
		} catch (IOException e) {
			System.out.println("IO오류 : " + e.getMessage());
		}
		
		
		
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public void setBoardReadUpdate(int idx) {
		boardDAO.setBoardReadUpdate(idx);
		
	}

	@Override
	public ArrayList<BoardVO> getPrevNaxt(int idx) {
		
		return boardDAO.getPrevNaxt(idx);
	}

	@Override
	public void setBoardUpDown(int idx, String mid, String sector) {
		BoardGoodVO vo = boardDAO.getBoardGoodCheck(idx,mid,sector);
			
		if(vo!=null) {
			boardDAO.setBoardGood(idx,-1);
			boardDAO.setBoardGoodMemberDelete(idx,mid,sector);
		}
		else {
			boardDAO.setBoardGood(idx,1);
			boardDAO.setBoardGoodMemberInput(idx,mid,sector);
		}
	}

	@Override
	public List<BoardVO> getBoardSearchResult(String searchString, String search, int startIndexNo, int pageSize) {
		
		return boardDAO.getBoardSearchResult(searchString, search,startIndexNo, pageSize);
	}

	@Override
	public void imgDelete(String content) {
		
		//content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/");
		System.out.println("realpath : " + realpath);
		String index = "board/";
		String nextImg = content.substring(content.indexOf(index)+index.length());

		System.out.println("파일명 " + nextImg);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\"")); //그림 파일명만 꺼내오기
			
			String ofPath = realpath+"board/"+imgFile;
			
			fileDelete(ofPath); //board 폴더의 그림을 삭제처리 한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else {
				nextImg = nextImg.substring(content.indexOf(index)+index.length());
			}
			
	}
		
	}

	public void fileDelete(String ofPath) {
		File delFile = new File(ofPath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setBoardDelete(int idx) {
		
		return boardDAO.setBoardDelete(idx);
	}

	@Override
	public void imgUpdate(String content, String root) {
		//content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realpath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 20;
		String index = "board/";
		String nextImg = content.substring(content.indexOf(index)+index.length());
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String ofPath = realpath+"board/"+imgFile;
			String cfPath = realpath+"ckeditor/"+imgFile;
			
			fileCopyCheck(ofPath, cfPath); //ckeditor 폴더의 그림파일을 board 폴더 위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else {
				nextImg = nextImg.substring(content.indexOf(index)+index.length());
			}
		
		}
	}

	@Override
	public int getboardUpdate(BoardVO vo) {
		
		return boardDAO.getboardUpdate(vo);
	}

	@Override
	public String getMaxGroupId(int boardIdx) {
		
		return boardDAO.getMaxGroupId(boardIdx);
	}

	@Override
	public void setBoardReply(BoardReplyVO replyVO) {
		boardDAO.setBoardReply(replyVO);
		
	}

	@Override
	public List<BoardReplyVO> getReplyList(int idx) {
		
		return  boardDAO.getReplyList(idx);
	}

	@Override
	public void setBoardReplyUpdate(int idx, String content, String postIp) {
		boardDAO.setBoardReplyUpdate(idx,content,postIp);
		
	}


	
	
}
