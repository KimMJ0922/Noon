<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="js/member/admin.js"></script>
</head>
<%
	MemberDto dto = (MemberDto)session.getAttribute("dto");
	String type = dto.getType();
	if(!type.equals("관리자")){
%>
		<script>
			alert("권한이 없습니다.");
			location.replace(history.back());
		</script>
<%
	}else{
		String dark = (String)session.getAttribute("dark_check");
	
%>
	<body>
		<div class="search_admin">
			<input type="text" style="border-radius: 5px;color:black" id="searchId" placeholder="검색할 아이디 입력">
		</div>
		<div class="admin_content">
	
		</div>
	</body>
<%
	}
%>
</html>