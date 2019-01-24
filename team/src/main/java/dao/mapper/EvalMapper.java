package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.ItemEval;

public interface EvalMapper {

	@Insert("insert into itemevaluate (no,title,content,userid,registdate,score,satisfy,size,color,pictureurl,itemno)"
			+ " values(#{no},#{title},#{content},#{userid},now(),#{score},#{satisfy},#{size},#{color},#{pictureurl},#{itemno})")
	void insert(ItemEval eval);

	@Select("select ifnull(max(no),0) from itemevaluate")
	int maxNum();
	
	@Select("select (select ifnull(avg(score),0) from itemevaluate where itemno = #{itemno}) from item where itemno = #{itemno}")
	int evavg(Integer itemno);
	
	@Select("select (select ifnull(avg(size),0) from itemevaluate where itemno = #{itemno}) from item where itemno = #{itemno}")
	int sizeavg(Integer itemno);
	
	@Select("select (select ifnull(avg(color),0) from itemevaluate where itemno = #{itemno}) from item where itemno = #{itemno}")
	int coloravg(Integer itemno);
	
	@Select("select (select ifnull(avg(satisfy) * 20 ,0) from itemevaluate where itemno = #{itemno}) from item where itemno = #{itemno}")
	int satavg(Integer itemno);
	
	@Select("select count(*) from itemevaluate where itemno=#{itemno}")
	int ecount(Integer itemno);


}
