<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idcheck = (String)session.getAttribute("idcheck");
	if(idcheck !=null && idcheck.equals("no")){
		session.removeAttribute("idcheck");
	}
	session.removeAttribute("loginok");
	
	
%>