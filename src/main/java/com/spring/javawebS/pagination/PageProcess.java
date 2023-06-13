package com.spring.javawebS.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawebS.dao.GuestDAO;

@Service
public class PageProcess {
	@Autowired
	GuestDAO guestDAO;
	
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchStr) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		
		if(section.equals("guest")) totRecCnt = guestDAO.totRecCnt();
		//else if(section.equals("member")) totRecCnt = memberDAO.totRecCnt();
		//else if(section.equals("board")) totRecCnt = boardDAO.totRecCnt();
		
		totRecCnt = guestDAO.totRecCnt();
		
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

}
