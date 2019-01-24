package logic;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ItemEval {
	private Integer no;
	private String title;
	private String pictureurl;
	private MultipartFile picture;
	private String content;
	private String userid;
	private Date registdate;
	private Double score;
	private Integer satisfy;
	private Integer size;
	private String color;
	private Integer itemno;
	
	
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
	public MultipartFile getPicture() {
		return picture;
	}
	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Date getRegistdate() {
		return registdate;
	}
	public void setRegistdate(Date registdate) {
		this.registdate = registdate;
	}
	public Double getScore() {
		return score;
	}
	public void setScore(Double score) {
		this.score = score;
	}
	public Integer getSatisfy() {
		return satisfy;
	}
	public void setSatisfy(Integer satisfy) {
		this.satisfy = satisfy;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	@Override
	public String toString() {
		return "ItemEval [no=" + no + ", title=" + title + ", pictureurl=" + pictureurl + ", picture=" + picture
				+ ", content=" + content + ", userid=" + userid + ", registdate=" + registdate + ", score=" + score
				+ ", satisfy=" + satisfy + ", size=" + size + ", color=" + color + "]";
	}

	
}
