package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;

public interface BoardMapper {

	@Select("select ifnull(max(num),0) from item")
	int maxNum();

	@Insert("insert into item (itemno,name,brand,price,gender,color,content,regdate,quantity,cate,subcate)"+
		 " values(#{itemno},#{name},#{brand},#{price},#{gender},#{color},#{content},now(),#{quantity},#{cate},#{subcate})")
	void insert(Board board);

	@Update("update item set name=#{name},price=#{price},content=#{content} where itemno=#{itemno}")
	void update(Board board);

	@Delete("delete from item where itemno=#{itemno}")
	void delete(Map<String, Integer> map);

}
