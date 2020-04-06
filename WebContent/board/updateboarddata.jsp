<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = dao.getBoard(num);
	
	JSONArray arr = new JSONArray();
	JSONObject ob=new JSONObject();
	ob.put("content",dto.getContent());
	arr.add(ob);
%>
<%=arr.toString()%>