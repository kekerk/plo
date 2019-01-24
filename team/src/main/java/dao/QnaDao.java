package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import dao.mapper.QnaMapper;
import logic.Qna;

@Repository
public class QnaDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.QnaMapper.";

	public int maxNum() {
		return sqlSession.getMapper(QnaMapper.class).maxnum();
	}

	public void insert(Qna qna) {
		 sqlSession.getMapper(QnaMapper.class).insert(qna);
		
	}

	public List<Qna> list(int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (1-1) * limit;
		map.put("startrow", startrow);
		map.put("limit", limit);
		return sqlSession.selectList(NS + "list",map);
	}
	
	public int qavg(Integer itemno) {
		return sqlSession.getMapper(QnaMapper.class).qavg(itemno);
	}

	public void qnaanswer(Qna qna) {
		 sqlSession.getMapper(QnaMapper.class).qnaanswer(qna);
		
	}

	public List<Qna> anslist(int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (1-1) * limit;
		map.put("startrow", startrow);
		map.put("limit", limit);
		return sqlSession.selectList(NS + "anslist",map);
	}

	public Qna select(Integer num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num",num);
		map.put("startrow", 0);
		map.put("limit", 1);
		return sqlSession.selectOne(NS + "anslist",map);
	}

	public Qna getqna(Integer num) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("num",num);
		map.put("startrow", 0);
		map.put("limit", 1);
		return sqlSession.selectOne(NS + "anslist",map);
	}

}
