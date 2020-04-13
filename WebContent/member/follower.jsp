<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script	src='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'></script>
<script type="text/javascript" src="js/UserProfile.js"></script>
<link rel="stylesheet" href="css/member/profile.css">
</head>
<body>
	<div class="list" style="margin-top: 100px;">
		<!-- 링크에 showProfile 클래스 입력시 UserProfile.js의 함수가 실행됨 -->
		<a class="showProfile" style="cursor: pointer;">id01</a>
		<a class="showProfile" style="cursor: pointer;">id02</a>
		<a class="showProfile" style="cursor: pointer;">admin</a>
	</div>
	<!-- 모달창이 들어갈 div -->
	<div class="profileModal"></div>
</body>
</html>