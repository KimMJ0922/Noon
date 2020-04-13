<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String replynum = request.getParameter("replynum");
	String boardnum = request.getParameter("boardnum");
	ReplyDAO dao=new ReplyDAO();
	dao.deleteReply(replynum, boardnum);
%>