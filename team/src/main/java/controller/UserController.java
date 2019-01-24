package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import exception.LoginException;
import logic.OrderItem;
import logic.Orders;
import logic.ShopService;
import logic.User;
import util.CiperUtil;

@Controller
public class UserController {
	@Autowired
	ShopService service;
	
	@RequestMapping("user/main") 
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/userForm") 
	public ModelAndView userForm() {
		ModelAndView mav = new ModelAndView("user/login");
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/userEntry") 
	public ModelAndView userEntry(@Valid User user,BindingResult bindResult) throws Exception {
		ModelAndView mav = new ModelAndView("user/userForm");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		if(user.getAddress() == "") {
			throw new LoginException("�̸����� �Է����ּ���.","../user/userEntry.shop");
		} 
		try {
			if(user.getAddress1() != "") {
				user.setAddress(user.getAddress()+" "+user.getAddress1());
			}
			user.setEmail(user.getEmail() +"@" +user.getEmail2());
			user.setPassword(service.getHashvlaue(user.getPassword()));
			service.userCreate(user);
			mav.addObject("user",user);
		} catch(DataIntegrityViolationException e) {
			bindResult.reject("error.duplicate.user");
			return mav;
		}
		mav.setViewName("user/main");
		return mav;
	}
	@RequestMapping("user/emailConfirm")
	public ModelAndView emailConfirm(User user,HttpServletRequest request) { // �̸�������
		ModelAndView mav = new ModelAndView("user/main");
		String key =request.getParameter("authKey");
		String email=service.Email(key);
		service.updateAuth(email);
		mav.addObject("user",user);
		return mav;
    }
	@RequestMapping("user/loginForm") 
	public ModelAndView loginForm() {
		ModelAndView mav = new ModelAndView("user/login");
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/login")
	public ModelAndView loginForm(@Valid User user,BindingResult bindResult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		//db���� ���̵��� ȸ�� ���� ��ȸ�ϰ� ��й�ȣ �����Ͽ� session�� ���
		//�α��� ������ loginSuccess
		try {
			//u : ���̵� �ش��ϴ� db�� ����� ���� ����
			User u = service.selectUser(user.getUserId()); 
			if(u == null){
				throw new LoginException("�Է� ������ �߸��Ǿ����ϴ�.","../user/main.shop");
			}
			if(!u.getUserauth().equals(1)) {
				bindResult.reject("error.login.email");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
			if(service.getHashvlaue(user.getPassword()).equals(u.getPassword())) { //���̵�� ��й�ȣ�� ��ġ
				service.visitcnt(u.getGender(),u.getBirthDay());
				session.setAttribute("loginUser", u); //�α��� ����.
				mav.setViewName("user/loginSuccess");
			} else {
				throw new LoginException("�Է� ������ �߸��Ǿ����ϴ�.","../user/main.shop");
			}
		} catch(Exception e) { 
			throw new LoginException("�Է� ������ �߸��Ǿ����ϴ�.","../user/main.shop");
		}
		mav.setViewName("user/main"); //�α��� �����ϴ� ��츸 ����
		return mav;
	}
	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.removeAttribute("loginUser");
		mav.setViewName("redirect:main.shop"); 
		return mav;
	}
	@RequestMapping("user/mypage")
	public ModelAndView mypage(String id, HttpSession session) {
		User user = service.selectUser(id);
		List<Orders> orderlist = service.orderList(id);
		for(Orders s : orderlist) {
			s.setItemList(service.orderItemList(s.getNo()));
			int total = 0;
			for(OrderItem si : s.getItemList()) {
				total += si.getQuantity() * si.getItem().getPrice();
			}
			s.setTotAmount(total);
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("user",user);
		mav.addObject("orderlist", orderlist);
		return mav;
	}
	@RequestMapping("user/updateForm")
	public ModelAndView updateForm(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(id);
		user.setEmail(CiperUtil.decrypt(user.getEmail(), user.getUserId()));
		mav.addObject("user",user);
		return mav;
	}
	/*
	 * 1. �Ķ���� ������ User ��ü�� ����, ��ȿ�� ����
	 * 2. AOP�� �̿��Ͽ� �α��� �ȵ� ���, �ٸ� ����� ���� ���� �ȵǵ��� LoginAspect Ŭ������ AOP�޼��� �߰�
	 * 3. ��й�ȣ�� ��ġ�ϴ� ��츸 ȸ������ ����
	 * 4. ȸ������ ���� ���� : mypage.shop ������ �̵�
	 *          ���� ���� : updateForm.shop ������ �̵�
	 */
	@RequestMapping("user/update")
	public ModelAndView update(HttpSession session, @Valid User user,BindingResult bindResult) {
		ModelAndView mav = new ModelAndView("user/updateForm");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			User u = service.selectUser(user.getUserId());
			if(service.getHashvlaue(user.getPassword()).equals(u.getPassword())) {
				if(user.getAddress1() != "") {
					user.setAddress(user.getAddress()+" "+user.getAddress1());
				}
				service.update(user);
			} else {
				bindResult.reject("error.login.password");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
		} catch(EmptyResultDataAccessException e) { 
			bindResult.reject("error.user.update");
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		mav.setViewName("redirect:/user/mypage.shop?id="+user.getUserId());
		return mav;
	}
	@RequestMapping(value="user/delete",method=RequestMethod.GET)
	public ModelAndView deleteForm(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(id);
		mav.addObject("user",user);
		return mav;
	}		
	/*
	 * -�����ڰ� �ٸ� ȸ���� ���� Ż��
	 * ��й�ȣ�� ������ ��й�ȣ �Է��ϱ�
	 * ������ ��й�ȣ�� �´� ��� ȸ�� ���� ����
	 * ���� Ż�� ���� : admin/list.shop������ �̵�
	 *       ���� : ��ȿ�� �������� delete.jsp ������ ���
	 * -���� ȸ�� Ż��
	 * ��й�ȣ�� ȸ�� ��й�ȣ �Է��ϱ�
	 * ��й�ȣ�� �´� ��� ȸ�� ���� ����
	 * Ż�� ���� : session ���� �� loginForm.shop������ �̵�
	 *    ���� : ��ȿ�� �������� delete.jsp�������� ���
	 */
	@RequestMapping(value="user/delete",method=RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String password) {
		ModelAndView mav = new ModelAndView();
		User u = (User)session.getAttribute("loginUser");
		
		if(u.getUserId().equals("admin")) {
			if(u.getPassword().equals(service.getHashvlaue(password))) {
				service.delete(id);
				session.invalidate();
				mav.setViewName("redirect:../admin/list.shop");
			} else {
				throw new LoginException("����","../user/delete.shop?id="+id);
			}
		} else {
			if(u.getPassword().equals(service.getHashvlaue(password))) {
				service.delete(id);
				session.invalidate();
				mav.setViewName("redirect:main.shop");
			} else {
				throw new LoginException("����","../user/delete.shop?id="+id);
			}
		}
		return mav;
	}
	@RequestMapping(value="user/idfind",method=RequestMethod.POST)
	public ModelAndView idfind(User user, HttpServletRequest request) {
		String email = request.getParameter("email");
		ModelAndView mav = new ModelAndView();
		mav.addObject("user",new User());
		String id = service.findId(email);
		mav.addObject("id",id);
		if(id==null) {
			throw new LoginException("�Է� ������ �߸��Ǿ����ϴ�.","../user/main.shop");
		} else {
			throw new LoginException("���̵�� "+id+"�Դϴ�.","../user/main.shop");
		}
	}
	@RequestMapping(value="user/passfind",method=RequestMethod.POST)
	public ModelAndView passfind(User user, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		String email = service.findEmail(user);
		if(email != null) {
			service.passEmail(email);
			throw new LoginException("����","../user/main.shop");
		} else {
			throw new LoginException("�Է� ������ �߸��Ǿ����ϴ�.","../user/loginForm.shop");
		}		
	}
	@RequestMapping(value="user/passChange",method=RequestMethod.GET)
	public ModelAndView passChange(String id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String key = request.getParameter("authKey");
		mav.addObject("authKey",key);
		return mav;
	}	
	@RequestMapping(value="user/passChange",method=RequestMethod.POST)
	public ModelAndView passChange(String authKey,String pass1,String pass2,HttpServletRequest request) { // �̸�������
		ModelAndView mav = new ModelAndView();	
//		String key =request.getParameter("authKey");
//		String pass1 = request.getParameter("pass1");
//		String password = request.getParameter("pass2");
		String email=service.Email(authKey);
		if(pass1.equals(pass2)) {
			try {
				String pass = service.getHashvlaue(pass1);
				service.passChange(pass,email);
				service.delkey(authKey);
				mav.setViewName("user/main");
				return mav;
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("��й�ȣ ������ �����߻�.","../user/passChange.shop?authKey="+authKey);
			}		
		} else {
			throw new LoginException("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.","../user/passChange.shop?authKey="+authKey);
		}
    }
	@RequestMapping(value="user/back",method=RequestMethod.GET)
	public ModelAndView back(String id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String key = request.getParameter("authKey");
		mav.addObject("authKey",key);
		return mav;
	}
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
	}
}
