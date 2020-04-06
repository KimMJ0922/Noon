<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 쿠키값 가져오기
    Cookie[] cookies = request.getCookies() ;
	String cValue ="";
    if(cookies != null){
        for(int i=0; i < cookies.length; i++){
            Cookie c = cookies[i] ;
            // 저장된 쿠키 이름을 가져온다
            String cName = c.getName();
            // 쿠키값을 가져온다
            if(cName.equals("maxrow")){
            	 cValue = c.getValue() ;
            	 break;
            }else{
            	 cValue = "10" ;
            }
        }
    }
%>
<%=cValue%>