<%@page import="reply.ReplyDAO"%>
<%@page import="reply.ReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = (String)session.getAttribute("id");
	String boardnum = request.getParameter("boardnum");
	String content = request.getParameter("content");
	String replynum = request.getParameter("replynum");
	
	System.out.println(boardnum);
	
	
	ReplyDTO dto = new ReplyDTO();
	dto.setBoardnum(boardnum);
	dto.setContent(content);
	dto.setReplynum(replynum);
	dto.setName(name);
	
	ReplyDAO dao = new ReplyDAO();
	dao.insertReply_re(dto);
%>