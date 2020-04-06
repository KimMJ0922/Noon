<%@page import="imgfile.MoveFile"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String prviewFolderPath = getServletContext().getRealPath("/preview/"+id);
	MoveFile mf = new MoveFile();
	mf.previewFolderDelete(prviewFolderPath);
%>