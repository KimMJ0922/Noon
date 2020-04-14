<%@page import="member.MemberDto"%>
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
<body>
<%
	String content = request.getParameter("content");
	System.out.println(content);
	if(content==null||content.equals("")){
		content = "main.jsp?view=member/Myprofile.jsp&content=profile.jsp";
	}
	MemberDto dto1 = (MemberDto)session.getAttribute("dto");

	String id = request.getParameter("id");
	if(id==null||id.equals("")){
		id = dto1.getId();
	}
%>
	<nav class="custom-nav">
		<a href="main.jsp?view=member/MyProfile.jsp&content=profile.jsp&id=<%=id%>">
			<i class="fa fa-user"> 계정설정</i>
		</a>
		<a href="main.jsp?view=member/MyProfile.jsp&content=boardlist/memberboardlist.jsp&id=<%=id%>">
			<i class="fa fa-credit-card"> 게시물</i>
		</a> 
		<a href="main.jsp?view=member/MyProfile.jsp&content=follower.jsp&id=<%=id%>">
			<i class="fa fa-tv"> 팔로워</i>
		</a> 
<%
		if(id.equals(dto1.getId())){
%>
		<a href="main.jsp?view=member/MyProfile.jsp&content=deleteMemberform.jsp">
			<i class="fa fa-cog"> 회원탈퇴</i>
		</a>
<%
		}
%>
	</nav>
	<div style="min-height: 550px;">
		<jsp:include page="<%=content %>">
			<jsp:param value="<%=id %>" name="id"/>
		</jsp:include>
	</div>
		
</body>
</html>