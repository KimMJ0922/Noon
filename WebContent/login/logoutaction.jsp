<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.removeAttribute("idcheck");
	session.removeAttribute("loginok");
	
	response.sendRedirect("noon_main.jsp");
%>