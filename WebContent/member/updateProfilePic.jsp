<%@page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.FileWriter"%>
<%@page import="member.MemberDto"%>
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
	MultipartRequest multi = null;
	try{
		multi = new MultipartRequest(request,createUserFolderPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());
		
		String base64 = multi.getParameter("base64");
		Base64 base = new Base64();
		byte[] byteImg = base.decode(base64);
		ByteArrayInputStream bis = new ByteArrayInputStream(byteImg);
		BufferedImage image=ImageIO.read(bis);
		bis.close();
		String format = multi.getFilesystemName("photo");
		format = format.substring(format.length()-3,format.length());
		ImageIO.write(image, format, multi.getFile("photo"));
		
		String photo = multi.getFilesystemName("photo");
		
		db.profilepic(id, photo);
		MemberDto dto = db.getdata(id);
		session.setAttribute("dto", dto);
		response.sendRedirect("../main.jsp?view=member/MyProfile.jsp&content=profile.jsp");
	}catch(Exception e){
		System.out.println("업로드 오류"+e.getMessage());
		e.printStackTrace();
	}
%>