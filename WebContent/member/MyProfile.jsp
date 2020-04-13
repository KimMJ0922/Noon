<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<!-- <link rel= "stylesheet" type="text/css" href="../css/top/topmenu.css"> -->
<link rel= "stylesheet" type="text/css" href="member/style.css">
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.0.10/css/all.css'>
<!-- <link rel= "stylesheet" type="text/css" href="../css/bootstrap.min.css">  -->
<!-- <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'> -->

<!--  <script src="https://code.jquery.com/jquery-1.10.2.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 -->
 
 <script src="member/script.js"></script>
<style>
.topmain{
	width:100%;
	background-color: #FAFAFA;
	max-height: 120px;
	border-bottom: 1px solid #DBDBDB;
}
.content{
	display:block;
}
</style>
</head>
<script type="text/javascript">
	function getData(){
		<%
		String id = (String)session.getAttribute("id");
		MemberDao db = new MemberDao();
		MemberDto dto = db.getdata(id);
		String Path = getServletContext().getRealPath("/profile/"+id);
		%>
	}
	
	function logincheck(){
		<%
		String loginok = (String)session.getAttribute("loginok");
		if(loginok==null){%>
			alert("로그인이 필요한 서비스 입니다.");
			location.replace("../login/noonlogin.jsp");
		<%}	%>
	}
</script>
<body>
<%
	String content = request.getParameter("content");
	System.out.println(content);
	if(content==null||content.equals("")){
		content = "main.jsp?view=member/Myprofile.jsp&content=profile.jsp";
	}
%>
	<div class="container">
		<nav class="custom-nav">
			<a href="main.jsp?view=member/MyProfile.jsp&content=profile.jsp"><i class="fa fa-user"> 계정설정</i></a> 
			<a href="main.jsp?view=member/MyProfile.jsp?content=boardlist/memberboardlist.jsp"><i class="fa fa-credit-card"> 게시물</i></a> 
			<a href="main.jsp?view=member/MyProfile.jsp?content=test2.jsp"><i class="fa fa-tv"> 팔로워</i></a> 
			<a href="main.jsp?view=member/MyProfile.jsp?content=test2.jsp"><i class="fa fa-cog"> 회원탈퇴</i></a>
		</nav>
	</div>
	<div>
		<jsp:include page="<%=content %>"/>
	</div>
		
</body>
</html>