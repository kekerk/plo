package logic;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

public class Cart {
	//itemList : ���� ��ٱ��Ͽ� ��ϵ� ��ǰ���
	private List<ItemSet> itemSetList = new ArrayList<ItemSet>(); //��ǰ���
	
	public List<ItemSet> getItemSetList() {
		return itemSetList;
	}
	public void setItemSetList(List<ItemSet> itemSetList) {
		this.itemSetList = itemSetList;
	}

	//itemSet : ��ٱ��Ͽ� ��ϵ� ��ǰ
	public void push(ItemSet itemSet) {
		for(ItemSet s : itemSetList) {
			if(s.getItem().getItemno() == itemSet.getItem().getItemno()) { //�߰� ��ǰ ���
				if(s.getSize().equals(itemSet.getSize())) {
					s.setQuantity(s.getQuantity() + itemSet.getQuantity());
					return;
				}
			}
		}
		itemSetList.add(itemSet);
	}
	public boolean isEmpty() {
		return itemSetList == null || itemSetList.size() == 0;
	}
	public int getTotalAmount(){
		int total = 0;
		for(ItemSet s : itemSetList) {
			total += s.getItem().getPrice() * s.getQuantity();
		}
		return total;
	}
	public void clearAll(HttpSession session) {
		itemSetList = new ArrayList<ItemSet>();
		session.setAttribute("CART",this);
	}

	public void update(ItemSet itemSet) {
		for(ItemSet s : itemSetList) {
			if(s.getItem().getItemno() == itemSet.getItem().getItemno()) { //�߰� ��ǰ ���
				if(s.getSize().equals(itemSet.getSize())) {
					s.setQuantity(itemSet.getQuantity());
					return;
				}
			}
		}	
	}
}
