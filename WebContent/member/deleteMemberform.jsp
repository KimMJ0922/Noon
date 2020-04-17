<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
	<div style="text-align: -webkit-center; padding-top: 100px;">
		<h1 class="font1" style="font-size: 10pt">회원탈퇴</h1>
		<h3>정말로 탈퇴 하시겠습니까?</h3>
		
		<label id="password" style="display: block;">비밀번호</label> <input
			type="password" id="deletePass" class="form-control"
			style="margin-bottom: 10px; width: 300px">
		<button type="button" class="btn btn-primary" onclick="deleteMember()">탈퇴</button>
		<button type="button" class="btn btn-default">취소</button>
	</div>
</body>
</html>