<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String maxrow = request.getParameter("maxrow");
	String sort = request.getParameter("sort");
	
    // 회원번호를 쿠키에 지정한다
    Cookie c = new Cookie("maxrow", maxrow) ;
    // 쿠키에 설명을 추가한다
    c.setComment("마지막 행") ;
    // 쿠키 유효기간을 설정한다. 초단위 : 60*60*24= 1일
    c.setMaxAge(60*60*24) ;
    // 응답헤더에 쿠키를 추가한다.
    response.addCookie(c) ;
    
    Cookie sortcookie = new Cookie("sort", sort);
    // 쿠키에 설명을 추가한다
    sortcookie.setComment("정렬") ;
    // 쿠키 유효기간을 설정한다. 초단위 : 60*60*24= 1일
    sortcookie.setMaxAge(60*60*24) ;
    // 응답헤더에 쿠키를 추가한다.
    response.addCookie(sortcookie) ;
%>