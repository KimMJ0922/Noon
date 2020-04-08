<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	MemberDao db = new MemberDao();
	String id = request.getParameter("id");
	String str="";
	boolean chk = db.isEqualID(id);
	if(chk==true){
		str = "중복된 아이디 입니다.";
	}else{
		str = "사용 가능한 아이디 입니다.";
	}
%>
<%=str%>