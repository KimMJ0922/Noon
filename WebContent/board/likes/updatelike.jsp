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
	String id="aaa";
	BoardLikesDTO bldto = new BoardLikesDTO();
	BoardLikesDAO bldao = new BoardLikesDAO();
	bldto.setId(id);
	bldto.setNum(num);
	bldao.insertLike(bldto);
%>
<%=likecnt%>