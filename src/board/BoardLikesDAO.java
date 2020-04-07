package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import history.HistoryDAO;
import oracle.db.OracleConn;

public class BoardLikesDAO {
	OracleConn db = new OracleConn();
	public void insertLike(BoardLikesDTO dto, int likes) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into boardlike values(?,?,sysdate)";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNum());
			pstmt.setString(2, dto.getId());
			pstmt.execute();
			
			sql = "select id from boardtb where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNum());
			rs = pstmt.executeQuery();
			String id = "";
			if(rs.next()) {
				id = rs.getString(1);
			}
			
			System.out.println("아이디 : "+id);
			
			//현재 로그인 된 아이디가 자기 게시물의 좋아요를 눌렀을 때 히스토리에 남기지 않음
			//좋아요가 +1 일때만 남김
			HistoryDAO hdao = new HistoryDAO();
			if(!id.equals(dto.getId()) && likes != -1) {
				String action = "like";
				hdao.insertHistory(dto.getId(),id,action);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
	}
}
