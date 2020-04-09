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
				+ "?,seq_reply.nextval,seq_reply.nextval,seq_reply.nextval,?,?,sysdate)";	
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
	
	public List<ReplyDTO> getAllDatas(String boardnum){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReplyDTO> list= new Vector<ReplyDTO>();
		String sql="select * from board_detail_reply where boardnum= ? order by sortnum desc";
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
}
