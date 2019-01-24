package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Qna;

public interface QnaMapper {
	@Select("select ifnull(max(num),0) from qa")
	int maxnum();
	
	@Insert("insert into qa (num,qtype,itemno,title,content,userid,regidate) "
			+ "values(#{num},#{qtype},#{itemno},#{title},#{content},#{userid},now())")
	void insert(Qna qna);

	@Select("select count(*) from qa where itemno=#{itemno}")
	int qavg(Integer itemno);

	@Update("update qa set answer = #{answer} where num = #{num}")
	void qnaanswer(Qna qna);

}
