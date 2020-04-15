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
<script type="text/javascript" src="member/followList.js"></script>
<link rel="stylesheet" href="css/member/profile.css">
<script type="text/javascript">
</script>
</head>
<body>
	<div class="row">
		<div class="col-md-6">
			<h2>팔로우</h2>
		</div> 
		<div class="col-md-6">
			<h2>팔로워</h2>
		</div>
		<div class="col-md-6 followed" style="float: left; height: 550px; overflow: scroll; overflow-x: hidden;">
			
		</div>
		<div class="col-md-6 follower" style="float: left; height: 550px; overflow: scroll; overflow-x: hidden;">
			
		</div>
	</div>
	<!-- 모달창이 들어갈 div -->
	<div class="profileModal"></div>
</body>
</html>