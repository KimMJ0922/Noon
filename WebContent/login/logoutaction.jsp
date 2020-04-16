<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idcheck = (String)session.getAttribute("idcheck");
	if(idcheck !=null && idcheck.equals("no")){
		session.removeAttribute("idcheck");
	}
	session.removeAttribute("loginok");
	session.removeAttribute("dto");
	session.removeAttribute("dark_check");
    Cookie c = new Cookie("sort", null) ;

    // 쿠키 유효기간을 설정한다. 초단위 : 60*60*24= 1일
    c.setMaxAge(60*60*24) ;
     
    // 응답헤더에 쿠키를 추가한다.
    response.addCookie(c) ;
%>
<script>
	location.replace("noonlogin.jsp");
</script>