package logic;

import java.util.Date;

public class Qna {
	private Integer num;
	private Integer qtype;
	private Integer itemno;
	private String title;
	private String content;
	private String userid;
	private Date regidate;
	private String answer;

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getQtype() {
		return qtype;
	}

	public void setQtype(Integer qtype) {
		this.qtype = qtype;
	}

	public Integer getItemno() {
		return itemno;
	}

	public void setItemno(Integer itemno) {
		this.itemno = itemno;
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

	public Date getRegidate() {
		return regidate;
	}

	public void setRegidate(Date regidate) {
		this.regidate = regidate;
	}

	@Override
	public String toString() {
		return "Qna [num=" + num + ", qtype=" + qtype + ", itemno=" + itemno + ", title=" + title + ", content="
				+ content + ", userid=" + userid + ", regidate=" + regidate + ", getNum()=" + getNum() + ", getQtype()="
				+ getQtype() + ", getItemno()=" + getItemno() + ", getTitle()=" + getTitle() + ", getContent()="
				+ getContent() + ", getUserid()=" + getUserid() + ", getRegidate()=" + getRegidate() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

}
