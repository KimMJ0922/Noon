<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 쿠키값 가져오기
    Cookie[] cookies = request.getCookies() ;
	String maxrow ="10";
	String sort = "";
    if(cookies != null){
        for(int i=0; i < cookies.length; i++){
            Cookie c = cookies[i] ;
            // 저장된 쿠키 이름을 가져온다
            String cName = c.getName();
            // 쿠키값을 가져온다
            if(cName.equals("maxrow")){
				maxrow = c.getValue() ;
            }else if(cName.equals("sort")){
            	sort = c.getValue();
            }
        }
    }
    
    JSONObject ob=new JSONObject();
	ob.put("maxrow",maxrow);
	ob.put("sort",sort);
%>
<%=ob.toString()%>