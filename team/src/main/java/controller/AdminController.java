package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import logic.Item;
import logic.Picture;
import logic.ShopService;
import logic.Size;
import logic.User;
import logic.money;
import logic.visitcnt;

//AOP 설정 : AdminController의 모든 메서드는 반드시 admin으로 로그인해야만 실행 되도록 하기

@Controller
public class AdminController {
   @Autowired
   private ShopService service;
   
   @RequestMapping("admin/list")
   public ModelAndView list(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      List<User> userlist = service.userList();
      mav.addObject("userlist",userlist);
      return mav;
   }
   @RequestMapping(value="admin/itemadd",method=RequestMethod.GET)
   public ModelAndView itemaddForm(HttpServletRequest request,HttpSession session) {
      ModelAndView mav = new ModelAndView("admin/itemadd");
      mav.addObject(new Item());
      return mav;
   }
   @RequestMapping(value="admin/itemadd",method=RequestMethod.POST)
   public ModelAndView itemadd(Item item,HttpServletRequest request,HttpSession session) {
      System.out.println(item);
      ModelAndView mav = new ModelAndView("admin/main");
      int itemno = service.itemmaxnum()+1;
      item.setItemno(itemno);
      try {
         service.additem(item);
          service.addsize(itemno, item.getSize());
          service.addpicture(itemno, item.getPicturelist(),request);
   } catch (Exception e) {
      e.printStackTrace();
   }
      mav.addObject(new Item());
      return mav;
   }
   @RequestMapping(value="admin/itemlist")
   public ModelAndView list(Integer pageNum, String searchType, String searchContent,HttpSession session) {
      if(pageNum ==null || pageNum.toString().equals("")) {
         pageNum=1;
      }
      ModelAndView mav = new ModelAndView();
      int limit=10;
      int listcount = service.itemcount(searchType,searchContent);
      List<Item> itemlist = service.itemlist2(searchType, searchContent , pageNum ,limit);
      int maxpage =(int) ((double)listcount/limit +0.95);
      int startpage =((int)((pageNum/10.0+0.9)-1))*10+1;
      int endpage =startpage+9;
      if(endpage>maxpage) endpage = maxpage;
      int itemcnt = listcount -(pageNum-1) *limit;
      mav.addObject("pageNum",pageNum);
      mav.addObject("maxpage",maxpage);
      mav.addObject("startpage",startpage);
      mav.addObject("endpage",endpage);
      mav.addObject("itemcnt",itemcnt);
      mav.addObject("listcount",listcount);
      mav.addObject("itemlist",itemlist);
      return mav;
   }
   
      @RequestMapping(value="admin/item*", method=RequestMethod.GET)
   public ModelAndView getitem(Integer itemno, HttpServletRequest request,HttpSession session) {
      ModelAndView mav = new ModelAndView();
      Item item = new Item();
      if(itemno != null) {
         item = service.getitem(itemno);
      }
      mav.addObject("item",item);
      return mav;
   }
   @RequestMapping("admin/admain")
      public ModelAndView main(HttpSession session) {
         ModelAndView mav = new ModelAndView();
         List<Integer> tot =service.visittot();
         List<Integer> todaycnt =service.todaycnt();
         List<visitcnt> men= service.men();
         List<visitcnt> girl = service.girl();
         List<money> cost =service.cost();
         List<money> amount =service.amount();
         for(int i=0; i<cost.size(); i++) {
            int a= amount.get(i).getAmount()-cost.get(i).getCost();
            amount.get(i).setMoney(a);
         }
         mav.addObject("cost",cost);
         mav.addObject("amount",amount);
         mav.addObject("men",men);
         mav.addObject("girl",girl);
         mav.addObject("tot",tot);
         mav.addObject("todaycnt",todaycnt);
         return mav;
   }
}