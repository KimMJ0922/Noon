<%@page import="member.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberFollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String fromid = request.getParameter("id");

	
			
	MemberFollowDao db = new MemberFollowDao();
	List<MemberDto> list = db.followingFriend(fromid);
	if(list.size()==0){%>
		<div>
			<h2>팔로우 구걸 좀 해라!</h2>
		</div>
	<%}
	for(MemberDto dto : list){
		String imgsrc = "profile/"+dto.getId()+"/"+dto.getPic();
		if(dto.getPic()==null || dto.getPic().equals("")){
			imgsrc = "profile/default.png";
		}
		boolean followed = db.followed(fromid, dto.getId());
	%>
		<div>
			<div class="col-md-12 col-sm-4 col-xs-6 propic">
				<img src="<%=imgsrc%>" class="followpic" alt="프로필사진">
				<a class="showProfile" class="followname"><%=dto.getName() %>(<%=dto.getId() %>)</a>
				<%if(followed==true){ %>
					<a fromid='<%=fromid %>' toid='<%=dto.getId() %>' class='pro-btn following' id="fbtn">언팔로우</a>
				<%}else{ %>
					<a fromid='<%=fromid %>' toid='<%=dto.getId() %>' class='pro-btn follow' id="fbtn">팔로우</a>
				<%} %>
			</div>
		</div>
	<%}
%>