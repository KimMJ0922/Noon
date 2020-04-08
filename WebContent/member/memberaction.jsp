<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="db" class="member.MemberDao"></jsp:useBean>
<jsp:useBean id="dto" class="member.MemberDto"></jsp:useBean>

<jsp:setProperty property="*" name="dto"/>
<%
	db.insertMember(dto);
%>
<script>
	location.replace("../login/noonlogin.jsp");
</script>