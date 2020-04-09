<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Montserrat+Subrayada&display=swap" rel="stylesheet">
<link rel= "stylesheet" type="text/css" href="css/top/topmenu.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String id = (String)session.getAttribute("id");
%>
<body>
	<div class="container" style="width: 100%;">
		<div class="row">
			<div class="col-md-3 col-sm-6 col-xs-6 topcontent">
				<P><a href="main.jsp">NOON</a></P>
			</div>
			<div class="col-md-6 hidden-sm hidden-xs topcontent">
				<input type="text" name="searchtag" class="searchtag">
			</div>
			<div class="col-md-3 col-sm-6 col-xs-6 topcontent">
				<div class="row">
					<div class="col-md-3 col-sm-4 col-xs-6 myinfo">
						<img src="img/member/logo.jpg" alt="프로필 사진">
					</div>
					<div class="col-md-9 col-sm-8 col-xs-6 myinfo">
								<!--	아이디	 -->
						<div class="col-md-12 col-sm-12 col-xs-12 myinfolist myinfolistid" id="loginid">
							<%=id %>
								<a href="#" id="logout" class="toplogout">로그아웃</a>
						</div>
								<!--	좋아요 게시글 팔로워	 -->
						<div class="col-md-12 col-sm-12 hidden-xs myinfolist myinfolist">
							<span> 좋아요 </span><div class = "vertical"></div>
							<span> 게시글 </span><div class = "vertical"></div>
							<span> 팔로워 </span>
						</div>
								<!--	좋아요 게시글 팔로워 숫자	 -->
						<div class="col-md-12 col-sm-12 hidden-xs myinfolist myinfolistval">
							<span> 14,032 </span>
							<span> 43 </span>
							<span> 348 </span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 		sub top	       -->
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-sm-4 col-xs-4 subtopcontent">1</div>
			<div class="col-md-4 col-sm-4 col-xs-4 subtopcontent">2</div>
			<div class="col-md-4 col-sm-4 col-xs-4 subtopcontent">3</div>
		</div>
	</div>
</body>
</html>