package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ItemMapper;
import dao.mapper.UserMapper;
import logic.Item;
import logic.Picture;
import logic.Size;
import logic.money;

@Repository
public class ItemDao {
   @Autowired
   private SqlSessionTemplate sqlSession;
   private final String NS = "dao.mapper.ItemMapper.";
   
   public int Maxnum() {
      return sqlSession.getMapper(ItemMapper.class).maxnum();
   }

   public void additem(Item item) {
      sqlSession.getMapper(ItemMapper.class).additem(item);
   }

   public void addsize(Size size) {
      sqlSession.getMapper(ItemMapper.class).addsize(size);
   }

   public void addpicture(Picture url) {
      sqlSession.getMapper(ItemMapper.class).addpicture(url);
      
   }

   public int itemcount(String searchContent, String searchType) {
      Map<String, String> param = new HashMap<String, String>();
      param.put("searchContent", searchContent);
      param.put("searchType", searchType);
      Integer ret = sqlSession.selectOne(NS+"count",param);
      return ret;
   }
   public int itemcount2(String searchContent, String searchType) {
       Map<String, String> param = new HashMap<String, String>();
        param.put("searchContent", searchContent);
        param.put("searchType", searchType);
        Integer ret = sqlSession.selectOne(NS+"count",param);
        return ret;
  }
   public List<Item> itemlist2(String searchContent, String searchType, Integer pageNum, int limit) {
      Map<String, Object> param = new HashMap<String, Object>();
      int startrow=(pageNum -1)*limit;
      param.put("searchContent", searchContent);
      param.put("searchType", searchType);
      param.put("startrow", startrow);
      param.put("limit", limit);
      List<Item> list= sqlSession.selectList(NS+"select",param);
      for(Item l : list) {
         List<Picture> pic = sqlSession.getMapper(ItemMapper.class).picturelist(l.getItemno());
         l.setPicturelist(pic);
      }
      return list;
   }
   public List<Item> itemlist(String searchContent, String searchType, Integer pageNum, int limit, Integer cate, Integer subcate, Integer searchPriceStart, Integer searchPriceEnd) {
	      Map<String, Object> param = new HashMap<String, Object>();
	      int startrow=(pageNum -1)*limit;
	      param.put("searchContent", searchContent);
	      param.put("searchType", searchType);
	      param.put("startrow", startrow);
	      param.put("limit", limit);
	      param.put("cate", cate);
	      param.put("subcate", subcate);
	      param.put("searchPriceStart", searchPriceStart);
	      param.put("searchPriceEnd", searchPriceEnd);
	      List<Item> list= sqlSession.selectList(NS+"select",param);
	      for(Item l : list) {
	         List<Picture> pic = sqlSession.getMapper(ItemMapper.class).picturelist(l.getItemno());
	         l.setPicturelist(pic);
	      }
	      return list;
}
   public Item itemone(Integer itemno) {
      Map<String, Integer> param = new HashMap<String, Integer>();
      param.put("itemno", itemno);
      param.put("startrow", 0);
      param.put("limit", 1);
      Item item = sqlSession.selectOne(NS+"select",param);
      List<Picture> pic = sqlSession.getMapper(ItemMapper.class).picturelist(itemno);
      List<Size> size = sqlSession.getMapper(ItemMapper.class).sizelist(itemno);
      item.setPicturelist(pic);
      item.setSize(size);
      return item;
   }
	public List<Item> list() {
		return sqlSession.selectList(NS + "list");
	}

	public Item getItemByNo(Integer itemno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("itemno", itemno);
		return sqlSession.selectOne(NS + "list",map);
	}
	public List<money> cost() {
	      return sqlSession.getMapper(ItemMapper.class).cost();
	}

	public List<money> amount() {
	      return sqlSession.getMapper(ItemMapper.class).amount();
	}
}