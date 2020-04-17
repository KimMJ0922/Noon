<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정</title>
<link rel= "stylesheet" type="text/css" href="css/member/MyProfilestyle.css">
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.0.10/css/all.css'>
<link href="https://fonts.googleapis.com/css?family=Gothic+A1|Noto+Sans+KR&display=swap" rel="stylesheet">
  <%
  	String dark="";
  	dark=(String)session.getAttribute("dark_check");
  	if(dark.equals("0")){
  		
  	}else if(dark.equals("1")){
  	%>
  	  <link rel="stylesheet" href="css/member/MyProfile_dark.css" />
  	<%	
  	}
  	%>
 <script src="js/member/MyProfilescript.js"></script>
 <script src="js/member/followList.js"></script>
</head>
<body>
<%
	String content = request.getParameter("content");
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
		<a href="main.jsp?view=member/MyProfile.jsp&content=../board/boardlist.jsp&id=<%=id%>">
			<i class="fa fa-credit-card"> 게시물</i>
		</a> 
		<%if(dto1.getType().equals("관리자")&&id.equals(dto1.getId())){ %>
		<a href="main.jsp?view=member/MyProfile.jsp&content=admin_content.jsp">
			<i class="fa fa-tv"> 회원관리</i>
		</a> 
<%
		}else{
			
		if(id.equals(dto1.getId())){
%>
		<a href="main.jsp?view=member/MyProfile.jsp&content=deleteMemberform.jsp">
			<i class="fa fa-cog"> 회원탈퇴</i>
		</a>
<%
		}
	} 
%>
		<a href="main.jsp?view=member/MyProfile.jsp&content=follower.jsp&id=<%=id%>">
			<i class="fa fa-tv"> 팔로워</i>
		</a> 

	</nav>
	<div id="view" style="min-height: 550px; visibility: hidden; height: 500px">
		<jsp:include page="<%=content %>">
			<jsp:param value="<%=id %>" name="id"/>
		</jsp:include>
	</div>
</body>
</html>