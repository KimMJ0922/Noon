<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel= "stylesheet" type="text/css" href="css/board/boardlist.css">
<script type="text/javascript" src="js/board/onhashchange.js"></script>
<script type="text/javascript" src="js/board/boardlist.js"></script>
<script type="text/javascript" src="js/UserProfile.js"></script>
<link rel="stylesheet" href="css/member/profile.css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); 
	String[] comment = {"오늘 하루는 어땠나요?",
						"오늘 기분 어떠신가요?",
						"자랑 할 일이 있나요?",
						"알리고 싶은 소식이 있나요?"
					   };
	double ran = Math.random()*4;
	int ranf = (int)ran;
	String search = request.getParameter("search");
	if(search==null){
		search="";
	}
	String id = request.getParameter("id");
	if(id==null){
		id="";
	}
	
	String dark = (String)session.getAttribute("dark_check");
	String mod = "다크 모드";
	if(dark.equals("1")){
		dark="recomentdark";
		mod = "라이트 모드";
	}else{
		dark="";
	}
	
%>
	<input type="hidden" id="searchText" value="<%=search %>">
	<input type="hidden" id="getId" value="<%=id %>">
<%
	if(id.equals("")){
%>
		<div style="margin: 1px auto; width: 500px;">
			<textarea class="addwrite" id="writebtn" placeholder="<%=comment[ranf]%>"></textarea>
		</div>
	<div class="remocon">
		<a><div class="showboard remoconlist" idx="0" id="showboard"></div></a>
		<div class="remoconcomment <%=dark%>">최신순</div>
		<a><div class="favorite remoconlist" idx="1" id="favorite"></div></a>
		<div class="remoconcomment <%=dark%>" >좋아요순</div>
		<a><div class="alam remoconlist" idx="2" id="alam"></div></a>
		<div class="remoconcomment <%=dark%>">알림</div>
		<div class="alambox">
			<div  class="alamul">
				<span class="alamli">
				<!--이부분 반복  시작-->
					
				</span>
				<br>
				<!--이부분 반복 끝 -->
			</div>
		</div>
		<a href="#"><div class="pagetopup remoconlist" idx="3" id="pagetopup"></div></a>
		<div class="remoconcomment <%=dark%>">맨위로</div>
		<a href="main.jsp?view=member/MyProfile.jsp&content=profile.jsp&id=<%=id%>">
			<div class="setting remoconlist" idx="4" id="setting"></div>
		</a>
		<div class="remoconcomment <%=dark%>" >설정</div>
		<a><div class="lightmode remoconlist" idx="5" id="darkmode" dark="0"></div></a>
		<div class="remoconcomment <%=dark%> status"><%=mod %></div>
	</div>
<%
	}
%>
	<div id="list">
	
	</div>
</body>
</html>