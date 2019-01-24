package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Orders;

public interface OrderMapper {

	@Select("select ifnull(max(no),0) from orders")
	Integer maxNo();

	@Insert("insert into orders (no,userid,receiver,phone,address,req,usepoint,addpoint,amount,paytype,orderdate)"
			+ " values(#{no},#{user.userId},#{receiver},#{phone},#{address},#{require},#{usepoint},#{addpoint},#{amount},#{paytype},CURDATE())")
	void insert(Orders order);

	@Select("select * from orders where userid=#{userid}")
	List<Orders> list(Map<String, Object> map);

}
