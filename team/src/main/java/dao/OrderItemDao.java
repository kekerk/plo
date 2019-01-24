package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.OrderItemMapper;
import logic.OrderItem;

@Repository
public class OrderItemDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.OrderItemMapper.";
	
	public void insert(OrderItem oi) {
		sqlSession.getMapper(OrderItemMapper.class).insert(oi);
	}

	public List<OrderItem> list(Integer no) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("no", no);
		return sqlSession.selectList(NS + "list",map);
	}

	public void usize(OrderItem oitem) {
		sqlSession.getMapper(OrderItemMapper.class).update(oitem);	
	}

	public void utotal(OrderItem oitem) {
		sqlSession.getMapper(OrderItemMapper.class).utotal(oitem);		
	}	
}
