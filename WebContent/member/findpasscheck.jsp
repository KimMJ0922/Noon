<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	
	MemberDao dao = new MemberDao();
	String findid = dao.findPwd(id, email);
%>
<%=findid%>