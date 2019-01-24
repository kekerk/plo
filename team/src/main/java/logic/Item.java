package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Item {
	private Integer itemno;
	private String name;
	private String brand;
	private Integer cost;
	private Integer discount;
	private Integer price;
	private String color;
	private String content;
	private Date regdate;
	private Integer total;
	private String cate;
	private String subcate;
	private List<Picture> picturelist = new ArrayList<Picture>();
	private List<Size> size = new ArrayList<Size>();
	public Integer getItemno() {
		return itemno;
	}
	public void setItemno(Integer itemno) {
		this.itemno = itemno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public Integer getCost() {
		return cost;
	}
	public void setCost(Integer cost) {
		this.cost = cost;
	}
	public Integer getDiscount() {
		return discount;
	}
	public void setDiscount(Integer discount) {
		this.discount = discount;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	public String getSubcate() {
		return subcate;
	}
	public void setSubcate(String subcate) {
		this.subcate = subcate;
	}
	
	public List<Picture> getPicturelist() {
		return picturelist;
	}
	public void setPicturelist(List<Picture> picturelist) {
		this.picturelist = picturelist;
	}
	public List<Size> getSize() {
		return size;
	}
	public void setSize(List<Size> size) {
		this.size = size;
	}
	@Override
	public String toString() {
		return "Item [itemno=" + itemno + ", name=" + name + ", brand=" + brand + ", cost=" + cost + ", discount="
				+ discount + ", price=" + price + ", color=" + color + ", content=" + content + ", regdate=" + regdate
				+ ", total=" + total + ", cate=" + cate + ", subcate=" + subcate + "]";
	}
	
}
