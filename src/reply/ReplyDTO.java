package reply;

import java.sql.Timestamp;

public class ReplyDTO {
	private String boardnum;
	private String replynum;
	private String sortnum;
	private String parentnum;
	private String name;
	private String content;
	private Timestamp writeday;
	public String getBoardnum() {
		return boardnum;
	}
	public String getReplynum() {
		return replynum;
	}
	public String getSortnum() {
		return sortnum;
	}
	public String getParentnum() {
		return parentnum;
	}
	public String getName() {
		return name;
	}
	public String getContent() {
		return content;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setBoardnum(String boardnum) {
		this.boardnum = boardnum;
	}
	public void setReplynum(String replynum) {
		this.replynum = replynum;
	}
	public void setSortnum(String sortnum) {
		this.sortnum = sortnum;
	}
	public void setParentnum(String parentnum) {
		this.parentnum = parentnum;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	
	
}
