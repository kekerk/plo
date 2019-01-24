package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Orders {
	private Integer no;
	private User user;
	private Date orderdate;
	private String address;
	private String phone;
	private String receiver;
	private Integer amount;
	private Integer paytype;
	private String require;
	private String userid;
	private Integer usepoint;
	private Integer addpoint;	
	private Integer totAmount;
	private List<OrderItem> itemList;
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Integer getPaytype() {
		return paytype;
	}
	public void setPaytype(Integer paytype) {
		this.paytype = paytype;
	}
	public String getRequire() {
		return require;
	}
	public void setRequire(String require) {
		this.require = require;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Integer getUsepoint() {
		return usepoint;
	}
	public void setUsepoint(Integer usepoint) {
		this.usepoint = usepoint;
	}
	public Integer getAddpoint() {
		return addpoint;
	}
	public void setAddpoint(Integer addpoint) {
		this.addpoint = addpoint;
	}
	public List<OrderItem> getItemList() {
		return itemList;
	}
	public void setItemList(List<OrderItem> itemList) {
		this.itemList = itemList;
	}
	@Override
	public String toString() {
		return "Orders [no=" + no + ", orderdate=" + orderdate + ", address=" + address + ", phone=" + phone
				+ ", receiver=" + receiver + ", amount=" + amount + ", paytype=" + paytype + ", require=" + require
				+ ", userid=" + userid + ", usepoint=" + usepoint + ", addpoint=" + addpoint + ", itemList=" + itemList
				+ "]";
	}
	public Integer getTotAmount() {
		return totAmount;
	}
	public void setTotAmount(Integer totAmount) {
		this.totAmount = totAmount;
	}
	
}
