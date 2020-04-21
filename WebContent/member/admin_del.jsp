<%@page import="board.BoardDAO"%>
<%@page import="imgfile.ImgFileDelete"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id=request.getParameter("id");
	
	
	ImgFileDelete ifd = new ImgFileDelete();
	String userFolderPath = getServletContext().getRealPath("/save/"+id); //폴더 경로
	String prviewFolderPath = getServletContext().getRealPath("/preview/"+id); //폴더 경로
	ifd.userImgFileDelete(prviewFolderPath, userFolderPath);
	BoardDAO bdao = new BoardDAO();
	bdao.memberOutUpdate();
	
	
	MemberDao dao=new MemberDao();
	dao.admindelete(id);
%>