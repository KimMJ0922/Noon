<%@page import="member.MemberDao"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDto dto = new MemberDto();
	MemberDao dao = new MemberDao();
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String findId = dao.findId(email, phone);
%>
<%=findId %>


