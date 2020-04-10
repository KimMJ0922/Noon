package reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import board.BoardDTO;
import oracle.db.OracleConn;

public class ReplyDAO {
	OracleConn db = new OracleConn();
	
	public void insertReply(ReplyDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into board_detail_reply values ("
				+ "?,seq_reply.nextval,0,0,seq_reply.nextval,?,?,sysdate)";	
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBoardnum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getContent());
			pstmt.execute();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("insertReply 메소드 오류 : "+e.getMessage());
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	public void insertReply_re(ReplyDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "select groupnum,sortnum from board_detail_reply where boardnum=? and replynum=?";
		ResultSet rs=null;
		conn = db.getConnection();
		try {
			int groupnum=0;
			int sortnum = 0;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBoardnum());
			pstmt.setString(2, dto.getReplynum());
			rs=pstmt.executeQuery();
			System.out.println();
			if(rs.next()) {
				groupnum=rs.getInt(1);
				sortnum = rs.getInt(2);
			}
			sortnum++;
			System.out.println("groupnum : " + groupnum);
			
			String sql2="insert into board_detail_reply values ("
					+ "?,seq_reply.nextval,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, dto.getBoardnum());
			pstmt.setInt(2, sortnum);
			pstmt.setString(3, dto.getReplynum());
			pstmt.setInt(4, groupnum);
			pstmt.setString(5, dto.getName());
			pstmt.setString(6, dto.getContent());
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("insertReply 메소드 오류 : "+e.getMessage());
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		
	}
	
	public List<ReplyDTO> getAllDatas(String boardnum){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReplyDTO> list= new Vector<ReplyDTO>();
		String sql="select * " + 
				"from BOARD_DETAIL_REPLY " + 
				"where boardnum= ? " + 
				"START WITH parentnum = 0 " + 
				"CONNECT BY PRIOR replynum = parentnum";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardnum);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ReplyDTO dto=new ReplyDTO();
				dto.setBoardnum(rs.getString("boardnum"));
				dto.setReplynum(rs.getString("replynum"));
				dto.setParentnum(rs.getString("parentnum"));
				dto.setSortnum(rs.getString("sortnum"));
				dto.setContent(rs.getString("content"));
				dto.setName(rs.getString("name"));
				dto.setGroupnum(rs.getString("groupnum"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				list.add(dto);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("getAllDatas 메소드 오류 : "+e.getMessage());
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	} 
	
	public void deleteReply(String replynum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from board_detail_reply where replynum = ?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, replynum);
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public void updateReply(String content,String replynum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update board_detail_reply set content=? where replynum = ?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setString(2, replynum);
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
}
