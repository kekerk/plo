package logic;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.EvalDao;
import dao.ItemDao;
import dao.OrderItemDao;
import dao.OrdersDao;
import dao.QnaDao;
import dao.UserDao;
import dao.VisitcntDao;
import exception.ShopException;
import util.MailHandler;
import util.TempKey;

@Service // @Component + Service 기능(Controller와 Repository사이의 중간 객체)
public class ShopService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private ItemDao itemDao;
	@Autowired
	private OrdersDao orderDao;
	@Autowired
	private OrderItemDao orderItemDao;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private VisitcntDao visit;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private EvalDao evalDao;
	@Autowired
	private QnaDao qnaDao;

	public void userCreate(User user) throws Exception {
		userDao.insert(user);
		String key = new TempKey().getKey(50, false);
		userDao.createAuthKey(user.getEmail(), key);
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[이메일 인증]");
		sendMail.setText(new StringBuffer().append("<h1>메일인증</h1>")
				.append("<a href='http://192.168.0.72:8080/team/user/emailConfirm.shop?authKey=").append(key)
				.append("' target='_blenk'>이메일 인증 확인</a>").toString());
		sendMail.setFrom("ziflrtm12@gmail.com", "Sinbal");
		sendMail.setTo(user.getEmail());
		sendMail.send();
	}

	public User selectUser(String userId) {
		return userDao.select(userId);
	}

	public void update(User user) {
		userDao.update(user);
	}

	public void delete(String id) {
		userDao.delete(id);
	}

	public List<User> userList() {
		return userDao.userList();
	}

	public List<User> userList(String[] idchks) {
		return userDao.list(idchks);
	}

	public String getHashvlaue(String password) {
		MessageDigest md;
		String hashvalue = "";
		try {
			md = MessageDigest.getInstance("SHA-256");
			byte[] plain = password.getBytes();
			byte[] hash = md.digest(plain);
			for (byte b : hash) {
				hashvalue += String.format("%02X", b);
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			throw new ShopException("전산부에 전화 요망", "../login.shop");
		}
		return hashvalue;
	}

	public void userAuth(String userEmail) throws Exception {
		userDao.userAuth(userEmail);
	}

	public String Email(String key) {
		return userDao.userEmail(key);
	}

	public void updateAuth(String email) {
		userDao.userAuth(email);
	}

	public String findId(String email) {
		return userDao.findId(email);
	}

	public String findEmail(User user) {
		return userDao.findEmail(user);
	}

	public void passEmail(String email) throws Exception {
		String key = new TempKey().getKey(50, false);
		userDao.createAuthKey(email, key);
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[비밀번호 변경]");
		sendMail.setText(new StringBuffer().append("<h1>비밀번호 변경</h1>")
				.append("<a href='http://192.168.0.72:8080/team/user/passChange.shop?authKey=").append(key)
				.append("' target='_blenk'>비밀번호 변경하기</a>").toString());
		sendMail.setFrom("ziflrtm12@gmail.com", "Sinbal");
		sendMail.setTo(email);
		sendMail.send();
	}
	public void passChange(String pass, String email) {
		userDao.updatePass(pass,email);	
	}

	public void delkey(String authKey) {
		userDao.delkey(authKey);
	}
	   public int itemmaxnum() {
	      return itemDao.Maxnum();
	   }

	   public void additem(Item item) {
	      itemDao.additem(item);      
	   }

	   public void addsize(int itemno, List<Size> list) {
	      Size size = new Size();
	      for(int i =0; i< list.size(); i++) {
	         
	         size.setItemno(itemno);
	         size.setSize(list.get(i).getSize());
	         size.setQuantity(list.get(i).getQuantity());
	         itemDao.addsize(size);      
	      }
	   }

	   public void addpicture(int itemno, List<Picture> list,HttpServletRequest request) {
	      Picture pic = new Picture();
	      for(int i =0; i< list.size(); i++) {   
	         pic.setItemno(itemno);
	         pic.setType(list.get(i).getType());
	         uploadFileCreate(list.get(i).getPicture(), request,"picture");
	         pic.setPictureurl(list.get(i).getPicture().getOriginalFilename());
	         itemDao.addpicture(pic);
	      }
	   }
	   
	   private void uploadFileCreate(MultipartFile picture, HttpServletRequest request,String path) {
	      String uploadPath =request.getServletContext().getRealPath("/")+path+"/";
	      //파일의 이름
	      String orgFile =picture.getOriginalFilename();
	      try {
	         //transferTo : 파일의 내용을 (uploadPath+orgFile)인 파일에 저장
	         System.out.println(uploadPath+orgFile);
	         picture.transferTo(new File(uploadPath+orgFile));
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }

	   public int itemcount(String searchType, String searchContent) {
	      return itemDao.itemcount(searchContent,searchType);
	   }
	   public List<Item> getItemList()	{
			return itemDao.list();
		}
	   public List<Item> itemlist2(String searchType, String searchContent, Integer pageNum, int limit) {
	      return itemDao.itemlist2(searchContent,searchType,pageNum,limit);
	   }

	   public Item getitem(Integer itemno) {
	      return itemDao.itemone(itemno);
	   }
	   public List<Item> itemlist(String searchType, String searchContent, Integer pageNum, int limit, Integer cate, Integer subcate, Integer searchPriceStart, Integer searchPriceEnd) {
	         return itemDao.itemlist(searchContent,searchType,pageNum,limit,cate,subcate,searchPriceStart,searchPriceEnd);
	      }
	   
	public Orders checkEnd(Orders order, Cart cart, User loginUser, int[] check) {
		order.setNo(orderDao.getMaxNo());
		order.setUser(loginUser);
		List<ItemSet> itemList = cart.getItemSetList();
		for(int i : check) {
		for(int j=0; j<itemList.size(); j++) {
			OrderItem oitem = new OrderItem();
			if(i==j) {
			oitem.setItem(itemList.get(j).getItem());
			oitem.setNo(order.getNo());
			oitem.setItemno(itemList.get(j).getItem().getItemno());
			oitem.setItemname(itemList.get(j).getItem().getName());
			oitem.setDiscount(itemList.get(j).getItem().getDiscount());
			oitem.setItemsize(itemList.get(j).getSize());
			oitem.setPrice(itemList.get(j).getItem().getPrice());
			oitem.setQuantity(itemList.get(j).getQuantity());
			orderItemDao.insert(oitem);
			orderItemDao.usize(oitem);
			orderItemDao.utotal(oitem);
			}
		}
		}
		orderDao.insert(order);
		userDao.upoint(order);
		
		return order;
	}

	public List<Orders> orderList(String id) {
		return orderDao.list(id);
	}
	
	public List<OrderItem> orderItemList(Integer no) {
		List<OrderItem> list = orderItemDao.list(no);
		for(OrderItem s : list) {
			s.setItem(itemDao.getItemByNo(s.getItemno()));
		}
		return list;
	}
	public void visitcnt(String gender, Date birthDay) {
	      visit.setVisitTotalCount(gender, birthDay);
	
	}

		   public List<Integer> visittot() {
		      return visit.getVisitTotalCount();
		   }

		   public List<Integer> todaycnt() {
		      return visit.getVisitTodayCount();
		   }

		   public List<visitcnt> men() {
		      return visit.getmen();
		   }

		   public List<visitcnt> girl() {
		      return visit.getgirl();
		   }

		   public List<money> cost() {
		      return itemDao.cost();
		   }

		   public List<money> amount() {
		      return  itemDao.amount();
		   }
		   public int boardcount(String searchType, String searchContent) {
				return boardDao.count(searchType, searchContent);
			}

			public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit) {
				return boardDao.list(searchType, searchContent, pageNum, limit);
			}

			public void insert(Board board, HttpServletRequest request) {
				if (board.getFile1() != null && !board.getFile1().isEmpty()) {
					uploadFileCreate(board.getFile1(), request, "file");
					board.setFileurl(board.getFile1().getOriginalFilename());
				}
				int max = boardDao.maxNum();
				board.setNum(++max);
				board.setRef(max);
				boardDao.insert(board);
			}


			public void boardupdate(Board board, HttpServletRequest request) {
				if (board.getFile1() != null && !board.getFile1().isEmpty()) {
					uploadFileCreate(board.getFile1(), request, "file");
					board.setFileurl(board.getFile1().getOriginalFilename());
				}
				boardDao.update(board);
			}

			public void boarddelete(Board board) {
				boardDao.delete(board.getNum());
			}
			public void evinsert(ItemEval eval, HttpServletRequest request) {
				if (eval.getPicture() != null && !eval.getPicture().isEmpty()) {
					uploadFileCreate(eval.getPicture(), request, "picture");
					eval.setPictureurl(eval.getPicture().getOriginalFilename());
				}
				int max = evalDao.maxNum();
				eval.setNo(++max);
				evalDao.insert(eval);
			}
			public int evcount() {
				return evalDao.count();
			}

			public List<ItemEval> evlist(int limit) {
				return evalDao.list(limit);
			}

			public int evavg(Integer itemno) {
				return evalDao.evavg(itemno);
			}
			public int sizeavg(Integer itemno) {
				return evalDao.sizeavg(itemno);
			}
			public int coloravg(Integer itemno) {
				return evalDao.coloravg(itemno);
			}
			
			public int satavg(Integer itemno) {
				return evalDao.satavg(itemno);
			}

			public void qnainsert(Qna qna, HttpServletRequest request) {
				int max = qnaDao.maxNum();
				qna.setNum(++max);
				qnaDao.insert(qna);
				
			}

			public List<Qna> qlist(int limit) {
				return qnaDao.list(limit);
			}
			public int qavg(Integer itemno) {
				return qnaDao.qavg(itemno);
			}
			public void qnaanswer(Qna qna, HttpServletRequest request) {
				qnaDao.qnaanswer(qna);
				
			}

			public List<Qna> anslist(int limit) {
				return qnaDao.anslist(limit);
			}

			public int ecount(Integer itemno) {
				return evalDao.ecount(itemno);
			}

			public Qna getqna(Integer num) {
				return qnaDao.select(num);
			}


		
}
