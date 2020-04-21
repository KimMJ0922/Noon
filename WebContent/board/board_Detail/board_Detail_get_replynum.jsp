<%@page import="org.json.simple.JSONObject"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String boardnum = request.getParameter("boardnum");
	ReplyDAO dao = new ReplyDAO();
	String replynum = dao.getReplyCount(boardnum);
	JSONObject ob=new JSONObject();
	ob.put("replynum",replynum);
%>
<%=ob.toString()%>