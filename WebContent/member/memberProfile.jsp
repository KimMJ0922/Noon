<%@page import="member.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel= "stylesheet" type="text/css" href="../css/topmenu.css">
<link rel= "stylesheet" type="text/css" href="../css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function(){
		
	});
</script>
<style>
.topmain{
	width:100%;
	background-color: #FAFAFA;
	max-height: 120px;
	border-bottom: 1px solid #DBDBDB;
}
</style>
</head>
<%
	String loginok = (String)session.getAttribute("loginok");
	String id = (String)session.getAttribute("id");
	if(loginok==null){%>
		<script type="text/javascript">
			alert("로그인이 필요한 서비스 입니다.");
			location.replace("../login/noonlogin.jsp");
		</script>
	<%}
	MemberDao db = new MemberDao();
	List<MemberDto> list = db.getdata(id);
%>
<body>
	<div class="topmain" style="padding:0; margin:0;">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-sm-12 ">
				<jsp:include page="../top/topmenu.jsp"/>
			</div>
		</div>
	</div>
	<div class="container">
		<table class="table table-straped table-bordered">
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>휴대전화</th>
					<th>이메일</th>
					<th>주소</th>
					<th>상세주소</th>
					<th>가입일</th>
					<th>회원유형</th>
					<th>프로필사진</th>
				</tr>
			</thead>
			<tbody>
			<%for(MemberDto dto : list){
				%>
				<tr>
					<td><%=dto.getNum() %></td>
					<td><%=dto.getName() %></td>
					<td><%=dto.getId() %></td>
					<td><%=dto.getPass() %></td>
					<td><%=dto.getHp1() %>-<%=dto.getHp2() %>-<%=dto.getHp3() %></td>
					<td><%=dto.getEmail1() %>@<%=dto.getEmail2() %></td>
					<td><%=dto.getAddr1() %></td>
					<td><%=dto.getAddr2() %></td>
					<td><%=dto.getSignupday() %></td>
					<td><%=dto.getType() %></td>
					<td><%=dto.getSignupday() %></td>
				</tr>
			<%}%>
			</tbody>
		</table>
	</div>
</body>
</html>