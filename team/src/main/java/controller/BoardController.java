package controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sun.jmx.snmp.Enumerated;

import dao.QnaDao;
import exception.ShopException;
import logic.Board;
import logic.Item;
import logic.ItemEval;
import logic.Qna;
import logic.ShopService;

@Controller
public class BoardController {
	@Autowired
	private ShopService service;
	
	@RequestMapping(value="board/*", method=RequestMethod.GET)
	public ModelAndView getboard(Integer num, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		mav.addObject("board",board);
		return mav;
	}
	@RequestMapping(value="board/list")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent) {
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		int limit = 10; 
		int listcount = service.boardcount(searchType, searchContent);
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit);
		int maxpage = (int)((double)listcount/limit + 0.95); 
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1; 
		int endpage = startpage + 9; 
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = listcount - (pageNum -1) * limit; 
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}
	@RequestMapping(value="board/write", method=RequestMethod.POST)
	public ModelAndView write(@Valid Board board, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			service.insert(board, request);
			mav.setViewName("redirect:list.shop");
			mav.addObject("board",board);
		} catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("작성실패","write.shop");
		}
		return mav;
	}



	
	@RequestMapping("board/detail")
	public ModelAndView detail(Qna qna,Integer itemno,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			Item item = service.getitem(itemno);
			int limit = 10; 
			int evavg = service.evavg(itemno);
			int sizeavg = service.sizeavg(itemno);
			int coloravg = service.coloravg(itemno);
			int satavg = service.satavg(itemno);
			int qavg = service.qavg(itemno);
			int ecount = service.ecount(itemno);
			List<ItemEval> evlist = service.evlist(limit);
			List<Qna> qlist = service.qlist(limit);
			List<Qna> anslist = service.anslist(limit);
			int listcount = service.evcount();
			int maxpage = (int)((double)listcount/limit + 0.95);
			int startpage = ((int)((1/10.0 + 0.9) -1)) * 10 + 1; 
			int endpage = startpage + 9; 
			if(endpage > maxpage) endpage = maxpage;
			int evcnt = listcount - (1 -1) * limit; 
			mav.addObject("pageNum", 1);
			mav.addObject("itemno",itemno);
			mav.addObject("listcount",listcount);
			mav.addObject("maxpage", maxpage);
			mav.addObject("startpage", startpage);
			mav.addObject("endpage", endpage);
			mav.addObject("qlist",qlist);
			mav.addObject("evlist", evlist);
			mav.addObject("anslist", anslist);
			mav.addObject("qavg",qavg);
			mav.addObject("satavg",satavg);
			mav.addObject("sizeavg",sizeavg);
			mav.addObject("coloravg",coloravg);
			mav.addObject("evavg",evavg);
			mav.addObject("ecount",ecount);
			mav.addObject("evcnt",evcnt);
			mav.addObject("item",item);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value="board/evalwrite", method=RequestMethod.POST)
	public ModelAndView eval(ItemEval eval, HttpServletRequest request,Integer itemno) {
//		Enumeration pe = request.getParameterNames();
//		while(pe.hasMoreElements()) {
//			String p = (String)pe.nextElement();
//			System.out.println(p + "=" + request.getParameter(p));
//		}
		System.out.println("메소드 들어옴");
		ModelAndView mav = new ModelAndView();
		try {
			service.evinsert(eval,request);
			mav.setViewName("redirect:detail.shop?itemno="+ eval.getItemno()+"#info_box2");
			mav.addObject("itemno",itemno);
			mav.addObject("eval",eval);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("작성실패","../user/main.shop");
		}
		return mav;
	}
	
	@RequestMapping(value="board/qna",method=RequestMethod.POST)
	public ModelAndView qna(Qna qna, HttpServletRequest request,Integer itemno) {
		ModelAndView mav = new ModelAndView();
		try {
			service.qnainsert(qna,request);
			mav.setViewName("redirect:detail.shop?itemno="+qna.getItemno()+"#info_box3");
			mav.addObject("itemno",itemno);
			mav.addObject("qna",qna);
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("작성실패","../board/detail.shop?itemno="+qna.getItemno()+"#info_box3");
		}
		return mav;
	}
	
	@RequestMapping(value="board/answer",method=RequestMethod.POST)
	public ModelAndView answer(Qna qna ,Integer num,Integer itemno,HttpServletRequest request) {
		System.out.println("답변 메서드 실행");
		ModelAndView mav = new ModelAndView();
		try {
			Item item = service.getitem(itemno);
			Qna qa = service.getqna(num);
			service.qnaanswer(qna,request);
			System.out.println(qa);
			System.out.println(item);
			System.out.println(itemno);
			System.out.println(num);
			mav.setViewName("redirect:detail.shop?itemno="+qna.getItemno()+"#info_box3");
			mav.addObject("ans",qna);
			mav.addObject("itemno",itemno);
			mav.addObject("num",num);
			mav.addObject("item",item);
			mav.addObject("qa",qa);
			System.out.println("답변 데이터 처리 완료");
		}catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("작성실패","../board/detail.shop?itemno="+qna.getItemno()+"#info_box3");
		}
		return mav;
	}
	@RequestMapping(value="board/answer",method=RequestMethod.GET)
	public ModelAndView answer1(Qna qna ,Integer num,Integer itemno,HttpServletRequest request) {
		System.out.println("답변 메서드 실행");
		ModelAndView mav = new ModelAndView();
		try {
			Item item = service.getitem(itemno);
			Qna qa = service.getqna(num);
			service.qnaanswer(qna,request);
			mav.addObject("itemno",itemno);
			mav.addObject("num",num);
			mav.addObject("item",item);
			mav.addObject("qa",qa);
			System.out.println("답변 데이터 처리 완료");
		}catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("작성실패","../board/detail.shop?itemno="+qna.getItemno()+"#info_box3");
		}
		return mav;
	}
}
