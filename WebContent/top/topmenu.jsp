<%@page import="member.MemberFollowDao"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Montserrat+Subrayada&display=swap" rel="stylesheet">
<link rel= "stylesheet" type="text/css" href="css/top/topmenu.css">
<script type="text/javascript" src="js/top/topmenu.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	MemberDto dto = (MemberDto)session.getAttribute("dto");
	String id = dto.getId();
	BoardDAO dao = new BoardDAO();
	BoardDTO bdto = dao.getCount(id);
	NumberFormat nf = NumberFormat.getInstance();
	
	String like = nf.format(bdto.getLikes());
	String boardcnt = nf.format(Integer.parseInt(bdto.getNum()));
	String profilesrc = "profile/default.png";
	
	//팔로워 수
	MemberFollowDao follow = new MemberFollowDao();
	int followCnt = follow.followerCnt(id);
	
	System.out.println(dto.getPic());
	if(dto.getPic()!=null && dto.getPic()!=""){
		profilesrc = "profile/"+id+"/"+dto.getPic();
	}
	
%>
<script type="text/javascript">
	
</script>
<body>
	<div class="container" style="width: 100%;">
	
		<div class="row howtotopdark">
			<div class="col-md-3 col-sm-6 col-xs-6 topcontent">
			<input type="hidden" id="darkmodes" name="darkmodes" value="0">
				<P><a href="main.jsp">NOON</a></P>
			</div>
			<div class="col-md-6 hidden-sm hidden-xs topcontent">
				<input type="text" name="searchtag" class="searchtag" placeholder="#을 붙여서 해시태그검색">
				<button class="searchbtn"><img id="searchimg" alt="돋보기" src="img/icon/search.png" style="margin-left: -10px;width: 47px;"></button>
			</div>
			<div class="col-md-3 col-sm-6 col-xs-6 topcontent">
				<div class="row">
					<div class="col-md-3 col-sm-4 col-xs-6 myinfo">

						<img src="<%=profilesrc %>" alt="프로필 사진">
					</div>
					<div class="col-md-9 col-sm-8 col-xs-6 myinfo">
								<!--	아이디	 -->
						<div class="col-md-12 col-sm-12 col-xs-12 myinfolist myinfolistid">
							<span id="loginid"><a href="main.jsp?view=member/MyProfile.jsp&content=profile.jsp"><%=id %></a></span>
								<a href="#" id="logout" class="toplogout">로그아웃</a>
						</div>
								<!--	좋아요 게시글 팔로워	 -->
						<div class="col-md-12 col-sm-12 hidden-xs myinfolist myinfolist">
							<span> 좋아요 </span><div class = "vertical"></div>
							<span> 게시글 </span><div class = "vertical"></div>
							<span> 팔로워 </span>
						</div>
								<!--	좋아요 게시글 팔로워 숫자	 -->
						<div class="col-md-12 col-sm-12 hidden-xs myinfolist myinfolistval">
							<span> <%=like %> </span>
							<span> <%=boardcnt %> </span>
							<span> <%=followCnt %> </span>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>