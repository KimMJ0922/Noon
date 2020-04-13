<%@page import="member.MemberFollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String fromid = request.getParameter("fromid");
	String toid = request.getParameter("toid");
	MemberFollowDao db = new MemberFollowDao();
	boolean followed = db.followed(fromid, toid);
%>
<%=followed%>