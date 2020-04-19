<%@page import="member.MemberDao"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDto dto = new MemberDto();
	MemberDao dao = new MemberDao();
	String ids ="";
	String passs ="";
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String pass = request.getParameter("pass");
	//pass 가 null일경우 pass 찾는 메소드(findPwd) 실행
	if(pass==null || pass==""){
		passs = dao.findPwd(id, email);
		%><%=passs%><%
	}else {
	//id 가 null일경우 id 찾는 메소드(findId) 실행
		ids=dao.findId(pass, email);
		%><%=ids%><%
	}
	
%>

