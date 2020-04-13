<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="board.BoardHashTagDTO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	BoardHashTagDAO htdao = new BoardHashTagDAO();
	
	List<String> list = htdao.getNumHashTag(num);
	for(String hash : list){
%>
	<a href="">#<%=hash %></a>
<%
	}
%>