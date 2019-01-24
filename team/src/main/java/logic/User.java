package logic;

import java.util.Date;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class User {
	@Size(min=3, max=10, message="���̵�� 3���̻� 10�� ���Ϸ� �Է��ϼ���.")
	private String userId;
	@Size(min=3, max=12, message="��й�ȣ�� 3���̻� 12�� ���Ϸ� �Է��ϼ���.")
	private String password;
	@NotEmpty(message="����� �̸��� �ʼ� �Դϴ�.")
	private String userName;
	private String phoneNo;
	private String postcode;
	private String address;
	private String address1;
	private String email;
	private String email2;
	private String gender;
	private Integer userauth;
	private Integer point;
	public Integer getUserauth() {
		return userauth;
	}
	public void setUserauth(Integer userauth) {
		this.userauth = userauth;
	}
	@Past(message="������ ���� ��¥�� �����մϴ�.")
	private Date birthDay;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Integer getPoint() {
		return point;
	}
	public void setPoint(Integer point) {
		this.point = point;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", password=" + password + ", userName=" + userName + ", phoneNo=" + phoneNo
				+ ", postcode=" + postcode + ", address=" + address + ", email=" + email + ", birthDay=" + birthDay
				+ "]";
	}
}
