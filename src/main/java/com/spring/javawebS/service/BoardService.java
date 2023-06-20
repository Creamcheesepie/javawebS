package com.spring.javawebS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javawebS.vo.BoardReplyVO;
import com.spring.javawebS.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public int setBoardInput(BoardVO vo);

	public void imgCheck(String content, String string);

	public BoardVO getBoardContent(int idx);

	public void setBoardReadUpdate(int idx);

	public ArrayList<BoardVO> getPrevNaxt(int idx);

	public void setBoardUpDown(int idx, String mid, String sector);

	public List<BoardVO> getBoardSearchResult(String searchString, String search, int startIndexNo, int pageSize);

	public void imgDelete(String content);

	public int setBoardDelete(int idx);

	public void imgUpdate(String content, String root);

	public int getboardUpdate(BoardVO vo);

	public String getMaxGroupId(int boardIdx);

	public void setBoardReply(BoardReplyVO replyVO);

	public List<BoardReplyVO> getReplyList(int idx);

	public void setBoardReplyUpdate(int idx, String content, String postIp);




}
