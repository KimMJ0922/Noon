<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="../js/jquery.form.js"></script>
<script src="../js/boardlist.js"></script>
<link rel= "stylesheet" type="text/css" href="../css/boardlist.css">
</head>
<body>
	<div>
		<button type="button" id="logout">로그아웃</button>
		<button type="button" id="writebtn">글쓰기</button>
		<button type="button" id="hsbtn">알림</button>
		<input type="text" id="searchtext" name="searchtext">
	</div>
	<div id="history">
	
	</div>
	<div id="list"></div>
</body>
</html>