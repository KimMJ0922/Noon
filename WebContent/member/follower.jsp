<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script	src='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'></script>
<!-- <script type="text/javascript" src="js/UserProfile.js"></script> -->
<script type="text/javascript" src="member/followedList.js"></script>
<link rel="stylesheet" href="css/member/profile.css">
</head>
<%
	MemberDto dto = (MemberDto)session.getAttribute("dto");
	String id = dto.getId();
	String imgsrc = "profile/"+id+"/"+dto.getPic();
	if(dto.getPic()==null || dto.getPic().equals("")){
		imgsrc = "profile/default.png";
	}
%>
<body>
	<!-- <div class="list" style="margin-top: 100px;">
		링크에 showProfile 클래스 입력시 UserProfile.js의 함수가 실행됨
		<a class="showProfile" style="cursor: pointer;">id01</a>
		<a class="showProfile" style="cursor: pointer;">id02</a>
		<a class="showProfile" style="cursor: pointer;">admin</a>
	</div> -->
	<div class="row">
		<div class="col-md-6">
			<h2>내가 팔로우 하는 친구</h2>
		</div> 
		<div class="col-md-6">
			<h2>나를 팔로우 하는 친구</h2>
		</div>
		<div class="col-md-6 followed" style="border: 1px solid black; float: left;">
			
		</div>
		<div class="col-md-6 following" style="border: 1px solid black">
			<div class="col-md-3 col-sm-4 col-xs-6 myinfo">
				<img src="<%=imgsrc%>" alt="프로필사진" style="margin: 10px;">
			</div>
			<a class="showProfile" style="cursor: pointer; line-height: 98px;">id01</a>
		</div>
	</div>
	<!-- 모달창이 들어갈 div -->
	<div class="profileModal"></div>
</body>
</html>