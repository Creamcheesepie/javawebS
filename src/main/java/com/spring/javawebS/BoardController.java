package com.spring.javawebS;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javawebS.pagination.PageProcess;
import com.spring.javawebS.pagination.PageVO;
import com.spring.javawebS.service.BoardService;
import com.spring.javawebS.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	
	@RequestMapping("/boardList")
	public String boardListGet(Model model,
			@RequestParam(name="pag",defaultValue = "1",required = false) int pag,
			@RequestParam(name="pageSize", defaultValue="5",required = false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", "","");
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/boardInput",method =RequestMethod.GET )
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		//content에 이미지가 저장되어 있다면 저장된 이미지만 골라서 /resources/data/board 폴더에 저장한다.
		boardService.imgCheck(vo.getContent());
		
		//이미지들의 모든 복사처리가 끝났다면 ckeditor의 경로를 board로 바꿔준다.
		vo.setContent(vo.getContent().replace("/data/", "/data/board/"));
		
		
		//content 안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res= boardService.setBoardInput(vo);
		
		if(res == 1) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
		
	}
	
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(
				@RequestParam(name="idx",defaultValue="0",required=false) int idx,
				@RequestParam(name="pag",defaultValue="0",required=false) int pag,
				@RequestParam(name="pageSize",defaultValue="0",required=false) int pageSize,
			Model model, HttpSession session
			) {
		
		//글 조회수 1씩 증가시키기(조회수 중복방지 - 세션처리( board+ 고유번호)
		ArrayList<String> contentIdx = (ArrayList<String>)session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String tempContentIdx = "board"+idx;
		if(!contentIdx.contains(tempContentIdx)) {
			contentIdx.add(tempContentIdx);
			boardService.setBoardReadUpdate(idx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		
		BoardVO vo = boardService.getBoardContent(idx);
		
		
		//이전글 다음글 가져오기
		ArrayList<BoardVO> pnVOS = boardService.getPrevNaxt(idx);
		System.out.println(idx);
		System.out.println(pnVOS);
		
		model.addAttribute("pnVOS", pnVOS);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		
		return "board/boardContent";
	}
	
	@RequestMapping(value = "/boardGoodCheck",method =RequestMethod.GET )
	public String boardGoodGet(Model model,
			@RequestParam(name="idx",defaultValue="0",required=false) int idx,
			@RequestParam(name="pag",defaultValue="0",required=false) int pag,
			@RequestParam(name="pageSize",defaultValue="0",required=false) int pageSize,			
			HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		boardService.setBoardUpDown(idx,mid,"board");
		
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		
		return "board/boardContent";
	}
	
	



}
