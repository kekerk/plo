package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.OrderMapper;
import logic.Orders;


@Repository
public class OrdersDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.OrderMapper.";
	
	public Integer getMaxNo() {
		Integer ret = sqlSession.getMapper(OrderMapper.class).maxNo();
		return ret+1;
	}

	public void insert(Orders order) {
		sqlSession.getMapper(OrderMapper.class).insert(order);
	}

	public List<Orders> list(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", id);
		return sqlSession.getMapper(OrderMapper.class).list(map);
	}
}
