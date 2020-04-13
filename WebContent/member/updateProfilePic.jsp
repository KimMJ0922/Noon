<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="imgfile.ImgFolderCreate"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	MemberDao db = new MemberDao();
	String id = (String)session.getAttribute("id");
	
	String createUserFolderPath = getServletContext().getRealPath("/profile/"+id);
	ImgFolderCreate ifc = new ImgFolderCreate();
	ifc.createFolder(createUserFolderPath);
	
	int uploadSize = 1024*1024*2;
	String imgName = "";
	MultipartRequest multi = null;
	try{
		multi = new MultipartRequest(request,createUserFolderPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
		String photo = multi.getFilesystemName("photo");
		
		db.profilepic(id, photo);
		response.sendRedirect("MyProfile.jsp");
	}catch(Exception e){
		System.out.println("업로드 오류"+e.getMessage());
	}
%>