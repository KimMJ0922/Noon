<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="board.BoardHashTagDTO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	String sort = request.getParameter("sort");
	String text = request.getParameter("text");
	String num = request.getParameter("num");
	BoardHashTagDAO htdao = new BoardHashTagDAO();
	
	List<String> list = htdao.getNumHashTag(num);
	for(String hash : list){
%>
	<a class="hashtag">#<%=hash %></a>
<%
	}
%>