<%@page import="imgfile.ImgFolderInSearch"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="imgfile.ImgFileDelete"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//클래스 선언
	ImgFileDelete ifd = new ImgFileDelete();
	ImgFolderInSearch fis = new ImgFolderInSearch();
	
	String imgName = request.getParameter("imgName");
	//세션으로 가져올 아이디
	String id = (String)session.getAttribute("id");
	String deleteImgFolderPath = getServletContext().getRealPath("/preview/"+id);
	
	ifd.imgDelete(deleteImgFolderPath, imgName);
	String url=request.getContextPath();
	MultipartRequest multi = null;
	JSONArray arr = new JSONArray();
	try{
		//임시파일로 저장
		List<String> list = fis.searchFolder(deleteImgFolderPath);
		
		//임시 폴더 안에 저장된 파일을 json 형식으로 리턴
		for(String img : list){
			JSONObject ob=new JSONObject();
			ob.put("imgURL",url+"/preview/"+id+"/"+img);
			ob.put("img",img);
			arr.add(ob);
		}

	}catch(Exception e){
		System.out.println(e);
	}
%>
<%=arr.toString() %>