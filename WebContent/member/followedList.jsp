<%@page import="member.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberFollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String fromid = (String)session.getAttribute("id");
	MemberFollowDao db = new MemberFollowDao();
	List<MemberDto> list = db.followedFriend(fromid);
	if(list.size()==0){%>
		<div>
			<h2>팔로우 좀 해라!</h2>
		</div>
	<%}
	for(MemberDto dto : list){
		String imgsrc = "profile/"+dto.getId()+"/"+dto.getPic();
		if(dto.getPic()==null || dto.getPic().equals("")){
			imgsrc = "profile/default.png";
		}	
	%>
		<div>
			<div class="col-md-12 col-sm-4 col-xs-6 propic">
				<img src="<%=imgsrc%>" class="followpic" alt="프로필사진">
				<a class="showProfile" class="followname"><%=dto.getName() %>(<%=dto.getId() %>)</a>
				<a fromid='<%=fromid %>' toid='<%=dto.getId() %>' class='pro-btn following fbtn'>언팔로우</a>
			</div>
		</div>
	<%}
%>