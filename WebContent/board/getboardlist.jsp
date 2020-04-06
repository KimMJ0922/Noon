<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDAO dao = new BoardDAO();
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm",Locale.KOREA);
	List<BoardDTO> list = dao.getBoardList(minrow,maxrow);
	
	JSONArray arr = new JSONArray();
	for(BoardDTO dto : list){
		JSONObject ob=new JSONObject();
		ob.put("num",dto.getNum());
		ob.put("id",dto.getId());
		ob.put("nickname",dto.getNickname());
		ob.put("content",dto.getContent());
		ob.put("likes",dto.getLikes());
		ob.put("writeday",sdf.format(dto.getWriteday()));
		ob.put("reply",dto.getReply());
		arr.add(ob);
	}
%>
<%=arr.toString()%>