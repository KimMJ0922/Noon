<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String idcheck[] = request.getParameterValues("idcheck");
	System.out.println("idcheck : "+idcheck);
	//searchTable
	MemberDao db = new MemberDao();
	boolean success = db.login(id, pass);
	if(success==true){
		//if success grant session 
		session.setAttribute("id", id);
		session.setAttribute("loginok", "ok");
		if(idcheck!=null)
			session.setAttribute("idcheck", "yes");
		else
			session.setAttribute("idcheck", "no");
		session.setMaxInactiveInterval(60*60*24);
		response.sendRedirect("../main.jsp");
	}else{%>
		<script>
			alert("일치하는 회원 정보가 없습니다.");
			history.back();
		</script>
	<%}
%>