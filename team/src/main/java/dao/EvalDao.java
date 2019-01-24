package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.EvalMapper;
import dao.mapper.QnaMapper;
import logic.ItemEval;
import logic.Qna;
@Repository
public class EvalDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.EvalMapper.";
	
	public int maxNum() {
		return sqlSession.getMapper(EvalMapper.class).maxNum();
	}
	
	public void insert(ItemEval eval) {
		sqlSession.getMapper(EvalMapper.class).insert(eval);
	}
	public ItemEval select(Integer no) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("no", no);
		map.put("startrow", 0);
		map.put("limit", 1);
		return sqlSession.selectOne(NS + "list",map);
	}
	
	public int count() {
		Map<String, String> map = new HashMap<String, String>();
		return sqlSession.selectOne(NS + "selectcount",map);
	}
	public List<ItemEval> list(int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (1-1) * limit;
		map.put("startrow", startrow);
		map.put("limit", limit);
		return sqlSession.selectList(NS + "list",map);
	}

	public int evavg(Integer itemno) {
		return sqlSession.getMapper(EvalMapper.class).evavg(itemno);
	}
	public int sizeavg(Integer itemno) {
		return sqlSession.getMapper(EvalMapper.class).sizeavg(itemno);
	}
	public int coloravg(Integer itemno) {
		return sqlSession.getMapper(EvalMapper.class).coloravg(itemno);
	}
	
	public int satavg(Integer itemno) {
		return sqlSession.getMapper(EvalMapper.class).satavg(itemno);
	}

	public int ecount(Integer itemno) {
		return sqlSession.getMapper(EvalMapper.class).ecount(itemno);
	}
}
