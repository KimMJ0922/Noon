<%@page import="history.HistoryDAO"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");


	String num = request.getParameter("num");
	HistoryDAO hdao = new HistoryDAO();
	hdao.deleteHistory(num);
%>