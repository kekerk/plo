package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import logic.OrderItem;

public interface OrderItemMapper {

	@Insert("insert into orderitem (no,itemno,itemname,price,quantity,discount,itemsize,updatetime)"
			+ " values(#{no},#{itemno},#{itemname},#{price},#{quantity},#{discount},#{itemsize},CURDATE())")
	void insert(OrderItem oi);

	@Update("update size set quantity=quantity-#{quantity} where itemno=#{itemno} and size=#{itemsize}")
	void update(OrderItem oi);

	@Update("update item set total=total-#{quantity} where itemno=#{itemno}")
	void utotal(OrderItem oitem);

}
