package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import oracle.db.OracleConn;

public class MemberDao {
	OracleConn db = new OracleConn();
	
	public void insertMember(MemberDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO membertb VALUES (seq_signup.nextval, ?,?,?,?,?,?,?,sysdate,?,null)";
		String type = "일반회원";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPass());
			pstmt.setString(4, dto.getHp1()+"-"+dto.getHp2()+"-"+dto.getHp3());
			pstmt.setString(5, dto.getEmail1()+"@"+dto.getEmail2());
			pstmt.setString(6, dto.getAddr1());
			pstmt.setString(7, dto.getAddr2());
			pstmt.setString(8, type);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public boolean login(String id, String pass) {
		boolean success=false;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from membertb where id=? and pass=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1)==1) {
					success=true;
				}
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return success;
	}
	
	public boolean isEqualID(String id) {
		boolean isEqual=false;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from membertb where id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt(1)==1) {
					isEqual=true;
				}
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return isEqual;
	}
	
	public MemberDto getdata(String id) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDto dto = new MemberDto();
		String sql = "select * from membertb where id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String[] email = rs.getString("email").split("@");
				String[] hp = rs.getString("hp").split("-");
				dto.setAddr1(rs.getString("addr1"));
				dto.setAddr2(rs.getString("addr2"));
				dto.setEmail1(email[0]);
				dto.setEmail2(email[1]);
				dto.setHp1(hp[0]);
				dto.setHp2(hp[1]);
				dto.setHp3(hp[2]);
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNum(rs.getString("num"));
				dto.setPass(rs.getString("pass"));
				dto.setSignupday(rs.getTimestamp("signupday"));
				dto.setType(rs.getString("type"));
				dto.setPic(rs.getString("pic"));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
}
