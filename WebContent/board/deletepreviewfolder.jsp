<%@page import="imgfile.MoveFile"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = "aaa";
	String prviewFolderPath = getServletContext().getRealPath("/preview/"+id);
	MoveFile mf = new MoveFile();
	mf.previewFolderDelete(prviewFolderPath);
%>