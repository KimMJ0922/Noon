<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 특정 쿠키만 삭제하기
    Cookie kc = new Cookie("maxrow", null) ;
    kc.setMaxAge(0) ;
    response.addCookie(kc) ;
 
 
%>