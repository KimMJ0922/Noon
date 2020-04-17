package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import history.HistoryDAO;
import oracle.db.OracleConn;

public class BoardLikesDAO {
	OracleConn db = new OracleConn();
	public void insertLike(BoardLikesDTO dto, int likes) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		if(likes==1) {
			sql = "insert into boardlike values(?,?,sysdate)";
		}else {
			sql = "delete from boardlike where num = ? and id = ?";
		}
		
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
			//작성자 아이디
			String id = "";
			if(rs.next()) {
				id = rs.getString(1);
			}
			
			//현재 로그인 된 아이디가 자기 게시물의 좋아요를 눌렀을 때 히스토리에 남기지 않음
			//좋아요가 +1 일때만 남김
			HistoryDAO hdao = new HistoryDAO();
			String action = "like";
			if(!id.equals(dto.getId()) && likes != -1) {
				hdao.insertHistory(dto.getNum(),dto.getId(),id,action);
			}else if(!id.equals(dto.getId()) && likes == -1){
				sql = "select * from history where fromid=? and toid = ? and action like '%좋아요%'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getId());
				pstmt.setString(2, id);
				rs = pstmt.executeQuery();
				String num = "";
				if(rs.next()) {
					num = rs.getString(1);
				}
				
				hdao.deleteHistory(num);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
	}
	
	
	//리스트에 보여질 것
	public List<String> getLikeList(String minrow, String maxrow, String id, String sort,String search,String getId){
		List<String> list = new Vector<String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		if(sort.equals("like")) {
			sql = "select min(num),max(num) from("+
					 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					 "from ( select b.*,m.profilpic from boardtb b, membertb m where b.id = m.id order by likes desc,writeday desc) a"+
					 ") where rnum > ? and rnum <= ?";
		}else if(!search.equals("")){
			sql = "select min(num),max(num) " + 
					"from( " + 
					"select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT " + 
					"from ( " + 
					"select b.*,m.profilpic,bh.hashtag " + 
					"from boardtb b, membertb m, BOARDHASHTAGTB bh " + 
					"where b.id = m.id and bh.num = b.num and bh.hashtag = ? " + 
					"order by writeday desc " + 
					") a " + 
					")" + 
					"where rnum > ? and rnum <= ?";
		}else if(!getId.equals("")) {
			sql = "select min(num),max(num) from("+
					  "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					  "from ( select b.* from boardtb b, membertb m "+
					  "where b.id = m.id and b.id = ?"+
					  "order by writeday desc) a"+
					  ") where rnum > ? and rnum <= ?";	
		}else {
			sql = "select min(num),max(num) from("+
					 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					 "from ( select b.*,m.profilpic from boardtb b, membertb m where b.id = m.id order by writeday desc) a"+
					 ") where rnum > ? and rnum <= ?";
		} 
		
		ResultSet rs = null;
		conn = db.getConnection();
		int max = 0;
		int min = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			if(!search.equals("")) {
				pstmt.setString(1, search);
				pstmt.setString(2, minrow);
				pstmt.setString(3, maxrow);
			}else if(!getId.equals("")){
				pstmt.setString(1, id);
				pstmt.setString(2, minrow);
				pstmt.setString(3, maxrow);
			}else {
				pstmt.setString(1, minrow);
				pstmt.setString(2, maxrow);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				min = rs.getInt(1);
				max = rs.getInt(2);
			}
			sql = "select num from boardlike "+
				  "where (num between ? and ?) and id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, min);
			pstmt.setInt(2, max);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String num = rs.getString("num");
				list.add(num);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("getLikeList 메소드 오류 : "+e.getMessage());
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public String getLikeNum(String num) {
		String likecnt = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select likes from boardtb where num = ?";
		
		conn = db.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				likecnt = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return likecnt;
	}
	
	public String getLikeStatus(String num, String id) {
		String likeStatus = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id from BOARDLIKE where num = ? and id = ?";
		
		conn = db.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				likeStatus = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return likeStatus;
	}
}
