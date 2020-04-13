package member;

import java.sql.Timestamp;

public class MemberDto {
	private String num;
	private String name;
	private String id;
	private String pass;
	private String hp1;
	private String hp2;
	private String hp3;
	private String email1;
	private String email2;
	private String addr1;
	private String addr2;
	private Timestamp signupday;
	private String type;
	private String pic;
	public String getNum() {
		return num;
	}
	public String getName() {
		return name;
	}
	public String getId() {
		return id;
	}
	public String getPass() {
		return pass;
	}
	public String getHp1() {
		return hp1;
	}
	public String getHp2() {
		return hp2;
	}
	public String getHp3() {
		return hp3;
	}
	public String getEmail1() {
		return email1;
	}
	public String getEmail2() {
		return email2;
	}
	public String getAddr1() {
		return addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public Timestamp getSignupday() {
		return signupday;
	}
	public String getType() {
		return type;
	}
	public String getPic() {
		return pic;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}
	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}
	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public void setSignupday(Timestamp signupday) {
		this.signupday = signupday;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
}
