<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String data = request.getParameter("data");
	String type = request.getParameter("type");
	String id = (String)session.getAttribute("id");
	
	MemberDao db = new MemberDao();
	db.update(data, type, id);
%>