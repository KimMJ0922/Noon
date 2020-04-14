<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<script src="js/member/boardlist/memberboardlist.js"></script>
<link rel="stylesheet" href="css/member/boardlist/memberboardlist.css">
</head>
<body>
<%
	MemberDto dto1 = (MemberDto)session.getAttribute("dto");
	
	String id = request.getParameter("id");
%>
	<input type="text" id="getId" value="<%=id%>">

	<div id="memberboardlist" >
	
	</div>

	
</body>
</html>