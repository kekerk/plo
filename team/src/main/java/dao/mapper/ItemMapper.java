package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Item;
import logic.Picture;
import logic.Size;
import logic.money;

public interface ItemMapper {

   @Select("select ifnull(max(itemno),0) from item")
   int maxnum();
   
   @Insert("insert into item (itemno,name,brand,price,color,discount,cost,content,regdate,total,cate,subcate) "
         + "values(#{itemno},#{name},#{brand},#{price},#{color},#{discount},#{cost},#{content},CURDATE(),#{total},#{cate},#{subcate})")
   void additem(Item item);

   @Insert("insert into size (itemno,size,quantity) values(#{itemno},#{size},#{quantity})")
   void addsize(Size size);
   
   @Insert("insert into picture (itemno,pictureurl,type) values(#{itemno},#{pictureurl},#{type})")
   void addpicture(Picture url);

   @Select("select * from picture where itemno  = #{itemno}")
   List<Picture> picturelist(Integer itemno);

   @Select("select * from size where itemno  = #{itemno}")
   List<Size> sizelist(Integer itemno);
   
   @Select("select sum((i.cost)*o.quantity) as 'cost',o.updatetime as 'date' from orderitem as o join item as i  where o.updatetime > DATE_SUB(NOW(),INTERVAL 7 day) and i.itemno = o.itemno group by o.updatetime")
   List<money> cost();

   @Select("select sum(amount)-sum(usepoint) as 'amount',orderdate as 'date' from orders where orderdate > DATE_SUB(NOW(),INTERVAL 7 day)  group by orderdate")
   List<money> amount();
}