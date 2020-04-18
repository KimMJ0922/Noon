<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id=request.getParameter("id");
	String type=request.getParameter("type");
	MemberDao dao=new MemberDao();
	dao.updateType(id, type);
%>