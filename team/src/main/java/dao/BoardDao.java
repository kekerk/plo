package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import logic.Board;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.BoardMapper.";
	
	public Board select(Integer num) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("num", num);
		map.put("startrow", 0);
		map.put("limit", 1);
		return sqlSession.selectOne(NS + "list",map);
	}
	public int count(String searchType, String searchContent) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		return sqlSession.selectOne(NS + "selectcount",map);
	}
	public List<Board> list(String searchType, String searchContent, Integer pageNum, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (pageNum -1) * limit;
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		return sqlSession.selectList(NS + "list",map);
	}
	public int maxNum() {
		return sqlSession.getMapper(BoardMapper.class).maxNum();
	}
	public void insert(Board board) {
		sqlSession.getMapper(BoardMapper.class).insert(board);
	}
	public void update(Board board) {	
		sqlSession.getMapper(BoardMapper.class).update(board);
	}
	public void delete(Integer num) {	
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("num", num);
		sqlSession.getMapper(BoardMapper.class).delete(map);
	}
}
