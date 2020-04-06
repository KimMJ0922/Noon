<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	
	BoardDAO dao = new BoardDAO();
	String con = dao.getNumContent(num);
%>
<%=con%>