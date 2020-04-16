<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id=request.getParameter("id");
	String type=request.getParameter("type");
	MemberDao dao=new MemberDao();
	
	if(type.equals("일반회원")){
		type="우수회원";
		dao.updateType(id, type);
	}else if(type.equals("우수회원")){
		type="관리자";
		dao.updateType(id, type);
	}else if(type.equals("관리자")){
		%>
		<script>
		alert("관리자 이상은 올라갈수 없습니다.");
		</script>
		<%
	}

	
%>