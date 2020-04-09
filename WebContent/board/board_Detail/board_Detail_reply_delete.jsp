<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String replynum=request.getParameter("replynum");
	
	ReplyDAO dao=new ReplyDAO();
	dao.deleteReply(replynum);
%>