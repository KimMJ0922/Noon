<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="imgfile.ImgFolderInSearch"%>
<%@page import="imgfile.ImgFolderCreate"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	ImgFolderCreate fc = new ImgFolderCreate();
	String createpreviewFolderPath = getServletContext().getRealPath("/preview");
	//임시 폴더 없으면 생성
	fc.createFolder(createpreviewFolderPath);
	//임시 폴더 안에 폴더 생성
	
	//폴더 생성 후 검색
	ImgFolderInSearch fis = new ImgFolderInSearch();
	String url=request.getContextPath();
	System.out.println(url);
	//폴더 경로
	String createUserFolderPath = getServletContext().getRealPath("/preview/"+id);
	fc.createFolder(createUserFolderPath);
	
	int uploadSize = 1024*1024*5;
	String imgName = "";
	MultipartRequest multi = null;
	JSONArray arr = new JSONArray();
	try{
		//임시파일로 저장
		multi = new MultipartRequest(request, createUserFolderPath, uploadSize,"utf-8", new DefaultFileRenamePolicy());
		List<String> list = fis.searchFolder(createUserFolderPath);
		
		//임시 폴더 안에 저장된 파일을 json 형식으로 리턴
		for(String img : list){
			JSONObject ob=new JSONObject();
			ob.put("imgURL",url+"/preview/"+id+"\\\\"+img);
			ob.put("img",img);
			arr.add(ob);
		}

	}catch(Exception e){
		System.out.println(e);
	}
%>
<%=arr.toString() %>