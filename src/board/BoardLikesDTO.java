package board;

import java.sql.Timestamp;

public class BoardLikesDTO {
	private String num;
	private String id;
	private Timestamp likeday;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Timestamp getLikeday() {
		return likeday;
	}
	public void setLikeday(Timestamp likeday) {
		this.likeday = likeday;
	}
}
