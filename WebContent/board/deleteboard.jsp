<%@page import="member.MemberDto"%>
<%@page import="java.util.Vector"%>
<%@page import="imgfile.ImgFileDelete"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardImgDTO"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	BoardDAO dao = new BoardDAO();
	BoardImgDAO imgdao = new BoardImgDAO();
	ImgFileDelete ifd = new ImgFileDelete();
	
	List<String> list = imgdao.getNumImglist(num);
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String id = mdto.getId();
	
	String folderPath = getServletContext().getRealPath("/save/"+id); //폴더 경로
	//삭제하는 글에 이미지 파일이 있는 경우
	if(list.size()!=0){
		//파일 이름만 잘라서 다시 list에 넣기
		for(int i=0;i<list.size();i++){
			String fileName = list.get(i);
			fileName = fileName.substring(id.length()+1,fileName.length());
			list.set(i,fileName);
		}
		
		ifd.boardImgDelete(folderPath,list);
	}
	dao.deleteBoard(num);
%>