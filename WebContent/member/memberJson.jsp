<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	MemberDao db = new MemberDao();
	MemberDto dto = db.getdata(id);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	JSONObject ob = new JSONObject();
	ob.put("addr1", dto.getAddr1());
	ob.put("addr2", dto.getAddr2());
	ob.put("email", dto.getEmail1()+"@"+dto.getEmail2());
	ob.put("hp", dto.getHp1()+"-"+dto.getHp2()+"-"+dto.getHp3());
	ob.put("id", dto.getId());
	ob.put("name", dto.getName());
	ob.put("num", dto.getNum());
	ob.put("pic", dto.getPic());
%>
<%=ob.toString()%>