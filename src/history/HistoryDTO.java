package history;

import java.sql.Timestamp;

public class HistoryDTO {
	private String num;
	private String formid;
	private String toid;
	private String action;
	private Timestamp actionday;
	
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getFormid() {
		return formid;
	}
	public void setFormid(String formid) {
		this.formid = formid;
	}
	public String getToid() {
		return toid;
	}
	public void setToid(String toid) {
		this.toid = toid;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public Timestamp getActionday() {
		return actionday;
	}
	public void setActionday(Timestamp actionday) {
		this.actionday = actionday;
	}
}
