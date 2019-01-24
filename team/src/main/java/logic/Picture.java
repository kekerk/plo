package logic;

import org.springframework.web.multipart.MultipartFile;

public class Picture {
	private Integer itemno;
	private String pictureurl;
	private Integer type;
	private MultipartFile picture;
	public Integer getItemno() {
		return itemno;
	}
	public void setItemno(Integer itemno) {
		this.itemno = itemno;
	}
	public String getPictureurl() {
		return pictureurl;
	}
	public void setPictureurl(String pictureurl) {
		this.pictureurl = pictureurl;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public MultipartFile getPicture() {
		return picture;
	}
	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
	@Override
	public String toString() {
		return "Picture [itemno=" + itemno + ", pictureurl=" + pictureurl + ", type=" + type + ", picture=" + picture
				+ "]";
	}
	
}
