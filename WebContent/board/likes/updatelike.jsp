<%@page import="member.MemberDto"%>
<%@page import="board.BoardLikesDAO"%>
<%@page import="board.BoardLikesDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	int likes = Integer.parseInt(request.getParameter("likes"));
	BoardDAO dao = new BoardDAO();
	int likecnt = dao.updateLikes(num,likes);
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String id = mdto.getId();
	System.out.println(id);
	
	BoardLikesDTO bldto = new BoardLikesDTO();
	BoardLikesDAO bldao = new BoardLikesDAO();
	bldto.setId(id);
	bldto.setNum(num);
	bldao.insertLike(bldto,likes);
%>
<%=likecnt%>