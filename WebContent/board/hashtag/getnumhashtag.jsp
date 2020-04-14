<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardHashTagDTO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	BoardHashTagDAO htdao = new BoardHashTagDAO();
	BoardHashTagDTO htdto = new BoardHashTagDTO();
	JSONArray arr = new JSONArray();
	List<String> list = htdao.getNumHashTag(num);
	if(list.size()!=0){
		for(int i=0;i<list.size();i++){
			JSONObject ob=new JSONObject();
			String hashtag = list.get(i);
			ob.put("hashtag",hashtag);
			arr.add(ob);
		}
%>
		<%=arr.toString()%>
<% 
	}
%>