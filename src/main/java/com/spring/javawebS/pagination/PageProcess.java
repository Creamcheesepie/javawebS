package com.spring.javawebS.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawebS.dao.BoardDAO;
import com.spring.javawebS.dao.GuestDAO;
import com.spring.javawebS.dao.PdsDAO;
import com.spring.javawebS.vo.PdsVO;

@Service
public class PageProcess {
	@Autowired
	GuestDAO guestDAO;

	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	PdsDAO pdsDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchStr) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		
		if(section.equals("guest")) totRecCnt = guestDAO.totRecCnt();
		else if(section.equals("board")) {
			if(part.equals(""))totRecCnt = boardDAO.totRecCnt();
			else {
				String search = part;
			}
		}
		else if(section.equals("board")) {
			totRecCnt = pdsDAO.totRecCnt(part);
		}
		//else if(section.equals("member")) totRecCnt = memberDAO.totRecCnt();

		
		int totPage = (totRecCnt%pageSize)==0?totRecCnt/pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag-1)/blockSize;
		int lastBlock =(totPage-1)/blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		
		
		return pageVO;
	}

	public PageVO totRecCntSearch(int pag, int pageSize, String secttion, String search, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = boardDAO.totRecCntSearch(search, searchString);
		
	
		//else if(section.equals("member")) totRecCnt = memberDAO.totRecCnt();

		
		int totPage = (totRecCnt%pageSize)==0?totRecCnt/pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag-1)/blockSize;
		int lastBlock =(totPage-1)/blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		
		
		
		return pageVO;
	}

}
