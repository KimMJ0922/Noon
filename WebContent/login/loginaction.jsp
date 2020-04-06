<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	//테이블 검색
	
	
	//성공시 세션 부여
	session.setAttribute("id", id);
%>