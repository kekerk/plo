package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.Item;
import logic.ShopService;

@Controller //@Component + Controller 기능 부여.
public class ItemController {
	@Autowired
	private ShopService service;
	 @RequestMapping(value="item/itemlist")
     public ModelAndView list(Integer pageNum, String searchType, String searchContent,Integer searchPriceStart,Integer searchPriceEnd,Integer cate,Integer subcate,HttpSession session) {
        if(pageNum ==null || pageNum.toString().equals("")) {
           pageNum=1;
        }
        ModelAndView mav = new ModelAndView();
        int limit=40;
        int listcount = service.itemcount(searchType,searchContent);
        List<Item> itemlist = service.itemlist(searchType, searchContent , pageNum ,limit,cate,subcate,searchPriceStart,searchPriceEnd );
        int maxpage =(int) ((double)listcount/limit +0.95);
        int startpage =((int)((pageNum/10.0+0.9)-1))*40+1;
        int endpage =startpage+9;
        if(endpage>maxpage) endpage = maxpage;
        int itemcnt = listcount -(pageNum-1) *limit;
        mav.addObject("searchPriceStart",searchPriceStart);
        mav.addObject("searchPriceEnd",searchPriceEnd);
        mav.addObject("pageNum",pageNum);
        mav.addObject("maxpage",maxpage);
        mav.addObject("startpage",startpage);
        mav.addObject("endpage",endpage);
        mav.addObject("itemcnt",itemcnt);
        mav.addObject("listcount",listcount);
        mav.addObject("itemlist",itemlist);
        return mav;
    }
	@RequestMapping("item/*")//*:매칭 되는 이름이 없으면 실행
	public ModelAndView detail(Integer itemno) { //id : "id"파라미터 값을 저장함
		Item item = service.getitem(itemno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("item",item);
		return mav;
	}
	@RequestMapping("item/create")
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView("item/add");
		mav.addObject(new Item());
		return mav;
	}
}
