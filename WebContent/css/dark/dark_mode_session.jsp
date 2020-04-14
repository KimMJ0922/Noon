<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String ch = (String)session.getAttribute("dark_check");
	String dark = "0";
	if(ch.equals("0")||ch==null){
		dark = "1";
		session.setAttribute("dark_check", dark);
	}else{
		session.setAttribute("dark_check", dark);
	}

	

%>