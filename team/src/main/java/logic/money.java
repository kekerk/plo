package logic;

import java.util.Date;

public class money {
private Integer cost;
private Date date;
private Integer amount;
private Integer money;
public Integer getMoney() {
   return money;
}
public void setMoney(Integer money) {
   this.money = money;
}
public Integer getCost() {
   return cost;
}
public void setCost(Integer cost) {
   this.cost = cost;
}
public Date getDate() {
   return date;
}
public void setDate(Date date) {
   this.date = date;
}
public Integer getAmount() {
   return amount;
}
public void setAmount(Integer amount) {
   this.amount = amount;
}

public money(Integer cost, Date date, Integer amount, Integer money) {
   super();
   this.cost = cost;
   this.date = date;
   this.amount = amount;
   this.money = money;
}
public money() {}
}