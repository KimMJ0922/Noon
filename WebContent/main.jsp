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
<title>Noon</title>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css폴더 안에 있는 파일 목록 -->
<link rel= "stylesheet" type="text/css" href="css/bootstrap.min.css">

<style>
.row>.boardlist {
	background: #DBDBDB;
	border: 1px solid #000;
}
.topmain{
	width:100%;
	background-color: #FAFAFA;
	max-height: 120px;
	border-bottom: 1px solid #DBDBDB;
}
</style>
</head>
<%
	String id = (String)session.getAttribute("id");
	String loginok = (String)session.getAttribute("loginok");
	if(loginok==null){
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
	<div class="container topmain" style="padding:0; margin:0;">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12 ">
				<jsp:include page="top/topmenu.jsp"/>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
<%
			if(view.indexOf("board_Detail_form.jsp")!=0){
%>
				<jsp:include page="<%=view %>" />
<%
			}else{
%>
				<div class="col-md-12 col-sm-12 col-xs-12 boardlist">
					<jsp:include page="<%=view %>" />
				</div>
<%
			}
%>
		</div>
	</div>
	<div>
		<jsp:include page="footer/footer.jsp" />
	</div>
</body>
</html>