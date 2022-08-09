package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	Connection conn;
	PreparedStatement pstmt;
	final String sql_selectOne="SELECT * FROM BOARD WHERE BID=?";
	final String sql_selectAll="SELECT * FROM BOARD WHERE CONCAT(CONCAT(TITLE,CONTENT),WRITER) LIKE '%'||?||'%' ORDER BY BID DESC";
	final String sql_insert="INSERT INTO BOARD VALUES((SELECT NVL(MAX(BID),0)+1 FROM BOARD),?,?,?)";
	final String sql_update="UPDATE BOARD SET TITLE=?,CONTENT=? WHERE BID=?";
	final String sql_delete="DELETE FROM BOARD WHERE BID=?";
	public BoardVO selectOne(BoardVO vo) {
		conn=JDBCUtill.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectOne);
			pstmt.setInt(1, vo.getBid());
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setContent(rs.getString("CONTENT"));
				data.setTitle(rs.getString("TITLE"));
				data.setWriter(rs.getString("WRITER"));
				return data;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtill.disConnect(pstmt, conn);
		}		
		return null;
	}
	public ArrayList<BoardVO> selectAll(BoardVO vo){
		ArrayList<BoardVO> datas=new ArrayList<BoardVO>();
		conn=JDBCUtill.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectAll);
			pstmt.setString(1, vo.getTitle());
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setContent(rs.getString("CONTENT"));
				data.setTitle(rs.getString("TITLE"));
				data.setWriter(rs.getString("WRITER"));
				datas.add(data);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtill.disConnect(pstmt, conn);
		}		
		return datas;
	}
	public boolean insert(BoardVO vo) {
		conn=JDBCUtill.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getWriter());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtill.disConnect(pstmt, conn);
		}
		return true;
	}
	public boolean update(BoardVO vo) {
		conn=JDBCUtill.connect();
		try {
			pstmt=conn.prepareStatement(sql_update);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtill.disConnect(pstmt, conn);
		}
		return true;
	}
	public boolean delete(BoardVO vo) {
		conn=JDBCUtill.connect();
		try {
			pstmt=conn.prepareStatement(sql_delete);
			pstmt.setInt(1,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtill.disConnect(pstmt, conn);
		}
		return true;
	}
}
