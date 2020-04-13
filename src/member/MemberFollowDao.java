package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.db.OracleConn;

public class MemberFollowDao {
	OracleConn db = new OracleConn();
	
	public void insertFollow(String fromid, String toid) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into followtb values(seq_follow.nextval,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromid);
			pstmt.setString(2, toid);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO: handle exception
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public boolean followed(String fromid, String toid) {
		boolean followed = false;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from followtb where fromid=? and toid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromid);
			pstmt.setString(2, toid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if(cnt==1) {
					followed = true;
				}
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return followed;
	}
}
