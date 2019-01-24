package exception;

public class Cartadd extends RuntimeException{
	private String url;
	public Cartadd(String msg, String url) {
		super(msg);
		this.url = url;
	}
	public String getUrl() {
		return url;
	}
}
