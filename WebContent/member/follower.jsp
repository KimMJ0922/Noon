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
<script type="text/javascript" src="js/member/followList.js"></script>
<link rel="stylesheet" href="css/member/profile.css">
<script type="text/javascript">
</script>
</head>
<%
	String id = request.getParameter("id");
	MemberDto dto = new MemberDto();
	if(id==null||id.equals("")){
		id = dto.getId();
	}
%>
<body>
	<div class="row">
		<div class="col-md-5">
			<h2 style="margin-left: 90px;">FOLLOW</h2>
		</div> 
		<div class="col-md-5">
			<h2 style="margin-left: 170px;">FOLLOWER</h2>
		</div>
	</div>
	<div class="row">
		<div class="col-md-5 followed" style="float: left; height: 550px; overflow: auto; overflow-x: hidden;margin-left: 80px;">
			
		</div>
		<div class="col-md-5 follower" style="float: left; height: 550px; overflow: auto; overflow-x: hidden;margin-left: 80px;">
			
		</div>
	</div>
	<input type="hidden" id="searchId" value="<%=id%>">
</body>
</html>