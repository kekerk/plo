package dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.visitcnt;


@Repository
public class VisitcntDao {
   @Autowired
   private SqlSessionTemplate sqlSession;

   public void setVisitTotalCount(String gender, Date date) {
      int age =doDiffOfDate(date);
      Map<String, Object> param = new HashMap<String, Object>();
       param.put("gender", gender);
       param.put("age", age);
      sqlSession.getMapper(UserMapper.class).insertcnt(param);
      
   }

   public List<Integer> getVisitTodayCount() {
      return sqlSession.getMapper(UserMapper.class).todaycnt();
   }

   public List<Integer> getVisitTotalCount() {
      return sqlSession.getMapper(UserMapper.class).cnt();
   }
   public int doDiffOfDate(Date birth){
       Date end = new Date();
      int age = end.getYear()-birth.getYear()+1;
      return (int) age;
   }

   public List<visitcnt> getmen() {
      return sqlSession.getMapper(UserMapper.class).men();
   }

   public List<visitcnt> getgirl() {
      return sqlSession.getMapper(UserMapper.class).girl();
   }
}