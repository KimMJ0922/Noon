package history;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import oracle.db.OracleConn;

public class HistoryDAO {
	OracleConn db = new OracleConn();
	public List<HistoryDTO> getHistory(String id){
		List<HistoryDTO> list = new Vector<HistoryDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select h.*, m.profilpic "+
					 "from history h, membertb m "+
					 "where h.toid = ? and h.fromid = m.id "+
					 "order by actionday desc";
		
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				HistoryDTO dto = new HistoryDTO();
				dto.setNum(rs.getString("num"));
				dto.setFormid(rs.getString("fromid"));
				dto.setAction(rs.getString("action"));
				dto.setActionday(rs.getTimestamp("actionday"));
				dto.setProfilepic(rs.getString("profilpic"));
				dto.setBoardnum(rs.getString("boardnum"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public void insertHistory(String num, String fromid, String toid, String action) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if(action.equals("like")) {
			action = "좋아요를 눌렀습니다.";
		}else if(action.equals("reply")) {
			action = "댓글을 달았습니다.";
		}else {
			action = "팔로우 했습니다.";
		}
		
		String sql = "insert into history values(?,?,?,?,sysdate,seq_history.nextval)";
		
		conn = db.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, fromid);
			pstmt.setString(3, toid);
			pstmt.setString(4, action);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public void deleteHistory(String num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete from history where num = ?";
		
		conn = db.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
}
