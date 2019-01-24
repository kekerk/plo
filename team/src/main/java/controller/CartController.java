package controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.CartEmptyException;
import exception.Cartadd;
import exception.LoginException;
import logic.Cart;
import logic.Item;
import logic.ItemSet;
import logic.OrderItem;
import logic.Orders;
import logic.ShopService;
import logic.User;

@Controller
public class CartController {
	@Autowired
	ShopService service;
	@RequestMapping("cart/cartAdd")
	public ModelAndView add(Integer itemno, Integer quantity, Integer size, HttpSession session) {
		//selectedItem : id값에서 Item 객체를 db에서 읽어서 Item 정보 저장
		Item selectedItem = service.getitem(itemno);
		Cart cart = (Cart)session.getAttribute("CART");
		if(cart == null) { //등록된 장바구니 상품이 없다.
			cart = new Cart();
			session.setAttribute("CART", cart); //empty Cart객체를 session저장
		}
		cart.push(new ItemSet(selectedItem,quantity,size));
		session.setMaxInactiveInterval(24*60*60);
		ModelAndView mav = new ModelAndView();
		mav.addObject("message", selectedItem.getName() + "을/를" + quantity + "개를 장바구니에 추가");
		mav.addObject("cart",cart);
		mav.addObject("size",size);
		throw new Cartadd("장바구니에 저장되었습니다. 장바구니로 이동 하시겠습니까?","../item/detail.shop?itemno="+itemno); 
	}
	@RequestMapping("cart/cartupdate")
	public ModelAndView update(Integer itemno, Integer quantity, Integer size, HttpSession session) {
		//selectedItem : id값에서 Item 객체를 db에서 읽어서 Item 정보 저장
		Item selectedItem = service.getitem(itemno);
		Cart cart = (Cart)session.getAttribute("CART");	
		cart.update(new ItemSet(selectedItem,quantity,size));
		session.setMaxInactiveInterval(24*60*60);
		ModelAndView mav = new ModelAndView("cart/cart");
		mav.addObject("message", selectedItem.getName() + "을/를" + quantity + "개를 장바구니에 추가");
		mav.addObject("cart",cart);
		mav.addObject("size",size);
		return mav;
	}
	@RequestMapping("cart/cartView")
	public ModelAndView view(HttpSession session) {
		Cart cart = (Cart)session.getAttribute("CART");
		if(cart == null || cart.isEmpty()) { //등록된 장바구니 상품이 없다.
			throw new CartEmptyException("장바구니에 상품이 없습니다.","../item/itemlist.shop");
		}
		ModelAndView mav = new ModelAndView("cart/cart");
		mav.addObject("cart",cart);
		return mav;
	}

	@RequestMapping("cart/cartDelete")
	public ModelAndView delete(Integer index, HttpSession session) {
		Cart cart = (Cart)session.getAttribute("CART");
		ModelAndView mav = new ModelAndView("cart/cart");
		int idx = index;
		ItemSet delete = null;
		try {
			delete = cart.getItemSetList().remove(idx);
			mav.addObject("message",delete.getItem().getName() + "상품을 장바구니에서 제거함");
		} catch(Exception e) {
			mav.addObject("message", "상품을 장바구니에서 제거 실패");
		}
		mav.addObject("cart",cart);
		return mav;		
	}
	@RequestMapping("cart/checkout")
	public ModelAndView checkout(int[] check,HttpSession session) { //CartAspect Aop 대상이 되는 핵심메서드
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("user");
		Cart cart = (Cart)session.getAttribute("CART");
		mav.addObject("cart",cart);
		mav.addObject("check",check);
		mav.addObject("user",user);
		return mav;
	}
	@RequestMapping("cart/end")
	public ModelAndView checkend(Orders order, HttpSession session,int[] check) { //CartAspect Aop 대상이 되는 핵심메서드
//		Enumeration ps = request.getParameterNames();
//		while(ps.hasMoreElements()) {
//			String pn = (String)ps.nextElement();
//			System.out.println(pn + ":" + request.getParameter(pn));
//		}
		ModelAndView mav = new ModelAndView();
		Cart cart = (Cart)session.getAttribute("CART");
		User loginUser = (User)session.getAttribute("loginUser");
		order = service.checkEnd(order,cart,loginUser,check);
		List<ItemSet> itemSetList = cart.getItemSetList();
		int tot = cart.getTotalAmount();
		cart.clearAll(session); //장바구니 상품 제거
		mav.addObject("order",order);
		mav.addObject("itemSetList",itemSetList);
		mav.addObject("totalAmount", tot);	
		return mav;
	}
}
