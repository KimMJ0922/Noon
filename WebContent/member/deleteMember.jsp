<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDto"%>
<%@page import="imgfile.ImgFileDelete"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pass = request.getParameter("pass");
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String id = mdto.getId();
	
	ImgFileDelete ifd = new ImgFileDelete();
	String userFolderPath = getServletContext().getRealPath("/save/"+id); //폴더 경로
	String prviewFolderPath = getServletContext().getRealPath("/preview/"+id); //폴더 경로
	ifd.userImgFileDelete(prviewFolderPath, userFolderPath);
	BoardDAO bdao = new BoardDAO();
	bdao.memberOutUpdate();
	boolean bool = false;
	
	MemberDao db = new MemberDao();
	boolean success = db.login(id, pass);
	
	if(success == true){
		db.deleteMember(id);
		session.removeAttribute("loginok");
		session.removeAttribute("dto");
		session.removeAttribute("idcheck");
		bool = true;
	}else{
		bool = false;
	}
%>
<%=bool%>