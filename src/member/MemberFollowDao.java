package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

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
	
	public void deleteFollow(String fromid, String toid) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "delete from followtb where fromid=? and toid=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromid);
			pstmt.setString(2, toid);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public List<MemberDto> followedFriend(String fromid){
		List<MemberDto> list = new Vector<MemberDto>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select toid from followtb where fromid=? order by toid";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, fromid);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				String toid = rs.getString("toid");
				MemberDao dao = new MemberDao();
				MemberDto dto = dao.getdata(toid);
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public List<MemberDto> followingFriend(String toid){
		List<MemberDto> list = new Vector<MemberDto>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select fromid from followtb where toid=? order by fromid";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, toid);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				String fromid = rs.getString("fromid");
				MemberDao dao = new MemberDao();
				MemberDto dto = dao.getdata(fromid);
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public int followerCnt(String toid) {
		int cnt = 0;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from followtb where toid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, toid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return cnt;
	}
}
