package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Vector;

import oracle.db.OracleConn;

public class BoardDAO {
	OracleConn db = new OracleConn();
	public String insertPosts(BoardDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into boardtb values(seq_board.nextval,?,?,?,0,sysdate,0)";
		ResultSet rs = null;
		String num = "";
		conn = db.getConnection();
		try {
			//boardtb에 insert
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getContent());
			pstmt.execute();
			
			//방금 작성한 게시글의 번호 가져오기
			sql="select max(num) from boardtb";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return num;
	}
	
	public List<BoardDTO> getBoardList(String minrow,String maxrow,String sort,String search,String id){
		List<BoardDTO> list = new Vector<BoardDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		String plussql = "";

		if(sort.equals("like")) {
			sql = "select * from("+
					 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					 "from ( select b.*,m.profilpic,m.type from boardtb b, membertb m where b.id = m.id order by likes desc,writeday desc) a"+
					 ") where rnum > ? and rnum <= ?";
		}else if(!search.equals("")){
			sql = "select * " + 
					"from( " + 
					"select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT " + 
					"from ( " + 
					"select b.*,m.profilpic,bh.hashtag,m.type " + 
					"from boardtb b, membertb m, BOARDHASHTAGTB bh " + 
					"where b.id = m.id and bh.num = b.num and bh.hashtag = ? " + 
					"order by writeday desc " + 
					") a " + 
					")" + 
					"where rnum > ? and rnum <= ?";
		}else if(!id.equals("")){
			sql = "select * from("+
					 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					 "from ( select b.*,m.profilpic,m.type from boardtb b, membertb m where b.id = m.id and b.id = ? order by writeday desc) a"+
					 ") where rnum > ? and rnum <= ?";
		}else {
			sql = "select * from("+
					 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					 "from ( select b.*,m.profilpic,m.type from boardtb b, membertb m where b.id = m.id order by writeday desc) a"+
					 ") where rnum > ? and rnum <= ?";
		} 
				
		ResultSet rs = null;
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			if(!search.equals("")) {
				pstmt.setString(1, search);
				pstmt.setString(2, minrow);
				pstmt.setString(3, maxrow);
			}else if(!id.equals("")){
				pstmt.setString(1, id);
				pstmt.setString(2, minrow);
				pstmt.setString(3, maxrow);
			}else {
				pstmt.setString(1, minrow);
				pstmt.setString(2, maxrow);
			}
			
				
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setContent(rs.getString("content"));
				dto.setLikes(rs.getInt("likes"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReply(rs.getString("reply"));
				dto.setProfilepic(rs.getString("profilpic"));
				dto.setType(rs.getString("type"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("getBoardList 메소드 오류 : "+e.getMessage());
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public void deleteBoard(String num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from boardtb where num = ?";
		conn = db.getConnection();
		try {
			//boardtb에 insert
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.execute();
			
			sql ="delete from history where num = ?";
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
	
	public BoardDTO getBoard(String num) {
		BoardDTO dto = new BoardDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select b.*,m.profilpic from boardtb b, membertb m where b.num = ? and b.id=m.id";	
		ResultSet rs = null;
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setContent(rs.getString("content"));
				dto.setLikes(rs.getInt("likes"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReply(rs.getString("reply"));
				dto.setProfilepic(rs.getString("profilpic"));
			}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return dto;
	}
	
	public void updateBoard(BoardDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update boardtb set content = ? where num = ?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getNum());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public int updateLikes(String num, int likes) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update boardtb set likes = likes + ? where num = ?";
		conn = db.getConnection();
		int likecnt = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, likes);
			pstmt.setString(2, num);
			pstmt.execute();
			
			sql = "select id, likes from boardtb where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			String id = "";
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
				likecnt = rs.getInt(2);
			}
			
			sql = "select sum(likes) from boardtb where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			int cnt = 0;
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			sql = "select type from membertb where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			String type = "";
			if(rs.next()) {
				type = rs.getString(1);
			}
			if(cnt>=3000&&!type.equals("관리자")) {
				sql = "update membertb set type='우수회원' where id = ?";
			}else if(cnt<3000&&!type.equals("관리자")){
				sql = "update membertb set type='일반회원' where id = ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
		return likecnt;
	}
	
	public String getNumContent(String num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select content from boardtb where num = ?";
		String con = "";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				con = rs.getString("content");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return con;
	}
	
	public BoardDTO getCount(String id) {
		BoardDTO dto = new BoardDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(num),sum(likes) from boardtb where id=?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setLikes(rs.getInt(2));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	public String getBoardWriter(String num) { 
		String writer = ""; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		String sql = "select id from boardtb where num = ?"; 
		conn = db.getConnection(); 
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, num); 
			rs = pstmt.executeQuery(); 
			if(rs.next()) { 
				writer = rs.getString(1); 
			} 
		} catch (SQLException e) { 
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
		}finally { 
			db.dbClose(rs, pstmt, conn); 
		} 
		 
		return writer; 
	}
	
	public String getNumWriter(String num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id from boardtb where num = ?";
		String id = "";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return id;
	}
}
