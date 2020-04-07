package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.db.OracleConn;

public class MemberDao {
	OracleConn db = new OracleConn();
	
	public void insertMember(MemberDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO membertb VALUES (seq_signup.nextval, ?,?,?,?,?,?,?,sysdate,?)";
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
			System.out.println(pass);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getInt(1));
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
}
