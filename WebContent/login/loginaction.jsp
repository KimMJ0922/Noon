<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String idcheck[] = request.getParameterValues("idcheck");
	//테이블 검색
	MemberDao db = new MemberDao();
	boolean success = db.login(id, pass);
	MemberDto dto = db.getdata(id);
	System.out.println("로그인 했을 때 "+dto.getName());
	if(success==true){
		//if success grant session 
		session.setAttribute("id", id);
		session.setAttribute("loginok", "ok");
		session.setAttribute("dto", dto);
		session.setAttribute("dark_check", "0");
		if(idcheck!=null)
			session.setAttribute("idcheck", "yes");
		else
			session.setAttribute("idcheck", "no");
		session.setMaxInactiveInterval(60*60*24);
		Cookie c = new Cookie("sort", null) ;

	    // 쿠키 유효기간을 설정한다. 초단위 : 60*60*24= 1일
	    c.setMaxAge(60*60*24) ;
	     
	    // 응답헤더에 쿠키를 추가한다.
	    response.addCookie(c) ;
		response.sendRedirect("../main.jsp");
	}else{%>
		<script>
			alert("일치하는 회원 정보가 없습니다.");
			history.back();
		</script>
	<%}
%>