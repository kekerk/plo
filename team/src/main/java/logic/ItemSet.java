package logic;
//상품, 수량을 가진 클래스
public class ItemSet {
	private Item item;
	private Integer quantity;
	private Integer size;
	public ItemSet(Item item, Integer quantity, Integer size) {
		this.item = item;
		this.quantity = quantity;
		this.size = size;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "ItemSet [item=" + item + ", quantity=" + quantity + "]";
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	
}
