<%@page import="member.MemberDto"%>
<%@page import="board.BoardLikesDAO"%>
<%@page import="board.BoardHashTagDAO"%>
<%@page import="board.BoardImgDAO"%>
<%@page import="board.BoardImgDTO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body >

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String minrow = request.getParameter("minrow");
	String maxrow = request.getParameter("maxrow");
	
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	String loginid = mdto.getId();
	BoardDAO bdao = new BoardDAO();
	BoardImgDAO bidao = new BoardImgDAO();
	BoardLikesDAO bldao = new BoardLikesDAO();
	BoardHashTagDAO bhtdao = new BoardHashTagDAO();
	
	List<BoardDTO> blist = bdao.getMemberBoardList(minrow,maxrow,id);
	
	for(int i=0; i<blist.size();i++){
		BoardDTO bdto = blist.get(i);
%>
		<div class="board row" id="<%=bdto.getNum() %>">
			<!-- 로그인한 아이디와 글 작성 아이디가 일치하면 수정 버튼 나오기 -->	
			<div <%if(id.equals(loginid)){%>
					class="col-md-6 col-sm-6 col-xs-6 boardwriter sameid"
				 <%}else{%>
					class="col-md-8 col-sm-8 col-xs-8 boardwriter nosameid"
				 <%} %>
			>
				<!-- 프로필 이미지가 있을 경우 그 이미지, 없으면 기본 이미지 -->
				<img <%if(bdto.getProfilepic()==null){%>
						src="profile/default.png"
					 <%}else{%>
						 src="profile/<%=id %>/<%=bdto.getProfilepic() %>"
					 <%} %> alt="프로필사진" class="boardprofile">
					 
				<font style="text-align:left;"><%=bdto.getId() %></font>
			</div>
			<div class="col-md-4 col-sm-4 col-xs-4 boardwriter">
				시간
			</div>
<%
			if(id.equals(loginid)){
%>
			<div class="col-md-2 col-sm-2 col-xs-2 menu" style="text-align:center;">
				<button type="button" class="menubtn" style="border:none; background:none;">
					<img src="img/icon/menu_icon.png" id="menubtn" style="width:25px; height:25px;">
				</button>
			
		    	<div class="btns">
					<form class="updatefrm" method="post" action="main.jsp?view=board/updateboard.jsp">
						<button type="submit" class="updatebtn myboardbtn">수정</button>
						<input type="hidden" name="num" value="<%=bdto.getNum()%>">
					</form>
					<button type="button" class="delbtn myboardbtn" num="<%=bdto.getNum()%>">삭제</button>
		    	</div>
			</div>
<%
			}

			List<String> bilist = bidao.getNumImglist(bdto.getNum());
			if(bilist.size()!=0){
%>
				
				<div class='col-md-12 col-sm-12 col-xs-12 imglist'>
					<div class="imgs">
<%
					
					int cnt = 0;
					String imgclass= "";
					for(int j=0;j<bilist.size();j++){
						String filename = bilist.get(j);
						if(bilist.size()==1){
							imgclass = "imgone";
						}else if(bilist.size()==2){
							imgclass = "imgtwo";
						}
						if(j<=3){
%>
							<a href="main.jsp?view=board/board_Detail/board_Detail_form.jsp?num=<%=bdto.getNum()%>"><img src="save/<%=filename %>" id="boardimg" class="<%=imgclass%>"></a>
<%
					
						}else{
							cnt++;
						}
					}
					
					if(cnt>=1){
%>
						<div class="moreimg">+<%=cnt %></div>
<%
					}
%>
					
					</div><!-- imgs 끝 -->
				</div><!-- imglist 끝 -->
<%
			}
%>
			<div class="col-md-12 col-sm-12 col-xs-12 boardcontent">
<%
				//본문의 길이가 10 초과
				if(bdto.getContent().trim().length()>10){
					String con = bdto.getContent().trim().substring(0,10)+"...";
					if(bdto.getContent().substring(0,1).equals("")){
%>
						<span class="conpre">...<button class="conmorebtn" idx="<%=bdto.getNum()%>">더보기</button></span>
<%
					}else{
%>
						<span class="conpre"><%=con %><button class="conmorebtn" idx="<%=bdto.getNum()%>">더보기</button></span>
<%
					}
				}else{
%>
					<a href="main.jsp?view=board/board_Detail/board_Detail_form.jsp?num=<%=bdto.getNum()%>">
						<pre class="content"><%=bdto.getContent() %></pre>
					</a>
<%
				}
%>
			</div><!-- boardcontent 끝 -->
			<div class="col-md-12 col-sm-12 col-xs-12 boardlike_reply">
<%
				String like = bldao.getLikeStatus(bdto.getNum(), bdto.getId());
				if(like==null||like.equals("")){
%>
					<img class='likey' src='img/like/like01.png' num="<%=bdto.getNum() %>"/><span><%=bdto.getLikes() %></span>
<%
				}else{
%>
					<img class='likey' src='img/like/like02.png' num="<%=bdto.getNum() %>"/><span><%=bdto.getLikes() %></span>
<%
				}
%>
				<span>댓글 : <%=bdto.getReply() %></span>
			</div><!-- boardlike_reply 끝 -->
			<div class="col-md-12 col-sm-12 col-xs-12 hashtags">
<%
				List<String> hashlist = bhtdao.getNumHashTag(bdto.getNum());
				String str = "";
				for(int k=0;k<hashlist.size();k++){
					String hashtag = hashlist.get(k);
					if(k>=4){
						str += "...<button class='hashtagmore' idx='"+bdto.getNum()+"'>더보기</button>";
						break;
					}else{
						str +=	"<a href='#' class='hashtag'>#"+hashtag.trim()+"</a>";
					}
				}
%>
<span class="hashtagspan">
<%=str.trim() %>
</span>
			</div><!-- hashtags 끝 -->
		</div><!-- board 끝 -->
<%
	}
%>
</body>
</html>