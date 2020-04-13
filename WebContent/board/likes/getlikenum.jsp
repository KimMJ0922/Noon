<%@page import="board.BoardLikesDAO"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	MemberDto dto = (MemberDto)session.getAttribute("dto");
	
	String id = dto.getId();
	
	BoardLikesDAO bldao = new BoardLikesDAO();
	String likecnt = bldao.getLikeNum(num);
%>
<%=likecnt%>