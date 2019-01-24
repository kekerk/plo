package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Orders;
import logic.User;
import logic.visitcnt;

public interface UserMapper {

	@Insert("insert into user (userid,password,username,phoneno,postcode,address,email,birthday,gender,point,userauth) " 
				+"values(#{userId},#{password},#{userName},#{phoneNo},#{postcode},#{address},#{email},#{birthDay},#{gender},0,0)")
	void insert(User user);

	@Update("update user set username=#{userName},phoneno=#{phoneNo}"
			+",postcode=#{postcode},address=#{address},email=#{email},birthday=#{birthDay} where userid=#{userId}")
	void update(User user);

	@Delete("delete from user where userid=#{userId}")
	void delete(Map<String, String> map);

	@Insert("insert into userauth (email,authkey) values(#{userEmail},#{authKey})")
	void Keyinsert(Map<String, Object> map);

	@Update("update user set userauth=1 where email=#{email}")
	void userAuth(String email);

	@Select("select email from userauth where authkey=#{key}")
	String userEmail(String key);

	@Select("select userid from user where email=#{email}")
	String findId(String email);

	@Update("update user set password=#{pass} where email=#{email}")
	void updatePass(Map<String, String> map);

	@Select("select email from user where userid=#{userId} and email=#{email}")
	String findEmail(User user);

	@Delete("delete from userauth where authkey=#{authKey}")
	void deleteKey(String authKey);

	@Update("update user set point=point - ifnull(#{usepoint},0) + #{addpoint} where userid=#{user.userId}")
	void upoint(Orders order);
	
	@Insert("insert into visit (date,gender,age) VALUES (CURDATE(),#{gender},#{age})")
	void insertcnt(Map<String, Object> param);

	@Select("select count(*) from visit where date= curdate() group by gender")
	List<Integer> todaycnt();
	   
	@Select("select count(*) from visit group by gender")
	List<Integer> cnt();
	   
	@Select("select count(*) 'cnt', case" + 
	         " when 10<= age and age <20 then '10대'" + 
	         " when 20<= age and age<30 then '20대'" + 
	         " when 30<= age and age<40 then '30대'" + 
	         " when 40<= age and age<50 then '40대'" + 
	         " when 50<= age and age<60 then '50대'" + 
	         " when 60<= age and age<70 then '60대'" + 
	         " else '70대이상'" + 
	         " end 'ag'" + 
	         " from visit where  gender =1 group by ag ")
	List<visitcnt> men();

	@Select("select count(*) 'cnt', case" + 
	         " when 10<= age and age <20 then '10대'" + 
	         " when 20<= age and age<30 then '20대'" + 
	         " when 30<= age and age<40 then '30대'" + 
	         " when 40<= age and age<50 then '40대'" + 
	         " when 50<= age and age<60 then '50대'" + 
	         " when 60<= age and age<70 then '60대'" + 
	         " else '70대이상'" + 
	         " end 'ag'" + 
	         " from visit where gender =2 group by ag ")
	List<visitcnt> girl();
}
