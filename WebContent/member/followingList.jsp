<%@page import="member.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberFollowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String fromid = (String)session.getAttribute("id");
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
				<img src="<%=imgsrc%>" alt="프로필사진" style="margin: 10px;width: 100px;height: 100px; border-radius: 50px;">
				<a class="showProfile" style="cursor: pointer; line-height: 100px; margin-left: 5px; font-size: 14pt;"><%=dto.getName() %>(<%=dto.getId() %>)</a>
				<%if(followed==true){ %>
					<a fromid='<%=fromid %>' toid='<%=dto.getId() %>' class='pro-btn following' style='cursor: pointer; float: right;margin-top: 38px;'>언팔로우</a>
				<%}else{ %>
					<a fromid='<%=fromid %>' toid='<%=dto.getId() %>' class='pro-btn follow' style='cursor: pointer; float: right;margin-top: 38px;'>팔로우</a>
				<%} %>
			</div>
		</div>
	<%}
%>