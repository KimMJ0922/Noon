package oracle.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OracleConn {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	
	public OracleConn() {
		try {
			Class.forName(driver);
//			System.out.println("드라이버 연결 성공");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
		System.out.println("드라이버 연결 실패 : "+e.getMessage());
		}
	}
	public Connection getConnection() {
		Connection conn =null;
		try {
			conn = DriverManager.getConnection(url,"angel","a1234");
//			System.out.println("계정 연결 성공");
		} catch (SQLException e) {
			System.out.println("계정 연결 실패 : "+e.getMessage());
		}
		return conn;
	}
	
	public Connection getConnection2() {
		Connection conn =null;
		String url = "jdbc:oracle:thin:@192.168.0.3:1521:xe";
		try {
			conn = DriverManager.getConnection(url,"angel","a1234");
//			System.out.println("계정 연결 성공");
		} catch (SQLException e) {
			System.out.println("계정 연결 실패 : "+e.getMessage());
		}
		return conn;
	}
	
	//sql 자원들을 닫는 메서드
		public void dbClose(PreparedStatement pstmt,Connection conn)
		{
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		public void dbClose(ResultSet rs,PreparedStatement pstmt,Connection conn)
		{
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		public void dbClose(Statement stmt,Connection conn)
		{
			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		public void dbClose(ResultSet rs,Statement stmt,Connection conn)
		{
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

}
