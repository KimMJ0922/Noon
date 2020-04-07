<%@page import="history.HistoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	HistoryDAO dao = new HistoryDAO();
	int cnt = dao.getHistoryCount(id);
%>
<%=cnt%>