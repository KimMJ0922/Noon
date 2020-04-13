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
	
	public List<BoardDTO> getBoardList(String minrow,String maxrow,String sort){
		List<BoardDTO> list = new Vector<BoardDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		if(sort.equals("like")) {
			sql = "select * from("+
					 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					 "from ( select b.*,m.profilpic from boardtb b, membertb m where b.id = m.id order by likes desc,writeday desc) a"+
					 ") where rnum > ? and rnum <= ?";
		}else {
			sql = "select * from("+
					 "select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
					 "from ( select b.*,m.profilpic from boardtb b, membertb m where b.id = m.id order by writeday desc) a"+
					 ") where rnum > ? and rnum <= ?";
		} 
				
		ResultSet rs = null;
		conn = db.getConnection();
		try {
			//boardtb에 insert
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, minrow);
			pstmt.setString(2, maxrow);
				
			
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
			//boardtb에 insert
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
			
			sql = "select likes from boardtb where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				likecnt = rs.getInt(1);
			}
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
	
	public List<BoardDTO> getMemberBoardList(String minrow, String maxrow, String id){
		List<BoardDTO> list = new Vector<BoardDTO>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = 
				"select * from("+
						"select a.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT "+
						"from ( "+
							"select b.*,m.profilpic "+
							"from boardtb b, membertb m "+
							"where b.id = m.id and b.id like ? "+
							"order by writeday desc "+
				 		") a"+
				 ") where rnum > ? and rnum <= ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, minrow);
			pstmt.setString(3, maxrow);
			System.out.println(id+", "+minrow+", "+maxrow);
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
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("getMemberBoardList 메소드 오류 : "+e.getMessage());
		}finally {
			db.dbClose(rs, pstmt, conn); 
		}
		return list;
	}
}
