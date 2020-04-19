<%@page import="java.io.FileOutputStream"%>
<%@page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%@page import="member.MemberDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="imgfile.ImgFolderCreate"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String BASE_64_PREFIX = "data:image/png;base64,";
	MemberDao db = new MemberDao();
	String id = (String)session.getAttribute("id");
	
	String createUserFolderPath = getServletContext().getRealPath("/profile/"+id);
	ImgFolderCreate ifc = new ImgFolderCreate();
	ifc.createFolder(createUserFolderPath);
	
	int uploadSize = 1024*1024*2;
	MultipartRequest multi = null;
	try{
		multi = new MultipartRequest(request,createUserFolderPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
		
		String photo = multi.getFilesystemName("photo");
		if(photo==null){
			photo = "null.jpg";
		}
		String path = createUserFolderPath+"\\"+photo;
		String base64 = multi.getParameter("base64");
		Base64 base = new Base64();
		byte[] byteImg = base.decode(base64.substring(BASE_64_PREFIX.length()));
		FileOutputStream fos = null;
		fos = new FileOutputStream(path);
		fos.write(byteImg, 0, byteImg.length);
		fos.close();
		
		db.profilepic(id, photo);
		MemberDto dto = db.getdata(id);
		session.setAttribute("dto", dto);
		response.sendRedirect("../main.jsp?view=member/MyProfile.jsp&content=profile.jsp");
	}catch(Exception e){
		System.out.println("업로드 오류"+e.getMessage());
		e.printStackTrace();
	}
%>