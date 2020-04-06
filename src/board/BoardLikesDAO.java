package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.db.OracleConn;

public class BoardLikesDAO {
	OracleConn db = new OracleConn();
	public void insertLike(BoardLikesDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into boardlike values(?,?,sysdate)";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNum());
			pstmt.setString(2, dto.getId());
			pstmt.execute();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
}
