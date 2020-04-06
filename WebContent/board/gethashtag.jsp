<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="board.BoardHashTagDTO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	BoardHashTagDAO htdao = new BoardHashTagDAO();
	JSONArray arr = new JSONArray();
	List<BoardHashTagDTO> list = htdao.getHashTags(minrow,maxrow);
	if(list.size()!=0){
		for(BoardHashTagDTO htdto : list){
			JSONObject ob=new JSONObject();
			ob.put("num",htdto.getNum());
			ob.put("hashtag",htdto.getHashtag());
			arr.add(ob);
		}
%>
		<%=arr.toString()%>
<% 
	}
%>