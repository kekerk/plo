package logic;

import java.util.Date;

public class OrderItem {
	private Integer no;
	private Integer itemno;
	private String itemname;
	private Integer price;
	private Integer quantity;
	private Integer discount;
	private Integer itemsize;
	private Date updateTime;
	private Item item;
	
	public OrderItem() {}
	public OrderItem(Integer saleno, Integer orderItemNo, ItemSet itemSet, Date currentTime) {
		this.no = saleno;
		this.itemno = orderItemNo;
		this.item = itemSet.getItem();
		this.itemname = item.getName();
		this.price = item.getPrice();
		this.quantity = itemSet.getQuantity();
		this.discount = item.getDiscount();
		this.itemsize = itemSet.getSize();
		this.updateTime = currentTime;
	}
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getItemno() {
		return itemno;
	}
	public void setItemno(Integer itemno) {
		this.itemno = itemno;
	}
	public String getItemname() {
		return itemname;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Integer getDiscount() {
		return discount;
	}
	public void setDiscount(Integer discount) {
		this.discount = discount;
	}
	public Integer getItemsize() {
		return itemsize;
	}
	public void setItemsize(Integer itemsize) {
		this.itemsize = itemsize;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	
}
