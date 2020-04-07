<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부트스트랩 101 템플릿</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link rel= "stylesheet" type="text/css" href="css/boardlist.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel= "stylesheet" type="text/css" href="css/topmenu.css">
<style>
.row>.content {
	background: #DBDBDB;
	border: 1px solid #000;
}
.topmenu{
	width: 100%;
	height: 120px;
	background-color: black;
}
.test1 {
	height: 100px;
}
</style>
</head>
<%
	String board= request.getParameter("main");
	if(board==null)
		board="board/boardlist.jsp";
%>
<body>
<div class="container" >
	<div class="row">
		<div class="col-md-12 col-sm-12 hidden-xs ">
			<jsp:include page="top/topmenu.jsp"/>
		</div>
	</div>
</div>
<div class="container">
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12 content">
			<jsp:include page="<%=board %>" />
		</div>
	</div>
</div>
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
<!-- <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<!-- <script src="../js/bootstrap.min.js"></script> -->
</body>
</html>