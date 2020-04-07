<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
%>
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


<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- js폴더 안에 있는 파일 목록 -->
<!-- css폴더 안에 있는 파일 목록 -->
<link rel= "stylesheet" type="text/css" href="css/topmenu.css">
<link rel= "stylesheet" type="text/css" href="css/bootstrap.min.css">
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
	String id = (String)session.getAttribute("id");
	if(id==null){
%>
	<script>
		alert("로그인해주세요");
		location.replace("login/noonlogin.jsp");
	</script>
<%
	}
	String view = request.getParameter("view");
	if(view==null)
		view="board/boardlist.jsp";
	System.out.println(view);
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
				<jsp:include page="<%=view %>" />
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