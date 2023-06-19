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
		boardService.imgCheck(vo.getContent(),"board");
		
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
	
	@RequestMapping(value = "/boardSearch" , method = RequestMethod.POST)
	public String boardSearchPost(Model model,
			@RequestParam(name="searchString",defaultValue="",required=false) String searchString,
			@RequestParam(name="search",defaultValue="",required=false) String search,
			@RequestParam(name="pag",defaultValue="0",required=false) int pag,
			@RequestParam(name="pageSize",defaultValue="0",required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCntSearch(pag, pageSize, "board", search, searchString);
		
		
		List<BoardVO> vos = boardService.getBoardSearchResult(searchString,search,pageVO.getStartIndexNo(), pageSize);
		
		String searchTitle = "";
		if(search.equals("title")) searchTitle  = "글제목";
		else if(search.equals("name")) searchTitle = "작성자";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("searchString", searchString );
		model.addAttribute("search",search);
		model.addAttribute("searchCount",vos.size());
		
		return "board/boardSearch";
	}
	
	@RequestMapping(value = "/boardSearch" , method = RequestMethod.GET)
	public String boardSearchGet(Model model,
			@RequestParam(name="searchString",defaultValue="",required=false) String searchString,
			@RequestParam(name="search",defaultValue="",required=false) String search,
			@RequestParam(name="pag",defaultValue="0",required=false) int pag,
			@RequestParam(name="pageSize",defaultValue="0",required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCntSearch(pag, pageSize, "board", search, searchString);
		
		
		List<BoardVO> vos = boardService.getBoardSearchResult(searchString,search,pageVO.getStartIndexNo(), pageSize);
		
		String searchTitle = "";
		if(search.equals("title")) searchTitle  = "글제목";
		else if(search.equals("name")) searchTitle = "작성자";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("searchString", searchString );
		model.addAttribute("search",search);
		model.addAttribute("searchCount",vos.size());
		
		return "board/boardSearch";
	}
	
	//게시글 삭제하기
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx, HttpSession session,
			@RequestParam(name="nickName",defaultValue="",required=false)String nickName
			) {
		
		String sNickName = (String) session.getAttribute("sNickName");
		if(!sNickName.equals(nickName)) return "redirect:/message/unSafeLoad";
		
		//게시글에 사진이 존재한다면 서버에 있는 사진파일을 먼저 삭제처리한다.
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
		
		//DB에서 실제로 존재하는 게시글을 삭제한다.
		int res = boardService.setBoardDelete(idx);
		
		if(res ==1 ) {
			return "redirect:/message/boardDeleteOk";
		}
		else {
			return "redirect:/message/boardDeleteNo";
		}
		
		
	}
	
	
	@RequestMapping(value = "/boardUpdate", method=RequestMethod.GET)
	public String boardUpateGET(Model model,
			@RequestParam(name="idx",defaultValue="0",required=false) int idx,
			@RequestParam(name="searchString",defaultValue="",required=false) String searchString,
			@RequestParam(name="search",defaultValue="",required=false) String search,
			@RequestParam(name="pag",defaultValue="0",required=false) int pag,
			@RequestParam(name="pageSize",defaultValue="0",required=false) int pageSize	
			) {
		//수정 창으로 이동할 때, 원본 파일에 그림 파일이 있다면,현재 폴더(board)의 그림파일을 ckeditor폴더로 복사시켜둔다. 
		BoardVO vo = boardService.getBoardContent(idx);
		
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgUpdate(vo.getContent(), "ckeditor/");
		
		System.out.println(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/boardUpdate",method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo,Model model,
			@RequestParam(name="pag",defaultValue="0",required=false) int pag,
			@RequestParam(name="pageSize",defaultValue="0",required=false) int pageSize	
			) {
		//수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다. 고로, DB에 저장된 
		BoardVO ovo = boardService.getBoardContent(vo.getIdx());
		
		if(!ovo.getContent().equals(vo.getContent())){
			//수정하기 버튼을 클릭하게 되면, 기존의 board 폴더에 저장된,현재 content의 그림파일 전부를 삭제시킨다. 
			if(ovo.getContent().indexOf("board/") !=1) boardService.imgDelete(ovo.getContent());
			
		}
		
		//content의 내용이 조금이라도 변경된 것디 있담ㄴ 내용을 수정처리한다.
		int res= boardService.getboardUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		
		if(res ==1 ) {
			return "redirect:/message/boardUpdateOk";
		}
		else {
			return "redirect:/message/boardUpdateNo";
		}
		
	}

}
