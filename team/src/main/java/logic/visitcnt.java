package logic;

import java.util.Date;

public class visitcnt {
   private int cnt;
   private String ag;
   public int getCnt() {
      return cnt;
   }

   public void setCnt(int cnt) {
      this.cnt = cnt;
   }

   public String getAg() {
      return ag;
   }

   public void setAg(String ag) {
      this.ag = ag;
   }

   public visitcnt(int cnt, String ag) {
      super();
      this.cnt = cnt;
      this.ag = ag;
   }
   public visitcnt() {
      
   }   
}