<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<link rel= "stylesheet" type="text/css" href="member/style.css">
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.0.10/css/all.css'>
 
 <script src="member/script.js"></script>
<style>
.topmain{
	width:100%;
	background-color: #FAFAFA;
	max-height: 120px;
	border-bottom: 1px solid #DBDBDB;
}
</style>
</head>
<%
	String content = request.getParameter("content");
	if(content==null || content.equals("")){
		content="profile.jsp";
	}
%>
<body>
	<div class="container">
		<nav class="custom-nav">
			<a href="main.jsp?view=member/MyProfile.jsp&content=profile.jsp"><i class="fa fa-user"> 계정설정</i></a> 
			<a href="main.jsp?view=member/MyProfile.jsp&content=test1.jsp"><i class="fa fa-credit-card"> 게시물</i></a> 
			<a href="main.jsp?view=member/MyProfile.jsp&content=test2.jsp"><i class="fa fa-tv"> 팔로워</i></a> 
			<a href="main.jsp?view=member/MyProfile.jsp&content=test3.jsp"><i class="fa fa-cog"> 회원탈퇴</i></a>
		</nav>
		
		
		<div>
			<jsp:include page="<%=content %>"></jsp:include>
		</div>
</body>
</html>