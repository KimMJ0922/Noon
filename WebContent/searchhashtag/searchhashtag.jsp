<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="js/searchhashtag/searchhashtag.js"></script>
<link rel= "stylesheet" type="text/css" href="css/board/boardlist.css">
<body>
<%
	String search = request.getParameter("search");
	if(search==null){
		search = "";
	}
%>
	<input type="hidden" id="searchtext" value="<%=search%>">
	<div id="searchboardlist">
		
	</div>
</body>
</html>