<%@page import="board.BoardDAO"%>
<%@page import="history.HistoryDAO"%>
<%@page import="reply.ReplyDAO"%>
<%@page import="reply.ReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = (String)session.getAttribute("id");
	String boardnum = request.getParameter("boardnum");
	String content = request.getParameter("content");
	
	ReplyDTO dto = new ReplyDTO();
	dto.setBoardnum(boardnum);
	dto.setContent(content);
	dto.setName(name);
	
	ReplyDAO dao = new ReplyDAO();
	dao.insertReply(dto);
	
	HistoryDAO hdao = new HistoryDAO();
	BoardDAO bdao = new BoardDAO();
	String action = "reply";
	String toid = bdao.getBoardWriter(boardnum);
	if(!name.equals(toid)){
		hdao.insertHistory(boardnum, name, toid, action);
	}
	
	
%>