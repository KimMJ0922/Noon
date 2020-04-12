package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import oracle.db.OracleConn;

public class BoardImgDAO {
	OracleConn db = new OracleConn();
	
	public void insertImgFileName(String num,String fileName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into boardimgtb values(?,?)";
		conn = db.getConnection();
		try {
			//boardtb에 insert
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, fileName);
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public void deleteImgBoard(String num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from boardimgtb where num = ?";
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
	
	//리스트에 보여질 것
	public List<BoardImgDTO> getImglist(String minrow, String maxrow,String sort,String text){
		List<BoardImgDTO> list = new Vector<BoardImgDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		System.out.println("imgdao에 밖 text "+text);
		if(sort.equals("like")) {
			if(!text.equals("#")) {
				sql = "select min(num),max(num)"+
					  "from( "+
					  		"select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					  		"from ("+
					  			   "select b.*, bh.hashtag "+
					  			   "from boardtb b, BOARDHASHTAGTB bh "+
					  			   "where b.num = bh.num and bh.hashtag like ? "+
					  			   "order by writeday desc"+
					  		") a "+
					  ")"+
					  "where rnum > ? and rnum <= ?";
			}else {
				sql = "select min(num),max(num) from("+
						 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
						 "from ( select * from boardtb order by likes desc, writeday desc) a"+
						 ") where rnum > ? and rnum <= ?";
			}
			
		}else {
			if(!text.equals("#")) {
				System.out.println("2번으로 들어옴");
				sql = "select min(num),max(num)"+
					  "from( "+
					  		"select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					  		"from ("+
					  			   "select b.*, bh.hashtag "+
					  			   "from boardtb b, BOARDHASHTAGTB bh "+
					  			   "where b.num = bh.num and bh.hashtag like ? "+
					  			   "order by writeday desc"+
					  		") a "+
					  ")"+
					  "where rnum > ? and rnum <= ?";	
			}else {
				System.out.println("3번으로 들어옴");
				sql = "select min(num),max(num) from("+
					  "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					  "from ( select * from boardtb order by writeday desc) a"+
					  ") where rnum > ? and rnum <= ?";	
			}
		} 
		
		
		ResultSet rs = null;
		conn = db.getConnection();
		int max = 0;
		int min = 0;
		try {
			System.out.println("imgdao에 안 text"+text);
			pstmt = conn.prepareStatement(sql);
			if(text.equals("#")&&(sort.equals("")||sort.equals("like"))) {
				System.out.println("바인드 1번으로 들어옴");
				pstmt.setString(1, minrow);
				pstmt.setString(2, maxrow);
			}else {
				System.out.println("바인드 2번으로 들어옴");
				pstmt.setString(1, text);
				pstmt.setString(2, minrow);
				pstmt.setString(3, maxrow);
				
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				min = rs.getInt(1);
				max = rs.getInt(2);
			}
			sql = "select * from boardimgtb "+
				  "where num between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, min);
			pstmt.setInt(2, max);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardImgDTO dto = new BoardImgDTO();
				dto.setNum(rs.getString("num"));
				dto.setImgfile(rs.getString("imgfile"));
				
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
	
	public List<String> getNumImglist(String num){
		List<String> list = new Vector<String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select imgfile from boardimgtb where num=?";
		ResultSet rs = null;
		conn = db.getConnection();
		try {
			//boardtb에 insert
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String fileName = rs.getString("imgfile");
				list.add(fileName);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("오류 : "+e.getMessage());
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
}
