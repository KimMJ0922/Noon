<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	MemberDao dao = new MemberDao();
	dao.changePassword(id, pass);
%>