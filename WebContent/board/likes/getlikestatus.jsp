<%@page import="member.MemberDto"%>
<%@page import="board.BoardLikesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	MemberDto dto = (MemberDto)session.getAttribute("dto");
	String id = dto.getId();
	String num = request.getParameter("num");
	
	BoardLikesDAO bldao = new BoardLikesDAO();
	
	String likeStatus = bldao.getLikeStatus(num, id);
%>
<%=likeStatus %>