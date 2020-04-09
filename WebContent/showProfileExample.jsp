<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery 필수 부트스트랩 css, js 필수
부트스트랩 jquery있으면 profile.css, UserProfile.js만 경로에 맞게 넣기 -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script	src='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'></script>
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>
<script type="text/javascript" src="js/UserProfile.js"></script>
<link rel="stylesheet" href="css/member/profile.css">
</head>
<body>
	<!-- 링크에 showProfile 클래스 입력시 UserProfile.js의 함수가 실행됨 -->
	<a class="showProfile">testId</a>
	<a class="showProfile">qweqwe</a>
	<a class="showProfile">123</a>
	<a class="showProfile">admin</a>
	<!-- 모달창이 들어갈 div -->
	<div class="profileModal"></div>
</body>
</html>