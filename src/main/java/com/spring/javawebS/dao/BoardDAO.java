package com.spring.javawebS.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.BoardGoodVO;
import com.spring.javawebS.vo.BoardReplyVO;
import com.spring.javawebS.vo.BoardVO;

public interface BoardDAO {

	public int totRecCnt();

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public void setBoardReadUpdate(@Param("idx") int idx);

	public ArrayList<BoardVO> getPrevNaxt(@Param("idx") int idx);

	public BoardGoodVO getBoardGoodCheck(@Param("idx") int idx,@Param("mid") String mid,@Param("sector") String sector);

	public void setBoardGood(@Param("idx") int idx,@Param("i") int i);

	public void setBoardGoodMemberDelete(@Param("idx") int idx,@Param("mid")  String mid, @Param("sector") String sector);

	public void setBoardGoodMemberInput(@Param("idx") int idx,@Param("mid")  String mid, @Param("sector") String sector);

	public int totRecCntSearch(@Param("search")String search,@Param("searchString") String searchString);

	public List<BoardVO> getBoardSearchResult(@Param("searchString") String searchString,@Param("search") String search,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int setBoardDelete(@Param("idx") int idx);

	public int getboardUpdate(@Param("vo") BoardVO vo);

	public String getMaxGroupId(@Param("boardIdx") int boardIdx);

	public void setBoardReply(@Param("replyVO") BoardReplyVO replyVO);

	public List<BoardReplyVO> getReplyList(@Param("boardIdx") int idx);

	public void setBoardReplyUpdate(@Param("idx") int idx,@Param("content") String content,@Param("postIp") String postIp);


}
