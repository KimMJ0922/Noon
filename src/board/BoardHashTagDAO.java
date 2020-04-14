package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import oracle.db.OracleConn;

public class BoardHashTagDAO {
	OracleConn db = new OracleConn();
	
	public void insertHashTag(BoardHashTagDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into boardhashtagtb values(?,?)";
		conn = db.getConnection();
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNum());
			pstmt.setString(2, dto.getHashtag());
			if(dto.getHashtag()==null||dto.getHashtag().equals("")) {
			}else {
				pstmt.execute();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public List<String> getNumHashTag(String num) {
		List<String> list = new Vector<String>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select hashtag from boardhashtagtb where num = ? order by hashtag";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("hashtag"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return list;
	}
	
	public List<BoardHashTagDTO> getHashTags(String minrow, String maxrow,String sort) {
		List<BoardHashTagDTO> list = new Vector<BoardHashTagDTO>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		if(sort.equals("like")) {
			sql = "select min(num),max(num) from("+
					  "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					  "from ( select * from boardtb order by likes desc, writeday desc) a"+
					  ") where rnum > ? and rnum <= ?";	
			
		}else {
			sql = "select min(num),max(num) from("+
					  "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					  "from ( select * from boardtb order by writeday desc) a"+
					  ") where rnum > ? and rnum <= ?";	
		}

		int max = 0;
		int min = 0;
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, minrow);
			pstmt.setString(2, maxrow);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				min = rs.getInt(1);
				max = rs.getInt(2);
			}
			
			sql = "select * from boardhashtagtb "+
				  "where num between ? and ? order by hashtag asc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, min);
			pstmt.setInt(2, max);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardHashTagDTO dto = new BoardHashTagDTO();
				dto.setNum(rs.getString("num"));
				dto.setHashtag(rs.getString("hashtag"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("오류 : "+e.getMessage());
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	
	public void deleteHashTag(String num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from boardhashtagtb where num = ?";
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
