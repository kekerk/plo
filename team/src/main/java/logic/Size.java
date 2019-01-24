package logic;

public class Size {
	private Integer itemno;
	private Integer size;
	private Integer quantity;
	public Integer getItemno() {
		return itemno;
	}
	public void setItemno(Integer itemno) {
		this.itemno = itemno;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "Size [itemno=" + itemno + ", size=" + size + ", quantity=" + quantity + "]";
	}
	
}
