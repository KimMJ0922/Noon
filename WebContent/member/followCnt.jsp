<%@page import="member.MemberFollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	MemberFollowDao db = new MemberFollowDao();
	int followCnt = db.followCnt(id);
	int followerCnt = db.followerCnt(id);
%>
<%="\"followCnt\":"+followCnt+",\"followerCnt\":"+followerCnt%>